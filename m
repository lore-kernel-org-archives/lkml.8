Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5051206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BoRQ16Rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgERMYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:24:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56750 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgERMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:24:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ICO8Km124534;
        Mon, 18 May 2020 07:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589804648;
        bh=9I8QiEcaEmO1r2jkUwpnJ5LxWet/9V+Ju+hCheGBXTI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BoRQ16RmxENsI4VGy5oqz0+hKGTV1mi619nY6EWiTGhEW1vinxzG5f/92gC0Zuh7f
         F6MDJpDOqseNKpV/PZeBSXxSOThoKQ0s5A7YNVTfOL/qC3kc3fXnzxH9ecsQ5Pkyqm
         jJbD40ZvRzODZfohpiM+R2UOlFsRvXbLDGuRp5mc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ICO7jc083806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 07:24:08 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 07:24:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 07:24:07 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICO4Wl093892;
        Mon, 18 May 2020 07:24:04 -0500
Subject: Re: [PATCH V3 5/8] phy: tegra: xusb: Add soc ops API to enable UTMI
 PAD protection
To:     Nagarjuna Kristam <nkristam@nvidia.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <1589437363-16727-6-git-send-email-nkristam@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <db698a53-c5f6-d03f-edf0-f4fb38963e1f@ti.com>
Date:   Mon, 18 May 2020 17:54:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589437363-16727-6-git-send-email-nkristam@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry,

On 5/14/2020 11:52 AM, Nagarjuna Kristam wrote:
> When USB charger is enabled, UTMI PAD needs to be protected according
> to the direction and current level. Add support for the same on Tegra210
> and Tegra186.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>

Can you give your Acked by for pending patches in this series?

Thanks
Kishon
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
>  };
>  
>  #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
> index caf0890..80c4349 100644
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
> @@ -1116,6 +1118,34 @@ void tegra210_usb2_pad_power_down(struct phy *phy)
>  	usb2->powered_on = false;
>  }
>  
> +static void
> +tegra210_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
> +					     int level,
> +					     enum tegra_vbus_dir dir)
> +{
> +	u32 value;
> +	struct tegra_xusb_padctl *padctl = port->padctl;
> +	unsigned int index = port->index;
> +
> +	value = padctl_readl(padctl,
> +			     XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
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
> 
