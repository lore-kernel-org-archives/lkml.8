Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B13C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625F920775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgICPri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:47:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:64924 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbgICPrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:47:35 -0400
IronPort-SDR: XU6FkpYigIYy2Md47dgRQs3UAbDQuQkMxaPjHM4L7PN9lkAGkQwQnWk6cA9LpT3sYIEGoS3WF1
 YjBxQqulMlVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="145337497"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="145337497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 08:47:35 -0700
IronPort-SDR: 02HMsGSDHA7JkyN8IszHHtFc4klZm85DZSDSX9WHjgZoJ1VS100XpYBUxC/3Q7xZFw6VGRyU2X
 VZ5UnQUMCsXQ==
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="446952734"
Received: from kdkrake-mobl.amr.corp.intel.com (HELO [10.212.29.67]) ([10.212.29.67])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 08:47:33 -0700
Subject: Re: [PATCH 0/7] ASoC: soundwire: Move sdw stream operations to
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
 <20200903104248.GQ2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <033ea005-e948-c2c6-9bd4-e074d3effde0@linux.intel.com>
Date:   Thu, 3 Sep 2020 09:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903104248.GQ2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 5:42 AM, Vinod Koul wrote:
> On 01-09-20, 23:02, Bard Liao wrote:
>> sdw stream operation APIs can be called once per stream. dailink
>> callbacks are good places to call these APIs.
> 
> Again, please mention here if this is to be merged thru sdw tree or ASoC
> tree

Good point, I thought it wouldn't matter but it does. I just gave it a 
try and there seems to be a conflict on Mark's tree w/ 
drivers/soundwire/intel.c (likely due to missing patches already added 
to Vinod's tree).

So this should go to Vinod's tree with Mark's Acked-by tag on the ASoC 
changes.

Alternatively we can also split this in two, with ASoC-only and 
SoundWire-only patches in separate series if it's easier for 
maintainers. We would lose the rationale for the changes but that's not 
essential.

>> Pierre-Louis Bossart (7):
>>    ASoC: soc-dai: clarify return value for get_sdw_stream()
>>    soundwire: stream: fix NULL/IS_ERR confusion
>>    soundwire: intel: fix NULL/ERR_PTR confusion
>>    ASOC: Intel: sof_sdw: add dailink .trigger callback
>>    ASOC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> 
> These should be ASoC

Right. if you are fine with the content and this goes in your tree, can 
this be modified while applying? Or do want a v2?

>>    soundwire: intel: remove .trigger operation
>>    soundwire: intel: remove stream handling from .prepare and .hw_free
>>
>>   drivers/soundwire/intel.c        | 60 ++++-------------------
>>   drivers/soundwire/stream.c       |  2 +-
>>   include/sound/soc-dai.h          |  3 +-
>>   sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
>>   4 files changed, 92 insertions(+), 54 deletions(-)
>>
>> -- 
>> 2.17.1
> 
