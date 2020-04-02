Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59081C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F71E2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 06:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgDBGbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 02:31:17 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37792 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgDBGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 02:31:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: myjosserand)
        with ESMTPSA id 64F16296F79
Subject: Re: [PATCH v2 1/2] soc: rockchip: Register a soc_device to retrieve
 revision
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        kernel@collabora.com, kever.yang@rock-chips.com,
        geert@linux-m68k.org
References: <20200401153513.423683-1-mylene.josserand@collabora.com>
 <20200401153513.423683-2-mylene.josserand@collabora.com>
 <5143930.cPWVAAQKI9@diego>
From:   Mylene Josserand <mylene.josserand@collabora.com>
Message-ID: <aea600e2-7169-1bbc-252f-1bc77bd5b104@collabora.com>
Date:   Thu, 2 Apr 2020 08:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <5143930.cPWVAAQKI9@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 4/1/20 6:34 PM, Heiko Stübner wrote:
> Hi Mylène,
> 
> Am Mittwoch, 1. April 2020, 17:35:12 CEST schrieb Mylène Josserand:
>> Determine which revision of rk3288 by checking the HDMI version.
>> According to the Rockchip BSP kernel/u-boot, on rk3288w, the HDMI
>> revision equals 0x1A which is not the case for the rk3288.
>>
>> As these SOC have some differences, this driver will help us
>> to know on which revision we are by using 'soc_device' registration
>> to be able to use 'soc_device_match' to detect rk3288/rk3288w.
>>
>> Signed-off-by: Mylène Josserand <mylene.josserand@collabora.com>
> 
> I like your new approach quite a lot :-)

Thank you, I am happy to know that :D

> 
> There are some things we need to take into account though, see below.

Sure, no problem

> 
> 
>> ---
>>   drivers/soc/rockchip/Makefile |   1 +
>>   drivers/soc/rockchip/rk3288.c | 125 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 126 insertions(+)
>>   create mode 100644 drivers/soc/rockchip/rk3288.c
>>
>> diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
>> index afca0a4c4b72..9dbf12913512 100644
>> --- a/drivers/soc/rockchip/Makefile
>> +++ b/drivers/soc/rockchip/Makefile
>> @@ -2,5 +2,6 @@
>>   #
>>   # Rockchip Soc drivers
>>   #
>> +obj-$(CONFIG_ARCH_ROCKCHIP) += rk3288.o
>>   obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
>>   obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
>> diff --git a/drivers/soc/rockchip/rk3288.c b/drivers/soc/rockchip/rk3288.c
> 
> I'd really like this to be a soc.c instead of rk3288.c ;-)

Cool! I will do that :)

> 
> 
>> new file mode 100644
>> index 000000000000..83379ba2b31b
>> --- /dev/null
>> +++ b/drivers/soc/rockchip/rk3288.c
>> @@ -0,0 +1,125 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2020 Collabora Ltd
>> + * Author: Mylene Josserand <mylene.josserand@collabora.com>
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +#include <linux/sys_soc.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +
>> +#define RK3288_HDMI_REV_REG	0x04
>> +#define RK3288W_HDMI_REV	0x1A
>> +
>> +enum rk3288_soc_rev {
>> +	RK3288_SOC_REV_NOT_DETECT,
>> +	RK3288_SOC_REV_RK3288,
>> +	RK3288_SOC_REV_RK3288W,
>> +};
>> +
>> +static int rk3288_revision(void)
>> +{
>> +	static int revision = RK3288_SOC_REV_NOT_DETECT;
>> +	struct device_node *dn;
>> +	void __iomem *hdmi_base;
>> +
>> +	if (revision != RK3288_SOC_REV_NOT_DETECT)
>> +		return revision;
>> +
>> +	dn = of_find_compatible_node(NULL, NULL, "rockchip,rk3288-dw-hdmi");
>> +	if (!dn) {
>> +		pr_err("%s: Couldn't find HDMI node\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hdmi_base = of_iomap(dn, 0);
>> +	of_node_put(dn);
>> +
>> +	if (!hdmi_base) {
>> +		pr_err("%s: Couldn't map %pOF regs\n", __func__,
>> +		       hdmi_base);
>> +		return -ENXIO;
>> +	}
> 
> The possible problem I see here is clocking and power-domain of the hdmi
> controller in corner-cases. In the past we already had a lot of fun with
> kexec, which also indicates that people actually use kexec productively.
> 
> So while all clocks are ungated and all power-domains are powered on first
> boot, on a system without graphics the pclk+power-domain could be off when
> doing a kexec into a second kernel, which then would probably hang here.
> 
> 
> Of course with the hdmi-pclk being sourced from hclk_vio we run into a
> chicken-egg-problem, as we need pclk_hdmi_ctrl to register hclk_vio at all.
> 
> So I guess one way out of this could be to
> - amend rk3288_clk_shutdown() to also ungate the hdmi-pclk on shutdown
> - add a shutdown mechanism to the power-domain driver so that it can
>    enable PD_VIO on shutdown

hm, indeed, I will send a v3 including that, thanks for the hints!

> 
>> +
>> +	if (readl_relaxed(hdmi_base + RK3288_HDMI_REV_REG)
>> +	    == RK3288W_HDMI_REV)
> 
> nit: a nicer look would be something like
> 	val = readl_relaxed(hdmi_base + RK3288_HDMI_REV_REG);
> 	if (val == RK3288W_HDMI_REV)

I will change that.

> 
>> +		revision = RK3288_SOC_REV_RK3288W;
>> +	else
>> +		revision = RK3288_SOC_REV_RK3288;
>> +
>> +	iounmap(hdmi_base);
>> +
>> +	return revision;
>> +}
>> +
>> +static const char *rk3288_socinfo_revision(u32 rev)
>> +{
>> +	const char *soc_rev;
>> +
>> +	switch (rev) {
>> +	case RK3288_SOC_REV_RK3288:
>> +		soc_rev = "RK3288";
>> +		break;
>> +
>> +	case RK3288_SOC_REV_RK3288W:
>> +		soc_rev = "RK3288w";
> 
> can we maybe use lower-case letters for all here?

Sure, no problem.

> 
>> +		break;
>> +
>> +	case RK3288_SOC_REV_NOT_DETECT:
>> +		soc_rev = "";
>> +		break;
>> +
>> +	default:
>> +		soc_rev = "unknown";
>> +		break;
>> +	}
>> +
>> +	return kstrdup_const(soc_rev, GFP_KERNEL);
>> +}
>> +
>> +static const struct of_device_id rk3288_soc_match[] = {
>> +	{ .compatible = "rockchip,rk3288", },
>> +	{ }
>> +};
>> +
>> +static int __init rk3288_soc_init(void)
> 
> as noted at the top, I'd really like to see this more generalized so that
> other socs can just hook in there with a revision callback in a
> rockchip_soc_data struct.

Yes, I will do!

> 
> 
>> +{
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +	struct device_node *np;
>> +
>> +	np = of_find_matching_node(NULL, rk3288_soc_match);
>> +	if (!np)
>> +		return -ENODEV;
>> +
>> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
>> +	if (!soc_dev_attr)
>> +		return -ENOMEM;
>> +
>> +	soc_dev_attr->family = "Rockchip";
>> +	soc_dev_attr->soc_id = "RK32xx";
> 
> nit: rk3288 instead of "32xx" please

okay

> 
>> +
>> +	np = of_find_node_by_path("/");
>> +	of_property_read_string(np, "model", &soc_dev_attr->machine);
>> +	of_node_put(np);
>> +
>> +	soc_dev_attr->revision = rk3288_socinfo_revision(rk3288_revision());
>> +
>> +	soc_dev = soc_device_register(soc_dev_attr);
>> +	if (IS_ERR(soc_dev)) {
>> +		kfree_const(soc_dev_attr->revision);
>> +		kfree_const(soc_dev_attr->soc_id);
>> +		kfree(soc_dev_attr);
>> +		return PTR_ERR(soc_dev);
>> +	}
>> +
>> +	dev_info(soc_device_to_device(soc_dev), "Rockchip %s %s detected\n",
>> +		 soc_dev_attr->soc_id, soc_dev_attr->revision);
> 
> nit: dev_dbg should be enough, that information doesn't really matter for
> most people, as it's only relevant to clock internals.

yep

Thank you again for this review!

Best regards,
Mylène Josserand

