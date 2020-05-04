Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454AC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CFC20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G9FsTWdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgEDJBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:01:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13579 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgEDJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:01:04 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafd9890001>; Mon, 04 May 2020 01:59:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 02:01:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 May 2020 02:01:03 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 09:01:02 +0000
Received: from [10.19.66.205] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 09:00:58 +0000
Subject: Re: [PATCH V2 6/8] phy: tegra: xusb: Add support for charger detect
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-7-git-send-email-nkristam@nvidia.com>
 <20200428105510.GH3592148@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <ea0f5906-4681-8b84-a55a-e959ce40aece@nvidia.com>
Date:   Mon, 4 May 2020 14:32:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428105510.GH3592148@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588582793; bh=jGq5qpiiwlNqoGOWpeiBQNcPcB9UTwr/jOVlwnpkL8E=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G9FsTWdvsi+5uX6ajvRB38b3vxng3RPpVvg70Ijb5G6fys+yhfZBKt8duQAQ7Q1NO
         RU2tyRtXCBDbQfEdMoVMz6oXNEDthdmhvb7MyW+hvM3sIHum2NKOPQVAmVxNCqOPxJ
         fTaHTeTS4b0cpltxLLX9/aF3JhrZIA5Eiu9d+iyMfOB24muJCZxPtk9Y3XuEPa3X+C
         d5EUokBlXBHZtxgC8LgpM1q5Y3ENG1qwMb68niij3D7A4MnFHwT1QtYvylNKKFFiKf
         XJVe/RzEKrmfIpp3z6nm4Bj9kTfy2Lypr1IHq+HTjgPeUuitOsZoBx4F4ZW/yGEzAA
         uDN1wvSTt7zCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



 >On 28-04-2020 16:25, Thierry Reding wrote:
>> On Wed, Apr 15, 2020 at 01:55:06PM +0530, Nagarjuna Kristam wrote:
>> Perform charger-detect operation if corresponding dt property is enabled.
>> Update usb-phy with the detected charger state and max current values.
>> Register charger-detect API's of usb-phy to provide needed functionalities.
>>
>> Signed-off-by: Nagarjuna Kristam<nkristam@nvidia.com>
>> ---
>> V2:
>>   - Patch re-based.
>> ---
>>   drivers/phy/tegra/Makefile        |   2 +-
>>   drivers/phy/tegra/xusb-tegra-cd.c | 300 ++++++++++++++++++++++++++++++++++++++
>>   drivers/phy/tegra/xusb.c          |  80 ++++++++++
>>   drivers/phy/tegra/xusb.h          |   7 +
>>   4 files changed, 388 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/phy/tegra/xusb-tegra-cd.c
> Looks mostly good to me, just a few small nits.
> 
>> diff --git a/drivers/phy/tegra/Makefile b/drivers/phy/tegra/Makefile
>> index 89b8406..25ea9a9 100644
>> --- a/drivers/phy/tegra/Makefile
>> +++ b/drivers/phy/tegra/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_PHY_TEGRA_XUSB) += phy-tegra-xusb.o
>>   
>> -phy-tegra-xusb-y += xusb.o
>> +phy-tegra-xusb-y += xusb.o xusb-tegra-cd.o
> Splitting this off into a separate file seems a little arbitrary. If
> adding this to xusb.c is really making things too unwieldy, I'd suggest
> a different name. Perhaps something like xusb-charger.c, or just cd.c.
> This is already in a directory called "tegra" and it's obvious also that
> this is part of the XUSB PHY driver.
> 
Will add as cd.c
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_124_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_132_SOC) += xusb-tegra124.o
>>   phy-tegra-xusb-$(CONFIG_ARCH_TEGRA_210_SOC) += xusb-tegra210.o
>> diff --git a/drivers/phy/tegra/xusb-tegra-cd.c b/drivers/phy/tegra/xusb-tegra-cd.c
>> new file mode 100644
>> index 0000000..0fafc68
>> --- /dev/null
>> +++ b/drivers/phy/tegra/xusb-tegra-cd.c
>> @@ -0,0 +1,300 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/phy/phy.h>
>> +
>> +#include "xusb.h"
>> +
>> +/* Data contact detection timeout */
>> +#define TDCD_TIMEOUT_MS                         400
>> +
>> +#define USB2_BATTERY_CHRG_OTGPADX_CTL0(x)       (0x80 + (x) * 0x40)
>> +#define  PD_CHG                                 (1 << 0)
>> +#define  VDCD_DET_FILTER_EN                     (1 << 4)
>> +#define  VDAT_DET                               (1 << 5)
>> +#define  VDAT_DET_FILTER_EN                     (1 << 8)
>> +#define  OP_SINK_EN                             (1 << 9)
>> +#define  OP_SRC_EN                              (1 << 10)
>> +#define  ON_SINK_EN                             (1 << 11)
>> +#define  ON_SRC_EN                              (1 << 12)
>> +#define  OP_I_SRC_EN                            (1 << 13)
>> +#define  ZIP_FILTER_EN                          (1 << 21)
>> +#define  ZIN_FILTER_EN                          (1 << 25)
>> +#define  DCD_DETECTED                           (1 << 26)
>> +
>> +#define USB2_BATTERY_CHRG_OTGPADX_CTL1(x)       (0x84 + (x) * 0x40)
>> +#define  PD_VREG                                (1 << 6)
>> +#define  VREG_LEV(x)                            (((x) & 0x3) << 7)
>> +#define  VREG_DIR(x)                            (((x) & 0x3) << 11)
>> +#define  VREG_DIR_IN                            VREG_DIR(1)
>> +#define  VREG_DIR_OUT                           VREG_DIR(2)
>> +#define  USBOP_RPD_OVRD                         (1 << 16)
>> +#define  USBOP_RPD_OVRD_VAL                     (1 << 17)
>> +#define  USBOP_RPU_OVRD                         (1 << 18)
>> +#define  USBOP_RPU_OVRD_VAL                     (1 << 19)
>> +#define  USBON_RPD_OVRD                         (1 << 20)
>> +#define  USBON_RPD_OVRD_VAL                     (1 << 21)
>> +#define  USBON_RPU_OVRD                         (1 << 22)
>> +#define  USBON_RPU_OVRD_VAL                     (1 << 23)
>> +
>> +#define XUSB_PADCTL_USB2_OTG_PADX_CTL0(x)	(0x88 + (x) * 0x40)
> There's a bit of a mix of spaces and tabs for indentation here. Just
> pick one and stick with it. I think checkpatch will want you to use tabs
> first and then spaces if additional indentation is needed.
> 
Will update accordingly
>> +#define  USB2_OTG_PD2                           (1 << 27)
>> +#define  USB2_OTG_PD2_OVRD_EN                   (1 << 28)
>> +#define  USB2_OTG_PD_ZI                         (1 << 29)
>> +
>> +#define XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0 (0x280)
>> +#define   TDCD_DBNC(x)                          (((x) & 0x7ff) << 0)
>> +
>> +static void tegra_xusb_padctl_set_debounce_time(
>> +				struct tegra_xusb_padctl *padctl, u32 val)
> Perhaps rename "val" to something like "debounce", or "delay" or
> something to avoid the "val" vs. "value" confusion. Also, wrapping
> should be after the return type. Same for most functions below.
> 
Will update accordingly
>> +{
>> +	u32 value;
>> +
>> +	value = padctl_readl(padctl,
>> +		XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0);
>> +	value &= ~(TDCD_DBNC(0));
>> +	value |= TDCD_DBNC(val);
>> +	padctl_writel(padctl, value,
>> +		XUSB_PADCTL_USB2_BATTERY_CHRG_TDCD_DBNC_TIMER_0);
>> +}
>> +
>> +static void tegra_xusb_padctl_utmi_pad_charger_detect_on(
>> +				struct tegra_xusb_padctl *padctl, u32 index)
> In general these function names are a little long for my taste. Charger
> detection can only happen on UTMI pads, right? So could we just drop the
> _utmi_pad infix in these? That doesn't give us much, but at least it
> should make splitting this across multiple lines less awkward.
> 
will remove utmi_pad_ and shorten the functions.
>> +{
>> +	u32 value;
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +	value &= ~USB2_OTG_PD_ZI;
>> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +	value |= (USB2_OTG_PD2 | USB2_OTG_PD2_OVRD_EN);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value &= ~PD_CHG;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	/* Set DP/DN Pull up/down to zero by default */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +	value &= ~(USBOP_RPD_OVRD_VAL | USBOP_RPU_OVRD_VAL |
>> +		USBON_RPD_OVRD_VAL | USBON_RPU_OVRD_VAL);
>> +	value |= (USBOP_RPD_OVRD | USBOP_RPU_OVRD |
>> +		USBON_RPD_OVRD | USBON_RPU_OVRD);
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	/* Disable DP/DN as src/sink */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value &= ~(OP_SRC_EN | ON_SINK_EN |
>> +	ON_SRC_EN | OP_SINK_EN);
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +}
>> +
>> +static void tegra_xusb_padctl_utmi_pad_charger_detect_off(
>> +				struct tegra_xusb_padctl *padctl, u32 index)
>> +{
>> +	u32 value;
>> +
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +	value &= ~(USBOP_RPD_OVRD | USBOP_RPU_OVRD |
>> +		 USBON_RPD_OVRD | USBON_RPU_OVRD);
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	/* power down necessary stuff */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value |= PD_CHG;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +	value &= ~(USB2_OTG_PD2 | USB2_OTG_PD2_OVRD_EN);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +}
>> +
>> +
>> +static void tegra_xusb_padctl_detect_filters(
>> +				struct tegra_xusb_padctl *padctl, u32 index,
>> +				bool on)
>> +{
>> +	u32 value;
>> +
>> +	if (on) {
>> +		value = padctl_readl(padctl,
>> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +		value |= (VDCD_DET_FILTER_EN | VDAT_DET_FILTER_EN |
>> +			  ZIP_FILTER_EN | ZIN_FILTER_EN);
>> +		padctl_writel(padctl, value,
>> +			      USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	} else {
>> +		value = padctl_readl(padctl,
>> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +		value &= ~(VDCD_DET_FILTER_EN | VDAT_DET_FILTER_EN |
>> +			   ZIP_FILTER_EN | ZIN_FILTER_EN);
>> +		padctl_writel(padctl, value,
>> +			      USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	}
>> +}
>> +
>> +static void tegra_xusb_padctl_utmi_pad_dcd(struct tegra_xusb_padctl *padctl,
>> +					      u32 index)
>> +{
>> +	u32 value;
>> +	int dcd_timeout_ms = 0;
>> +	bool ret = false;
>> +
>> +	/* Turn on IDP_SRC */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value |= OP_I_SRC_EN;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	/* Turn on D- pull-down resistor */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +	value |= USBON_RPD_OVRD_VAL;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	/* Wait for TDCD_DBNC */
>> +	usleep_range(10000, 120000);
>  From the comment this looks like we're waiting for some hardware
> condition. Can we somehow obtain this rather than implementing a fixed
> sleep? Especially since the range here is so large.
> 
As per data sheet we need to wait for 10 micro seconds as settle time.
>> +
>> +	while (dcd_timeout_ms < TDCD_TIMEOUT_MS) {
>> +		value = padctl_readl(padctl,
>> +				     USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +		if (value & DCD_DETECTED) {
>> +			dev_dbg(padctl->dev, "USB2 port %d DCD successful\n",
>> +				index);
>> +			ret = true;
>> +			break;
>> +		}
>> +
>> +		usleep_range(20000, 22000);
>> +		dcd_timeout_ms += 22;
>> +	}
> Can we just use a timed loop instead? You should be able to use
> something like:
Will update using single API accordingly
> 
> 		unsigned int offset = USB2_BATTERY_CHRG_OTGPADX_CTL0(index);
> 
> 		err = readl_poll_timeout(padctl->regs + offset, value,
> 					 value & DCD_DETECTED,
> 					 22000, TDCD_TIMEOUT_MS * 1000);
> 
> That's slightly suboptimal because it doesn't let you use padctl_readl,
> but at least it gives you a standard way of doing this kind of loop.
> 
>> +
>> +	if (!ret)
>> +		dev_info(padctl->dev, "%s: DCD timeout %d ms\n", __func__,
>> +			 dcd_timeout_ms);
> Should this be a dev_err() or dev_warn()? Is this expected to happen?
> 
In general shouldnot happen, will mark as warn.
>> +
>> +	/* Turn off IP_SRC, clear DCD DETECTED*/
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value &= ~OP_I_SRC_EN;
>> +	value |= DCD_DETECTED;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	/* Turn off D- pull-down resistor */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +	value &= ~USBON_RPD_OVRD_VAL;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>> +
>> +	dev_dbg(padctl->dev, "DCD: %d\n", ret);
>> +}
>> +
>> +static bool tegra_xusb_padctl_utmi_pad_primary_charger_detect(
>> +				struct tegra_xusb_padctl *padctl, u32 index)
>> +{
>> +	u32 value;
>> +	int ret = false;
> It doesn't look like there's a need to initialize this.
> 
will remove.
>> +
>> +	/* data contact detection */
>> +	tegra_xusb_padctl_utmi_pad_dcd(padctl, index);
>> +
>> +	/* Source D+ to D- */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value |= OP_SRC_EN | ON_SINK_EN;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	/* Wait for TVDPSRC_ON */
>> +	msleep(40);
> Again, is this a hardware condition that we can wait on by polling a
> register?
> 
It HW settle time before reading registers.
>> +
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	ret = !!(value & VDAT_DET);
>> +
>> +	/* Turn off OP_SRC, ON_SINK, clear VDAT, ZIN status change */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value &= ~(OP_SRC_EN | ON_SINK_EN);
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	return ret;
>> +}
>> +
>> +static bool tegra_xusb_padctl_utmi_pad_secondary_charger_detect(
>> +				struct tegra_xusb_padctl *padctl, u32 index)
>> +{
>> +	u32 value;
>> +	bool ret = false;
>> +
>> +	/* Source D- to D+ */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value |= ON_SRC_EN | OP_SINK_EN;
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	/* Wait for TVDPSRC_ON */
>> +	msleep(40);
>> +
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	ret = !(value & VDAT_DET);
>> +
>> +	/* Turn off ON_SRC, OP_SINK, clear VDAT, ZIP status change */
>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +	value &= ~(ON_SRC_EN | OP_SINK_EN);
>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>> +
>> +	return ret;
>> +}
> This seems to be mostly identical to the primary charger detect, so
> perhaps this can be parameterized instead? I'm not generally opposed to
> splitting functions up like this if they are fairly small, but in this
> particular case, splitting up could make the name a lot shorter, and in
> this case it's really quite excessive (I count 51 characters...) =)
> Will update accordingly
>> +
>> +enum usb_charger_type tegra_xusb_padctl_charger_detect(
>> +					  struct tegra_xusb_port *port)
>> +{
>> +	struct tegra_xusb_padctl *padctl = port->padctl;
>> +	struct phy *phy = port->lane->pad->lanes[port->index];
>> +	struct tegra_xusb_usb2_lane *usb2 = to_usb2_lane(port->lane);
>> +	u32 index = port->index;
>> +	enum usb_charger_type chrg_type;
>> +	bool pad_power_off = false;
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	if (!usb2->powered_on) {
>> +		padctl->soc->ops->utmi_pad_power_on(phy);
>> +		pad_power_off = true;
>> +	}
>> +
>> +	tegra_xusb_padctl_utmi_pad_charger_detect_on(padctl, index);
>> +	tegra_xusb_padctl_set_debounce_time(padctl, 0xa);
> Perhaps use 10 here because that's how we're usually used to read time
> values.
> 
Will update accordingly
>> +	tegra_xusb_padctl_detect_filters(padctl, index, true);
>> +
>> +	if (tegra_xusb_padctl_utmi_pad_primary_charger_detect(padctl,
>> +								 index)) {
>> +		/*
>> +		 * wait 20ms (max of TVDMSRC_DIS) for D- to be disabled
>> +		 * from host side, before we perform secondary detection.
>> +		 * Some hosts may not respond well if we do secondary
>> +		 * detection right after primary detection.
>> +		 */
>> +		msleep(20);
> Could use a blank line after this for readability.
> 
Will update accordingly
>> +		if (tegra_xusb_padctl_utmi_pad_secondary_charger_detect(padctl,
>> +									index))
>> +			chrg_type = CDP_TYPE;
>> +		else
>> +			chrg_type = DCP_TYPE;
>> +	} else {
>> +		chrg_type = SDP_TYPE;
>> +	}
>> +
>> +	dev_dbg(&port->dev, "charger detected of type %d", chrg_type);
> Do we have a string representation of this?
> 
No String representation available. Shall i add one for wasy reading ?
>> +
>> +	tegra_xusb_padctl_detect_filters(padctl, index, false);
>> +	tegra_xusb_padctl_utmi_pad_charger_detect_off(padctl, index);
>> +
>> +	if (pad_power_off)
>> +		padctl->soc->ops->utmi_pad_power_down(phy);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +	return chrg_type;
>> +}
>> +
>> +MODULE_AUTHOR("Nagarjuna Kristam<nkristam@nvidia.com>");
>> +MODULE_DESCRIPTION("NVIDIA Tegra186 XUSB charger detect driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index de4a46f..e505ac4 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -591,6 +591,50 @@ static enum usb_phy_events to_usb_phy_event(enum usb_role role)
>>   	}
>>   }
>>   
>> +#define VON_DIV2P0_DET BIT(0)
>> +#define VON_DIV2P7_DET BIT(1)
>> +#define VOP_DIV2P0_DET BIT(2)
>> +#define VOP_DIV2P7_DET BIT(3)
>> +
>> +#define VREG_CUR_LEVEL_0        500
>> +#define VREG_CUR_LEVEL_1        900
>> +#define VREG_CUR_LEVEL_2        1500
>> +#define VREG_CUR_LEVEL_3        2000
>> +
>> +#define IS_CUR_IN_RANGE(ma, low, high)  \
>> +	((ma >= VREG_CUR_LEVEL_##low) && (ma <= (VREG_CUR_LEVEL_##high - 1)))
>> +#define VREG_LVL(ma, level)     IS_CUR_IN_RANGE(ma, level, level + 1)
>> +
>> +static void tegra_xusb_padctl_vbus_pad_portection(struct tegra_xusb_port *port)
>> +{
>> +	struct tegra_xusb_padctl *padctl = port->padctl;
>> +	int level = 0;
>> +	enum tegra_vbus_dir dir = TEGRA_VBUS_SINK;
>> +	int max_ua, min_ua;
>> +
>> +	if (!padctl->soc->ops->utmi_pad_set_protection_level)
>> +		return;
>> +
>> +	usb_phy_get_charger_current(&port->usb_phy, &min_ua, &max_ua);
>> +
>> +	if (max_ua == 0) {
>> +		level = -1;
>> +		dir = TEGRA_VBUS_DEFAULT;
>> +	} else if (VREG_LVL(max_ua, 0)) {
>> +		level = 0;
>> +	} else if (VREG_LVL(max_ua, 1)) {
>> +		level = 1;
>> +	} else if (VREG_LVL(max_ua, 2)) {
>> +		level = 2;
>> +	} else if (max_ua >= VREG_CUR_LEVEL_3) {
>> +		level = 3;
>> +	} else {
>> +		return;
>> +	}
>> +
>> +	padctl->soc->ops->utmi_pad_set_protection_level(port, max_ua, dir);
>> +}
> level seems to never be used in the above. Instead you just pass max_ua
> to the set protection level callback.
> 
Will remove accordingly
>> +
>>   static void tegra_xusb_usb_phy_work(struct work_struct *work)
>>   {
>>   	struct tegra_xusb_port *port = container_of(work,
>> @@ -598,6 +642,10 @@ static void tegra_xusb_usb_phy_work(struct work_struct *work)
>>   						    usb_phy_work);
>>   	enum usb_role role = usb_role_switch_get_role(port->usb_role_sw);
>>   
>> +	/* Set role to none, if charger is DCP type */
>> +	if (port->chrg_type == DCP_TYPE)
>> +		role = USB_ROLE_NONE;
>> +
>>   	usb_phy_set_event(&port->usb_phy, to_usb_phy_event(role));
>>   
>>   	dev_dbg(&port->dev, "%s(): calling notifier for role %s\n", __func__,
>> @@ -610,9 +658,26 @@ static int tegra_xusb_role_sw_set(struct usb_role_switch *sw,
>>   				  enum usb_role role)
>>   {
>>   	struct tegra_xusb_port *port = usb_role_switch_get_drvdata(sw);
>> +	enum usb_charger_state charger_state;
>>   
>>   	dev_dbg(&port->dev, "%s(): role %s\n", __func__, usb_roles[role]);
>>   
>> +	/* Do charger detect if role is Device and charger detect is enabled */
>> +	if (port->charger_detect) {
>> +		if (role == USB_ROLE_DEVICE)
>> +			port->chrg_type =
>> +					 tegra_xusb_padctl_charger_detect(port);
>> +		else
>> +			port->chrg_type = UNKNOWN_TYPE;
>> +
>> +		charger_state = (port->chrg_type == UNKNOWN_TYPE) ?
>> +				 USB_CHARGER_ABSENT : USB_CHARGER_PRESENT;
>> +
>> +		usb_phy_set_charger_state(&port->usb_phy, charger_state);
>> +
>> +		tegra_xusb_padctl_vbus_pad_portection(port);
>> +	}
>> +
>>   	schedule_work(&port->usb_phy_work);
>>   
>>   	return 0;
>> @@ -643,6 +708,14 @@ static int tegra_xusb_set_host(struct usb_otg *otg, struct usb_bus *host)
>>   	return 0;
>>   }
>>   
>> +static enum usb_charger_type tegra_xusb_charger_detect(struct usb_phy *usb_phy)
>> +{
>> +	struct tegra_xusb_port *port = container_of(usb_phy,
>> +						    struct tegra_xusb_port,
>> +						    usb_phy);
>> +
>> +	return port->chrg_type;
>> +}
>>   
>>   static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>>   {
>> @@ -693,6 +766,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
>>   	port->usb_phy.otg->set_peripheral = tegra_xusb_set_peripheral;
>>   	port->usb_phy.otg->set_host = tegra_xusb_set_host;
>>   
>> +	if (port->charger_detect)
>> +		port->usb_phy.charger_detect = tegra_xusb_charger_detect;
>> +
>>   	err = usb_add_phy_dev(&port->usb_phy);
>>   	if (err < 0) {
>>   		dev_err(&port->dev, "Failed to add USB PHY: %d\n", err);
>> @@ -727,6 +803,10 @@ static int tegra_xusb_usb2_port_parse_dt(struct tegra_xusb_usb2_port *usb2)
>>   		usb2->mode = USB_DR_MODE_HOST;
>>   	}
>>   
>> +	if (port->padctl->soc->charger_detect &&
>> +	    of_property_read_bool(np, "nvidia,charger-detect"))
>> +		port->charger_detect = true;
>> +
>>   	/* usb-role-switch property is mandatory for OTG/Peripheral modes */
>>   	if (usb2->mode == USB_DR_MODE_PERIPHERAL ||
>>   	    usb2->mode == USB_DR_MODE_OTG) {
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 79e96b0..714bca2 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -282,6 +282,9 @@ struct tegra_xusb_port {
>>   	struct work_struct usb_phy_work;
>>   	struct usb_phy usb_phy;
>>   
>> +	bool charger_detect;
>> +	enum usb_charger_type chrg_type;
>> +
>>   	const struct tegra_xusb_port_ops *ops;
>>   };
>>   
>> @@ -306,6 +309,9 @@ struct tegra_xusb_port *
>>   tegra_xusb_find_port(struct tegra_xusb_padctl *padctl, const char *type,
>>   		     unsigned int index);
>>   
>> +enum usb_charger_type tegra_xusb_padctl_charger_detect(
>> +					  struct tegra_xusb_port *port);
>> +
>>   struct tegra_xusb_usb2_port {
>>   	struct tegra_xusb_port base;
>>   
>> @@ -430,6 +436,7 @@ struct tegra_xusb_padctl_soc {
>>   	unsigned int num_supplies;
>>   	bool supports_gen2;
>>   	bool need_fake_usb3_port;
>> +	bool charger_detect;
> Perhaps make this "supports_charger_detection" because it being in the
> SoC structure means that it's a capability. "charger_detect" makes it
> look like an option that we've enabled or not. That's what struct
> tegra_xusb_port.charger_detect already is.
> 
Will update accordingly
-Nagarjuna
> Thierry
> 
