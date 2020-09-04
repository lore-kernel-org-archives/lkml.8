Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4F1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D4620791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q0qc8qjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgIDJKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:10:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12655 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgIDJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:10:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5204670000>; Fri, 04 Sep 2020 02:09:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 02:10:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 04 Sep 2020 02:10:47 -0700
Received: from [10.19.101.15] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 09:10:40 +0000
Subject: Re: [PATCH v2 03/12] phy: tegra: xusb: t210: rearrange UPHY init
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-4-jckuo@nvidia.com> <20200831114212.GA1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <6aada109-0320-3c9b-7ded-9095ddaed90c@nvidia.com>
Date:   Fri, 4 Sep 2020 17:10:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831114212.GA1689119@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599210599; bh=vX10UU5Zu1jLkKbMfqoDXzs5YaYEqs74J8wZVVXkFB0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=q0qc8qjlL6PGa0b1KI8gRF4v3q8byxzk/csTfpmYEShJEl7DcbDQb2RecVYnQCDlc
         wW4lJ3aqv6OqgYyZw75xividM3podRktakTuzZ5g0sIWDvapJyICTvhjD9c23S6ONV
         gPK3WS1e7b+cc6YYkPSUlVGmtkDy20hkLkzE9B9Btxq3WjvUWXqE0dsWuqPlVb4az+
         TgRxUu6N8oOLC9e6xLzr1GLzQxME+n3P4GXymoEGwqqpMiKF0dZzKKxaKPhkrpOq80
         8sy0R0pSvQMmbCHUhtR6nIQJ0CBfQoKkwUzuvqS8Itsax9yKXADUeDi+f8WM0fe4gq
         QwhH5XTvAn7lw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review.

On 8/31/20 7:42 PM, Thierry Reding wrote:
> Please start commit subjects with a capital letter after the prefix.
> Also, please avoid t210 as abbreviation and use tegra210 instead.
> 
> The above should be something like:
> 
>     phy: tegra: xusb: tegra210: Rearrange UPHY init
> 
> Or perhaps:
> 
>     phy: tegra: xusb: Rearrange UPHY init on Tegra210
I will take this one. Thanks.
> 
> On Mon, Aug 31, 2020 at 12:40:34PM +0800, JC Kuo wrote:
>> This commit is a preparation for enabling XUSB SC7 support.
>> It rearranges Tegra210 XUSB PADCTL UPHY initialization sequence,
>> for the following reasons:
>>
>> 1. PLLE hardware power sequencer has to be enabled only after both
>>    PEX UPHY PLL and SATA UPHY PLL are initialized.
>>    tegra210_uphy_init() -> tegra210_pex_uphy_enable()
>>                         -> tegra210_sata_uphy_enable()
>>                         -> tegra210_plle_hw_sequence_start()
>>                         -> tegra210_aux_mux_lp0_clamp_disable()
>>
>> 2. Once UPHY PLL hardware power sequencer is enabled, do not assert
>>    reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be
>>    broken.
>>    reset_control_assert(pcie->rst) and reset_control_assert(sata->rst)
>>    are removed from PEX/SATA UPHY disable procedure.
>>
>> 3. At cold boot and SC7 exit, the following bits must be cleared after
>>    PEX/SATA lanes are out of IDDQ (IDDQ_DISABLE=1).
>>    a. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN,
>>    b. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN_EARLY
>>    c. XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN
>>
>>    tegra210_pex_uphy_enable() and tegra210_sata_uphy_enable() are in
>>    charge of bringing lanes out of IDDQ, and then AUX_MUX_LP0_* bits
>>    will be cleared by tegra210_aux_mux_lp0_clamp_disable().
>>
>> 4. The programming sequence in tegra210_usb3_port_enable() is required
>>    for both cold boot and SC7 exit, and must be performed only after
>>    PEX/SATA UPHY is initialized. Therefore, this commit moves the
>>    programming sequence to .power_on() stub which is invoked after
>>    .init(). PEX/SATA UPHY is initialzied in .init().
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/phy/tegra/xusb-tegra210.c | 495 ++++++++++++++++--------------
>>  drivers/phy/tegra/xusb.c          |   2 +-
>>  drivers/phy/tegra/xusb.h          |   6 +-
>>  3 files changed, 270 insertions(+), 233 deletions(-)
> 
> You've listed 4 logically separate changes in the commit message, so I'm
> wondering if it's possible to split this patch into 4 different ones. It
> might not be worth doing that if they all basically fix the sequence in
> one go, but it's pretty difficult to review this as-is.
I found #1 and #3 are not possible to be split. I will submit #2 and #4 as
separate changes.

> 
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
>> index 66bd4613835b..3a2d9797fb9f 100644
>> --- a/drivers/phy/tegra/xusb-tegra210.c
>> +++ b/drivers/phy/tegra/xusb-tegra210.c
>> @@ -256,23 +256,52 @@ to_tegra210_xusb_padctl(struct tegra_xusb_padctl *padctl)
>>  	return container_of(padctl, struct tegra210_xusb_padctl, base);
>>  }
>>  
>> +static const struct tegra_xusb_lane_map tegra210_usb3_map[] = {
>> +	{ 0, "pcie", 6 },
>> +	{ 1, "pcie", 5 },
>> +	{ 2, "pcie", 0 },
>> +	{ 2, "pcie", 3 },
>> +	{ 3, "pcie", 4 },
>> +	{ 3, "pcie", 4 },
>> +	{ 0, NULL,   0 }
>> +};
>> +
>> +static int tegra210_usb3_lane_map(struct tegra_xusb_lane *lane)
>> +{
>> +	const struct tegra_xusb_lane_map *map;
>> +
>> +	for (map = tegra210_usb3_map; map->type; map++) {
>> +		if (map->index == lane->index &&
>> +		    strcmp(map->type, lane->pad->soc->name) == 0) {
>> +			dev_dbg(lane->pad->padctl->dev,
>> +				"lane = %s map to port = usb3-%d\n",
> 
> "mapped to port"?
Yes, each PEX/SATA lane maps to an USB3 (super-speed) port.
> 
>> +				lane->pad->soc->lanes[lane->index].name,
>> +				map->port);
>> +			return map->port;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  /* must be called under padctl->lock */
>>  static int tegra210_pex_uphy_enable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	struct tegra_xusb_pcie_pad *pcie = to_pcie_pad(padctl->pcie);
>>  	unsigned long timeout;
>>  	u32 value;
>> -	int err;
>> +	int err, i;
> 
> i should be unsigned to match the type of padctl->pcie->soc->num_lanes.
I will fix this. Thanks.
> 
>>  
>> -	if (pcie->enable > 0) {
>> -		pcie->enable++;
>> +	if (pcie->enable)
>>  		return 0;
>> -	}
>>  
>>  	err = clk_prepare_enable(pcie->pll);
>>  	if (err < 0)
>>  		return err;
>>  
>> +	if (tegra210_plle_hw_sequence_is_enabled())
>> +		goto skip_pll_init;
>> +
>>  	err = reset_control_deassert(pcie->rst);
> 
> Is it guaranteed that the reset is asserted if the PLLE HW sequencer is
> enabled? I suppose with the change to not enable the sequencer by
> default in one of the earlier patches this may indeed be a valid
> assumption.
Yes, reset is de-asserted before PLLE initialization happens.
> 
>>  	if (err < 0)
>>  		goto disable;
>> @@ -455,7 +484,14 @@ static int tegra210_pex_uphy_enable(struct tegra_xusb_padctl *padctl)
>>  
>>  	tegra210_xusb_pll_hw_sequence_start();
>>  
>> -	pcie->enable++;
>> +skip_pll_init:
>> +	pcie->enable = true;
>> +
>> +	for (i = 0; i < padctl->pcie->soc->num_lanes; i++) {
>> +		value = padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
>> +		value |= XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
>> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
>> +	}
>>  
>>  	return 0;
>>  
>> @@ -469,34 +505,42 @@ static int tegra210_pex_uphy_enable(struct tegra_xusb_padctl *padctl)
>>  static void tegra210_pex_uphy_disable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	struct tegra_xusb_pcie_pad *pcie = to_pcie_pad(padctl->pcie);
>> +	u32 value;
>> +	int i;
> 
> Same as above.
I will fix this. Thanks.
> 
>>  
>> -	mutex_lock(&padctl->lock);
>> -
>> -	if (WARN_ON(pcie->enable == 0))
>> -		goto unlock;
>> +	if (WARN_ON(!pcie->enable))
>> +		return;
>>  
>> -	if (--pcie->enable > 0)
>> -		goto unlock;
>> +	pcie->enable = false;
>>  
>> -	reset_control_assert(pcie->rst);
>> +	for (i = 0; i < padctl->pcie->soc->num_lanes; i++) {
>> +		value = padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
>> +		value &= ~XUSB_PADCTL_USB3_PAD_MUX_PCIE_IDDQ_DISABLE(i);
>> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
>> +	}
>>  	clk_disable_unprepare(pcie->pll);
> 
> Please leave a blank line after a block for better readability.
I will fix this. Thanks.
> 
>> -
>> -unlock:
>> -	mutex_unlock(&padctl->lock);
>>  }
>>  
>>  /* must be called under padctl->lock */
>> -static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl, bool usb)
>> +static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	struct tegra_xusb_sata_pad *sata = to_sata_pad(padctl->sata);
>> +	struct tegra_xusb_lane *lane = tegra_xusb_find_lane(padctl, "sata", 0);
>>  	unsigned long timeout;
>>  	u32 value;
>> -	int err;
>> +	int err, i;
> 
> Same comment as above for "i".
I will fix this. Thanks.
> 
>> +	bool usb;
>>  
>> -	if (sata->enable > 0) {
>> -		sata->enable++;
>> +	if (sata->enable)
> 
> Do we want a WARN_ON() here for symmetry with the implementation of
> tegra210_sata_uphy_disable() below?
Yes, I can add this.
> 
>>  		return 0;
>> -	}
>> +
>> +	if (!lane)
>> +		return 0;
>> +
>> +	if (tegra210_plle_hw_sequence_is_enabled())
>> +		goto skip_pll_init;
>> +
>> +	usb = tegra_xusb_lane_check(lane, "usb3-ss");
>>  
>>  	err = clk_prepare_enable(sata->pll);
>>  	if (err < 0)
>> @@ -697,7 +741,14 @@ static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl, bool usb)
>>  
>>  	tegra210_sata_pll_hw_sequence_start();
>>  
>> -	sata->enable++;
>> +skip_pll_init:
>> +	sata->enable = true;
>> +
>> +	for (i = 0; i < padctl->sata->soc->num_lanes; i++) {
>> +		value = padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
>> +		value |= XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
>> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
>> +	}
>>  
>>  	return 0;
>>  
>> @@ -711,31 +762,26 @@ static int tegra210_sata_uphy_enable(struct tegra_xusb_padctl *padctl, bool usb)
>>  static void tegra210_sata_uphy_disable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	struct tegra_xusb_sata_pad *sata = to_sata_pad(padctl->sata);
>> +	u32 value;
>> +	int i;
> 
> unsigned int, please.
I will fix this. Thanks.
> 
>>  
>> -	mutex_lock(&padctl->lock);
>> -
>> -	if (WARN_ON(sata->enable == 0))
>> -		goto unlock;
>> +	if (WARN_ON(!sata->enable))
>> +		return;
>>  
>> -	if (--sata->enable > 0)
>> -		goto unlock;
>> +	sata->enable = false;
>>  
>> -	reset_control_assert(sata->rst);
>> +	for (i = 0; i < padctl->sata->soc->num_lanes; i++) {
>> +		value = padctl_readl(padctl, XUSB_PADCTL_USB3_PAD_MUX);
>> +		value &= ~XUSB_PADCTL_USB3_PAD_MUX_SATA_IDDQ_DISABLE(i);
>> +		padctl_writel(padctl, value, XUSB_PADCTL_USB3_PAD_MUX);
>> +	}
>>  	clk_disable_unprepare(sata->pll);
>> -
>> -unlock:
>> -	mutex_unlock(&padctl->lock);
>>  }
>>  
>> -static int tegra210_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
>> +static void tegra210_aux_mux_lp0_clamp_disable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	u32 value;
>>  
>> -	mutex_lock(&padctl->lock);
>> -
>> -	if (padctl->enable++ > 0)
>> -		goto out;
>> -
>>  	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>>  	value &= ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> @@ -751,24 +797,12 @@ static int tegra210_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
>>  	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>>  	value &= ~XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> -
>> -out:
>> -	mutex_unlock(&padctl->lock);
>> -	return 0;
>>  }
>>  
>> -static int tegra210_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
>> +static void tegra210_aux_mux_lp0_clamp_enable(struct tegra_xusb_padctl *padctl)
>>  {
>>  	u32 value;
>>  
>> -	mutex_lock(&padctl->lock);
>> -
>> -	if (WARN_ON(padctl->enable == 0))
>> -		goto out;
>> -
>> -	if (--padctl->enable > 0)
>> -		goto out;
>> -
>>  	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>>  	value |= XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_VCORE_DOWN;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> @@ -784,12 +818,36 @@ static int tegra210_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
>>  	value = padctl_readl(padctl, XUSB_PADCTL_ELPG_PROGRAM1);
>>  	value |= XUSB_PADCTL_ELPG_PROGRAM1_AUX_MUX_LP0_CLAMP_EN;
>>  	padctl_writel(padctl, value, XUSB_PADCTL_ELPG_PROGRAM1);
>> +}
>> +
>> +static int tegra210_uphy_init(struct tegra_xusb_padctl *padctl)
>> +{
>> +	if (padctl->pcie)
>> +		tegra210_pex_uphy_enable(padctl);
>> +	if (padctl->sata)
>> +		tegra210_sata_uphy_enable(padctl);
>> +
>> +	if (!tegra210_plle_hw_sequence_is_enabled())
>> +		tegra210_plle_hw_sequence_start();
>> +	else
>> +		dev_dbg(padctl->dev, "PLLE is already in HW control\n");
>> +
>> +	tegra210_aux_mux_lp0_clamp_disable(padctl);
>>  
>> -out:
>> -	mutex_unlock(&padctl->lock);
>>  	return 0;
>>  }
>>  
>> +static void __maybe_unused
>> +tegra210_uphy_deinit(struct tegra_xusb_padctl *padctl)
>> +{
>> +	tegra210_aux_mux_lp0_clamp_enable(padctl);
> 
> Do we need tegra210_plle_hw_sequence_stop() here?
> 
PLLE hardware power sequencer must remain enabled at SC7 entry.
>> +
>> +	if (padctl->pcie)
>> +		tegra210_pex_uphy_disable(padctl);
>> +	if (padctl->sata)
>> +		tegra210_sata_uphy_disable(padctl);
> 
> Maybe reverse the order of these two so that they are symmetrical with
> tegra210_uphy_init()? Also, single blank lines between the two blocks
> make this easier to read, in my opinion.
I can do this. Thanks.
> 
> Thierry
> 
