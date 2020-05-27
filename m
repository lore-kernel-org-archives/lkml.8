Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46ABC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DA620776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgE0DxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:53:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:8198 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387487AbgE0DxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:53:19 -0400
IronPort-SDR: GRSqhu7Ij8H6PUGsOjoVTH4LQEhYjTFL2JnYFfVSjdWWVEU2aqrurznGQy27uNZH7BA/6dLOJ/
 A/5tz9dRxjbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 20:53:19 -0700
IronPort-SDR: f0/a7uXNqJ5aDFrnDJ0yEoe7GmPGGF/fM4jFM9d1GXpNKVgxLRdXoBGZ/L70VPM+xs2wnh8j4G
 vfSzCZXTOKAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="442356630"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 26 May 2020 20:53:19 -0700
Received: from [10.214.150.18] (rtanwar-mobl.gar.corp.intel.com [10.214.150.18])
        by linux.intel.com (Postfix) with ESMTP id 1D8CC5803C1;
        Tue, 26 May 2020 20:53:15 -0700 (PDT)
Subject: Re: [PATCH v8 2/2] clk: intel: Add CGU clock driver for a new SoC
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Cc:     robh@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
References: <cover.1587102634.git.rahul.tanwar@linux.intel.com>
 <42a4f71847714df482bacffdcd84341a4052800b.1587102634.git.rahul.tanwar@linux.intel.com>
 <159054541310.88029.5777794695153819198@swboyd.mtv.corp.google.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <c91ec0e0-5a16-2e28-dae0-4219f5f5340f@linux.intel.com>
Date:   Wed, 27 May 2020 11:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <159054541310.88029.5777794695153819198@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

On 27/5/2020 10:10 am, Stephen Boyd wrote:
> Quoting Rahul Tanwar (2020-04-16 22:54:47)
>> diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
>> new file mode 100644
>> index 000000000000..802a7fa88535
>> --- /dev/null
>> +++ b/drivers/clk/x86/clk-cgu.c
>> @@ -0,0 +1,636 @@
> [...]
>> +       ctx->membase = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(ctx->membase))
>> +               return PTR_ERR(ctx->membase);
>> +
>> +       ctx->np = np;
>> +       ctx->dev = dev;
>> +       spin_lock_init(&ctx->lock);
>> +
>> +       ret = lgm_clk_register_plls(ctx, lgm_pll_clks,
>> +                                   ARRAY_SIZE(lgm_pll_clks));
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = lgm_clk_register_branches(ctx, lgm_branch_clks,
>> +                                       ARRAY_SIZE(lgm_branch_clks));
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = lgm_clk_register_ddiv(ctx, lgm_ddiv_clks,
>> +                                   ARRAY_SIZE(lgm_ddiv_clks));
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                         &ctx->clk_data);
>> +       if (ret)
>> +               return ret;
> Are any of the clks unregistered on failure? It looks like devm_ isn't
> used for registration so nothing can be undone? Please fix this in a
> future patch.

Thanks a lot for accepting the patch series. I went through all of your
comments and i agree with all of them. Will fix it & address other
review concerns in a future patch once 5.8 is released.

Regards,
Rahul

