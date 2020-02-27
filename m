Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D6DC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732962072D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgB0HwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:52:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:44578 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbgB0HwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:52:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 23:52:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,491,1574150400"; 
   d="scan'208";a="241965935"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2020 23:52:17 -0800
Received: from [10.226.39.43] (unknown [10.226.39.43])
        by linux.intel.com (Postfix) with ESMTP id B8CFA580544;
        Wed, 26 Feb 2020 23:52:14 -0800 (PST)
Subject: Re: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
 <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
 <20200226144147.GQ10400@smile.fi.intel.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <371e50f1-cab6-56f4-d12d-371d1b1f9c67@linux.intel.com>
Date:   Thu, 27 Feb 2020 15:52:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200226144147.GQ10400@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Andy for reviewing and giving the inputs.
I will update them as per your comments, but for couple of cases of i 
have a different opinion. Please check and give your inputs.

On 2/26/2020 10:41 PM, Andy Shevchenko wrote:
> On Wed, Feb 26, 2020 at 06:09:53PM +0800, Dilip Kota wrote:
>> Combophy subsystem provides PHYs for various
>> controllers like PCIe, SATA and EMAC.
> Thanks for an update, my comments below.
>
> ...
>
>> +config PHY_INTEL_COMBO
>> +	bool "Intel Combo PHY driver"
>> +	depends on OF && HAS_IOMEM && (X86 || COMPILE_TEST)
> I guess it would be better to have like this:
>
> 	depends on X86 || COMPILE_TEST
> 	depends on OF && HAS_IOMEM
>
> But do you still have a dependency to OF?
Yes, OF is not required. I will remove it.
>
>> +	select MFD_SYSCON
>> +	select GENERIC_PHY
>> +	select REGMAP
> ...
>
>> + * Copyright (C) 2019 Intel Corporation.
> 2019-2020
My bad. I will update it.
>
> ...
>
...
>> +};
>> +
>> +enum {
>> +	PHY_0,
>> +	PHY_1,
>> +	PHY_MAX_NUM,
> But here we don't need it since it's a terminator line.
> Ditto for the rest of enumerators with a terminator / max entry.

Sure i will remove them.

To be meaningful, i will remove the max entry for the enums representing 
the value of register bitfields.

...
> ...
>
>> +static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
> dt -> fwnode
> Ditto for other similar function names.
Sure, it looks appropriate for intel_cbphy_iphy_dt_parse() -> 
intel_cbphy_iphy_fwnode_parse().
Whereas for intel_cbphy_dt_parse() i will keep it unchanged, because it 
is calling devm_*, devm_platform_*, fwnode_* APIs to traverse dt node.
>
>> +				     struct fwnode_handle *fwnode, int idx)
>> +{
>> +	dev = get_dev_from_fwnode(fwnode);
> I don't see where you drop reference count to the struct device object.

I will add it. Thanks for pointing it.

...

> ...
>
>> +	struct fwnode_reference_args ref;
>> +	struct device *dev = cbphy->dev;
>> +	struct fwnode_handle *fwnode;
>> +	struct platform_device *pdev;
>> +	int i, ret;
>> +	u32 prop;
> I guess the following would be better:
In the v2 patch, for int i = 0 you mentioned to do initialization at the 
user, instead of doing at declaration.
So i followed the same for "pdev" and "fwnode" which are being used 
after few lines of the code . It looked good in the perspective of code 
readability.
>
> 	struct device *dev = cbphy->dev;
> 	struct platform_device *pdev = to_platform_device(dev);
> 	struct fwnode_handle *fwnode = dev_fwnode(dev);
> 	struct fwnode_reference_args ref;
> 	int i, ret;
> 	u32 prop;
>
>> +	pdev = to_platform_device(dev);
> See above.
>
>> +	fwnode = dev_fwnode(dev);
> See above.
>
>
Regards,
Dilip

