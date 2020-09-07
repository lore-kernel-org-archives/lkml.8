Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF69C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883D420796
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="D/sOKuww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgIGC03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:26:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15886 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgIGC01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 22:26:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f559a430001>; Sun, 06 Sep 2020 19:26:11 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 06 Sep 2020 19:26:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 06 Sep 2020 19:26:25 -0700
Received: from [10.19.100.119] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 02:26:20 +0000
Subject: Re: [PATCH v2 04/12] phy: tegra: xusb: t210: add lane_iddq operations
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-5-jckuo@nvidia.com> <20200831115330.GB1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <59118eb8-43d9-e3d4-8edf-1a92884872b1@nvidia.com>
Date:   Mon, 7 Sep 2020 10:26:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831115330.GB1689119@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599445572; bh=LWQD0r/LLc7PivDJOXjTqASz5siAoKPYTMLCgq/Rpoo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=D/sOKuwwrgK7R6S8Hv5tICzoZoiyyrNUu619yXss97OJzw6x2DeVN8j0Wy6axoqNc
         CSXD/LQ/kwE+DAzRU6DpQf7c2+oc92yUbKzCnDs0XjzlF5TKI9GYnJypUHOSakanv3
         VuoYIBKP7XBuHwDifEbdtxgc226cvEtGakPiJvMzFklCdweg1bMC/2ufsLsklaV262
         uldmoGvGxfXP3i+uNAPaGI44RE59FpO50rPmV9ZZJiw4Jhrslqtr+tIPo8Tv6XYIIZ
         MLcXohsuXxc8d+SK0QDJUzHBIBRUvw6I1vECE7YNogeMzKKnkhOyyBtZCtyREdF2uG
         4fvosiotOIkbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review. I will amend accordingly and submit a new patch.

JC

On 8/31/20 7:53 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 12:40:35PM +0800, JC Kuo wrote:
>> As per Tegra210 TRM, before changing lane assignments, driver should
>> keep lanes in IDDQ and sleep state; after changing lane assignments,
>> driver should bring lanes out of IDDQ.
>> This commit implements the required operations.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/phy/tegra/xusb-tegra210.c | 94 +++++++++++++++++++++++++++++++
>>  drivers/phy/tegra/xusb.c          |  6 ++
>>  drivers/phy/tegra/xusb.h          |  4 +-
>>  3 files changed, 103 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
>> index 3a2d9797fb9f..fe1ab440424d 100644
>> --- a/drivers/phy/tegra/xusb-tegra210.c
>> +++ b/drivers/phy/tegra/xusb-tegra210.c
>> @@ -198,6 +198,18 @@
>>  #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_TERM_EN BIT(18)
>>  #define XUSB_PADCTL_UPHY_MISC_PAD_CTL1_AUX_RX_MODE_OVRD BIT(13)
>>  
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(x) (0x464 + (x) * 0x40)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ BIT(0)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD BIT(1)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK (0x3 << 4)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL (0x3 << 4)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD BIT(24)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ BIT(8)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD BIT(9)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK (0x3 << 12)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL (0x3 << 12)
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD BIT(25)
>> +
>>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL1 0x860
>>  
>>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL2 0x864
>> @@ -209,6 +221,7 @@
>>  #define XUSB_PADCTL_UPHY_PLL_S0_CTL8 0x87c
>>  
>>  #define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL1 0x960
>> +#define XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2 0x964
>>  
>>  #define XUSB_PADCTL_UPHY_USB3_PADX_ECTL1(x) (0xa60 + (x) * 0x40)
>>  #define XUSB_PADCTL_UPHY_USB3_PAD_ECTL1_TX_TERM_CTRL_SHIFT 16
>> @@ -1636,6 +1649,63 @@ static const struct tegra_xusb_pad_soc tegra210_hsic_pad = {
>>  	.ops = &tegra210_hsic_ops,
>>  };
>>  
>> +static void
>> +tegra210_uphy_lane_iddq_enable(struct tegra_xusb_padctl *padctl, unsigned lane)
>> +{
>> +	u32 val, offset;
>> +
>> +	if (lane <= 6)
>> +		offset = XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
>> +	else if (lane == 7)
>> +		offset = XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
>> +	else {
>> +		WARN(true, "invalid lane %u\n", lane);
>> +		return;
>> +	}
>> +
>> +	val = padctl_readl(padctl, offset);
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
>> +	padctl_writel(padctl, val, offset);
>> +}
>> +
>> +static void
>> +tegra210_uphy_lane_iddq_disable(struct tegra_xusb_padctl *padctl, unsigned lane)
>> +{
>> +	u32 val, offset;
>> +
>> +	if (lane <= 6)
>> +		offset = XUSB_PADCTL_UPHY_MISC_PAD_PX_CTL2(lane);
>> +	else if (lane == 7)
>> +		offset = XUSB_PADCTL_UPHY_MISC_PAD_S0_CTL2;
>> +	else {
>> +		WARN(true, "invalid lane %d\n", lane);
>> +		return;
>> +	}
>> +
>> +	val = padctl_readl(padctl, offset);
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ_OVRD;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ_OVRD;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_PWR_OVRD;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_PWR_OVRD;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_IDDQ;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_MASK;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_TX_SLEEP_VAL;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_IDDQ;
>> +	val &= ~XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_MASK;
>> +	val |= XUSB_PADCTL_UPHY_MISC_PAD_CTL2_RX_SLEEP_VAL;
>> +	padctl_writel(padctl, val, offset);
>> +}
>> +
>> +
>>  static const char *tegra210_pcie_functions[] = {
>>  	"pcie-x1",
>>  	"usb3-ss",
>> @@ -1808,9 +1878,21 @@ static void tegra210_pcie_lane_remove(struct tegra_xusb_lane *lane)
>>  	kfree(pcie);
>>  }
>>  
>> +static void tegra210_pcie_lane_iddq_enable(struct tegra_xusb_lane *lane)
>> +{
>> +	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index);
>> +}
>> +
>> +static void tegra210_pcie_lane_iddq_disable(struct tegra_xusb_lane *lane)
>> +{
>> +	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index);
>> +}
>> +
>>  static const struct tegra_xusb_lane_ops tegra210_pcie_lane_ops = {
>>  	.probe = tegra210_pcie_lane_probe,
>>  	.remove = tegra210_pcie_lane_remove,
>> +	.iddq_enable = tegra210_pcie_lane_iddq_enable,
>> +	.iddq_disable = tegra210_pcie_lane_iddq_disable,
>>  };
>>  
>>  static int tegra210_pcie_phy_init(struct phy *phy)
>> @@ -1971,9 +2053,21 @@ static void tegra210_sata_lane_remove(struct tegra_xusb_lane *lane)
>>  	kfree(sata);
>>  }
>>  
>> +static void tegra210_sata_lane_iddq_enable(struct tegra_xusb_lane *lane)
>> +{
>> +	tegra210_uphy_lane_iddq_enable(lane->pad->padctl, lane->index + 7);
>> +}
>> +
>> +static void tegra210_sata_lane_iddq_disable(struct tegra_xusb_lane *lane)
>> +{
>> +	tegra210_uphy_lane_iddq_disable(lane->pad->padctl, lane->index + 7);
>> +}
> 
> This looks like abstraction at the wrong level. You introduce this
> arbtitrary offset 7 to differentiate between the two types, whereas what
> you really only seem to be after is to get the correct offset.
> 
> Can't we instead make tegra210_uphy_lane_iddq_{enable,disable}() take
> the offset instead and push the logic to pick the offset into the
> callers? We could then have an extra helper that determines the offset
> from the lane if we want to avoid duplicating that logic.
> 
> Or perhaps an even better way would be to store the offset to this MISC
> register in struct tegra_xusb_lane_soc? Something like this perhaps:
> 
>     struct tegra_xusb_lane_soc {
>         ...
>         struct {
>             unsigned int misc;
>         } regs;
>     };
> 
> That way we don't even have to go through two layers but instead can
> operate on the struct tegra_xusb_lane directly.
> 
>> +
>>  static const struct tegra_xusb_lane_ops tegra210_sata_lane_ops = {
>>  	.probe = tegra210_sata_lane_probe,
>>  	.remove = tegra210_sata_lane_remove,
>> +	.iddq_enable = tegra210_sata_lane_iddq_enable,
>> +	.iddq_disable = tegra210_sata_lane_iddq_disable,
>>  };
>>  
>>  static int tegra210_sata_phy_init(struct phy *phy)
>> diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
>> index b48b590aa0c1..74abd67e3a31 100644
>> --- a/drivers/phy/tegra/xusb.c
>> +++ b/drivers/phy/tegra/xusb.c
>> @@ -321,11 +321,17 @@ static void tegra_xusb_lane_program(struct tegra_xusb_lane *lane)
>>  	if (soc->num_funcs < 2)
>>  		return;
>>  
>> +	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
>> +		lane->pad->ops->iddq_enable(lane);
> 
> You can drop the second check because it isn't relevant here.
> 
>> +
>>  	/* choose function */
>>  	value = padctl_readl(padctl, soc->offset);
>>  	value &= ~(soc->mask << soc->shift);
>>  	value |= lane->function << soc->shift;
>>  	padctl_writel(padctl, value, soc->offset);
>> +
>> +	if (lane->pad->ops->iddq_enable && lane->pad->ops->iddq_disable)
>> +		lane->pad->ops->iddq_disable(lane);
> 
> Similarly, the first check can be dropped here because only the second
> is relevant. It might make sense to only support IDDQ if both callbacks
> are implemented, but that's not something we need to check at this
> level. The check here is only to avoid calling a NULL function. If you
> absolutely want to do sanity checks, do them at ->probe() time. But I
> don't think we need that here. It's up to the developer to get this
> right.
> 
>>  }
>>  
>>  static void tegra_xusb_pad_program(struct tegra_xusb_pad *pad)
>> diff --git a/drivers/phy/tegra/xusb.h b/drivers/phy/tegra/xusb.h
>> index 0c828694cf2d..485b692a3b15 100644
>> --- a/drivers/phy/tegra/xusb.h
>> +++ b/drivers/phy/tegra/xusb.h
>> @@ -22,6 +22,7 @@ struct phy;
>>  struct phy_provider;
>>  struct platform_device;
>>  struct regulator;
>> +struct tegra_xusb_padctl;
>>  
>>  /*
>>   * lanes
>> @@ -126,6 +127,8 @@ struct tegra_xusb_lane_ops {
>>  					 struct device_node *np,
>>  					 unsigned int index);
>>  	void (*remove)(struct tegra_xusb_lane *lane);
>> +	void (*iddq_enable)(struct tegra_xusb_lane *lane);
>> +	void (*iddq_disable)(struct tegra_xusb_lane *lane);
>>  };
>>  
>>  bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane, const char *function);
>> @@ -134,7 +137,6 @@ bool tegra_xusb_lane_check(struct tegra_xusb_lane *lane, const char *function);
>>   * pads
>>   */
>>  struct tegra_xusb_pad_soc;
>> -struct tegra_xusb_padctl;
>>  
>>  struct tegra_xusb_pad_ops {
>>  	struct tegra_xusb_pad *(*probe)(struct tegra_xusb_padctl *padctl,
> 
> These last two hunks look like leftovers. I don't see why they are
> needed here.
> 
> Thierry
> 
