Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A817C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22642067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389304AbgHQRHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:07:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:6220 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388552AbgHQQKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:10:37 -0400
IronPort-SDR: dmTxRCrVGvqHk3zeMbQ8lUYqzj3nBpGG/MeB1rH+6TcGA3JtTAukfQJnMz5PPoUzHMz3OI69ZB
 a/4gG/kX7raQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155831458"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="155831458"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:10:29 -0700
IronPort-SDR: FU/qJukm9lMEnugsV4tXLKOeYwlgKtadxOBp25Yer+nYIV8SKJWX/VzHpO/Cscb+A5fPUztv5p
 2Qn94R5I+JYw==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="310139813"
Received: from jhor-mobl.gar.corp.intel.com (HELO [10.209.166.196]) ([10.209.166.196])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 09:10:27 -0700
Subject: Re: [PATCH 00/13] soundwire: intel: add power management support
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200817120841.GQ2639@vkoul-mobl>
 <d8f8f64f-34db-9c9a-c821-83dda3b2db9a@linux.intel.com>
Message-ID: <093dcb7d-e2b7-b568-6a23-aeaf9bfb6004@linux.intel.com>
Date:   Mon, 17 Aug 2020 11:10:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8f8f64f-34db-9c9a-c821-83dda3b2db9a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> I had applied except 3 & 9 (few skipped in middle due to conflict while
>> applying), BUT I get a build failure on patch 2 onwards :(
>>
>> drivers/soundwire/intel_init.c: In function ‘sdw_intel_cleanup’:
>> drivers/soundwire/intel_init.c:72:4: error: implicit declaration of 
>> function ‘pm_runtime_disable’ [-Werror=implicit-function-declaration]
>>     72 |    pm_runtime_disable(&link->pdev->dev);
>>
>> I suspect due to missing header? I was on x64 build with allmodconfig
>>
>> So only patch 1 is applied and pushed now
> 
> I just tried on these series applied on top of soundwire/next
> 
> commit 9b3b4b3f2f2af863d2f6dd65afd295a5a673afa2 (soundwire/next)
> 
>      soundwire: intel: Add basic power management support
> 
> And I don't see any issue?

Sorry, I misunderstood the issue. Yes indeed the #include 
<linux/pm_runtime.h> is added to the wrong patch, I see Bard fixed this 
in our tree. Not sure what happened here, I ran a patch-by-patch 
compilation test a long time ago and kbuild was silent. Thanks for 
spotting this.

> If you want to double-check merge issues, I pushed the code here: 
> https://github.com/plbossart/sound/tree/sdw/pm_runtime_soundwire_next
> 
> I am really not sure what conflicts you are referring to, git am worked 
> fine for me, only skipped the first patch that's already applied.

But the point about conflicts does remain, I am not sure why you skipped 
patches, I have no merge conflicts on my side.

