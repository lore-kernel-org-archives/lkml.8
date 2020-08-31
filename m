Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D497C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC66C20767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgHaPPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:15:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:37214 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgHaPPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:15:42 -0400
IronPort-SDR: Jqv2qd2ZDwx60MNQUPK89BPVQr1+p5Guwuoo9yJ7xpgltdo9MtiHusTWe+a2wJrnXBEdmiIqTS
 1Ld58yu5zfCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="157998298"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="157998298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 08:15:41 -0700
IronPort-SDR: v+uBZj2yz55phQgP83igUTAsDBunmkJ9f49VrBbrIS3NM4KS8+6pGtYENeFcFdHxEM6jugM9Bv
 4kF0z8JH/H9A==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="501376518"
Received: from jaeikcho-mobl.amr.corp.intel.com (HELO [10.213.165.6]) ([10.213.165.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 08:15:38 -0700
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
References: <20200829110047.GC2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <051afb2d-dd2e-0ea4-d8a9-980f5df136b7@linux.intel.com>
Date:   Mon, 31 Aug 2020 10:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829110047.GC2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> Detect cases where the clock is assumed to be stopped but the IP is
>>>>>> not in the relevant state, and add a dynamic debug trace.
>>>>>
>>>>> you meant a debug print..and it looks like error print below (also in title).
>>>>
>>>> I don't understand the comment. Is the 'trace' confusing and are you asking
>>>> to e.g. change the commit message to 'add dynamic debug log'?
>>>
>>> Question is what is dynamic about this?
>> dev_dbg() is part of the kernel dynamic debug capability...
>>
>> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>>
>> Not sure what you are asking here?
> 
> :-| where is dev_dbg() ?
> 
> See [1]

> 
> [1]
> 
>> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
> 
>                          ^^^^^^^

it's still a log using the "dynamic debug" framework.

Again, what are you asking us to fix?

