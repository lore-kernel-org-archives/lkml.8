Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609A2CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 238B62176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pBXQ1/hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgEMLnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:43:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58910 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgEMLnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:43:46 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87A3051F;
        Wed, 13 May 2020 13:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1589370222;
        bh=ygJlzKD/kkPmQ15AP4aH5DUKgm8yHCTUBzWdmjzzqT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pBXQ1/hqlNCgsmWRH/DSGMo+8TktUk8THkyost6t3defre/boV2EoloqbU/XUiTcs
         E/rrSNRnqVjeOIH+LzXek/JMmL1M9EoE3mm4o5CYu8ked/CxDnxxQLiJYr2/vvvq3j
         B8EKttEDpmjuHRHp05UNaJbBI+ZRFWWhU9465vmk=
Date:   Wed, 13 May 2020 14:43:36 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v7 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200513114336.GA5945@pendragon.ideasonboard.com>
References: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
 <20200401221025.26087-3-laurent.pinchart@ideasonboard.com>
 <3ec8a581-ca53-6861-31f3-3ececedefdbd@ti.com>
 <20200508005348.GK5838@pendragon.ideasonboard.com>
 <a63c62da-b57e-804a-7b2e-573e5828216b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a63c62da-b57e-804a-7b2e-573e5828216b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Wed, May 13, 2020 at 08:16:19AM +0530, Kishon Vijay Abraham I wrote:
> On 5/8/2020 6:23 AM, Laurent Pinchart wrote:
> > On Thu, May 07, 2020 at 10:14:45AM +0530, Kishon Vijay Abraham I wrote:
> >> On 4/2/2020 3:40 AM, Laurent Pinchart wrote:
> >>> From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >>>
> >>> Xilinx ZynqMP SoCs have a Gigabit Transceiver with four lanes. All the
> >>> high speed peripherals such as USB, SATA, PCIE, Display Port and
> >>> Ethernet SGMII can rely on any of the four GT lanes for PHY layer. This
> >>> patch adds driver for that ZynqMP GT core.
> >>>
> >>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >>> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> ---
> >>> Changes since v5:
> >>>
> >>> - Cleanup headers
> >>> - Organize the code in sections
> >>> - Constify data tables and structures
> >>> - Allocate all PHY instances in one go
> >>> - Add I/O accessors
> >>> - Move DP-specific init to a separate function
> >>> - Use devm_platform_ioremap_resource_byname()
> >>> - Simplify acquisition of reset controllers
> >>> - Implement .configure() PHY operation for DP
> >>> - Implement .power_on() and .power_off() operations
> >>> - Wait for PLL lock for DP PHY too
> >>> - Remove USB core reset operations
> >>> - Fix SGMII bus width settings
> >>> - Update copyright notice and authors list
> >>> - Disable error messages on probe deferral
> >>> - Update reset names to new DT bindings
> >>> - Update to removal of subnodes in new DT bindings
> >>> - Handle reference clocks through CCF
> >>> - Add MAINTAINERS entry
> >>> - Drop reset handling
> >>> - Split TX term fix to separate function
> >>> - Remove unused registers
> >>> ---
> >>>  MAINTAINERS              |   9 +
> >>>  drivers/phy/Kconfig      |   8 +
> >>>  drivers/phy/Makefile     |   1 +
> >>>  drivers/phy/phy-zynqmp.c | 995 +++++++++++++++++++++++++++++++++++++++
> >>
> >> Better to add a xilinx directory for this driver.
> > 
> > OK.
> > 
> >>>  4 files changed, 1013 insertions(+)
> >>>  create mode 100644 drivers/phy/phy-zynqmp.c
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 07293073c4f6..19e630fcaf62 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -18406,6 +18406,15 @@ F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
> >>>  F:	drivers/dma/xilinx/xilinx_dpdma.c
> >>>  F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
> >>>  
> >>> +XILINX ZYNQMP GSPTR PHY DRIVER
> >>
> >> Looks like a typo here,  rest of the place seems to use PSGTR
> > 
> > Good catch. Will fix it.
> > 
> >>> +M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >>> +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> +L:	linux-kernel@vger.kernel.org
> >>> +T:	git https://github.com/Xilinx/linux-xlnx.git
> >>> +S:	Supported
> >>> +F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> >>> +F:	drivers/phy/phy-zynqmp.c
> >>> +
> >>>  XILLYBUS DRIVER
> >>>  M:	Eli Billauer <eli.billauer@gmail.com>
> >>>  L:	linux-kernel@vger.kernel.org
> >>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> >>> index b3ed94b98d9b..b8251b9f3d87 100644
> >>> --- a/drivers/phy/Kconfig
> >>> +++ b/drivers/phy/Kconfig
> >>> @@ -49,6 +49,14 @@ config PHY_XGENE
> >>>  	help
> >>>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
> >>>  
> >>> +config PHY_XILINX_ZYNQMP
> >>> +	tristate "Xilinx ZynqMP PHY driver"
> >>> +	depends on ARCH_ZYNQMP
> >>> +	select GENERIC_PHY
> >>> +	help
> >>> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
> >>> +	  that is part of ZynqMP SoC.
> >>> +
> >>>  source "drivers/phy/allwinner/Kconfig"
> >>>  source "drivers/phy/amlogic/Kconfig"
> >>>  source "drivers/phy/broadcom/Kconfig"
> >>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> >>> index 310c149a9df5..5dc7469f078b 100644
> >>> --- a/drivers/phy/Makefile
> >>> +++ b/drivers/phy/Makefile
> >>> @@ -8,6 +8,7 @@ obj-$(CONFIG_GENERIC_PHY_MIPI_DPHY)	+= phy-core-mipi-dphy.o
> >>>  obj-$(CONFIG_PHY_LPC18XX_USB_OTG)	+= phy-lpc18xx-usb-otg.o
> >>>  obj-$(CONFIG_PHY_XGENE)			+= phy-xgene.o
> >>>  obj-$(CONFIG_PHY_PISTACHIO_USB)		+= phy-pistachio-usb.o
> >>> +obj-$(CONFIG_PHY_XILINX_ZYNQMP)		+= phy-zynqmp.o
> >>>  obj-$(CONFIG_ARCH_SUNXI)		+= allwinner/
> >>>  obj-$(CONFIG_ARCH_MESON)		+= amlogic/
> >>>  obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
> >>> diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
> >>> new file mode 100644
> >>> index 000000000000..8ab99d6b9220
> >>> --- /dev/null
> >>> +++ b/drivers/phy/phy-zynqmp.c
> >>> @@ -0,0 +1,995 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
> >>> + *
> >>> + * Copyright (C) 2018-20 Xilinx Inc.
> >>> + *
> >>> + * Author: Anurag Kumar Vulisha <anuragku@xilinx.com>
> >>> + * Author: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> >>> + * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> + *
> >>> + * This driver is tested for USB, SATA and Display Port currently.
> >>> + * Other controllers PCIe and SGMII should also work but that is
> >>> + * experimental as of now.
> >>> + */
> >>> +
> >>> +#include <linux/clk.h>
> >>> +#include <linux/delay.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/phy/phy.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/slab.h>
> >>> +
> >>> +#include <dt-bindings/phy/phy.h>
> >>> +
> >>> +/*
> >>> + * Lane Registers
> >>> + */
> >>> +
> >>> +/* TX De-emphasis parameters */
> >>> +#define L0_TX_ANA_TM_18			0x0048
> >>> +#define L0_TX_ANA_TM_118		0x01d8
> >>> +#define L0_TX_ANA_TM_118_FORCE_17_0	BIT(0)
> >>> +
> >>> +/* DN Resistor calibration code parameters */
> >>> +#define L0_TXPMA_ST_3			0x0b0c
> >>> +#define L0_DN_CALIB_CODE		0x3f
> >>> +
> >>> +/* PMA control parameters */
> >>> +#define L0_TXPMD_TM_45			0x0cb4
> >>> +#define L0_TXPMD_TM_48			0x0cc0
> >>> +#define L0_TXPMD_TM_45_OVER_DP_MAIN	BIT(0)
> >>> +#define L0_TXPMD_TM_45_ENABLE_DP_MAIN	BIT(1)
> >>> +#define L0_TXPMD_TM_45_OVER_DP_POST1	BIT(2)
> >>> +#define L0_TXPMD_TM_45_ENABLE_DP_POST1	BIT(3)
> >>> +#define L0_TXPMD_TM_45_OVER_DP_POST2	BIT(4)
> >>> +#define L0_TXPMD_TM_45_ENABLE_DP_POST2	BIT(5)
> >>> +
> >>> +/* PCS control parameters */
> >>> +#define L0_TM_DIG_6			0x106c
> >>> +#define L0_TM_DIS_DESCRAMBLE_DECODER	0x0f
> >>> +#define L0_TX_DIG_61			0x00f4
> >>> +#define L0_TM_DISABLE_SCRAMBLE_ENCODER	0x0f
> >>> +
> >>> +/* PLL Test Mode register parameters */
> >>> +#define L0_TM_PLL_DIG_37		0x2094
> >>> +#define L0_TM_COARSE_CODE_LIMIT		0x10
> >>> +
> >>> +/* PLL SSC step size offsets */
> >>> +#define L0_PLL_SS_STEPS_0_LSB		0x2368
> >>> +#define L0_PLL_SS_STEPS_1_MSB		0x236c
> >>> +#define L0_PLL_SS_STEP_SIZE_0_LSB	0x2370
> >>> +#define L0_PLL_SS_STEP_SIZE_1		0x2374
> >>> +#define L0_PLL_SS_STEP_SIZE_2		0x2378
> >>> +#define L0_PLL_SS_STEP_SIZE_3_MSB	0x237c
> >>> +#define L0_PLL_STATUS_READ_1		0x23e4
> >>> +
> >>> +/* SSC step size parameters */
> >>> +#define STEP_SIZE_0_MASK		0xff
> >>> +#define STEP_SIZE_1_MASK		0xff
> >>> +#define STEP_SIZE_2_MASK		0xff
> >>> +#define STEP_SIZE_3_MASK		0x3
> >>> +#define STEP_SIZE_SHIFT			8
> >>> +#define FORCE_STEP_SIZE			0x10
> >>> +#define FORCE_STEPS			0x20
> >>> +#define STEPS_0_MASK			0xff
> >>> +#define STEPS_1_MASK			0x07
> >>> +
> >>> +/* Reference clock selection parameters */
> >>> +#define L0_Ln_REF_CLK_SEL(n)		(0x2860 + (n) * 4)
> >>> +#define L0_REF_CLK_SEL_MASK		0x8f
> >>> +
> >>> +/* Calibration digital logic parameters */
> >>> +#define L3_TM_CALIB_DIG19		0xec4c
> >>> +#define L3_CALIB_DONE_STATUS		0xef14
> >>> +#define L3_TM_CALIB_DIG18		0xec48
> >>> +#define L3_TM_CALIB_DIG19_NSW		0x07
> >>> +#define L3_TM_CALIB_DIG18_NSW		0xe0
> >>> +#define L3_TM_OVERRIDE_NSW_CODE         0x20
> >>> +#define L3_CALIB_DONE			0x02
> >>> +#define L3_NSW_SHIFT			5
> >>> +#define L3_NSW_PIPE_SHIFT		4
> >>> +#define L3_NSW_CALIB_SHIFT		3
> >>> +
> >>> +#define PHY_REG_OFFSET			0x4000
> >>> +
> >>> +/*
> >>> + * Global Registers
> >>> + */
> >>> +
> >>> +/* Refclk selection parameters */
> >>> +#define PLL_REF_SEL(n)			(0x10000 + (n) * 4)
> >>> +#define PLL_FREQ_MASK			0x1f
> >>> +#define PLL_STATUS_LOCKED		0x10
> >>> +
> >>> +/* Inter Connect Matrix parameters */
> >>> +#define ICM_CFG0			0x10010
> >>> +#define ICM_CFG1			0x10014
> >>> +#define ICM_CFG0_L0_MASK		0x07
> >>> +#define ICM_CFG0_L1_MASK		0x70
> >>> +#define ICM_CFG1_L2_MASK		0x07
> >>> +#define ICM_CFG2_L3_MASK		0x70
> >>> +#define ICM_CFG_SHIFT			4
> >>> +
> >>> +/* Inter Connect Matrix allowed protocols */
> >>> +#define ICM_PROTOCOL_PD			0x0
> >>> +#define ICM_PROTOCOL_PCIE		0x1
> >>> +#define ICM_PROTOCOL_SATA		0x2
> >>> +#define ICM_PROTOCOL_USB		0x3
> >>> +#define ICM_PROTOCOL_DP			0x4
> >>> +#define ICM_PROTOCOL_SGMII		0x5
> >>> +
> >>> +/* Test Mode common reset control  parameters */
> >>> +#define TM_CMN_RST			0x10018
> >>> +#define TM_CMN_RST_EN			0x1
> >>> +#define TM_CMN_RST_SET			0x2
> >>> +#define TM_CMN_RST_MASK			0x3
> >>> +
> >>> +/* Bus width parameters */
> >>> +#define TX_PROT_BUS_WIDTH		0x10040
> >>> +#define RX_PROT_BUS_WIDTH		0x10044
> >>> +#define PROT_BUS_WIDTH_10		0x0
> >>> +#define PROT_BUS_WIDTH_20		0x1
> >>> +#define PROT_BUS_WIDTH_40		0x2
> >>> +#define PROT_BUS_WIDTH_SHIFT		2
> >>> +
> >>> +/* Number of GT lanes */
> >>> +#define NUM_LANES			4
> >>> +
> >>> +/* SIOU SATA control register */
> >>> +#define SATA_CONTROL_OFFSET		0x0100
> >>> +
> >>> +/* Total number of controllers */
> >>> +#define CONTROLLERS_PER_LANE		5
> >>> +
> >>> +/* Protocol Type parameters */
> >>> +#define XPSGTR_TYPE_USB0		0  /* USB controller 0 */
> >>> +#define XPSGTR_TYPE_USB1		1  /* USB controller 1 */
> >>> +#define XPSGTR_TYPE_SATA_0		2  /* SATA controller lane 0 */
> >>> +#define XPSGTR_TYPE_SATA_1		3  /* SATA controller lane 1 */
> >>> +#define XPSGTR_TYPE_PCIE_0		4  /* PCIe controller lane 0 */
> >>> +#define XPSGTR_TYPE_PCIE_1		5  /* PCIe controller lane 1 */
> >>> +#define XPSGTR_TYPE_PCIE_2		6  /* PCIe controller lane 2 */
> >>> +#define XPSGTR_TYPE_PCIE_3		7  /* PCIe controller lane 3 */
> >>> +#define XPSGTR_TYPE_DP_0		8  /* Display Port controller lane 0 */
> >>> +#define XPSGTR_TYPE_DP_1		9  /* Display Port controller lane 1 */
> >>> +#define XPSGTR_TYPE_SGMII0		10 /* Ethernet SGMII controller 0 */
> >>> +#define XPSGTR_TYPE_SGMII1		11 /* Ethernet SGMII controller 1 */
> >>> +#define XPSGTR_TYPE_SGMII2		12 /* Ethernet SGMII controller 2 */
> >>> +#define XPSGTR_TYPE_SGMII3		13 /* Ethernet SGMII controller 3 */
> >>> +
> >>> +/* Timeout values */
> >>> +#define TIMEOUT_US			1000
> >>> +
> >>> +struct xpsgtr_dev;
> >>> +
> >>> +/**
> >>> + * struct xpsgtr_ssc - structure to hold SSC settings for a lane
> >>> + * @refclk_rate: PLL reference clock frequency
> >>> + * @pll_ref_clk: value to be written to register for corresponding ref clk rate
> >>> + * @steps: number of steps of SSC (Spread Spectrum Clock)
> >>> + * @step_size: step size of each step
> >>> + */
> >>> +struct xpsgtr_ssc {
> >>> +	u32 refclk_rate;
> >>> +	u8  pll_ref_clk;
> >>> +	u32 steps;
> >>> +	u32 step_size;
> >>> +};
> >>> +
> >>> +/**
> >>> + * struct xpsgtr_phy - representation of a lane
> >>> + * @phy: pointer to the kernel PHY device
> >>> + * @type: controller which uses this lane
> >>> + * @lane: lane number
> >>> + * @protocol: protocol in which the lane operates
> >>> + * @skip_phy_init: skip phy_init() if true
> >>> + * @dev: pointer to the xpsgtr_dev instance
> >>> + * @refclk: reference clock index
> >>> + */
> >>> +struct xpsgtr_phy {
> >>> +	struct phy *phy;
> >>> +	u8 type;
> >>> +	u8 lane;
> >>> +	u8 protocol;
> >>> +	bool skip_phy_init;
> >>> +	struct xpsgtr_dev *dev;
> >>> +	unsigned int refclk;
> >>> +};
> >>> +
> >>> +/**
> >>> + * struct xpsgtr_dev - representation of a ZynMP GT device
> >>> + * @dev: pointer to device
> >>> + * @serdes: serdes base address
> >>> + * @siou: siou base address
> >>> + * @gtr_mutex: mutex for locking
> >>> + * @phys: PHY lanes
> >>> + * @refclk_sscs: spread spectrum settings for the reference clocks
> >>> + * @tx_term_fix: fix for GT issue
> >>> + * @saved_icm_cfg0: stored value of ICM CFG0 register
> >>> + * @saved_icm_cfg1: stored value of ICM CFG1 register
> >>> + */
> >>> +struct xpsgtr_dev {
> >>> +	struct device *dev;
> >>> +	void __iomem *serdes;
> >>> +	void __iomem *siou;
> >>> +	struct mutex gtr_mutex; /* mutex for locking */
> >>> +	struct xpsgtr_phy phys[NUM_LANES];
> >>> +	const struct xpsgtr_ssc *refclk_sscs[NUM_LANES];
> >>> +	bool tx_term_fix;
> >>> +	unsigned int saved_icm_cfg0;
> >>> +	unsigned int saved_icm_cfg1;
> >>> +};
> >>> +
> >>> +/* -----------------------------------------------------------------------------
> >>
> >> The dash here is not commonly used. Please stick to default multi-line comment
> >> style.
> > 
> > It's more common in some subsystems than others :-) No big deal, I'll
> > drop it (even if I think it increases readability by clearly marking
> > sections visually).
> > 
> >>> + * Configuration Data
> >>> + */
> >>> +
> >>> +/* lookup table to hold all settings needed for a ref clock frequency */
> >>> +static const struct xpsgtr_ssc ssc_lookup[] = {
> >>> +	{  19200000, 0x05,  608, 264020 },
> >>> +	{  20000000, 0x06,  634, 243454 },
> >>> +	{  24000000, 0x07,  760, 168973 },
> >>> +	{  26000000, 0x08,  824, 143860 },
> >>> +	{  27000000, 0x09,  856,  86551 },
> >>> +	{  38400000, 0x0a, 1218,  65896 },
> >>> +	{  40000000, 0x0b,  634, 243454 },
> >>> +	{  52000000, 0x0c,  824, 143860 },
> >>> +	{ 100000000, 0x0d, 1058,  87533 },
> >>> +	{ 108000000, 0x0e,  856,  86551 },
> >>> +	{ 125000000, 0x0f,  992, 119497 },
> >>> +	{ 135000000, 0x10, 1070,  55393 },
> >>> +	{ 150000000, 0x11,  792, 187091 }
> >>> +};
> >>> +
> >>> +/* -----------------------------------------------------------------------------
> >>> + * I/O Accessors
> >>> + */
> >>> +
> >>> +static inline u32 xpsgtr_read(struct xpsgtr_dev *gtr_dev, u32 reg)
> >>> +{
> >>> +	return readl(gtr_dev->serdes + reg);
> >>> +}
> >>> +
> >>> +static inline void xpsgtr_write(struct xpsgtr_dev *gtr_dev, u32 reg, u32 value)
> >>> +{
> >>> +	writel(value, gtr_dev->serdes + reg);
> >>> +}
> >>> +
> >>> +static inline void xpsgtr_clr_set(struct xpsgtr_dev *gtr_dev, u32 reg,
> >>> +				  u32 clr, u32 set)
> >>> +{
> >>> +	u32 value = xpsgtr_read(gtr_dev, reg);
> >>> +
> >>> +	value &= ~clr;
> >>> +	value |= set;
> >>> +	xpsgtr_write(gtr_dev, reg, value);
> >>> +}
> >>> +
> >>> +static inline u32 xpsgtr_read_phy(struct xpsgtr_phy *gtr_phy, u32 reg)
> >>> +{
> >>> +	void __iomem *addr = gtr_phy->dev->serdes
> >>> +			   + gtr_phy->lane * PHY_REG_OFFSET + reg;
> >>> +
> >>> +	return readl(addr);
> >>> +}
> >>> +
> >>> +static inline void xpsgtr_write_phy(struct xpsgtr_phy *gtr_phy,
> >>> +				    u32 reg, u32 value)
> >>> +{
> >>> +	void __iomem *addr = gtr_phy->dev->serdes
> >>> +			   + gtr_phy->lane * PHY_REG_OFFSET + reg;
> >>> +
> >>> +	writel(value, addr);
> >>> +}
> >>> +
> >>> +static inline void xpsgtr_clr_set_phy(struct xpsgtr_phy *gtr_phy,
> >>> +				      u32 reg, u32 clr, u32 set)
> >>> +{
> >>> +	void __iomem *addr = gtr_phy->dev->serdes
> >>> +			   + gtr_phy->lane * PHY_REG_OFFSET + reg;
> >>> +
> >>> +	writel((readl(addr) & ~clr) | set, addr);
> >>> +}
> >>> +
> >>> +/* -----------------------------------------------------------------------------
> >>> + * Hardware Configuration
> >>> + */
> >>> +
> >>> +/* Wait for the PLL to lock (with a timeout). */
> >>> +static int xpsgtr_wait_pll_lock(struct phy *phy)
> >>> +{
> >>> +	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
> >>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
> >>> +	unsigned int timeout = TIMEOUT_US;
> >>> +	int ret;
> >>> +
> >>> +	dev_dbg(gtr_dev->dev, "Waiting for PLL lock\n");
> >>> +
> >>> +	while (1) {
> >>> +		u32 reg = xpsgtr_read_phy(gtr_phy, L0_PLL_STATUS_READ_1);
> >>> +
> >>> +		if ((reg & PLL_STATUS_LOCKED) == PLL_STATUS_LOCKED) {
> >>> +			ret = 0;
> >>> +			break;
> >>> +		}
> >>> +
> >>> +		if (--timeout == 0) {
> >>> +			ret = -ETIMEDOUT;
> >>> +			break;
> >>> +		}
> >>> +
> >>> +		udelay(1);
> >>> +	}
> >>> +
> >>> +	if (ret == -ETIMEDOUT)
> >>> +		dev_err(gtr_dev->dev,
> >>> +			"lane %u (type %u, protocol %u): PLL lock timeout\n",
> >>> +			gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
> >>> +
> >>> +	return ret;
> >>> +}
> >>> +
> >>> +/* Configure PLL and spread-sprectrum clock. */
> >>> +static void xpsgtr_configure_pll(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	const struct xpsgtr_ssc *ssc;
> >>> +	u32 step_size;
> >>> +
> >>> +	ssc = gtr_phy->dev->refclk_sscs[gtr_phy->refclk];
> >>> +	step_size = ssc->step_size;
> >>> +
> >>> +	xpsgtr_clr_set(gtr_phy->dev, PLL_REF_SEL(gtr_phy->lane),
> >>> +		       PLL_FREQ_MASK, ssc->pll_ref_clk);
> >>> +
> >>> +	/* Enable lane clock sharing, if required */
> >>> +	if (gtr_phy->refclk != gtr_phy->lane) {
> >>> +		/* Lane3 Ref Clock Selection Register */
> >>> +		xpsgtr_clr_set(gtr_phy->dev, L0_Ln_REF_CLK_SEL(gtr_phy->lane),
> >>> +			       L0_REF_CLK_SEL_MASK, 1 << gtr_phy->refclk);
> >>> +	}
> >>> +
> >>> +	/* SSC step size [7:0] */
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_0_LSB,
> >>> +			   STEP_SIZE_0_MASK, step_size & STEP_SIZE_0_MASK);
> >>> +
> >>> +	/* SSC step size [15:8] */
> >>> +	step_size >>= STEP_SIZE_SHIFT;
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_1,
> >>> +			   STEP_SIZE_1_MASK, step_size & STEP_SIZE_1_MASK);
> >>> +
> >>> +	/* SSC step size [23:16] */
> >>> +	step_size >>= STEP_SIZE_SHIFT;
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_2,
> >>> +			   STEP_SIZE_2_MASK, step_size & STEP_SIZE_2_MASK);
> >>> +
> >>> +	/* SSC steps [7:0] */
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEPS_0_LSB,
> >>> +			   STEPS_0_MASK, ssc->steps & STEPS_0_MASK);
> >>> +
> >>> +	/* SSC steps [10:8] */
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEPS_1_MSB,
> >>> +			   STEPS_1_MASK,
> >>> +			   (ssc->steps >> STEP_SIZE_SHIFT) & STEPS_1_MASK);
> >>> +
> >>> +	/* SSC step size [24:25] */
> >>> +	step_size >>= STEP_SIZE_SHIFT;
> >>> +	xpsgtr_clr_set_phy(gtr_phy, L0_PLL_SS_STEP_SIZE_3_MSB,
> >>> +			   STEP_SIZE_3_MASK, (step_size & STEP_SIZE_3_MASK) |
> >>> +			   FORCE_STEP_SIZE | FORCE_STEPS);
> >>> +}
> >>> +
> >>> +/* Configure the lane protocol. */
> >>> +static void xpsgtr_lane_set_protocol(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
> >>> +	u8 protocol = gtr_phy->protocol;
> >>> +
> >>> +	switch (gtr_phy->lane) {
> >>> +	case 0:
> >>> +		xpsgtr_clr_set(gtr_dev, ICM_CFG0, ICM_CFG0_L0_MASK, protocol);
> >>> +		break;
> >>> +	case 1:
> >>> +		xpsgtr_clr_set(gtr_dev, ICM_CFG0, ICM_CFG0_L1_MASK,
> >>> +			       protocol << ICM_CFG_SHIFT);
> >>> +		break;
> >>> +	case 2:
> >>> +		xpsgtr_clr_set(gtr_dev, ICM_CFG1, ICM_CFG0_L0_MASK, protocol);
> >>> +		break;
> >>> +	case 3:
> >>> +		xpsgtr_clr_set(gtr_dev, ICM_CFG1, ICM_CFG0_L1_MASK,
> >>> +			       protocol << ICM_CFG_SHIFT);
> >>> +		break;
> >>> +	default:
> >>> +		/* We already checked 0 <= lane <= 3 */
> >>> +		break;
> >>> +	}
> >>> +}
> >>> +
> >>> +/* Bypass (de)scrambler and 8b/10b decoder and encoder. */
> >>> +static void xpsgtr_bypass_scrambler_8b10b(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TM_DIG_6, L0_TM_DIS_DESCRAMBLE_DECODER);
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TX_DIG_61, L0_TM_DISABLE_SCRAMBLE_ENCODER);
> >>> +}
> >>> +
> >>> +/* DP-specific initialization. */
> >>> +static void xpsgtr_phy_init_dp(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TXPMD_TM_45,
> >>> +			 L0_TXPMD_TM_45_OVER_DP_MAIN |
> >>> +			 L0_TXPMD_TM_45_ENABLE_DP_MAIN |
> >>> +			 L0_TXPMD_TM_45_OVER_DP_POST1 |
> >>> +			 L0_TXPMD_TM_45_OVER_DP_POST2 |
> >>> +			 L0_TXPMD_TM_45_ENABLE_DP_POST2);
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_118,
> >>> +			 L0_TX_ANA_TM_118_FORCE_17_0);
> >>> +}
> >>> +
> >>> +/* SATA-specific initialization. */
> >>> +static void xpsgtr_phy_init_sata(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
> >>> +
> >>> +	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
> >>> +
> >>> +	writel(gtr_phy->lane, gtr_dev->siou + SATA_CONTROL_OFFSET);
> >>> +}
> >>
> >> The cover letter mentions this has been tested with DP. Was it tested with SATA
> >> and SGMII as well?
> > 
> > On the Xilinx downstream kernel only, as SATA and SGMII isn't available
> > upstream yet.
> 
> Would prefer to merge only what is tested upstream. Are there plans of getting
> SATA and SGMII upstream? Are the patches posted?

The SATA controller is compatible with the drivers/ata/ahci_ceva.c
driver present upstream, which supports PHYs through the ahci_platform
helpers. I've just checked and there are no changes in drivers/ata/ in
the Xilinx tree compared to mainline. I think it's thus just a matter of
DT integration (that part is present in the Xilinx tree but not in
mainline).

Ethernet for ZynqMP is supported by the drivers/net/ethernet/cadence
driver. The driver supports SGMII, but I'm not sure how it integrates
with PSGTR.

Maybe Anurag or Michal can comment on all this, and Xilinx's plans to
upstream missing features, if any ?

I can strip down the SATA and SGMII support from the driver, but that's
very little code, and as drivers exist upstream for both SATA and SGMII,
with DT integration being the only missing piece for SATA as far as I
understand, I'd rather keep it in the driver.

> >>> +
> >>> +/* SGMII-specific initialization. */
> >>> +static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
> >>> +
> >>> +	/* Set SGMII protocol TX and RX bus width to 10 bits. */
> >>> +	xpsgtr_write(gtr_dev, TX_PROT_BUS_WIDTH,
> >>> +		     PROT_BUS_WIDTH_10 << (gtr_phy->lane * PROT_BUS_WIDTH_SHIFT));
> >>> +	xpsgtr_write(gtr_dev, RX_PROT_BUS_WIDTH,
> >>> +		     PROT_BUS_WIDTH_10 << (gtr_phy->lane * PROT_BUS_WIDTH_SHIFT));
> >>> +
> >>> +	xpsgtr_bypass_scrambler_8b10b(gtr_phy);
> >>> +}
> >>> +
> >>> +/* Configure TX de-emphasis and margining for DP. */
> >>> +static void xpsgtr_phy_configure_dp(struct xpsgtr_phy *gtr_phy, unsigned int pre,
> >>> +				    unsigned int voltage)
> >>> +{
> >>> +	static const u8 voltage_swing[4][4] = {
> >>> +		{ 0x2a, 0x27, 0x24, 0x20 },
> >>> +		{ 0x27, 0x23, 0x20, 0xff },
> >>> +		{ 0x24, 0x20, 0xff, 0xff },
> >>> +		{ 0xff, 0xff, 0xff, 0xff }
> >>> +	};
> >>> +	static const u8 pre_emphasis[4][4] = {
> >>> +		{ 0x02, 0x02, 0x02, 0x02 },
> >>> +		{ 0x01, 0x01, 0x01, 0xff },
> >>> +		{ 0x00, 0x00, 0xff, 0xff },
> >>> +		{ 0xff, 0xff, 0xff, 0xff }
> >>> +	};
> >>> +
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TXPMD_TM_48, voltage_swing[pre][voltage]);
> >>> +	xpsgtr_write_phy(gtr_phy, L0_TX_ANA_TM_18, pre_emphasis[pre][voltage]);
> >>> +}
> >>> +
> >>> +/* -----------------------------------------------------------------------------
> >>> + * PHY Operations
> >>> + */
> >>> +
> >>> +static bool xpsgtr_phy_init_required(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	/*
> >>> +	 * As USB may save the snapshot of the states during hibernation, doing
> >>> +	 * phy_init() will put the USB controller into reset, resulting in the
> >>> +	 * losing of the saved snapshot. So try to avoid phy_init() for USB
> >>> +	 * except when gtr_phy->skip_phy_init is false (this happens when FPD is
> >>> +	 * shutdown during suspend or when gt lane is changed from current one)
> >>> +	 */
> >>> +	if (gtr_phy->protocol == ICM_PROTOCOL_USB && gtr_phy->skip_phy_init)
> >>> +		return false;
> >>> +	else
> >>
> >> 'else' here is un-necessary.
> > 
> > Does it hurt though ? I find it more readable.
>
> Fine then.
>
> >>> +		return true;
> >>> +}
> >>> +
> >>> +/*
> >>> + * There is a functional issue in the GT. The TX termination resistance can be
> >>> + * out of spec due to a issue in the calibration logic. This is the workaround
> >>> + * to fix it, required for XCZU9EG silicon.
> >>> + */
> >>> +static int xpsgtr_phy_tx_term_fix(struct xpsgtr_phy *gtr_phy)
> >>> +{
> >>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
> >>> +	u32 timeout = TIMEOUT_US;
> >>> +	u32 nsw;
> >>> +
> >>> +	/* Enabling Test Mode control for CMN Rest */
> >>> +	xpsgtr_clr_set(gtr_dev, TM_CMN_RST, TM_CMN_RST_MASK, TM_CMN_RST_SET);
> >>
> >> This function writes to the global registers. Wouldn't this affect a lane that
> >> is already configured?
> > 
> > This function is only executed once, for the first PHY that is
> > initialized (see the caller, this is guarded with a mutex, so there's no
> > race condition).
> 
> Indeed.

-- 
Regards,

Laurent Pinchart
