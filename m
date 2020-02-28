Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02851246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgB1JVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:21:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:48110 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgB1JVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:21:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 01:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,495,1574150400"; 
   d="scan'208";a="232182809"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 28 Feb 2020 01:21:02 -0800
Received: from [10.226.39.43] (unknown [10.226.39.43])
        by linux.intel.com (Postfix) with ESMTP id 70C5A5805EA;
        Fri, 28 Feb 2020 01:20:59 -0800 (PST)
Subject: Re: [PATCH v3 3/3] phy: intel: Add driver support for Combophy
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
References: <cover.1582709320.git.eswara.kota@linux.intel.com>
 <48dbbe705a1f22fb9e088827ca0be149e8fbcd85.1582709320.git.eswara.kota@linux.intel.com>
 <20200226144147.GQ10400@smile.fi.intel.com>
 <371e50f1-cab6-56f4-d12d-371d1b1f9c67@linux.intel.com>
 <CAHp75VfJHvtLBueHJnU6xEuSrehiXH4Pvj880TqpyDBBnx1RuQ@mail.gmail.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <8627eb55-e590-4295-a528-9d091fdbb4f1@linux.intel.com>
Date:   Fri, 28 Feb 2020 17:20:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfJHvtLBueHJnU6xEuSrehiXH4Pvj880TqpyDBBnx1RuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/27/2020 5:43 PM, Andy Shevchenko wrote:
> On Thu, Feb 27, 2020 at 9:54 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
...
>>>> +static int intel_cbphy_iphy_dt_parse(struct intel_combo_phy *cbphy,
>>> dt -> fwnode
>>> Ditto for other similar function names.
>> Sure, it looks appropriate for intel_cbphy_iphy_dt_parse() ->
>> intel_cbphy_iphy_fwnode_parse().
>> Whereas for intel_cbphy_dt_parse() i will keep it unchanged, because it
>> is calling devm_*, devm_platform_*, fwnode_* APIs to traverse dt node.
> How do you know that it will be DT node?
> I can't say it from the function parameters: Is any of them takes of_node?
Got it, All the functions are traversing through device only. I will 
change intel_cbphy_dt_parse() to intel_cbphy_fwnode_parse().
(PS: My intention is something different. As the function is fetching 
device tree node entries so kept is as *_dt_parse() )
>
>>>> +                                 struct fwnode_handle *fwnode, int idx)
> ...
>
>>>> +    struct fwnode_reference_args ref;
>>>> +    struct device *dev = cbphy->dev;
>>>> +    struct fwnode_handle *fwnode;
>>>> +    struct platform_device *pdev;
>>>> +    int i, ret;
>>>> +    u32 prop;
>>> I guess the following would be better:
>> In the v2 patch, for int i = 0 you mentioned to do initialization at the
>> user, instead of doing at declaration.
>> So i followed the same for "pdev" and "fwnode" which are being used
>> after few lines of the code . It looked good in the perspective of code
>> readability.
> No, it is different. For the loop counter is better to have closer to
> the loop, for the more global thingy like platform device it makes it
> actually harder to find.
> When you do assignments you have to think about the variable meaning
> and scope. Scope is different for loop counter versus the mentioned
> rest.

Understand. I will follow the same and keep a note for future drivers too.

Thanks for detail explanation.

Regards,
Dilip

>> .
