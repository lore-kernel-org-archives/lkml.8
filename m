Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C8C3524F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA02F2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgBCJDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:03:55 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:44332 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBCJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:03:54 -0500
Received: from [10.7.0.4] (10.28.11.250) by mail-sz.amlogic.com (10.28.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 3 Feb
 2020 17:04:25 +0800
Subject: Re: [PATCH v6 5/5] clk: meson: a1: add support for Amlogic A1
 Peripheral clock driver
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200116080440.118679-1-jian.hu@amlogic.com>
 <20200116080440.118679-6-jian.hu@amlogic.com>
 <20200129054253.6F8CD2071E@mail.kernel.org>
From:   Jian Hu <jian.hu@amlogic.com>
Message-ID: <3e103a45-62d4-1a10-e4af-5a4c588162d6@amlogic.com>
Date:   Mon, 3 Feb 2020 17:04:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129054253.6F8CD2071E@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.11.250]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stephen

Thanks for your review

On 2020/1/29 13:42, Stephen Boyd wrote:
> Quoting Jian Hu (2020-01-16 00:04:40)
>> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
>> new file mode 100644
>> index 000000000000..2cf20ae1db75
>> --- /dev/null
>> +++ b/drivers/clk/meson/a1.c
>> @@ -0,0 +1,2249 @@
> [...]
>> +       &a1_ceca_32k_clkout,
>> +       &a1_cecb_32k_clkin,
>> +       &a1_cecb_32k_div,
>> +       &a1_cecb_32k_sel_pre,
>> +       &a1_cecb_32k_sel,
>> +       &a1_cecb_32k_clkout,
>> +};
>> +
>> +static struct regmap_config clkc_regmap_config = {
> 
> Can this be const?
OK, I will add const in next v8 version.
> 
>> +       .reg_bits       = 32,
>> +       .val_bits       = 32,
>> +       .reg_stride     = 4,
>> +};
>> +
>> +static int meson_a1_periphs_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +       void __iomem *base;
>> +       struct regmap *map;
>> +       int ret, i;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       base = devm_ioremap_resource(dev, res);
> 
> Can you use the combination function that does the get resource and
> ioremap in one function?
OK, I will use 'devm_platform_ioremap_resource' here.
> 
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       map = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
>> +       if (IS_ERR(map))
>> +               return PTR_ERR(map);
>> +
>> +       /* Populate regmap for the regmap backed clocks */
> 
> Seems like a useless comment.
OK, I will remove it.
> 
>> +       for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
>> +               a1_periphs_regmaps[i]->map = map;
>> +
> 
The same with a1-pll.c file, I will modify, too.
> .
> 
