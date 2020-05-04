Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7FEC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77802054F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h1TUPmvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEDKYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:24:39 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14349 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDKYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:24:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafece70001>; Mon, 04 May 2020 03:22:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 03:24:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 May 2020 03:24:38 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 10:24:38 +0000
Received: from [10.19.66.205] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 10:24:33 +0000
Subject: Re: [PATCH V2 5/8] phy: tegra: xusb: Add soc ops API to enable UTMI
 PAD protection
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-6-git-send-email-nkristam@nvidia.com>
 <20200428101515.GE3592148@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <8ce32a32-7d28-6ba2-ca82-18f40b1477b7@nvidia.com>
Date:   Mon, 4 May 2020 15:56:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428101515.GE3592148@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588587751; bh=NV7MEJ6CFQlKaEaHV4Y/1UEDjWTDLJ7GAiwjhJ/RABQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=h1TUPmvFFG3XtKOyPmynG4X7881mZToJ5zagLFJnQHBo9nDG6B82Teh9SjUYbbX33
         4qxNN1cm/v+xTGLpPcZ+0N6sYsWSZAPwt5VHSvOP+YL8wF1+Q0VY15B/CP3zxQHkk0
         2G9IL8nSliNcn7cfZfNsSNna0ZVp6DQ9LNkUXQgnWlxwhj30X/l/yMCn/bJyIcOGTX
         CKls0NfuGc1aw41N/5HPEKLA6zBpbhcCXjvoFTIKSXRq1SI8gll2XYnqfjSlnD5HoA
         jq4vh6smANUw829ZoHBpfB3ooqivgKevcrL8kUV4g43efgkvZO3bh4Avhc10ZE2E0Y
         2xT0YN0//RoZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-04-2020 15:45, Thierry Reding wrote:
> On Wed, Apr 15, 2020 at 01:55:05PM +0530, Nagarjuna Kristam wrote:
>> When USB charger is enabled, UTMI PAD needs to be protected according
>> to the direction and current level. Add support for the same on Tegra210
>> and Tegra186.
>>
>> Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
>> ---
>> V2:
>>   - Commit message coorected.
>>   - Patch re-based.
>> ---
>>   drivers/phy/tegra/xusb-tegra186.c | 40 +++++++++++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb-tegra210.c | 31 ++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb.h          | 13 +++++++++++++
>>   3 files changed, 84 insertions(+)
> Oh wait... you're not actually adding custom public APIs for this but
> are simply wiring this through the SoC-specific code. Okay, that seems
> fine to me.
> 
> Ignore my comments on the prior two patches.
> 
>> diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
>> index f862254..03bdb5b 100644
>> --- a/drivers/phy/tegra/xusb-tegra186.c
>> +++ b/drivers/phy/tegra/xusb-tegra186.c
>> @@ -68,6 +68,13 @@
>>   #define   PORTX_SPEED_SUPPORT_MASK		(0x3)
>>   #define     PORT_SPEED_SUPPORT_GEN1		(0x0)
>>   
>> +#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)       (0x84 + (x) * 0x40)
>> +#define  PD_VREG                                (1 << 6)
>> +#define  VREG_LEV(x)                            (((x) & 0x3) << 7)
>> +#define  VREG_DIR(x)                            (((x) & 0x3) << 11)
>> +#define  VREG_DIR_IN                            VREG_DIR(1)
>> +#define  VREG_DIR_OUT                           VREG_DIR(2)
>> +
>>   #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
>>   #define  HS_CURR_LEVEL(x)			((x) & 0x3f)
>>   #define  TERM_SEL				BIT(25)
>> @@ -289,6 +296,37 @@ static void tegra_phy_xusb_utmi_pad_power_down(struct phy *phy)
>>   	usb2->powered_on = false;
>>   }
>>   
>> +static void tegra186_xusb_padctl_utmi_pad_set_protection_level(
>> +				struct tegra_xusb_port *port, int level,
>> +				enum tegra_vbus_dir dir)
> It's more idiomatic to wrap after the return type and while at it,
> perhaps make this name a little shorter, like so:
> 
>      static void
>      tegra186_xusb_padctl_utmi_pad_set_protection(struct tegra_xusb_port *port,
> 						 int level,
> 						 enum tegra_vbus_dir dir)
> 
Will update accordingly.
>> +{
>> +	u32 value;
>> +	struct tegra_xusb_padctl *padctl = port->padctl;
>> +	unsigned int index = port->index;
>> +
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	if (level < 0) {
>> +		/* disable pad protection */
>> +		value |= PD_VREG;
>> +		value &= ~VREG_LEV(~0);
>> +		value &= ~VREG_DIR(~0);
>> +	} else {
>> +		if (dir == TEGRA_VBUS_SOURCE)
>> +			value |= VREG_DIR_OUT;
>> +		else if (dir == TEGRA_VBUS_SINK)
>> +			value |= VREG_DIR_IN;
>> +
>> +		value &= ~PD_VREG;
>> +		value &= ~VREG_DIR(~0);
>> +		value &= ~VREG_LEV(~0);
>> +		value |= VREG_LEV(level);
>> +	}
>> +
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +}
>> +
>> +
> There's an extra blank line above that can be dropped.
> 
Will remove the same.
>>   static int tegra186_xusb_padctl_vbus_override(struct tegra_xusb_padctl *padctl,
>>   					       bool status)
>>   {
>> @@ -935,6 +973,8 @@ static const struct tegra_xusb_padctl_ops tegra186_xusb_padctl_ops = {
>>   	.vbus_override = tegra186_xusb_padctl_vbus_override,
>>   	.utmi_pad_power_on = tegra_phy_xusb_utmi_pad_power_on,
>>   	.utmi_pad_power_down = tegra_phy_xusb_utmi_pad_power_down,
>> +	.utmi_pad_set_protection_level =
>> +			tegra186_xusb_padctl_utmi_pad_set_protection_level,
>>   };
>>   
>>   #if IS_ENABLED(CONFIG_ARCH_TEGRA_186_SOC)
>> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
>> index caf0890..7d84f1a 100644
>> --- a/drivers/phy/tegra/xusb-tegra210.c
>> +++ b/drivers/phy/tegra/xusb-tegra210.c
>> @@ -74,6 +74,8 @@
>>   #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_MASK 0x3
>>   #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV_VAL 0x1
>>   #define XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18 (1 << 6)
>> +#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(x) (((x) & 0x3) << 7)
>> +#define USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(x) (((x) & 0x3) << 11)
>>   
>>   #define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x) (0x088 + (x) * 0x40)
>>   #define XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD_ZI (1 << 29)
>> @@ -1116,6 +1118,33 @@ void tegra210_usb2_pad_power_down(struct phy *phy)
>>   	usb2->powered_on = false;
>>   }
>>   
>> +static void tegra210_xusb_padctl_utmi_pad_set_protection_level(
>> +				struct tegra_xusb_port *port, int level,
>> +				enum tegra_vbus_dir dir)
> Same comment as above.
> 
will update accordingly.
>> +{
>> +	u32 value;
>> +	struct tegra_xusb_padctl *padctl = port->padctl;
>> +	unsigned int index = port->index;
>> +
>> +	value = padctl_readl(padctl,
>> +			     XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	if (level < 0) {
>> +		/* disable pad protection */
>> +		value |= XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
>> +		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
>> +		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
>> +	} else {
>> +		value &= ~XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_FIX18;
>> +		value &= ~USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_DIR(~0);
>> +		value &= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(~0);
>> +		value |= USB2_BATTERY_CHRG_OTGPAD_CTL1_VREG_LEV(level);
>> +	}
>> +
>> +	padctl_writel(padctl, value,
>> +		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +}
>> +
>>   static int tegra210_usb2_phy_set_mode(struct phy *phy, enum phy_mode mode,
>>   				      int submode)
>>   {
>> @@ -2291,6 +2320,8 @@ static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
>>   	.utmi_port_reset = tegra210_utmi_port_reset,
>>   	.utmi_pad_power_on = tegra210_usb2_pad_power_on,
>>   	.utmi_pad_power_down = tegra210_usb2_pad_power_down,
>> +	.utmi_pad_set_protection_level =
>> +			tegra210_xusb_padctl_utmi_pad_set_protection_level,
>>   };
>>   
>>   static const char * const tegra210_xusb_padctl_supply_names[] = {
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 6995fc4..79e96b0 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -259,6 +259,17 @@ to_sata_pad(struct tegra_xusb_pad *pad)
>>    */
>>   struct tegra_xusb_port_ops;
>>   
>> +/*
>> + * Tegra OTG port VBUS direction:
>> + * default (based on port capability) or
>> + * as source or sink
>> + */
>> +enum tegra_vbus_dir {
>> +	TEGRA_VBUS_DEFAULT,
>> +	TEGRA_VBUS_SOURCE,
>> +	TEGRA_VBUS_SINK
>> +};
> Can't we key off of something like the OTG mode? I thought we already
> carried that elsewhere.
> 
Unlike OTG mode, this is VBUS direction, which is different and not same 
as mode. Hence its a seperate structure.
>> +
>>   struct tegra_xusb_port {
>>   	struct tegra_xusb_padctl *padctl;
>>   	struct tegra_xusb_lane *lane;
>> @@ -398,6 +409,8 @@ struct tegra_xusb_padctl_ops {
>>   	int (*utmi_port_reset)(struct phy *phy);
>>   	void (*utmi_pad_power_on)(struct phy *phy);
>>   	void (*utmi_pad_power_down)(struct phy *phy);
>> +	void (*utmi_pad_set_protection_level)(struct tegra_xusb_port *port,
>> +					int max_ua, enum tegra_vbus_dir dir);
> You call the variable "max_ua" here but it's "level" in the
> implementations, which is slightly confusing. Please choose one and
> stick with it. Also, if it's a value in microamperes, perhaps just make
> it unsigned int?
> 
Its level actually, and needed as int, as it can carry negative value. 
Will syncronize the naming across all places.

> Thierry
