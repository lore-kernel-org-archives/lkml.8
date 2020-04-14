Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B580EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9786B2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504490AbgDNSyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:54:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:25328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504434AbgDNSyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:54:04 -0400
IronPort-SDR: cLw27pjfhl03m3Z5KJ4KurPrcVHYPtVLSC9oxY5/UzjqD23GnSjHZ/Zs3wh3A8E1HE86sGxZxc
 xDERD+K7QDWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 11:54:03 -0700
IronPort-SDR: hoN/JjJah2VUqWKnTwlrf7C3VPLIlSMNSn/PJq4GuJetvLLjSlJI+Hy1urbgwRtKxsxZSt2RKB
 y0j8foxGrwzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,383,1580803200"; 
   d="scan'208";a="253280689"
Received: from svarahab-mobl.amr.corp.intel.com (HELO [10.212.190.40]) ([10.212.190.40])
  by orsmga003.jf.intel.com with ESMTP; 14 Apr 2020 11:54:00 -0700
Subject: Re: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Mark Brown <broonie@kernel.org>
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
 <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
 <BN6PR1101MB21320F655CFC1C271CCA9CE097DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4b9455cb-d0d2-f5d8-f04c-df6e5abb4441@linux.intel.com>
Date:   Tue, 14 Apr 2020 13:53:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB21320F655CFC1C271CCA9CE097DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/20 9:29 AM, Lu, Brent wrote:
>>
>> That looks like an error caught by the ALSA conformance tool?
>>
>> What are the odds that we have a similar issue with the other broadwell
>> drivers which don't have a constraint on the number of channels either on
>> their 'System PCM' dailink?
>>
>> Thanks
>> -Pierre
>>
> 
> Yes. That's why I am sending patch for this old BDW platform...
> 
> So far as I know only 'buddy' supports 2/4-channel recording while other BDW
> Chrome products should support stereo recording only. Therefore, this defect
> should only be triggered by the ALSA conformance tool.
> 
> I am think about implementing the constraint in FE DAI's startup() callback
> instead of DAI Link's callback. Since the channels_max is 4 for the capture
> stream, ALSA conformance tool will always test 3-channel recording on any
> platforms using this driver. Does it make sense to you?

Looking back at previous threads, you indicated that the number of 
channels supported in propagated from BE to FE, so a similar patch to 
add 2ch constraints for bwd-rt5677 was dropped  ("ASoC: bdw-rt5677: 
channel constraint support")

Actually I am not sure it was dropped since later you submitted another 
patch ("ASoC: bdw-rt5677: enable runtime channel merge"), and my 
feedback was that it seemed simpler to add constraints on all machine 
drivers.

And now this patch only addresses bdw-rt5650.c but with the initial 
solution suggested for bdw-rt5677.c

It seems like a generic problem on all Broadwell devices so let's solve 
with one a single patchset.

Shouldn't we just add the 2ch constraints for broadwell.c and 
bdw-rt5677.c, and the 2 or 4ch constraint for bdw-rt5650.c? Would this 
work for you?

Thanks
-Pierre

