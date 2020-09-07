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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856D2C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426F520DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ce3TwXgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgIGDHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:07:25 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12645 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgIGDHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:07:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f55a3b20000>; Sun, 06 Sep 2020 20:06:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 06 Sep 2020 20:07:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 06 Sep 2020 20:07:15 -0700
Received: from [10.19.100.119] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 03:07:09 +0000
Subject: Re: [PATCH v2 06/12] soc/tegra: pmc: provide usb sleepwalk register
 map
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-7-jckuo@nvidia.com> <20200831120908.GD1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <0735b136-d318-083f-94a8-7c9425a10cab@nvidia.com>
Date:   Mon, 7 Sep 2020 11:07:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831120908.GD1689119@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599447986; bh=ArWoVvzVa+av5uOFDvKHWO2qNlpjGwUZRCV/tRsLmdA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Ce3TwXgd5zQis7/Ldfyxb3klftnY/J5bQIJLc0bsxEFG1vuPRBEAgRFoCouEimSgW
         v09iwJtuEKHM1U+zI9s9mIa+LswQoNUqCIcylry3/qSvbzL/gQjhrwnvrsuV6iq8MN
         /97nDpZv1kkX3eMPh2J4eSRwG+LLX4KiJm8s8oATsZN4/nnXMzXzT3UJ40C5oY0Flf
         9wlQaSYoJu8FaMnwHlQ/kt+hzYpjqF0HS4Tu29RllDZeAoMVKrqNr5ILQ5MjV3xPHE
         yYvCGH8w/Cm1uIKZssP8mgA0WeYp17IrDsKo9z0WYRUbM0n5rRf2Bo5BRzJ38bm7gR
         Yttgi6IITlK0Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review. I will amend accordingly and submit a new patch.

JC

On 8/31/20 8:09 PM, Thierry Reding wrote:
> On Mon, Aug 31, 2020 at 12:40:37PM +0800, JC Kuo wrote:
>> This commit implements a register map which grants USB (UTMI and HSIC)
>> sleepwalk registers access to USB phy drivers. The USB sleepwalk logic
>> is in PMC hardware block but USB phy drivers have the best knowledge
>> of proper programming sequence. This approach prevents using custom
>> pmc APIs.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 89 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 89 insertions(+)
> 
> Same comment as in earlier patches regarding the subject and "USB PHY"
> in the commit message.
> 
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index d332e5d9abac..03317978915a 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -43,6 +43,7 @@
>>  #include <linux/seq_file.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/regmap.h>
>>  
>>  #include <soc/tegra/common.h>
>>  #include <soc/tegra/fuse.h>
>> @@ -102,6 +103,9 @@
>>  
>>  #define PMC_PWR_DET_VALUE		0xe4
>>  
>> +#define PMC_USB_DEBOUNCE_DEL		0xec
>> +#define PMC_USB_AO			0xf0
>> +
>>  #define PMC_SCRATCH41			0x140
>>  
>>  #define PMC_WAKE2_MASK			0x160
>> @@ -133,6 +137,13 @@
>>  #define IO_DPD2_STATUS			0x1c4
>>  #define SEL_DPD_TIM			0x1c8
>>  
>> +#define PMC_UTMIP_UHSIC_TRIGGERS	0x1ec
>> +#define PMC_UTMIP_UHSIC_SAVED_STATE	0x1f0
>> +
>> +#define PMC_UTMIP_TERM_PAD_CFG		0x1f8
>> +#define PMC_UTMIP_UHSIC_SLEEP_CFG	0x1fc
>> +#define PMC_UTMIP_UHSIC_FAKE		0x218
>> +
>>  #define PMC_SCRATCH54			0x258
>>  #define  PMC_SCRATCH54_DATA_SHIFT	8
>>  #define  PMC_SCRATCH54_ADDR_SHIFT	0
>> @@ -145,8 +156,18 @@
>>  #define  PMC_SCRATCH55_CHECKSUM_SHIFT	16
>>  #define  PMC_SCRATCH55_I2CSLV1_SHIFT	0
>>  
>> +#define  PMC_UTMIP_UHSIC_LINE_WAKEUP	0x26c
>> +
>> +#define PMC_UTMIP_BIAS_MASTER_CNTRL	0x270
>> +#define PMC_UTMIP_MASTER_CONFIG		0x274
>> +#define PMC_UTMIP_UHSIC2_TRIGGERS	0x27c
>> +#define PMC_UTMIP_MASTER2_CONFIG	0x29c
>> +
>>  #define GPU_RG_CNTRL			0x2d4
>>  
>> +#define PMC_UTMIP_PAD_CFG0		0x4c0
>> +#define PMC_UTMIP_UHSIC_SLEEP_CFG1	0x4d0
>> +#define PMC_UTMIP_SLEEPWALK_P3		0x4e0
>>  /* Tegra186 and later */
>>  #define WAKE_AOWAKE_CNTRL(x) (0x000 + ((x) << 2))
>>  #define WAKE_AOWAKE_CNTRL_LEVEL (1 << 3)
>> @@ -334,6 +355,7 @@ struct tegra_pmc_soc {
>>  	const struct pmc_clk_init_data *pmc_clks_data;
>>  	unsigned int num_pmc_clks;
>>  	bool has_blink_output;
>> +	bool has_usb_sleepwalk;
>>  };
>>  
>>  static const char * const tegra186_reset_sources[] = {
>> @@ -2495,6 +2517,67 @@ static void tegra_pmc_clock_register(struct tegra_pmc *pmc,
>>  			 err);
>>  }
>>  
>> +#define regmap_reg(x) regmap_reg_range(x, x)
> 
> This doesn't seem like a good idea. What if anyone ever thought it was a
> good idea to add this to the core regmap header? We'd get a naming
> conflict that would first have to get resolved.
> 
>> +static const struct regmap_range pmc_usb_sleepwalk_ranges[] = {
>> +	regmap_reg_range(PMC_USB_DEBOUNCE_DEL, PMC_USB_AO),
>> +	regmap_reg_range(PMC_UTMIP_UHSIC_TRIGGERS, PMC_UTMIP_UHSIC_SAVED_STATE),
>> +	regmap_reg_range(PMC_UTMIP_TERM_PAD_CFG, PMC_UTMIP_UHSIC_FAKE),
>> +	regmap_reg(PMC_UTMIP_UHSIC_LINE_WAKEUP),
>> +	regmap_reg_range(PMC_UTMIP_BIAS_MASTER_CNTRL, PMC_UTMIP_MASTER_CONFIG),
>> +	regmap_reg_range(PMC_UTMIP_UHSIC2_TRIGGERS, PMC_UTMIP_MASTER2_CONFIG),
>> +	regmap_reg_range(PMC_UTMIP_PAD_CFG0, PMC_UTMIP_UHSIC_SLEEP_CFG1),
>> +	regmap_reg(PMC_UTMIP_SLEEPWALK_P3),
>> +};
> 
> Since we only have two usages of the regmap_reg() macro, perhaps just
> use regmap_reg_range() with the same parameter used twice?
> 
>> +
>> +static const struct regmap_access_table pmc_usb_sleepwalk_table = {
>> +	.yes_ranges = pmc_usb_sleepwalk_ranges,
>> +	.n_yes_ranges = ARRAY_SIZE(pmc_usb_sleepwalk_ranges),
>> +};
>> +
>> +static int tegra_pmc_regmap_readl(void *context, unsigned int reg, unsigned int *val)
> 
> s/reg/offset/ to make it clearer what this really is. Also: s/val/value/ to
> avoid potential confusion with "valid".
> 
>> +{
>> +	struct tegra_pmc *pmc = context;
>> +
>> +	*val = tegra_pmc_readl(pmc, reg);
>> +	return 0;
>> +}
>> +
>> +static int tegra_pmc_regmap_writel(void *context, unsigned int reg, unsigned int val)
>> +{
>> +	struct tegra_pmc *pmc = context;
>> +
>> +	tegra_pmc_writel(pmc, val, reg);
>> +	return 0;
>> +}
> 
> Same here.
> 
>> +
>> +static const struct regmap_config usb_sleepwalk_regmap_config = {
>> +	.name = "usb_sleepwalk",
>> +	.reg_bits = 32,
>> +	.val_bits = 32,
>> +	.reg_stride = 4,
>> +	.fast_io = true,
>> +	.rd_table = &pmc_usb_sleepwalk_table,
>> +	.wr_table = &pmc_usb_sleepwalk_table,
>> +	.reg_read = tegra_pmc_regmap_readl,
>> +	.reg_write = tegra_pmc_regmap_writel,
>> +};
>> +
>> +static int tegra_pmc_regmap_init(struct tegra_pmc *pmc)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	if (pmc->soc->has_usb_sleepwalk) {
>> +		regmap = devm_regmap_init(pmc->dev, NULL, (__force void *)pmc,
> 
> Do you really need that __force in there?
> 
>> +					  &usb_sleepwalk_regmap_config);
>> +		if (IS_ERR(regmap)) {
>> +			dev_err(pmc->dev, "failed to allocate register map\n");
> 
> Maybe output the error code here?
> 
>> +			return PTR_ERR(regmap);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int tegra_pmc_probe(struct platform_device *pdev)
>>  {
>>  	void __iomem *base;
>> @@ -2613,6 +2696,10 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>>  	pmc->base = base;
>>  	mutex_unlock(&pmc->powergates_lock);
>>  
>> +	err = tegra_pmc_regmap_init(pmc);
>> +	if (err < 0)
>> +		goto cleanup_powergates;
> 
> You could call this perhaps a little bit earlier to avoid having to
> clean up powergates? Since you register with devm_regmap_init() you
> won't have to clean this up manually.
> 
> For that reason it makes sense as a general rule to initialize devm
> things before anything that's not managed (unless, of course, if it
> doesn't make any sense).
> 
>> +
>>  	tegra_pmc_clock_register(pmc, pdev->dev.of_node);
>>  	platform_set_drvdata(pdev, pmc);
>>  
>> @@ -2976,6 +3063,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
>>  	.pmc_clks_data = tegra_pmc_clks_data,
>>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
>>  	.has_blink_output = true,
>> +	.has_usb_sleepwalk = true,
>>  };
>>  
>>  static const char * const tegra210_powergates[] = {
>> @@ -3094,6 +3182,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
>>  	.pmc_clks_data = tegra_pmc_clks_data,
>>  	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
>>  	.has_blink_output = true,
>> +	.has_usb_sleepwalk = true,
>>  };
>>  
>>  #define TEGRA186_IO_PAD_TABLE(_pad)                                          \
> 
> I'd prefer if we explicitly set this to false on SoC generations where
> we don't have sleepwalk support (or don't need to deal with it in the
> kernel). That avoids confusion as to whether this was simply forgotten
> or whether the omission was on purpose.
> 
> Thierry
> 
