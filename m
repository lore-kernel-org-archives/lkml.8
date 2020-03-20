Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3577E20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCTSSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:18:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:6726 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgCTSSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:18:04 -0400
IronPort-SDR: MJuDvWSls+whKWjkAl5O74C51A+RWvwyBTs04310L5E8jj4kkba0Ji8mV/Lj10SR+rmbMs5nGB
 ozTESYyLJtpA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2020 11:18:04 -0700
IronPort-SDR: zbi2N4p/jkWWXG5sygpgaZcdsWnUMpYX5W4p6Y/W5HV3X5nuDH7+9Oz5xclUjfXH7BP4Q7V1oz
 hi6rn+uhtmcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; 
   d="scan'208";a="392230416"
Received: from manallet-mobl.amr.corp.intel.com (HELO [10.255.34.12]) ([10.255.34.12])
  by orsmga004.jf.intel.com with ESMTP; 20 Mar 2020 11:18:01 -0700
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <20200320141528.GI4885@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f212f561-27aa-265c-3f4c-45b2336ac145@linux.intel.com>
Date:   Fri, 20 Mar 2020 09:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200320141528.GI4885@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 9:15 AM, Vinod Koul wrote:
> On 17-03-20, 05:51, Pierre-Louis Bossart wrote:
>> In a multi-cpu DAI context, the stream routines may be called from
>> multiple DAI callbacks. Make sure the stream state only changes for
>> the first call, and don't return error messages if the target state is
>> already reached.
> 
> For stream-apis we have documented explicitly in Documentation/driver-api/soundwire/stream.rst
> 
> "Bus implements below API for allocate a stream which needs to be called once
> per stream. From ASoC DPCM framework, this stream state maybe linked to
> .startup() operation.
> 
> .. code-block:: c
> 
>    int sdw_alloc_stream(char * stream_name); "
> 
> This is documented for all stream-apis.
> 
> This can be resolved by moving the calling of these APIs from
> master-dais/slave-dais to machine-dais. They are unique in the card.

this change is about prepare/enable/disable/deprepare, not allocation or 
startup.

I see no reason to burden the machine driver with all these steps. It's 
not because QCOM needs this transition that everyone does.

As discussed earlier, QCOM cannot use this functionality because the 
prepare/enable and disable/deprepare are done in the hw_params and 
hw_free respectively. This was never the intended use, but Intel let it 
happen so I'd like you to return the favor. This change has no impact 
for QCOM and simplifies the Intel solution, so why would you object?

Seriously, your replies on all Intel contributions make me wonder if 
this is the QCOM/Linaro SoundWire subsystem, or if we are going to find 
common ground to deal with vastly different underlying architectures?
