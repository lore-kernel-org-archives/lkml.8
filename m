Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D419C2BB84
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240A3208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 01:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UttuyRbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIHBOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:14:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8845 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbgIHBOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 21:14:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f56daf50000>; Mon, 07 Sep 2020 18:14:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 07 Sep 2020 18:14:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 07 Sep 2020 18:14:43 -0700
Received: from [10.19.100.126] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 01:14:36 +0000
Subject: Re: [PATCH v2 08/12] phy: tegra: xusb: t210: support wake and
 sleepwalk
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-9-jckuo@nvidia.com> <20200831123721.GE1689119@ulmo>
From:   JC Kuo <jckuo@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b3598fb1-c4aa-0874-f01c-e548774580fc@nvidia.com>
Date:   Tue, 8 Sep 2020 09:14:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831123721.GE1689119@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599527669; bh=RKegGiDMkHbdxQrum3wYP22qHQXd8i1koa/2x34F9+Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UttuyRbV+3KaBQKYO55jRCE4nj/m1yLTbz4GuOMTyPRbdDVkbcU+AkmO/ZSg8Z8F3
         EV8Ohgi1zxq7K9UQl+FrihbI0aKHFo6tHw4XB/ZQUCHMhMJKQ4h6n73xfYiI8USvJ1
         hQNJrFhPmTtjJNBy0D2/eIHaf0FQIxVczbhh05PCHAqAKI/nbaJ4lT8MhDjcMh0xms
         8PYseBnQH5o9MGck9oDVKsGg61skToHYYnz/UXQo/+9me3z1wZnOMvmI1mbkk5OLCn
         mEGyS8GKKTaKyPlQNJm2MklqT/B0qOu2Llu95w40tzCLDRUISoLX9e4xlfATH3Qg0W
         GZgP+LBGCqj5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review.

On 8/31/20 8:37 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 12:40:39PM +0800, JC Kuo wrote:
>> This commit implements Tegra210 XUSB PADCTL wake and sleepwalk
>> routines. Sleepwalk logic is in PMC (always-on) hardware block.
>> PMC driver provides managed access to the sleepwalk registers
>> via regmap framework.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/phy/tegra/xusb-tegra210.c | 1094 ++++++++++++++++++++++++++++-
>>  1 file changed, 1079 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
>> index fe1ab440424d..1c03f4ec4b59 100644
>> --- a/drivers/phy/tegra/xusb-tegra210.c
>> +++ b/drivers/phy/tegra/xusb-tegra210.c
>> @@ -16,6 +16,8 @@
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/reset.h>
>>  #include <linux/slab.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of_platform.h>
>>  
>>  #include <soc/tegra/fuse.h>
>>  
>> @@ -52,6 +54,20 @@
>>  #define XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP(x, v) (((v) & 0x7) << ((x) * 5))
>>  #define XUSB_PADCTL_SS_PORT_MAP_PORT_DISABLED 0x7
>>  
>> +#define XUSB_PADCTL_ELPG_PROGRAM_0 0x20
>> +#define   USB2_PORT_WAKE_INTERRUPT_ENABLE(x)      BIT((x))
>> +#define   USB2_PORT_WAKEUP_EVENT(x)               BIT((x) + 7)
>> +#define   SS_PORT_WAKE_INTERRUPT_ENABLE(x)        BIT((x) + 14)
>> +#define   SS_PORT_WAKEUP_EVENT(x)                 BIT((x) + 21)
>> +#define   USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(x) BIT((x) + 28)
>> +#define   USB2_HSIC_PORT_WAKEUP_EVENT(x)          BIT((x) + 30)
>> +#define   ALL_WAKE_EVENTS ( \
>> +		USB2_PORT_WAKEUP_EVENT(0) | USB2_PORT_WAKEUP_EVENT(1) | \
>> +		USB2_PORT_WAKEUP_EVENT(2) | USB2_PORT_WAKEUP_EVENT(3) | \
>> +		SS_PORT_WAKEUP_EVENT(0) | SS_PORT_WAKEUP_EVENT(1) | \
>> +		SS_PORT_WAKEUP_EVENT(2) | SS_PORT_WAKEUP_EVENT(3) | \
>> +		USB2_HSIC_PORT_WAKEUP_EVENT(0))
>> +
>>  #define XUSB_PADCTL_ELPG_PROGRAM1 0x024
>>  #define XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN (1 << 31)
>>  #define XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN_EARLY (1 << 30)
>> @@ -90,6 +106,8 @@
>>  #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR (1 << 2)
>>  #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DISC_OVRD (1 << 1)
>>  #define XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_CHRP_OVRD (1 << 0)
>> +#define   RPD_CTRL(x)                      (((x) & 0x1f) << 26)
>> +#define   RPD_CTRL_VALUE(x)                (((x) >> 26) & 0x1f)
>>  
>>  #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0 0x284
>>  #define XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD (1 << 11)
>> @@ -108,6 +126,8 @@
>>  #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_SHIFT 12
>>  #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK 0x7f
>>  #define XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_VAL 0x1e
>> +#define   TCTRL_VALUE(x)                (((x) & 0x3f) >> 0)
>> +#define   PCTRL_VALUE(x)                (((x) >> 6) & 0x3f)
>>  
>>  #define XUSB_PADCTL_HSIC_PADX_CTL0(x) (0x300 + (x) * 0x20)
>>  #define XUSB_PADCTL_HSIC_PAD_CTL0_RPU_STROBE (1 << 18)
>> @@ -251,16 +271,161 @@
>>  #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_FLOATING 8
>>  #define XUSB_PADCTL_USB2_VBUS_ID_OVERRIDE_GROUNDED 0
>>  
>> +/* USB2 SLEEPWALK registers */
>> +#define UTMIP(_port, _offset1, _offset2) \
>> +		(((_port) <= 2) ? (_offset1) : (_offset2))
>> +
>> +#define PMC_UTMIP_UHSIC_SLEEP_CFG(x)	UTMIP(x, 0x1fc, 0x4d0)
>> +#define   UTMIP_MASTER_ENABLE(x)		UTMIP(x, BIT(8 * (x)), BIT(0))
>> +#define   UTMIP_FSLS_USE_PMC(x)			UTMIP(x, BIT(8 * (x) + 1), \
>> +							BIT(1))
>> +#define   UTMIP_PCTRL_USE_PMC(x)		UTMIP(x, BIT(8 * (x) + 2), \
>> +							BIT(2))
>> +#define   UTMIP_TCTRL_USE_PMC(x)		UTMIP(x, BIT(8 * (x) + 3), \
>> +							BIT(3))
>> +#define   UTMIP_WAKE_VAL(_port, _value)		(((_value) & 0xf) << \
>> +					(UTMIP(_port, 8 * (_port) + 4, 4)))
>> +#define   UTMIP_WAKE_VAL_NONE(_port)		UTMIP_WAKE_VAL(_port, 12)
>> +#define   UTMIP_WAKE_VAL_ANY(_port)		UTMIP_WAKE_VAL(_port, 15)
>> +
>> +#define PMC_UTMIP_UHSIC_SLEEP_CFG1	(0x4d0)
>> +#define   UTMIP_RPU_SWITC_LOW_USE_PMC_PX(x)	BIT((x) + 8)
>> +#define   UTMIP_RPD_CTRL_USE_PMC_PX(x)		BIT((x) + 16)
>> +
>> +#define PMC_UTMIP_MASTER_CONFIG		(0x274)
>> +#define   UTMIP_PWR(x)				UTMIP(x, BIT(x), BIT(4))
>> +#define   UHSIC_PWR(x)				BIT(3)
>> +
>> +#define PMC_USB_DEBOUNCE_DEL		(0xec)
>> +#define   DEBOUNCE_VAL(x)			(((x) & 0xffff) << 0)
>> +#define   UTMIP_LINE_DEB_CNT(x)			(((x) & 0xf) << 16)
>> +#define   UHSIC_LINE_DEB_CNT(x)			(((x) & 0xf) << 20)
>> +
>> +#define PMC_UTMIP_UHSIC_FAKE(x)		UTMIP(x, 0x218, 0x294)
>> +#define   UTMIP_FAKE_USBOP_VAL(x)		UTMIP(x, BIT(4 * (x)), BIT(8))
>> +#define   UTMIP_FAKE_USBON_VAL(x)		UTMIP(x, BIT(4 * (x) + 1), \
>> +							BIT(9))
>> +#define   UTMIP_FAKE_USBOP_EN(x)		UTMIP(x, BIT(4 * (x) + 2), \
>> +							BIT(10))
>> +#define   UTMIP_FAKE_USBON_EN(x)		UTMIP(x, BIT(4 * (x) + 3), \
>> +							BIT(11))
>> +
>> +#define PMC_UTMIP_UHSIC_SLEEPWALK_CFG(x)	UTMIP(x, 0x200, 0x288)
>> +#define   UTMIP_LINEVAL_WALK_EN(x)		UTMIP(x, BIT(8 * (x) + 7), \
>> +							BIT(15))
>> +
>> +#define PMC_USB_AO			(0xf0)
>> +#define   USBOP_VAL_PD(x)			UTMIP(x, BIT(4 * (x)), BIT(20))
>> +#define   USBON_VAL_PD(x)			UTMIP(x, BIT(4 * (x) + 1), \
>> +							BIT(21))
>> +#define   STROBE_VAL_PD(x)			BIT(12)
>> +#define   DATA0_VAL_PD(x)			BIT(13)
>> +#define   DATA1_VAL_PD				BIT(24)
>> +
>> +#define PMC_UTMIP_UHSIC_SAVED_STATE(x)	UTMIP(x, 0x1f0, 0x280)
>> +#define   SPEED(_port, _value)			(((_value) & 0x3) << \
>> +						(UTMIP(_port, 8 * (_port), 8)))
>> +#define   UTMI_HS(_port)			SPEED(_port, 0)
>> +#define   UTMI_FS(_port)			SPEED(_port, 1)
>> +#define   UTMI_LS(_port)			SPEED(_port, 2)
>> +#define   UTMI_RST(_port)			SPEED(_port, 3)
>> +
>> +#define PMC_UTMIP_UHSIC_TRIGGERS		(0x1ec)
>> +#define   UTMIP_CLR_WALK_PTR(x)			UTMIP(x, BIT(x), BIT(16))
>> +#define   UTMIP_CAP_CFG(x)			UTMIP(x, BIT((x) + 4), BIT(17))
>> +#define   UTMIP_CLR_WAKE_ALARM(x)		UTMIP(x, BIT((x) + 12), \
>> +							BIT(19))
>> +#define   UHSIC_CLR_WALK_PTR			BIT(3)
>> +#define   UHSIC_CLR_WAKE_ALARM			BIT(15)
>> +
>> +#define PMC_UTMIP_SLEEPWALK_PX(x)	UTMIP(x, 0x204 + (4 * (x)), \
>> +							0x4e0)
>> +/* phase A */
>> +#define   UTMIP_USBOP_RPD_A			BIT(0)
>> +#define   UTMIP_USBON_RPD_A			BIT(1)
>> +#define   UTMIP_AP_A				BIT(4)
>> +#define   UTMIP_AN_A				BIT(5)
>> +#define   UTMIP_HIGHZ_A				BIT(6)
>> +/* phase B */
>> +#define   UTMIP_USBOP_RPD_B			BIT(8)
>> +#define   UTMIP_USBON_RPD_B			BIT(9)
>> +#define   UTMIP_AP_B				BIT(12)
>> +#define   UTMIP_AN_B				BIT(13)
>> +#define   UTMIP_HIGHZ_B				BIT(14)
>> +/* phase C */
>> +#define   UTMIP_USBOP_RPD_C			BIT(16)
>> +#define   UTMIP_USBON_RPD_C			BIT(17)
>> +#define   UTMIP_AP_C				BIT(20)
>> +#define   UTMIP_AN_C				BIT(21)
>> +#define   UTMIP_HIGHZ_C				BIT(22)
>> +/* phase D */
>> +#define   UTMIP_USBOP_RPD_D			BIT(24)
>> +#define   UTMIP_USBON_RPD_D			BIT(25)
>> +#define   UTMIP_AP_D				BIT(28)
>> +#define   UTMIP_AN_D				BIT(29)
>> +#define   UTMIP_HIGHZ_D				BIT(30)
>> +
>> +#define PMC_UTMIP_UHSIC_LINE_WAKEUP	(0x26c)
>> +#define   UTMIP_LINE_WAKEUP_EN(x)		UTMIP(x, BIT(x), BIT(4))
>> +#define   UHSIC_LINE_WAKEUP_EN			BIT(3)
>> +
>> +#define PMC_UTMIP_TERM_PAD_CFG		(0x1f8)
>> +#define   PCTRL_VAL(x)				(((x) & 0x3f) << 1)
>> +#define   TCTRL_VAL(x)				(((x) & 0x3f) << 7)
>> +
>> +#define PMC_UTMIP_PAD_CFGX(x)		(0x4c0 + (4 * (x)))
>> +#define   RPD_CTRL_PX(x)			(((x) & 0x1f) << 22)
>> +
>> +#define PMC_UHSIC_SLEEP_CFG	PMC_UTMIP_UHSIC_SLEEP_CFG(0)
>> +#define   UHSIC_MASTER_ENABLE			BIT(24)
>> +#define   UHSIC_WAKE_VAL(_value)		(((_value) & 0xf) << 28)
>> +#define   UHSIC_WAKE_VAL_SD10			UHSIC_WAKE_VAL(2)
>> +#define   UHSIC_WAKE_VAL_NONE			UHSIC_WAKE_VAL(12)
>> +
>> +#define PMC_UHSIC_FAKE			PMC_UTMIP_UHSIC_FAKE(0)
>> +#define   UHSIC_FAKE_STROBE_VAL			BIT(12)
>> +#define   UHSIC_FAKE_DATA_VAL			BIT(13)
>> +#define   UHSIC_FAKE_STROBE_EN			BIT(14)
>> +#define   UHSIC_FAKE_DATA_EN			BIT(15)
>> +
>> +#define PMC_UHSIC_SAVED_STATE		PMC_UTMIP_UHSIC_SAVED_STATE(0)
>> +#define   UHSIC_MODE(_value)			(((_value) & 0x1) << 24)
>> +#define   UHSIC_HS				UHSIC_MODE(0)
>> +#define   UHSIC_RST				UHSIC_MODE(1)
>> +
>> +#define PMC_UHSIC_SLEEPWALK_CFG		PMC_UTMIP_UHSIC_SLEEPWALK_CFG(0)
>> +#define   UHSIC_WAKE_WALK_EN			BIT(30)
>> +#define   UHSIC_LINEVAL_WALK_EN			BIT(31)
>> +
>> +#define PMC_UHSIC_SLEEPWALK_P0		(0x210)
>> +#define   UHSIC_DATA0_RPD_A			BIT(1)
>> +#define   UHSIC_DATA0_RPU_B			BIT(11)
>> +#define   UHSIC_DATA0_RPU_C			BIT(19)
>> +#define   UHSIC_DATA0_RPU_D			BIT(27)
>> +#define   UHSIC_STROBE_RPU_A			BIT(2)
>> +#define   UHSIC_STROBE_RPD_B			BIT(8)
>> +#define   UHSIC_STROBE_RPD_C			BIT(16)
>> +#define   UHSIC_STROBE_RPD_D			BIT(24)
>> +
>>  struct tegra210_xusb_fuse_calibration {
>>  	u32 hs_curr_level[4];
>>  	u32 hs_term_range_adj;
>>  	u32 rpd_ctrl;
>>  };
>>  
>> +struct tegra210_xusb_padctl_context {
>> +	u32 usb2_pad_mux;
>> +	u32 usb2_port_cap;
>> +	u32 ss_port_map;
>> +	u32 usb3_pad_mux;
>> +};
>> +
>>  struct tegra210_xusb_padctl {
>>  	struct tegra_xusb_padctl base;
>>  
>>  	struct tegra210_xusb_fuse_calibration fuse;
>> +	struct tegra210_xusb_padctl_context context;
>> +	struct regmap *pmc_reg;
> 
> I'd move this more towards the top because it's a resource that we're
> requesting early on. Also, perhaps just name it "regmap" since "pmc_reg"
> could be mistaken for a "PMC register offset".
> 
Yes, I will move and rename.
>>  };
>>  
>>  static inline struct tegra210_xusb_padctl *
>> @@ -886,6 +1051,671 @@ static int tegra210_hsic_set_idle(struct tegra_xusb_padctl *padctl,
>>  	return 0;
>>  }
>>  
>> +static int tegra210_usb3_enable_phy_sleepwalk(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	int port = tegra210_usb3_lane_map(lane);
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	if (port < 0) {
>> +		dev_err(dev, "invalid usb3 port number\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "phy enable sleepwalk usb3 %d\n", port);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>> +	value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> +
>> +	usleep_range(100, 200);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>> +	value |= XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> +
>> +	usleep_range(250, 350);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_usb3_disable_phy_sleepwalk(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	int port = tegra210_usb3_lane_map(lane);
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	if (port < 0) {
>> +		dev_err(dev, "invalid usb3 port number\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "phy disable sleepwalk usb3 %d\n", port);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>> +	value &= ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN_EARLY(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> +
>> +	usleep_range(100, 200);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>> +	value &= ~XUSB_PADCTL_ELPG_PROGRAM1_SSPX_ELPG_CLAMP_EN(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_usb3_enable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	int port = tegra210_usb3_lane_map(lane);
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	if (port < 0) {
>> +		dev_err(dev, "invalid usb3 port number\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "phy enable wake usb3 %d\n", port);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= SS_PORT_WAKEUP_EVENT(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= SS_PORT_WAKE_INTERRUPT_ENABLE(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_usb3_disable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	int port = tegra210_usb3_lane_map(lane);
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	if (port < 0) {
>> +		dev_err(dev, "invalid usb3 port number\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "phy disable wake usb3 %d\n", port);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value &= ~SS_PORT_WAKE_INTERRUPT_ENABLE(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= SS_PORT_WAKEUP_EVENT(port);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_utmi_enable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy enable wake on usb2 %d\n", index);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_PORT_WAKEUP_EVENT(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_utmi_disable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy disable wake on usb2 %d\n", index);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value &= ~USB2_PORT_WAKE_INTERRUPT_ENABLE(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_PORT_WAKEUP_EVENT(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_hsic_enable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy enable wake on hsic %d\n", index);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_HSIC_PORT_WAKEUP_EVENT(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_hsic_disable_phy_wake(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct device *dev = padctl->dev;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy disable wake on hsic %d\n", index);
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value &= ~USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	usleep_range(10, 20);
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	value &= ~ALL_WAKE_EVENTS;
>> +	value |= USB2_HSIC_PORT_WAKEUP_EVENT(index);
>> +	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra210_usb3_phy_remote_wake_detected(
>> +			struct tegra_xusb_padctl *padctl, int port)
> 
> The 80 column limit no longer applies and you can now use up to 100
> columns. There's a couple of other places where you've unnecessarily
> wrapped too early.
> 
Got it. Thanks.
>> +{
>> +	u32 value;
>> +
>> +	if (port < 0) {
> 
> Do we need this check here? Since this is a local helper, shouldn't all
> the callers already make sure that they're not passing in invalid
> values?
> 
I will remove it.
>> +		dev_err(padctl->dev, "invalid usb3 port number %d\n",
>> +					port);
>> +		return false;
> 
> If you want the function to return bool, just make the return type bool
> as well.
> 
I will change the return type.
>> +	}
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	if ((value & SS_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
>> +	    (value & SS_PORT_WAKEUP_EVENT(port)))
>> +		return true;
>> +	else
>> +		return false;
> 
> The else is not needed here.
> 
Got it. Thanks.
>> +}
>> +
>> +static int tegra210_utmi_phy_remote_wake_detected(
>> +			struct tegra_xusb_padctl *padctl, int port)
>> +{
>> +	u32 value;
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	if ((value & USB2_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
>> +	    (value & USB2_PORT_WAKEUP_EVENT(port)))
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +
>> +static int tegra210_hsic_phy_remote_wake_detected(
>> +			struct tegra_xusb_padctl *padctl, int port)
>> +{
>> +	u32 value;
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM_0);
>> +	if ((value & USB2_HSIC_PORT_WAKE_INTERRUPT_ENABLE(port)) &&
>> +	    (value & USB2_HSIC_PORT_WAKEUP_EVENT(port)))
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> Perhaps you want to sort these with the USB3, HSIC and UTMI functions
> above rather than sort them by type of function?
> 
Yes, I will do accordingly.
>> +
>> +#define padctl_pmc_readl(_priv, _offset)			\
>> +({								\
>> +	int rc;							\
>> +	u32 val;						\
> 
> s/val/value/ here and below.
> 
Sure.
>> +	rc = regmap_read(_priv->pmc_reg, _offset, &val);	\
>> +	if (rc)							\
>> +		return rc;					\
>> +	val;							\
>> +})
>> +
>> +#define padctl_pmc_writel(_priv, _val, _offset)			\
>> +do {								\
>> +	int rc;							\
>> +	rc = regmap_write(_priv->pmc_reg, _offset, _val);	\
>> +	if (rc)							\
>> +		return rc;					\
>> +} while (0)
>> +
>> +/* T210 USB2 SLEEPWALK APIs */
> 
> Tegra210, please. Although this really shouldn't be needed, since you
> can derive as much from the function names.
> 
I will remove it.
>> +int tegra_pmc_utmi_enable_phy_sleepwalk(struct phy *phy,
>> +					enum usb_device_speed speed)
> 
> Perhaps use tegra210_ as the prefix for consistency?
> 
Sure, will do.
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +	struct device *dev = padctl->dev;
>> +	unsigned int port = lane->index;
>> +	u32 val, tctrl, pctrl, rpd_ctrl;
> 
> s/val/value/ here and below.
> 
Got it.
>> +
>> +	if (speed > USB_SPEED_HIGH)
>> +		return -EINVAL;
>> +
>> +	dev_dbg(dev, "phy enable sleepwalk usb2 %d speed %d\n", port, speed);
>> +
>> +	val = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
>> +	tctrl = TCTRL_VALUE(val);
>> +	pctrl = PCTRL_VALUE(val);
>> +
>> +	val = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(port));
>> +	rpd_ctrl = RPD_CTRL_VALUE(val);
>> +
>> +	/* ensure sleepwalk logic is disabled */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	val &= ~UTMIP_MASTER_ENABLE(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	/* ensure sleepwalk logics are in low power mode */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_MASTER_CONFIG);
>> +	val |= UTMIP_PWR(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_MASTER_CONFIG);
>> +
>> +	/* set debounce time */
>> +	val = padctl_pmc_readl(priv, PMC_USB_DEBOUNCE_DEL);
>> +	val &= ~UTMIP_LINE_DEB_CNT(~0);
>> +	val |= UTMIP_LINE_DEB_CNT(0x1);
>> +	padctl_pmc_writel(priv, val, PMC_USB_DEBOUNCE_DEL);
>> +
>> +	/* ensure fake events of sleepwalk logic are desiabled */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_FAKE(port));
>> +	val &= ~(UTMIP_FAKE_USBOP_VAL(port) | UTMIP_FAKE_USBON_VAL(port) |
>> +			UTMIP_FAKE_USBOP_EN(port) | UTMIP_FAKE_USBON_EN(port));
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_FAKE(port));
>> +
>> +	/* ensure wake events of sleepwalk logic are not latched */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	val &= ~UTMIP_LINE_WAKEUP_EN(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	/* disable wake event triggers of sleepwalk logic */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	val &= ~UTMIP_WAKE_VAL(port, ~0);
>> +	val |= UTMIP_WAKE_VAL_NONE(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	/* power down the line state detectors of the pad */
>> +	val = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	val |= (USBOP_VAL_PD(port) | USBON_VAL_PD(port));
>> +	padctl_pmc_writel(priv, val, PMC_USB_AO);
>> +
>> +	/* save state per speed */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SAVED_STATE(port));
>> +	val &= ~SPEED(port, ~0);
>> +	if (speed == USB_SPEED_HIGH)
>> +		val |= UTMI_HS(port);
>> +	else if (speed == USB_SPEED_FULL)
>> +		val |= UTMI_FS(port);
>> +	else if (speed == USB_SPEED_LOW)
>> +		val |= UTMI_LS(port);
>> +	else
>> +		val |= UTMI_RST(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SAVED_STATE(port));
>> +
>> +	/* enable the trigger of the sleepwalk logic */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEPWALK_CFG(port));
>> +	val |= UTMIP_LINEVAL_WALK_EN(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEPWALK_CFG(port));
>> +
>> +	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
>> +	 * as well as capture the configuration of the USB2.0 pad
>> +	 */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
>> +	val |= (UTMIP_CLR_WALK_PTR(port) | UTMIP_CLR_WAKE_ALARM(port) |
>> +		UTMIP_CAP_CFG(port));
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_TRIGGERS);
>> +
>> +	/* program electrical parameters read from XUSB PADCTL */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_TERM_PAD_CFG);
>> +	val &= ~(TCTRL_VAL(~0) | PCTRL_VAL(~0));
>> +	val |= (TCTRL_VAL(tctrl) | PCTRL_VAL(pctrl));
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_TERM_PAD_CFG);
>> +
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_PAD_CFGX(port));
>> +	val &= ~RPD_CTRL_PX(~0);
>> +	val |= RPD_CTRL_PX(rpd_ctrl);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_PAD_CFGX(port));
>> +
>> +	/* setup the pull-ups and pull-downs of the signals during the four
>> +	 * stages of sleepwalk.
>> +	 * if device is connected, program sleepwalk logic to maintain a J and
>> +	 * keep driving K upon seeing remote wake.
>> +	 */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_SLEEPWALK_PX(port));
>> +	val = (UTMIP_USBOP_RPD_A | UTMIP_USBOP_RPD_B | UTMIP_USBOP_RPD_C |
>> +		UTMIP_USBOP_RPD_D);
>> +	val |= (UTMIP_USBON_RPD_A | UTMIP_USBON_RPD_B | UTMIP_USBON_RPD_C |
>> +		UTMIP_USBON_RPD_D);
>> +	if (speed == USB_SPEED_UNKNOWN) {
>> +		val |= (UTMIP_HIGHZ_A | UTMIP_HIGHZ_B | UTMIP_HIGHZ_C |
>> +			UTMIP_HIGHZ_D);
>> +	} else if ((speed == USB_SPEED_HIGH) || (speed == USB_SPEED_FULL)) {
>> +		/* J state: D+/D- = high/low, K state: D+/D- = low/high */
>> +		val |= UTMIP_HIGHZ_A;
>> +		val |= UTMIP_AP_A;
>> +		val |= (UTMIP_AN_B | UTMIP_AN_C | UTMIP_AN_D);
>> +	} else if (speed == USB_SPEED_LOW) {
>> +		/* J state: D+/D- = low/high, K state: D+/D- = high/low */
>> +		val |= UTMIP_HIGHZ_A;
>> +		val |= UTMIP_AN_A;
>> +		val |= (UTMIP_AP_B | UTMIP_AP_C | UTMIP_AP_D);
>> +	}
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_SLEEPWALK_PX(port));
>> +
>> +	/* power up the line state detectors of the pad */
>> +	val = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	val &= ~(USBOP_VAL_PD(port) | USBON_VAL_PD(port));
>> +	padctl_pmc_writel(priv, val, PMC_USB_AO);
>> +
>> +	usleep_range(50, 100);
>> +
>> +	/* switch the electric control of the USB2.0 pad to PMC */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	val |= (UTMIP_FSLS_USE_PMC(port) | UTMIP_PCTRL_USE_PMC(port) |
>> +			UTMIP_TCTRL_USE_PMC(port));
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG1);
>> +	val |= (UTMIP_RPD_CTRL_USE_PMC_PX(port) |
>> +			UTMIP_RPU_SWITC_LOW_USE_PMC_PX(port));
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG1);
>> +
>> +	/* set the wake signaling trigger events */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	val &= ~UTMIP_WAKE_VAL(port, ~0);
>> +	val |= UTMIP_WAKE_VAL_ANY(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	/* enable the wake detection */
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	val |= UTMIP_MASTER_ENABLE(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	val = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	val |= UTMIP_LINE_WAKEUP_EN(port);
>> +	padctl_pmc_writel(priv, val, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	return 0;
>> +}
>> +
>> +int tegra_pmc_utmi_disable_phy_sleepwalk(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +	struct device *dev = padctl->dev;
>> +	unsigned int port = lane->index;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy disable sleepwalk usb2 %d\n", port);
>> +
>> +	/* disable the wake detection */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	value &= ~UTMIP_MASTER_ENABLE(port);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	value &= ~UTMIP_LINE_WAKEUP_EN(port);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	/* switch the electric control of the USB2.0 pad to XUSB or USB2 */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	value &= ~(UTMIP_FSLS_USE_PMC(port) | UTMIP_PCTRL_USE_PMC(port) |
>> +			UTMIP_TCTRL_USE_PMC(port));
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG1);
>> +	value &= ~(UTMIP_RPD_CTRL_USE_PMC_PX(port) |
>> +			UTMIP_RPU_SWITC_LOW_USE_PMC_PX(port));
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG1);
>> +
>> +	/* disable wake event triggers of sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +	value &= ~UTMIP_WAKE_VAL(port, ~0);
>> +	value |= UTMIP_WAKE_VAL_NONE(port);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_SLEEP_CFG(port));
>> +
>> +	/* power down the line state detectors of the port */
>> +	value = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	value |= (USBOP_VAL_PD(port) | USBON_VAL_PD(port));
>> +	padctl_pmc_writel(priv, value, PMC_USB_AO);
>> +
>> +	/* clear alarm of the sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
>> +	value |= UTMIP_CLR_WAKE_ALARM(port);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
>> +
>> +	return 0;
>> +}
>> +
>> +int tegra_pmc_hsic_enable_phy_sleepwalk(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +	struct device *dev = padctl->dev;
>> +	unsigned int port = lane->index;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy enable sleepwalk hsic %d\n", port);
>> +
>> +	/* ensure sleepwalk logic is disabled */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value &= ~UHSIC_MASTER_ENABLE;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	/* ensure sleepwalk logics are in low power mode */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_MASTER_CONFIG);
>> +	value |= UHSIC_PWR(port);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_MASTER_CONFIG);
>> +
>> +	/* set debounce time */
>> +	value = padctl_pmc_readl(priv, PMC_USB_DEBOUNCE_DEL);
>> +	value &= ~UHSIC_LINE_DEB_CNT(~0);
>> +	value |= UHSIC_LINE_DEB_CNT(0x1);
>> +	padctl_pmc_writel(priv, value, PMC_USB_DEBOUNCE_DEL);
>> +
>> +	/* ensure fake events of sleepwalk logic are desiabled */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_FAKE);
>> +	value &= ~(UHSIC_FAKE_STROBE_VAL | UHSIC_FAKE_DATA_VAL |
>> +			UHSIC_FAKE_STROBE_EN | UHSIC_FAKE_DATA_EN);
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_FAKE);
>> +
>> +	/* ensure wake events of sleepwalk logic are not latched */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	value &= ~UHSIC_LINE_WAKEUP_EN;
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	/* disable wake event triggers of sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value &= ~UHSIC_WAKE_VAL(~0);
>> +	value |= UHSIC_WAKE_VAL_NONE;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	/* power down the line state detectors of the port */
>> +	value = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	value |= (STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
>> +	padctl_pmc_writel(priv, value, PMC_USB_AO);
>> +
>> +	/* save state, HSIC always comes up as HS */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SAVED_STATE);
>> +	value &= ~UHSIC_MODE(~0);
>> +	value |= UHSIC_HS;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SAVED_STATE);
>> +
>> +	/* enable the trigger of the sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEPWALK_CFG);
>> +	value |= (UHSIC_WAKE_WALK_EN | UHSIC_LINEVAL_WALK_EN);
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEPWALK_CFG);
>> +
>> +	/* reset the walk pointer and clear the alarm of the sleepwalk logic,
>> +	 * as well as capture the configuration of the USB2.0 port
>> +	 */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
>> +	value |= (UHSIC_CLR_WALK_PTR | UHSIC_CLR_WAKE_ALARM);
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
>> +
>> +	/* setup the pull-ups and pull-downs of the signals during the four
>> +	 * stages of sleepwalk.
>> +	 * maintain a HSIC IDLE and keep driving HSIC RESUME upon remote wake
>> +	 */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEPWALK_P0);
>> +	value = (UHSIC_DATA0_RPD_A | UHSIC_DATA0_RPU_B | UHSIC_DATA0_RPU_C |
>> +		UHSIC_DATA0_RPU_D);
>> +	value |= (UHSIC_STROBE_RPU_A | UHSIC_STROBE_RPD_B | UHSIC_STROBE_RPD_C |
>> +		UHSIC_STROBE_RPD_D);
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEPWALK_P0);
>> +
>> +	/* power up the line state detectors of the port */
>> +	value = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	value &= ~(STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
>> +	padctl_pmc_writel(priv, value, PMC_USB_AO);
>> +
>> +	usleep_range(50, 100);
>> +
>> +	/* set the wake signaling trigger events */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value &= ~UHSIC_WAKE_VAL(~0);
>> +	value |= UHSIC_WAKE_VAL_SD10;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	/* enable the wake detection */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value |= UHSIC_MASTER_ENABLE;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	value |= UHSIC_LINE_WAKEUP_EN;
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	return 0;
>> +}
>> +
>> +int tegra_pmc_hsic_disable_phy_sleepwalk(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +	struct device *dev = padctl->dev;
>> +	unsigned int port = lane->index;
>> +	u32 value;
>> +
>> +	dev_dbg(dev, "phy disable sleepwalk hsic %d\n", port);
>> +
>> +	/* disable the wake detection */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value &= ~UHSIC_MASTER_ENABLE;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +	value &= ~UHSIC_LINE_WAKEUP_EN;
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_LINE_WAKEUP);
>> +
>> +	/* disable wake event triggers of sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UHSIC_SLEEP_CFG);
>> +	value &= ~UHSIC_WAKE_VAL(~0);
>> +	value |= UHSIC_WAKE_VAL_NONE;
>> +	padctl_pmc_writel(priv, value, PMC_UHSIC_SLEEP_CFG);
>> +
>> +	/* power down the line state detectors of the port */
>> +	value = padctl_pmc_readl(priv, PMC_USB_AO);
>> +	value |= (STROBE_VAL_PD(port) | DATA0_VAL_PD(port) | DATA1_VAL_PD);
>> +	padctl_pmc_writel(priv, value, PMC_USB_AO);
>> +
>> +	/* clear alarm of the sleepwalk logic */
>> +	value = padctl_pmc_readl(priv, PMC_UTMIP_UHSIC_TRIGGERS);
>> +	value |= UHSIC_CLR_WAKE_ALARM;
>> +	padctl_pmc_writel(priv, value, PMC_UTMIP_UHSIC_TRIGGERS);
>> +
>> +	return 0;
>> +}
>> +
>>  static int tegra210_usb3_set_lfps_detect(struct tegra_xusb_padctl *padctl,
>>  					 unsigned int index, bool enable)
>>  {
>> @@ -988,8 +1818,23 @@ static int tegra210_usb2_phy_init(struct phy *phy)
>>  {
>>  	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct tegra_xusb_usb2_port *port;
>> +	int err;
>>  	u32 value;
>>  
>> +	port = tegra_xusb_find_usb2_port(padctl, index);
>> +	if (!port) {
>> +		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
>> +		return -ENODEV;
>> +	}
>> +
>> +	err = regulator_enable(port->supply);
>> +	if (err)
>> +		return err;
>> +
>> +	mutex_lock(&padctl->lock);
>> +
>>  	value = padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
>>  	value &= ~(XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_MASK <<
>>  		   XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT);
>> @@ -997,11 +1842,29 @@ static int tegra210_usb2_phy_init(struct phy *phy)
>>  		 XUSB_PADCTL_USB2_PAD_MUX_USB2_BIAS_PAD_SHIFT;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_PAD_MUX);
>>  
>> +	mutex_unlock(&padctl->lock);
>> +
>>  	return 0;
>>  }
> 
> How is this related to sleepwalk? Should this perhaps be a separate
> patch? Looks like some hunks below are also not immediately related to
> this commit. Or perhaps I don't understand how they are related.
> 
I will make it a  change. Thanks.
>>  
>>  static int tegra210_usb2_phy_exit(struct phy *phy)
>>  {
>> +	struct tegra_xusb_lane *lane = phy_get_drvdata(phy);
>> +	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>> +	unsigned int index = lane->index;
>> +	struct tegra_xusb_usb2_port *port;
>> +	int err;
>> +
>> +	port = tegra_xusb_find_usb2_port(padctl, index);
>> +	if (!port) {
>> +		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
>> +		return -ENODEV;
>> +	}
>> +
>> +	err = regulator_disable(port->supply);
>> +	if (err)
>> +		return err;
>> +
>>  	return 0;
>>  }
>>  
>> @@ -1122,6 +1985,8 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
>>  
>>  	priv = to_tegra210_xusb_padctl(padctl);
>>  
>> +	mutex_lock(&padctl->lock);
>> +
>>  	if (port->usb3_port_fake != -1) {
>>  		value = padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
>>  		value &= ~XUSB_PADCTL_SS_PORT_MAP_PORTX_MAP_MASK(
>> @@ -1215,14 +2080,6 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
>>  	padctl_writel(padctl, value,
>>  		      XUSB_PADCTL_USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>>  
>> -	if (port->supply && port->mode == USB_DR_MODE_HOST) {
>> -		err = regulator_enable(port->supply);
>> -		if (err)
>> -			return err;
>> -	}
>> -
>> -	mutex_lock(&padctl->lock);
>> -
>>  	if (pad->enable > 0) {
>>  		pad->enable++;
>>  		mutex_unlock(&padctl->lock);
>> @@ -1231,7 +2088,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
>>  
>>  	err = clk_prepare_enable(pad->clk);
>>  	if (err)
>> -		goto disable_regulator;
>> +		goto out;
>>  
>>  	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
>>  	value &= ~((XUSB_PADCTL_USB2_BIAS_PAD_CTL1_TRK_START_TIMER_MASK <<
>> @@ -1263,8 +2120,7 @@ static int tegra210_usb2_phy_power_on(struct phy *phy)
>>  
>>  	return 0;
>>  
>> -disable_regulator:
>> -	regulator_disable(port->supply);
>> +out:
>>  	mutex_unlock(&padctl->lock);
>>  	return err;
>>  }
>> @@ -1275,12 +2131,12 @@ static int tegra210_usb2_phy_power_off(struct phy *phy)
>>  	struct tegra_xusb_usb2_pad *pad = to_usb2_pad(lane->pad);
>>  	struct tegra_xusb_padctl *padctl = lane->pad->padctl;
>>  	struct tegra_xusb_usb2_port *port;
>> +	unsigned int index = lane->index;
>>  	u32 value;
>>  
>> -	port = tegra_xusb_find_usb2_port(padctl, lane->index);
>> +	port = tegra_xusb_find_usb2_port(padctl, index);
>>  	if (!port) {
>> -		dev_err(&phy->dev, "no port found for USB2 lane %u\n",
>> -			lane->index);
>> +		dev_err(&phy->dev, "no port found for USB2 lane %u\n", index);
>>  		return -ENODEV;
>>  	}
>>  
>> @@ -1318,12 +2174,19 @@ static int tegra210_usb2_phy_power_off(struct phy *phy)
>>  	if (--pad->enable > 0)
>>  		goto out;
>>  
>> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +	value |= XUSB_PADCTL_USB2_OTG_PAD_CTL0_PD;
>> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL0(index));
>> +
>> +	value = padctl_readl(padctl, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>> +	value |= XUSB_PADCTL_USB2_OTG_PAD_CTL1_PD_DR;
>> +	padctl_writel(padctl, value, XUSB_PADCTL_USB2_OTG_PADX_CTL1(index));
>> +
>>  	value = padctl_readl(padctl, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
>>  	value |= XUSB_PADCTL_USB2_BIAS_PAD_CTL0_PD;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL0);
>>  
>>  out:
>> -	regulator_disable(port->supply);
>>  	mutex_unlock(&padctl->lock);
>>  	return 0;
>>  }
>> @@ -2120,6 +2983,120 @@ static const struct phy_ops tegra210_sata_phy_ops = {
>>  	.owner = THIS_MODULE,
>>  };
>>  
>> +static inline bool is_usb3_phy(struct phy *phy)
>> +{
>> +	return (phy->ops == &tegra210_pcie_phy_ops ||
>> +		phy->ops == &tegra210_sata_phy_ops);
>> +}
>> +
>> +static inline bool is_hsic_phy(struct phy *phy)
>> +{
>> +	return phy->ops == &tegra210_hsic_phy_ops;
>> +}
>> +
>> +static inline bool is_utmi_phy(struct phy *phy)
>> +{
>> +	return phy->ops == &tegra210_usb2_phy_ops;
>> +}
>> +
>> +static int
>> +tegra210_xusb_padctl_enable_phy_wake(struct tegra_xusb_padctl *padctl,
>> +				     struct phy *phy)
>> +{
>> +	if (!phy)
>> +		return 0;
>> +
>> +	if (is_usb3_phy(phy))
>> +		return tegra210_usb3_enable_phy_wake(phy);
>> +	else if (is_utmi_phy(phy))
>> +		return tegra210_utmi_enable_phy_wake(phy);
>> +	else if (is_hsic_phy(phy))
>> +		return tegra210_hsic_enable_phy_wake(phy);
>> +	else
>> +		return -EINVAL;
>> +}
> 
> Since all of these branches return, you don't need the else and can
> write this more simply as:
> 
> 	if (is_usb3_phy(phy))
> 		return ...;
> 
> 	if (is_utmi_phy(phy))
> 		return ...;
> 
> 	if (is_hsic_phy(phy))
> 		return ...;
> 
> 	return -EINVAL;
> 
> I'd probably also leave out the check for !phy since that should never
> happen and it might be good to just let it crash in that case to make
> sure that bug is found as quickly as possible.
> 
Got it. I will do as suggested.
>> +
>> +static int
>> +tegra210_xusb_padctl_disable_phy_wake(struct tegra_xusb_padctl *padctl,
>> +				      struct phy *phy)
>> +{
>> +	if (!phy)
>> +		return 0;
>> +
>> +	if (is_usb3_phy(phy))
>> +		return tegra210_usb3_disable_phy_wake(phy);
>> +	else if (is_utmi_phy(phy))
>> +		return tegra210_utmi_disable_phy_wake(phy);
>> +	else if (is_hsic_phy(phy))
>> +		return tegra210_hsic_disable_phy_wake(phy);
>> +	else
>> +		return -EINVAL;
>> +}
>> +
>> +int tegra210_xusb_padctl_remote_wake_detected(struct phy *phy)
>> +{
>> +	struct tegra_xusb_lane *lane;
>> +	struct tegra_xusb_padctl *padctl;
>> +
>> +	if (!phy)
>> +		return 0;
>> +
>> +	lane = phy_get_drvdata(phy);
>> +	padctl = lane->pad->padctl;
>> +
>> +	if (is_utmi_phy(phy))
>> +		return tegra210_utmi_phy_remote_wake_detected(padctl,
>> +					lane->index);
>> +	else if (is_hsic_phy(phy))
>> +		return tegra210_hsic_phy_remote_wake_detected(padctl,
>> +					lane->index);
>> +	else if (is_usb3_phy(phy))
>> +		return tegra210_usb3_phy_remote_wake_detected(padctl,
>> +					tegra210_usb3_lane_map(lane));
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int
>> +tegra210_xusb_padctl_enable_phy_sleepwalk(struct tegra_xusb_padctl *padctl,
>> +					  struct phy *phy,
>> +					  enum usb_device_speed speed)
>> +{
>> +	if (!phy)
>> +		return 0;
>> +
>> +	if (is_usb3_phy(phy))
>> +		return tegra210_usb3_enable_phy_sleepwalk(phy);
>> +	else if (is_utmi_phy(phy))
>> +		return tegra_pmc_utmi_enable_phy_sleepwalk(phy, speed);
>> +	else if (is_hsic_phy(phy))
>> +		return tegra_pmc_hsic_enable_phy_sleepwalk(phy);
>> +	else
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +tegra210_xusb_padctl_disable_phy_sleepwalk(struct tegra_xusb_padctl *padctl,
>> +					   struct phy *phy)
>> +{
>> +	if (!phy)
>> +		return 0;
>> +
>> +	if (is_usb3_phy(phy))
>> +		return tegra210_usb3_disable_phy_sleepwalk(phy);
>> +	else if (is_utmi_phy(phy))
>> +		return tegra_pmc_utmi_disable_phy_sleepwalk(phy);
>> +	else if (is_hsic_phy(phy))
>> +		return tegra_pmc_hsic_disable_phy_sleepwalk(phy);
>> +	else
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +
>>  static struct tegra_xusb_pad *
>>  tegra210_sata_pad_probe(struct tegra_xusb_padctl *padctl,
>>  			const struct tegra_xusb_pad_soc *soc,
>> @@ -2317,6 +3294,8 @@ tegra210_xusb_padctl_probe(struct device *dev,
>>  			   const struct tegra_xusb_padctl_soc *soc)
>>  {
>>  	struct tegra210_xusb_padctl *padctl;
>> +	struct device_node *node, *np = dev->of_node;
>> +	struct platform_device *pmc_dev;
>>  	int err;
>>  
>>  	padctl = devm_kzalloc(dev, sizeof(*padctl), GFP_KERNEL);
>> @@ -2330,6 +3309,24 @@ tegra210_xusb_padctl_probe(struct device *dev,
>>  	if (err < 0)
>>  		return ERR_PTR(err);
>>  
>> +	node = of_parse_phandle(np, "nvidia,pmc", 0);
>> +	if (!node) {
>> +		dev_err(dev, "nvidia,pmc property is missing\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	pmc_dev = of_find_device_by_node(node);
>> +	if (!pmc_dev) {
>> +		dev_err(dev, "pmc device is not available\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	padctl->pmc_reg = dev_get_regmap(&pmc_dev->dev, "usb_sleepwalk");
>> +	if (!padctl->pmc_reg) {
>> +		dev_err(dev, "pmc regmap is not available.\n");
>> +		return ERR_PTR(-ENODEV);
>> +	}
> 
> We'll have to make this optional for backwards compatibility, which will
> also help make this easier to merge because it doesn't all have to go in
> at the same time.
> 
Understood. I will make it optional in the next revision.
> Thierry
> 
>> +
>>  	return &padctl->base;
>>  }
>>  
>> @@ -2337,13 +3334,80 @@ static void tegra210_xusb_padctl_remove(struct tegra_xusb_padctl *padctl)
>>  {
>>  }
>>  
>> +static void tegra210_xusb_padctl_save(struct tegra_xusb_padctl *padctl)
>> +{
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +
>> +	priv->context.usb2_pad_mux =
>> +		padctl_readl(padctl, XUSB_PADCTL_USB2_PAD_MUX);
>> +	priv->context.usb2_port_cap =
>> +		padctl_readl(padctl, XUSB_PADCTL_USB2_PORT_CAP);
>> +	priv->context.ss_port_map =
>> +		padctl_readl(padctl, XUSB_PADCTL_SS_PORT_MAP);
>> +	priv->context.usb3_pad_mux =
>> +		padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
>> +}
>> +
>> +static void tegra210_xusb_padctl_restore(struct tegra_xusb_padctl *padctl)
>> +{
>> +	struct tegra210_xusb_padctl *priv = to_tegra210_xusb_padctl(padctl);
>> +	int i;
>> +
>> +	padctl_writel(padctl, priv->context.usb2_pad_mux,
>> +		XUSB_PADCTL_USB2_PAD_MUX);
>> +	padctl_writel(padctl, priv->context.usb2_port_cap,
>> +		XUSB_PADCTL_USB2_PORT_CAP);
>> +	padctl_writel(padctl, priv->context.ss_port_map,
>> +		XUSB_PADCTL_SS_PORT_MAP);
>> +
>> +	for (i = 0; i <= 7; i ++)
>> +		tegra210_uphy_lane_iddq_enable(padctl, i);
>> +
>> +	padctl_writel(padctl, priv->context.usb3_pad_mux,
>> +		XUSB_PADCTL_USB3_PAD_MUX);
>> +
>> +	for (i = 0; i <= 7; i ++)
>> +		tegra210_uphy_lane_iddq_disable(padctl, i);
>> +}
>> +
>> +static int tegra210_xusb_padctl_suspend_noirq(struct tegra_xusb_padctl *padctl)
>> +{
>> +	mutex_lock(&padctl->lock);
>> +
>> +	tegra210_uphy_deinit(padctl);
>> +
>> +	tegra210_xusb_padctl_save(padctl);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +	return 0;
>> +}
>> +
>> +static int tegra210_xusb_padctl_resume_noirq(struct tegra_xusb_padctl *padctl)
>> +{
>> +	mutex_lock(&padctl->lock);
>> +
>> +	tegra210_xusb_padctl_restore(padctl);
>> +
>> +	tegra210_uphy_init(padctl);
>> +
>> +	mutex_unlock(&padctl->lock);
>> +	return 0;
>> +}
>> +
>>  static const struct tegra_xusb_padctl_ops tegra210_xusb_padctl_ops = {
>>  	.probe = tegra210_xusb_padctl_probe,
>>  	.remove = tegra210_xusb_padctl_remove,
>> +	.suspend_noirq = tegra210_xusb_padctl_suspend_noirq,
>> +	.resume_noirq = tegra210_xusb_padctl_resume_noirq,
>>  	.usb3_set_lfps_detect = tegra210_usb3_set_lfps_detect,
>>  	.hsic_set_idle = tegra210_hsic_set_idle,
>>  	.vbus_override = tegra210_xusb_padctl_vbus_override,
>>  	.utmi_port_reset = tegra210_utmi_port_reset,
>> +	.enable_phy_sleepwalk = tegra210_xusb_padctl_enable_phy_sleepwalk,
>> +	.disable_phy_sleepwalk = tegra210_xusb_padctl_disable_phy_sleepwalk,
>> +	.enable_phy_wake = tegra210_xusb_padctl_enable_phy_wake,
>> +	.disable_phy_wake = tegra210_xusb_padctl_disable_phy_wake,
>> +	.remote_wake_detected = tegra210_xusb_padctl_remote_wake_detected,
>>  };
>>  
>>  static const char * const tegra210_xusb_padctl_supply_names[] = {
>> -- 
>> 2.25.1
>>
