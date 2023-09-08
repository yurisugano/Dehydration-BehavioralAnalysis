# Load necessary libraries
library(dplyr)
library(ggplot2)
library(gtable)
library(grid)

# Constants
Size <- 14

# Load and preprocess data
CORT <- read.csv(file = "All Results - Cort.csv")
levels(CORT$Condition) <- c("Control", "200 μg", "2000 μg")

All <- read.csv(file = "Both Populations - complete.csv")
All$population <- as.character(All$population)
All$Condition <- factor(All$Condition, levels = c("controle", "10", "20"))
levels(All$Condition) <- c("100%", "90%", "80%")
All$population[All$population == "A"] <- "Invasive"
All$population[All$population == "B"] <- "Native"
All$population <- as.factor(All$population)
Size <- 14

### Fig 1: Movement Latency ----
MovementLatency <- ggplot(data = All, mapping = aes(x = population, y = Movementlatency)) +
  geom_boxplot(mapping = aes(fill = population), outlier.shape = NA) + 
  geom_point(mapping = aes(shape = population), color = "#737373", position = position_jitter(width = 0.1), 
             size = 2) +
  theme_classic(base_size = Size) +
  labs(x = "Population",
       y = "Latency to start moving (s)") +
  facet_grid(cols = vars(Condition)) +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_y_continuous(breaks = c(0, 150, 300, 450, 600, 750),
                     limits = c(0, 750)) +
  scale_shape_manual(values = c(15, 17)) + 
  scale_fill_manual(values = c("#cfcfcf",
                               "#ffffff")) +
  guides(shape = FALSE, fill = FALSE) 

gridTitle<- ggplotGrob(MovementLatency)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                     list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                          textGrob("Hydration level", gp = gpar(cex = 1.2, col = "black"))),
                     t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)

grid.newpage()
grid.draw(gridTitle)

ggsave("Fig1_MovementLatency.pdf", gridTitle, width = 5, height = 4)



### Fig 2: Time in water ~ hydration level -------
WaterHydrationLvl <- ggplot(data = All, mapping = aes(x = population, y = WaterProportion * 100)) +
  geom_boxplot(mapping = aes(fill = population), outlier.shape = NA) + 
  geom_point(mapping = aes(shape = population), color = "#737373", position = position_jitter(width = 0.1), 
             size = 2) +
  labs(x = "Population",
       y = "Time spent hydrating (%)") + 
  facet_grid(cols = vars(Condition)) +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_shape_manual(values = c(15, 17)) +
  scale_fill_manual(values = c("#cfcfcf",
                               "#ffffff")) +
  guides(shape = FALSE, fill = FALSE)

gridTitle<- ggplotGrob(WaterHydrationLvl)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                     list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                          textGrob("Hydration level", gp = gpar(cex = 1.2, col = "black"))),
                     t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)
grid.newpage()
grid.draw(gridTitle)

ggsave("Fig2_WaterHydrationLvl.pdf", gridTitle, width = 5, height = 4)

### Fig 3: Time in arm ~ population * condition ------
ArmPopulation <- ggplot(data = All, mapping = aes(x = population, y = ArmProportion * 100)) +
  geom_boxplot(mapping = aes(fill = population), outlier.shape = NA) + 
  geom_point(mapping = aes(shape = population),
             color = "#737373", position = position_jitter(width = 0.1), 
             size = 2) +
  labs(x = "Population",
       y = "Time near water (%)") +
  facet_grid(cols = vars(Condition)) +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_shape_manual(values = c(15, 17)) +
  scale_fill_manual(values = c("#cfcfcf",
                               "#ffffff")) +
  guides(shape = FALSE, fill = FALSE)

gridTitle<- ggplotGrob(ArmPopulation)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                     list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                          textGrob("Hydration level", gp = gpar(cex = 1.2, col = "black"))),
                     t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)

grid.newpage()
grid.draw(gridTitle)

ggsave("Fig3_ArmPopulation.pdf", gridTitle, width = 5, height = 4)

### Fig 4: Attempts ~ Condition ------
All$FoundWater <- !is.na(All$WaterLatency)
Attempts <- ggplot(data = All, mapping = aes(x = Condition, y = Attempts)) +
  geom_boxplot(mapping = aes(fill = population), outlier.shape = NA) + 
  geom_point(mapping = aes(shape = population),
             color = "#737373", position = position_jitter(width = 0.1), 
             size = 2) +
  labs(x = "Hydration level",
       y = "Attempts to find water (un)") + 
  theme_classic(base_size = Size) +
  facet_grid(cols = vars(population)) +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_shape_manual(values = c(15, 17)) +
  scale_fill_manual(values = c("#cfcfcf",
                               "#ffffff")) +
  guides(shape = FALSE, fill = FALSE)

gridTitle<- ggplotGrob(Attempts)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                     list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                          textGrob("Population", gp = gpar(cex = 1.2, col = "black"))),
                     t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)

grid.newpage()
grid.draw(gridTitle)

ggsave("Fig4_Attempts.pdf", gridTitle, width = 5, height = 4)

### Fig 5: Proportion moving ~ population * condition -----
ProportionMoving <- ggplot(data = All, mapping = aes(x = population, y = MovementProportion * 100)) +
  geom_boxplot(mapping = aes(fill = population), outlier.shape = NA) + 
  geom_point(mapping = aes(shape = population), color = "#737373", position = position_jitter(width = 0.1), 
             size = 2) +
  labs(x = "Population",
       y = "Time spent moving (%)",
       legend = "Population") + 
  facet_grid(cols = vars(Condition)) +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_shape_manual(values = c(15, 17)) +
  scale_fill_manual(values = c("#cfcfcf",
                               "#ffffff")) +
  guides(shape = FALSE, fill = FALSE)

gridTitle<- ggplotGrob(ProportionMoving)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                     list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                          textGrob("Hydration level", gp = gpar(cex = 1.2, col = "black"))),
                     t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)

grid.newpage()
grid.draw(gridTitle)

ggsave("Fig5_ProportionMoving.pdf", gridTitle, width = 5, height = 4)

### Fig 7: CORT Water Latency ----
CortValue <- c(4, 6, 8, 2, 9, 1)
CortFound <- c("Success", "Fail", "Success", "Fail", "Success", "Fail")
CortCond <- factor(c("Control", "Control", "200 μg CORT", 
                           "200 μg CORT", "2000 μg CORT", "2000 μg CORT"),
                         levels = c("Control", "200 μg CORT", "2000 μg CORT"))
CortAll <- rep(1, 6)
Data.CortGraph <- data.frame(CortCond, CortValue, CortFound, CortAll)


CortGraph <- ggplot(data = Data.CortGraph, mapping = aes(x = CortFound, y = CortValue * 10)) +
  geom_bar(mapping = aes(fill = CortFound), position = position_dodge2(), color = "black",
           stat = "identity") +
  theme_bw(base_size = Size) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank(),
        strip.background = element_rect(fill = "white")) +
  scale_fill_manual(values = c("#ffffff", "#cfcfcf", "#4d4d4d")) +
  guides(fill = FALSE) +
  labs(x = "Success at finding water",
       y = "Proportion of animals (%)") +
  scale_y_continuous(limits = c(0,100), breaks = c(0, 20, 40, 60, 80, 100)) +
  facet_grid(cols = vars(CortCond))
gridTitle<- ggplotGrob(CortGraph)
gridTitle<- gtable_add_rows(gridTitle, gridTitle$height[7], pos = 6)
# gtable_show_layout(z)
gridTitle<- gtable_add_grob(gridTitle, 
                            list(rectGrob(gp = gpar(col = "black", fill = "white", size = 1)),
                                 textGrob("Treatment", gp = gpar(cex = 1.2, col = "black"))),
                            t = 7, l = 5, b = 7, r = 9, name = c("a", "b"))
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 7)
gridTitle<- gtable_add_rows(gridTitle, unit(2/10, "line"), 8)

grid.newpage()
grid.draw(gridTitle)

ggsave("Fig7_CortGraph.pdf", gridTitle, width = 5, height = 4)

### Figure 8: Proportion of movement for CORT ------
CORTMovement <- ggplot(data = CORT, mapping = aes(x = Condition, y = MovementProportion * 100)) +
  geom_boxplot(outlier.shape = NA) +
  geom_point(color = "#737373", position = position_jitter(width = 0.1, seed = 123), 
             size = 2) +
  geom_line(mapping = aes(group = ID), alpha = 0.25, position = position_jitter(width = 0.1, seed = 123)) +
  labs(x = "Condition",
       y = "Latency for movement (s)") +
  theme_bw(base_size = Size) +
  ylim(0,100) +
  theme(panel.background = element_rect(fill = NA),
        panel.grid = element_blank())
CORTMovement
 # HydrationTimeCort <- ggplot(data = CORT, mapping = aes(x = Condition, y = WaterProportion)) +
#   geom_boxplot(outlier.shape = NA) + 
#   geom_point(color = "#737373", position = position_jitter(width = 0.1), 
#              size = 2) +
#   labs(x = "Condition",
#        y = "Proportion of time hydration (%)") +
#   theme_bw(base_size = Size) +
#   theme(panel.background = element_rect(fill = NA),
#         panel.grid = element_blank()) 
# HydrationTimeCort

ggsave("Fig8_CORTMovement.pdf", CORTMovement, width = 5, height = 4)



