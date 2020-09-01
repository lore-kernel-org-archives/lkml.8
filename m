Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1878AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA01B206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgIANcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:32:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:45739 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgIANbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:31:44 -0400
IronPort-SDR: wUNd+JOqiJ8eiDvFzP4qwfJ6RfzN0l2DRRinJvo5GqLck4AU3mD3gBCDFQNgkexBegw4sLeBE9
 gCbyOr1qZozA==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="136681369"
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="136681369"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 06:31:22 -0700
IronPort-SDR: AGXl7TqFyYMzY+0nDQFWipcPsAWD9PripkK5s9uET5CINDhTMhqK+2b+R0jdg2W+iA9o5DbvLv
 ExDHSdugl+QA==
X-IronPort-AV: E=Sophos;i="5.76,379,1592895600"; 
   d="scan'208";a="446127414"
Received: from dlabricc-mobl.amr.corp.intel.com (HELO [10.212.239.51]) ([10.212.239.51])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 06:31:21 -0700
Subject: Re: [PATCH 09/11] soundwire: intel: add dynamic debug trace for
 clock-stop invalid configs
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200829110047.GC2639@vkoul-mobl>
 <051afb2d-dd2e-0ea4-d8a9-980f5df136b7@linux.intel.com>
 <20200901110716.GA2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <101ce54e-a368-d25f-c849-48aeb2bc14c0@linux.intel.com>
Date:   Tue, 1 Sep 2020 08:31:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901110716.GA2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/20 6:07 AM, Vinod Koul wrote:
> On 31-08-20, 10:15, Pierre-Louis Bossart wrote:
>>
>>>>>>>> Detect cases where the clock is assumed to be stopped but the IP is
>>>>>>>> not in the relevant state, and add a dynamic debug trace.
>>>>>>>
>>>>>>> you meant a debug print..and it looks like error print below (also in title).
>>>>>>
>>>>>> I don't understand the comment. Is the 'trace' confusing and are you asking
>>>>>> to e.g. change the commit message to 'add dynamic debug log'?
>>>>>
>>>>> Question is what is dynamic about this?
>>>> dev_dbg() is part of the kernel dynamic debug capability...
>>>>
>>>> https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
>>>>
>>>> Not sure what you are asking here?
>>>
>>> :-| where is dev_dbg() ?
>>>
>>> See [1]
>>
>>>
>>> [1]
>>>
>>>> +			dev_err(dev, "%s invalid configuration, clock was not stopped", __func__);
>>>
>>>                           ^^^^^^^
>>
>> it's still a log using the "dynamic debug" framework.
>>
>> Again, what are you asking us to fix?
> 
> Ah you are really testing my patience!

I was asking a question, not making a statement.

There is no need to blow a fuse or yell via exclamation marks at people 
who provide 90% of the patches for the subsystem you maintain, or 
provide fixes for your own patches.

> The title says "dynamic debug" and then you use a dev_err which is *not*
> part of dynamic debug as it is printed always and cannot be dynamically
> enabled and disabled!

I accept the argument, I just didn't understand what the issue was.

> See Documentation/admin-guide/dynamic-debug-howto.rst:
> 
> "Dynamic debug is designed to allow you to dynamically enable/disable
> kernel code to obtain additional kernel information.  Currently, if
> ``CONFIG_DYNAMIC_DEBUG`` is set, then all ``pr_debug()``/``dev_dbg()`` and
> ``print_hex_dump_debug()``/``print_hex_dump_bytes()`` calls can be dynamically
> enabled per-callsite."
> 
> No dev_err here!

ok, so we will change the title to 'soundwire: intel: add error log for 
clock-stop invalid config'.

Thanks
-Pierre
