Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01232206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598859368;
	bh=AmuiRA9ag6zrrQLhZzSQH64RuSqSCWUPiji2PS7IRfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GgCrZptUW3X4xazb11oZWbWJffEMC4nHyqHAeUfrg2nekfMXoaxGIDpBYXDM48G68
	 yGgQhsmqNrlgdTvIAYKUK+Ow/XGYrfgXP9DxtJV8J/QnSHCOwxCqXnmfWuvO6eq56s
	 AwIIH6GKr/NZKFzWYBwE/rjx2R4Vkz6gP6oioXz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgHaHgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaHgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:36:00 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5A8206EB;
        Mon, 31 Aug 2020 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598859359;
        bh=AmuiRA9ag6zrrQLhZzSQH64RuSqSCWUPiji2PS7IRfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omVR4E1V9p59SGh3NCwkGPbmZ4yk/C/d/XOEDQpdjEleYqYq/n7fV+WAEz8AwOg0o
         SaApy4rCEULKr1VjvVTTOL0PfAOq180K4h16Ov1mVNF7/k+GlTryeeTwkkS+8xrIeM
         n5V+9MfMGUv2Yuor0Z1kAymt+BfsndpTc+08KuVQ=
Date:   Mon, 31 Aug 2020 13:05:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     kishon@ti.com, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 4/7] phy: tegra: xusb: Add soc ops API to enable UTMI
 PAD protection
Message-ID: <20200831073554.GF2639@vkoul-mobl>
References: <1595238948-20531-1-git-send-email-nkristam@nvidia.com>
 <1595238948-20531-5-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595238948-20531-5-git-send-email-nkristam@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 15:25, Nagarjuna Kristam wrote:
> When USB charger is enabled, UTMI PAD needs to be protected according
> to the direction and current level. Add support for the same on Tegra210
> and Tegra186.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V5:
>  - No changes.
> ---
> V4:
>  - Added Acked-by updates to commit message.
> ---
> V3:
>  - Alligned function and its arguments.
>  - Fixed other comments from Thierry.
> ---
> V2:
>  - Commit message coorected.
>  - Patch re-based.
> ---
>  drivers/phy/tegra/xusb-tegra186.c | 40 +++++++++++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb-tegra210.c | 32 +++++++++++++++++++++++++++++++
>  drivers/phy/tegra/xusb.h          | 13 +++++++++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
> index f862254..59b78a7 100644
> --- a/drivers/phy/tegra/xusb-tegra186.c
> +++ b/drivers/phy/tegra/xusb-tegra186.c
> @@ -68,6 +68,13 @@
>  #define   PORTX_SPEED_SUPPORT_MASK		(0x3)
>  #define     PORT_SPEED_SUPPORT_GEN1		(0x0)
>  
> +#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)       (0x84 + (x) * 0x40)
> +#define  PD_VREG                                (1 << 6)
> +#define  VREG_LEV(x)                            (((x) & 0x3) << 7)
> +#define  VREG_DIR(x)                            (((x) & 0x3) << 11)

maybe FIELD_GET() would be better, avoids error with shifts

> +#define  VREG_DIR_IN                            VREG_DIR(1)
> +#define  VREG_DIR_OUT                           VREG_DIR(2)
> +
>  #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
>  #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
>  #define  TERM_SEL				BIT(25)
> @@ -289,6 +296,37 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>  	usb2->powered_on = false;
>  }
>  
> +static void
> +tegra186_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
> +					     int level,
> +					     enum tegra_vbus_dir dir)
> +{
> +	u32 value;
> +	struct tegra_xusb_padctl *padctl = port->padctl;
> +	unsigned int index = port->index;
> +
> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +
> +	if (level < 0) {
> +		/* disable pad protection */
> +		value |= PD_VREG;
> +		value &= ~VREG_LEV(~0);
> +		value &= ~VREG_DIR(~0);
> +	} else {
> +		if (dir == TEGRA_VBUS_SOURCE)
> +			value |= VREG_DIR_OUT;
> +		else if (dir == TEGRA_VBUS_SINK)
> +			value |= VREG_DIR_IN;
> +
> +		value &= ~PD_VREG;
> +		value &= ~VREG_DIR(~0);
> +		value &= ~VREG_LEV(~0);
> +		value |= VREG_LEV(level);

This would look much cleaner with FIELD_PREP() or u32_encoded_bits()

> +	}
> +
> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +}
> +
>  static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
>  					       bool status)
>  {
> @@ -935,6 +973,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
>  	.vbus_override = tegra186_xusb_padctl_vbus_override,
>  	.utmi_pad_power_on = tegra_phy_xusb_utmi_pad_power_on,
>  	.utmi_pad_power_down = tegra_phy_xusb_utmi_pad_power_down,
> +	.utmi_pad_set_protection =
> +			tegra186_xusb_padctl_utmi_pad_set_protection,

single line please

>  };
>  
>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
> index 2e5f71c..3aff284 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -74,6 +74,8 @@
>  #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_MASK 0x3
>  #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_VAL 0x1
>  #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18 (1 << 6)
> +#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(x) (((x) & 0x3) << 7)
> +#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(x) (((x) & 0x3) << 11)
>  
>  #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x) (0x088 + (x) * 0x40)
>  #define XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD_ZI (1 << 29)
> @@ -1116,6 +1118,34 @@ static void tegra210_usb2_pad_power_down(struct phy *phy)
>  	usb2->powered_on = false;
>  }
>  
> +static void
> +tegra210_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
> +					     int level,
> +					     enum tegra_vbus_dir dir)

single line and aligned to preceeding parenthesis (hint checkpatch.pl
with --strict option tells you so)


> +{
> +	u32 value;
> +	struct tegra_xusb_padctl *padctl = port->padctl;
> +	unsigned int index = port->index;
> +
> +	value = padctl_readl(padctl,
> +			     XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));

Single line please

> +
> +	if (level < 0) {
> +		/* disable pad protection */
> +		value |= XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
> +		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
> +		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
> +	} else {
> +		value &= ~XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
> +		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
> +		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
> +		value |= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(level);
> +	}
> +
> +	padctl_writel(padctl, value,
> +		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
> +}
> +
>  static int tegra210_usb2_phy_set_mode(struct phy *phy, enum phy_mode mode,
>  				      int submode)
>  {
> @@ -2291,6 +2321,8 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
>  	.utmi_port_reset = tegra210_utmi_port_reset,
>  	.utmi_pad_power_on = tegra210_usb2_pad_power_on,
>  	.utmi_pad_power_down = tegra210_usb2_pad_power_down,
> +	.utmi_pad_set_protection =
> +			tegra210_xusb_padctl_utmi_pad_set_protection,

Here too

>  };
>  
>  static const char * const tegra210_xusb_padctl_supply_names[] = {
> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
> index 6995fc4..475bcc6 100644
> --- a/drivers/phy/tegra/xusb.h
> +++ b/drivers/phy/tegra/xusb.h
> @@ -259,6 +259,17 @@ to_sata_pad(struct tegra_xusb_pad *pad)
>   */
>  struct tegra_xusb_port_ops;
>  
> +/*
> + * Tegra OTG port VBUS direction:
> + * default (based on port capability) or
> + * as source or sink
> + */
> +enum tegra_vbus_dir {
> +	TEGRA_VBUS_DEFAULT,
> +	TEGRA_VBUS_SOURCE,
> +	TEGRA_VBUS_SINK
> +};
> +
>  struct tegra_xusb_port {
>  	struct tegra_xusb_padctl *padctl;
>  	struct tegra_xusb_lane *lane;
> @@ -398,6 +409,8 @@ struct tegra_xusb_padctl_ops {
>  	int (*utmi_port_reset)(struct phy *phy);
>  	void (*utmi_pad_power_on)(struct phy *phy);
>  	void (*utmi_pad_power_down)(struct phy *phy);
> +	void (*utmi_pad_set_protection)(struct tegra_xusb_port *port,
> +					int level, enum tegra_vbus_dir dir);
>  };
>  
>  struct tegra_xusb_padctl_soc {
> -- 
> 2.7.4

-- 
~Vinod
