Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2ADC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983A6206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598863838;
	bh=w7GILwlnmbwNn51e2hei6U35hUGZv7Y4UBF1UqN+VkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qnp/tte6usvLspZeEPRI9KuMTkSCrPWVqH4C+DWX6Tl+yJtGICwZdZ0mNZK0iIHZt
	 uNYooZVEGHKuaXP/nwDBWagBPj10hNG2mTQPR81f065QKalgkeFPD+djZQpQw0wG17
	 cnfj0OS3oAUqDVqrXQrxxN/b72lrGd/r7GwMWvt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHaIug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgHaIuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:50:32 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAA3206F0;
        Mon, 31 Aug 2020 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598863832;
        bh=w7GILwlnmbwNn51e2hei6U35hUGZv7Y4UBF1UqN+VkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFxZb6il+5SsynJ67x29zLpIox8zm3XWOtZcm9S2JOE5ZFix1+4cwEE7vIePPlsEK
         St3EOgPQ6mUX8WyBy8y32oIr9m+Wn7K639mdQWdoCoxQwc3B+YbhfHvQK6GKnv/KlQ
         17i5/uj/8MAo/SVOWhMJ+R+bNrjgeoC6hLtwUgxI=
Date:   Mon, 31 Aug 2020 14:20:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     kishon@ti.com, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 5/7] phy: tegra: xusb: Add support for charger detect
Message-ID: <20200831085028.GG2639@vkoul-mobl>
References: <1595238948-20531-1-git-send-email-nkristam@nvidia.com>
 <1595238948-20531-6-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595238948-20531-6-git-send-email-nkristam@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 15:25, Nagarjuna Kristam wrote:

> +#define USB2_BATTERY_CHRG_OTGPADX_CTL0(x)	(0x80 + (x) * 0x40)
> +#define  PD_CHG					BIT(0)
> +#define  VDCD_DET_FILTER_EN			BIT(4)
> +#define  VDAT_DET				BIT(5)
> +#define  VDAT_DET_FILTER_EN			BIT(8)
> +#define  OP_SINK_EN				BIT(9)
> +#define  OP_SRC_EN				BIT(10)
> +#define  ON_SINK_EN				BIT(11)
> +#define  ON_SRC_EN				BIT(12)
> +#define  OP_I_SRC_EN				BIT(13)
> +#define  ZIP_FILTER_EN				BIT(21)
> +#define  ZIN_FILTER_EN				BIT(25)
> +#define  DCD_DETECTED				BIT(26)
> +
> +#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)	(0x84 + (x) * 0x40)
> +#define  PD_VREG				BIT(6)
> +#define  VREG_LEV(x)				(((x) & 0x3) << 7)
> +#define  VREG_DIR(x)				(((x) & 0x3) << 11)

GENMASK and FIELD_PREP please

> +static void
> +tegra_xusb_padctl_set_debounce_time(struct tegra_xusb_padctl *padctl,
> +				    u32 debounce)
> +{
> +	u32 value;
> +
> +	value = padctl_readl(padctl,
> +		XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0);

Single line

> +static void
> +tegra_xusb_padctl_charger_detect_on(struct tegra_xusb_padctl *padctl, u32 index)
> +{
> +	u32 value;
> +
> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +	value &= ~USB2_OTG_PD_ZI;
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +
> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +	value |= (USB2_OTG_PD2 | USB2_OTG_PD2_OVRD_EN);
> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
> +
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value &= ~PD_CHG;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));

maybe a padctl_updatel() helper to do read, modify and write

> +static void tegra_xusb_padctl_dcd(struct tegra_xusb_padctl *padctl, u32 index)
> +{
> +	u32 value;
> +	unsigned int offset;
> +	bool ret = false;
> +
> +	/* Turn on IDP_SRC */
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |= OP_I_SRC_EN;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/* Turn on D- pull-down resistor */
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +	value |= USBON_RPD_OVRD_VAL;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	/* Wait for TDCD_DBNC (DCD debounce), refer to BC1.2 spec Table 5 */
> +	usleep_range(10000, 20000);
> +
> +	offset = USB2_BATTERY_CHRG_OTGPADX_CTL0(index);
> +	ret = readl_poll_timeout(padctl->regs + offset, value,
> +				 value & DCD_DETECTED, 20000,
> +				 TDCD_TIMEOUT_MS * 1000);
> +	if (!ret)
> +		dev_warn(padctl->dev, "%s: DCD timeout.", __func__);

Not dev_err() ? and continue after this?

> +static bool
> +tegra_xusb_padctl_primary_secondary(struct tegra_xusb_padctl *padctl, u32 index,
> +				    bool is_primary)
> +{
> +	u32 value;
> +	u32 config = is_primary ? (OP_SRC_EN | ON_SINK_EN) :
> +				  (ON_SRC_EN | OP_SINK_EN);
> +	bool ret = false;
> +
> +	if (is_primary)
> +		/* data contact detection */
> +		tegra_xusb_padctl_dcd(padctl, index);
> +
> +	/* Source D- to D+ */
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	value |= config;
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +
> +	/*
> +	 * Wait for TVDPSRC_ON/TVDMSRC_ON(D+/- voltage source on time),
> +	 * refer to BC1.2 spec Table 5
> +	 */
> +	msleep(40);
> +
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
> +	if (is_primary)
> +		ret = !!(value & VDAT_DET);
> +	else
> +		ret = !(value & VDAT_DET);

How about 

        ret = !(value & VDAT_DET);
        if (is_primary)
                ret = !ret;

> +#define VON_DIV2P0_DET BIT(0)
> +#define VON_DIV2P7_DET BIT(1)
> +#define VOP_DIV2P0_DET BIT(2)
> +#define VOP_DIV2P7_DET BIT(3)
> +
> +#define VREG_CUR_LEVEL_0        500
> +#define VREG_CUR_LEVEL_1        900
> +#define VREG_CUR_LEVEL_2        1500
> +#define VREG_CUR_LEVEL_3        2000

tabs or spaces, pick one please, not both

> +
> +#define IS_CUR_IN_RANGE(ma, low, high)  \
> +	((ma >= VREG_CUR_LEVEL_##low) && (ma <= (VREG_CUR_LEVEL_##high - 1)))
> +#define VREG_LVL(ma, level)     IS_CUR_IN_RANGE(ma, level, level + 1)
> +
> +static void tegra_xusb_padctl_vbus_pad_portection(struct tegra_xusb_port *port)
> +{
> +	struct tegra_xusb_padctl *padctl = port->padctl;
> +	int level = 0;
> +	enum tegra_vbus_dir dir = TEGRA_VBUS_SINK;
> +	int max_ua, min_ua;

reverse christmas tree please

> +static enum usb_charger_type tegra_xusb_charger_detect(struct usb_phy *usb_phy)
> +{
> +	struct tegra_xusb_port *port = container_of(usb_phy,
> +						    struct tegra_xusb_port,
> +						    usb_phy);

how about:

        struct tegra_xusb_port *port = 
                        container_of(usb_phy, struct tegra_xusb_port, usb_phy);
-- 
~Vinod
