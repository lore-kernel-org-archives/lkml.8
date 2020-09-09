Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D66DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DF821D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 10:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIKec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 06:34:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:29695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgIIKda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 06:33:30 -0400
IronPort-SDR: sY0qwDgbUV11l4czCb3jlGrhPccjiAky7l9B7TyF/Ydn9lYyYXO4SEfe4+Roqs/EaMPOZwzWDH
 JDqEjVjAQTbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146024023"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146024023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 03:33:25 -0700
IronPort-SDR: b0fZegHHelVqHvkD6wzmTiyf3as0QAL1ZKDn4jFpHjIu2BVakLrkUBUgTzqxmTXk4qp2d603Pr
 uEU9Erq3gGFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="333774825"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 09 Sep 2020 03:33:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kFxPh-00FPwG-IJ; Wed, 09 Sep 2020 13:33:17 +0300
Date:   Wed, 9 Sep 2020 13:33:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
Message-ID: <20200909103317.GL1891694@smile.fi.intel.com>
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 02:52:05PM +0800, Rahul Tanwar wrote:
> PVT controller (MR75203) is used to configure & control
> Moortec embedded analog IP which contains temprature
> sensor(TS), voltage monitor(VM) & process detector(PD)
> modules. Add driver to support MR75203 PVT controller.

...

> +#include <linux/clk.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>


> +#include <linux/of.h>

I don't see anything special about OF here.
Perhaps
	mod_devicetable.h
	property.h
?

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

...

> +#define PVT_POLL_TIMEOUT	20000

Units?

...

> +	sys_freq = clk_get_rate(pvt->clk) / 1000000;

HZ_PER_MHZ ?

> +	while (high >= low) {
> +		middle = DIV_ROUND_CLOSEST(low + high, 2);

I'm wondering would it be better in the code like

	middle = (low + high + 1) / 2;

> +		key = DIV_ROUND_CLOSEST(sys_freq, middle);
> +		if (key > 514) {
> +			low = middle + 1;
> +			continue;
> +		} else if (key < 2) {
> +			high = middle - 1;
> +			continue;
> +		}
> +
> +		break;
> +	}
> +
> +	key = clamp_val(key, 2, 514) - 2;

I guess above deserves a comment with formulas.

...

> +		regmap_write(p_map, SDIF_DISABLE, GENMASK(p_num - 1, 0));

For non-constants better would be BIT(p_num) - 1.

...

> +		regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
> +		regmap_write(v_map, SDIF_HALT, 0x0);
> +		regmap_write(v_map, SDIF_DISABLE, 0);

In some you have 0, in some 0x0 over the file, can it be consistent?

...

> +static struct regmap_config pvt_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,

How do you use regmap's lock?

> +};

...

> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name)
> +{
> +	struct device *dev = &pdev->dev;

> +	struct pvt_device *pvt = platform_get_drvdata(pdev);

Can it be first line in definition block?

> +	struct regmap **reg_map;
> +	void __iomem *io_base;
> +	struct resource *res;
> +
> +	if (!strcmp(reg_name, "common"))
> +		reg_map = &pvt->c_map;
> +	else if (!strcmp(reg_name, "ts"))
> +		reg_map = &pvt->t_map;
> +	else if (!strcmp(reg_name, "pd"))
> +		reg_map = &pvt->p_map;
> +	else if (!strcmp(reg_name, "vm"))
> +		reg_map = &pvt->v_map;
> +	else
> +		return -EINVAL;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name);
> +	io_base = devm_ioremap_resource(dev, res);

	io_base = devm_platform_ioremap_resource_by_name(pdev, reg_name);

?

> +	if (IS_ERR(io_base))
> +		return PTR_ERR(io_base);
> +
> +	pvt_regmap_config.name = reg_name;

Hmm... regmap API keeps it in devres. Why is there a copy?

> +	*reg_map = devm_regmap_init_mmio(dev, io_base, &pvt_regmap_config);
> +	if (IS_ERR(*reg_map)) {
> +		dev_err(dev, "failed to init register map\n");
> +		return PTR_ERR(*reg_map);
> +	}
> +
> +	return 0;
> +}

...

> +		for (i = 0; i < num; i++)
> +			in_config[i] = HWMON_I_INPUT;

memset32() ?

-- 
With Best Regards,
Andy Shevchenko


