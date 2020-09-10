Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D71C2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A517D20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgIJH1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:27:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:5784 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgIJH1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:27:42 -0400
IronPort-SDR: /5d06dtqMTRY7lzQF5tuf4rGO9rWV19sXXnxea+WnfwuVZaz1kvbuZNKHiaxmZOdh7gm9hqn7I
 zqxB6vAviJeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="138002032"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="138002032"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 00:26:09 -0700
IronPort-SDR: IuROGYMsnJyCthmZ52YfiKeT6z1c0bLlhrO5j9eYWcfQ6dc22mFu4mnQLj+rMrjb/U/ZfAD7w+
 VbAIrvI8i++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="407683701"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2020 00:26:09 -0700
Received: from [10.215.160.12] (rtanwar-MOBL.gar.corp.intel.com [10.215.160.12])
        by linux.intel.com (Postfix) with ESMTP id 261DA5807AD;
        Thu, 10 Sep 2020 00:26:05 -0700 (PDT)
Subject: Re: [PATCH 2/2] Add driver for Moortec MR75203 PVT controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rtanwar@maxlinear.com
References: <cover.1599634208.git.rahul.tanwar@linux.intel.com>
 <ecb6794a8f2ef6576421e6d5fbdf4e6a91f06b91.1599634208.git.rahul.tanwar@linux.intel.com>
 <20200909103317.GL1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <41cf7b4d-2476-4d0e-0dae-f0200649d7dd@linux.intel.com>
Date:   Thu, 10 Sep 2020 15:26:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909103317.GL1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andy,

Thanks for the review & feedback.

On 9/9/2020 6:33 pm, Andy Shevchenko wrote:
> On Wed, Sep 09, 2020 at 02:52:05PM +0800, Rahul Tanwar wrote:
>> PVT controller (MR75203) is used to configure & control
>> Moortec embedded analog IP which contains temprature
>> sensor(TS), voltage monitor(VM) & process detector(PD)
>> modules. Add driver to support MR75203 PVT controller.
> ...
>
>> +#include <linux/clk.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>
>> +#include <linux/of.h>
> I don't see anything special about OF here.
> Perhaps
> 	mod_devicetable.h
> 	property.h
> ?

of.h is needed because of of_property_read_u8_array(). I will add
mod_devicetable.h.
property.h seems not required at all.

>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
> ...
>
>> +#define PVT_POLL_TIMEOUT	20000
> Units?

Well noted.

> ...
>
>> +	sys_freq = clk_get_rate(pvt->clk) / 1000000;
> HZ_PER_MHZ ?

Well noted.

>> +	while (high >= low) {
>> +		middle = DIV_ROUND_CLOSEST(low + high, 2);
> I'm wondering would it be better in the code like
>
> 	middle = (low + high + 1) / 2;

Will update.

>> +		key = DIV_ROUND_CLOSEST(sys_freq, middle);
>> +		if (key > 514) {
>> +			low = middle + 1;
>> +			continue;
>> +		} else if (key < 2) {
>> +			high = middle - 1;
>> +			continue;
>> +		}
>> +
>> +		break;
>> +	}
>> +
>> +	key = clamp_val(key, 2, 514) - 2;
> I guess above deserves a comment with formulas.

Hmm..I will try to add some more info. Problem is that the datasheet doesn't
explain it clearly.

> ...
>
>> +		regmap_write(p_map, SDIF_DISABLE, GENMASK(p_num - 1, 0));
> For non-constants better would be BIT(p_num) - 1.

Well noted.

> ...
>
>> +		regmap_write(v_map, SDIF_SMPL_CTRL, 0x0);
>> +		regmap_write(v_map, SDIF_HALT, 0x0);
>> +		regmap_write(v_map, SDIF_DISABLE, 0);
> In some you have 0, in some 0x0 over the file, can it be consistent?

Yes, missed that, will update.

> ...
>
>> +static struct regmap_config pvt_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
> How do you use regmap's lock?

We mutex lock whenever read temperature or voltage values from the registers.
All non-probe/non-init paths. We do not override regmap's internal lock.

>> +};
> ...
>
>> +static int pvt_get_regmap(struct platform_device *pdev, char *reg_name)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct pvt_device *pvt = platform_get_drvdata(pdev);
> Can it be first line in definition block?

Well noted.

>> +	struct regmap **reg_map;
>> +	void __iomem *io_base;
>> +	struct resource *res;
>> +
>> +	if (!strcmp(reg_name, "common"))
>> +		reg_map = &pvt->c_map;
>> +	else if (!strcmp(reg_name, "ts"))
>> +		reg_map = &pvt->t_map;
>> +	else if (!strcmp(reg_name, "pd"))
>> +		reg_map = &pvt->p_map;
>> +	else if (!strcmp(reg_name, "vm"))
>> +		reg_map = &pvt->v_map;
>> +	else
>> +		return -EINVAL;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name);
>> +	io_base = devm_ioremap_resource(dev, res);
> 	io_base = devm_platform_ioremap_resource_by_name(pdev, reg_name);
>
> ?

Well noted.

>> +	if (IS_ERR(io_base))
>> +		return PTR_ERR(io_base);
>> +
>> +	pvt_regmap_config.name = reg_name;
> Hmm... regmap API keeps it in devres. Why is there a copy?

Just populating the name in regmap config because of multiple register
regions.. 

>> +	*reg_map = devm_regmap_init_mmio(dev, io_base, &pvt_regmap_config);
>> +	if (IS_ERR(*reg_map)) {
>> +		dev_err(dev, "failed to init register map\n");
>> +		return PTR_ERR(*reg_map);
>> +	}
>> +
>> +	return 0;
>> +}
> ...
>
>> +		for (i = 0; i < num; i++)
>> +			in_config[i] = HWMON_I_INPUT;
> memset32() ?
>

Well noted. Thanks.

Regards,
Rahul
