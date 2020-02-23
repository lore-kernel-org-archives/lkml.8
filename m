Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D7C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5327D2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 15:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgBWP7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 10:59:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:36989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWP7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:59:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 07:59:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="409638642"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.252.23.197]) ([10.252.23.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2020 07:59:31 -0800
Subject: Re: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joe Perches <joe@perches.com>, Xu Wang <vulab@iscas.ac.cn>,
        "Slawinski, AmadeuszX" <amadeuszx.slawinski@intel.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200221101112.3104-1-vulab@iscas.ac.cn>
 <1247da797bc0a860e845989241385e124e589063.camel@perches.com>
 <8e96c207-cdf8-2d1f-755e-be60555c8728@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a0f5a3bc-3814-4e96-f81a-b693f78d2511@intel.com>
Date:   Sun, 23 Feb 2020 16:59:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <8e96c207-cdf8-2d1f-755e-be60555c8728@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 16:40, Pierre-Louis Bossart wrote:
> On 2/21/20 8:41 AM, Joe Perches wrote:
>> On Fri, 2020-02-21 at 18:11 +0800, Xu Wang wrote:
>>> PTR_ERR should access the value just tested by IS_ERR.
>>> In skl_clk_dev_probe(),it is inconsistent.

Please include all maintainers of given driver when submitting the 
patch, thank you.

>> []
>>> diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c 
>>> b/sound/soc/intel/skylake/skl-ssp-clk.c
>> []
>>> @@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct 
>>> platform_device *pdev)
>>>                   &clks[i], clk_pdata, i);
>>>           if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>>> -            ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>>> +            ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
>>
>> NAK.
>>
>> This is not inconsistent and you are removing the ++
>> which is a post increment.  Likely that is necessary.
>>
>> You could write the access and the increment as two
>> separate statements if it confuses you.
> 
> Well to be fair the code is far from clear.

Thanks for notifying, Pierre.

Although NAK is upheld here. Proposed change is likely to introduce 
regression.

> 
> the post-increment is likely needed because of the error handling in 
> unregister_src_clk 1
>          data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
>                  &clks[i], clk_pdata, i);
> 
>          if (IS_ERR(data->clk[data->avail_clk_cnt])) {
>              ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>              goto err_unreg_skl_clk;
>          }
>      }
> 
>      platform_set_drvdata(pdev, data);
> 
>      return 0;
> 
> err_unreg_skl_clk:
>      unregister_src_clk(data);
> 
> static void unregister_src_clk(struct skl_clk_data *dclk)
> {
>      while (dclk->avail_clk_cnt--)
>          clkdev_drop(dclk->clk[dclk->avail_clk_cnt]->lookup);
> }
> 
> So the post-increment is cancelled in the while().
> 
> That said, the avail_clk_cnt field is never initialized or incremented 
> in normal usages so the code looks quite suspicious indeed.

As basically entire old Skylake code, so no surprises here : )
struct skl_clk_data::avail_clk_cnt field is initialized with 0 via 
devm_kzalloc in skl_clk_dev_probe().

> 
> gitk tells me this patch is likely the culprit:
> 
> 6ee927f2f01466 ('ASoC: Intel: Skylake: Fix NULL ptr dereference when 
> unloading clk dev')
> 
> -        data->clk[i] = register_skl_clk(dev, &clks[i], clk_pdata, i);
> -        if (IS_ERR(data->clk[i])) {
> -            ret = PTR_ERR(data->clk[i]);
> +        data->clk[data->avail_clk_cnt] = register_skl_clk(dev,
> +                &clks[i], clk_pdata, i);
> +
> +        if (IS_ERR(data->clk[data->avail_clk_cnt])) {
> +            ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
>               goto err_unreg_skl_clk;
>           }
> -
> -        data->avail_clk_cnt++;
> 
> That last removal is probably wrong. Cezary and Amadeusz, you may want 
> to look at this?

Indeed, code looks wrong. Idk what are we even dropping in 
unregister_src_clk() if register_skl_clk() fails and avail_clk_cnt gets 
incremented anyway.

In general usage of while(ptr->counter--) (example of which is present 
in unregister_src_clk()) is prone to errors. Decrementation happens 
regardless of while's check outcome and caller may receive back handle 
in invalid state.

Amadeo, your thoughts?

Czarek
