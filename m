Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74907C7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8212081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FrHINWpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgBOMnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:43:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52468 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgBOMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:43:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01FCh3rN025357;
        Sat, 15 Feb 2020 06:43:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581770583;
        bh=yBn9gK1NwrSrfDV5/cv9nIfbuJXvtNU93U3m+DXnd+Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FrHINWpf7UPsdPZtq9h1f5L7EkHetpfrH9ckLHLDqD3GzginIR3F27+kH5QOszLK8
         D6xjZvRX9WIKp8QbOzKWrwEpfg5LGjqK/p3ECf782IsiMgYedu5kfHZKpF514KyBHf
         y2cl9QhtYeNvkcuae41nQJh22PUBSyCIin/BQCcs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01FCh2EV001643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Feb 2020 06:43:03 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 15
 Feb 2020 06:43:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 15 Feb 2020 06:43:02 -0600
Received: from [10.250.133.210] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01FCgwSA110275;
        Sat, 15 Feb 2020 06:42:59 -0600
Subject: Re: [PATCH v2 2/2] clk: keystone: Add new driver to handle syscon
 based clocks
To:     Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20200207044425.32398-1-vigneshr@ti.com>
 <20200207044425.32398-3-vigneshr@ti.com>
 <158136117429.94449.12421902020705390139@swboyd.mtv.corp.google.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <700f5237-3fd5-87a4-3f68-3d289db2ed08@ti.com>
Date:   Sat, 15 Feb 2020 18:12:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <158136117429.94449.12421902020705390139@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2020 12:29 AM, Stephen Boyd wrote:
> Quoting Vignesh Raghavendra (2020-02-06 20:44:25)
>> diff --git a/drivers/clk/keystone/Kconfig b/drivers/clk/keystone/Kconfig
>> index 38aeefb1e808..69ca3db1a99e 100644
>> --- a/drivers/clk/keystone/Kconfig
>> +++ b/drivers/clk/keystone/Kconfig
>> @@ -26,3 +26,11 @@ config TI_SCI_CLK_PROBE_FROM_FW
>>           This is mostly only useful for debugging purposes, and will
>>           increase the boot time of the device. If you want the clocks probed
>>           from firmware, say Y. Otherwise, say N.
>> +
>> +config TI_SYSCON_CLK
>> +       tristate "Syscon based clock driver for K2/K3 SoCs"
>> +       depends on (ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST) && OF
>> +       default (ARCH_KEYSTONE || ARCH_K3)
> 
> Drop parenthesis. It's not useful. Also, not sure why OF is a build
> dependency. Please drop it.
> 

Yes, will drop..

> 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
> 	default ARCH_KEYSTONE || ARCH_K3
> 
>> +       help
>> +         This adds clock driver support for syscon based gate
>> +         clocks on TI's K2 and K3 SoCs.
>> diff --git a/drivers/clk/keystone/Makefile b/drivers/clk/keystone/Makefile
>> index d044de6f965c..0e426e648f7c 100644
>> --- a/drivers/clk/keystone/Makefile
>> +++ b/drivers/clk/keystone/Makefile
>> @@ -1,3 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  obj-$(CONFIG_COMMON_CLK_KEYSTONE)      += pll.o gate.o
>>  obj-$(CONFIG_TI_SCI_CLK)               += sci-clk.o
>> +obj-$(CONFIG_TI_SYSCON_CLK)            += syscon-clk.o
>> diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
>> new file mode 100644
>> index 000000000000..42e7416371ff
>> --- /dev/null
>> +++ b/drivers/clk/keystone/syscon-clk.c
>> @@ -0,0 +1,177 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
>> +//
> 
> These last three comment lines should be normal kernel style. /* */
> 
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk.h>
> 
> Is this used?
> 

Will drop

>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
> 
> Hopefully these two includes aren't needed.
> 

Not anymore

>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
> [...]
>> +
>> +static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
>> +{
>> +       const struct ti_syscon_gate_clk_data *data, *p;
>> +       struct clk_hw_onecell_data *hw_data;
>> +       struct device *dev = &pdev->dev;
>> +       struct regmap *regmap;
>> +       int num_clks = 0;
> 
> Please don't initialize here.

Ok

> 
>> +       int i;
>> +
>> +       data = of_device_get_match_data(dev);
> 
> Use device_get_match_data() instead?

Sure

> 
>> +       if (!data)
>> +               return -EINVAL;
>> +
>> +       regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +                                                "ti,tbclk-syscon");
>> +       if (IS_ERR(regmap)) {
>> +               if (PTR_ERR(regmap) == -EPROBE_DEFER)
>> +                       return -EPROBE_DEFER;
>> +               dev_err(dev, "failed to find parent regmap\n");
>> +               return PTR_ERR(regmap);
>> +       }
>> +
>> +       for (p = data; p->name; p++)
> 
> Initialize num_clks here so we know it's a loop that's counting.

OK

> 
>> +               num_clks++;
>> +
>> +       hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, num_clks),
>> +                              GFP_KERNEL);
>> +       if (!hw_data)
>> +               return -ENOMEM;
>> +
>> +       hw_data->num = num_clks;
>> +
>> +       for (i = 0; i < num_clks; i++) {
>> +               hw_data->hws[i] = ti_syscon_gate_clk_register(dev, regmap,
>> +                                                             &data[i]);
>> +               if (IS_ERR(hw_data->hws[i]))
>> +                       dev_err(dev, "failed to register %s",
> 
> Add a newline?

Yes, will add

> 
>> +                               data[i].name);
> 
> And we don't fail? So it really isn't a problem? Maybe dev_warn()
> instead?
> 

OK

>> +       }
>> +
>> +       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                          hw_data);
>> +}
>> +
>> +#define TI_SYSCON_CLK_GATE(_name, _offset, _bit_idx)   \
>> +       {                                               \
>> +               .name = _name,                          \
>> +               .offset = (_offset),                    \
>> +               .bit_idx = (_bit_idx),                  \
>> +       }
>> +
>> +static const struct ti_syscon_gate_clk_data am654_clk_data[] = {
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk0", 0x0, 0),
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk1", 0x4, 0),
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk2", 0x8, 0),
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk3", 0xc, 0),
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk4", 0x10, 0),
>> +       TI_SYSCON_CLK_GATE("ehrpwm_tbclk5", 0x14, 0),
>> +       { /* Sentinel */ },
>> +};
>> +
>> +static const struct of_device_id ti_syscon_gate_clk_ids[] = {
>> +       {
>> +               .compatible = "ti,am654-ehrpwm-tbclk",
>> +               .data = &am654_clk_data,
>> +       },
>> +       { }
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
>> +
>> +static struct platform_driver ti_syscon_gate_clk_driver = {
>> +       .probe = ti_syscon_gate_clk_probe,
>> +       .driver = {
>> +               .name = "ti-syscon-gate-clk",
>> +               .of_match_table = ti_syscon_gate_clk_ids,
>> +       },
>> +};
>> +
> 
> Nitpick: Drop the newline.
> 

Ok

>> +module_platform_driver(ti_syscon_gate_clk_driver);
>> +

Thanks for the review!

Regards
Vignesh
