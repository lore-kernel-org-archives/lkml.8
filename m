Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10878C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D071821D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIJDOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:14:19 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:44566 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIJDOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:14:08 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 23:14:05 EDT
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 487AD104E;
        Thu, 10 Sep 2020 11:07:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P25134T140525325764352S1599707237793667_;
        Thu, 10 Sep 2020 11:07:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9b78765c88d40245569064639cb03e69>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: kever.yang@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v3 6/6] clk: rockchip: rk3399: Support module build
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
References: <20200904074405.24439-1-zhangqing@rock-chips.com>
 <20200904074505.24917-1-zhangqing@rock-chips.com> <3524790.GmC4BGDxql@diego>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <ad06ac8a-e7f9-382d-1cbc-01aea6256e5c@rock-chips.com>
Date:   Thu, 10 Sep 2020 11:07:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3524790.GmC4BGDxql@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

在 2020/9/7 上午6:49, Heiko Stübner 写道:
> Am Freitag, 4. September 2020, 09:45:05 CEST schrieb Elaine Zhang:
>> support CLK_OF_DECLARE and builtin_platform_driver_probe
>> double clk init method.
>> add module author, description and license to support building
>> Soc Rk3399 clock driver as module.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>   drivers/clk/rockchip/clk-rk3399.c | 55 +++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
>> index ce1d2446f142..40ff17aee5b6 100644
>> --- a/drivers/clk/rockchip/clk-rk3399.c
>> +++ b/drivers/clk/rockchip/clk-rk3399.c
>> @@ -5,9 +5,11 @@
>>    */
>>   
>>   #include <linux/clk-provider.h>
>> +#include <linux/module.h>
>>   #include <linux/io.h>
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>> +#include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>   #include <dt-bindings/clock/rk3399-cru.h>
>> @@ -1600,3 +1602,56 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
>>   	rockchip_clk_of_add_provider(np, ctx);
>>   }
>>   CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
>> +
>> +struct clk_rk3399_inits {
>> +		void (*inits)(struct device_node *np);
>> +};
>> +
>> +static const struct clk_rk3399_inits clk_rk3399_pmucru_init = {
>> +	.inits = rk3399_pmu_clk_init,
>> +};
>> +
>> +static const struct clk_rk3399_inits clk_rk3399_cru_init = {
>> +	.inits = rk3399_clk_init,
>> +};
>> +
>> +static const struct of_device_id clk_rk3399_match_table[] = {
>> +	{
>> +		.compatible = "rockchip,rk3399-cru",
>> +		.data = &clk_rk3399_cru_init,
>> +	},  {
>> +		.compatible = "rockchip,rk3399-pmucru",
>> +		.data = &clk_rk3399_pmucru_init,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
>> +
>> +static int __init clk_rk3399_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	const struct of_device_id *match;
>> +	const struct clk_rk3399_inits *init_data;
>> +
>> +	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
>> +	if (!match || !match->data)
>> +		return -EINVAL;
>> +
>> +	init_data = match->data;
>> +	if (init_data->inits)
>> +		init_data->inits(np);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver clk_rk3399_driver = {
>> +	.driver		= {
>> +		.name	= "clk-rk3399",
>> +		.of_match_table = clk_rk3399_match_table,
> I guess we probably want
> 		.suppress_bind_attrs = true,
OK, I will add it in the next version.
>
> here, because there is no unloading.
> Also what happens when you try to rmmod the module?
console:/ # lsmod | grep clk

clk_rk808              16384  0
clk_rk3399             49152  0 [permanent]
clk_rockchip           57344  32 rockchip_dmc,rockchip_opp_select,clk_rk3399
rockchip_sip           24576  6 
rk_vcodec,rockchip_pwm_remotectl,rockchip_bus,nvmem_rockchip_efuse,rockchip_pm_config,clk_rockchip

console:/ # rmmod clk_rk3399

rmmod: failed to unload clk_rk3399: Device or resource busy

console:/ # rmmod -f clk_rk3399

rmmod: failed to unload clk_rk3399: Device or resource busy


The builtin_platform_driver_probe()  without the __exit parts.

>
> Heiko
>
>
>
>


