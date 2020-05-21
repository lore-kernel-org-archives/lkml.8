Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7886C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7534020823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 18:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgEUSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 14:10:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:21653 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgEUSK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 14:10:56 -0400
IronPort-SDR: 3zziwMNeLeZykRN5RmtUL7C+ztk1ZPBnV/xR+8QlotFFZ2Nhrt+9z6OtxJ/hB8DDn6+mYbtbo6
 K0UiSVun8SEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 11:10:55 -0700
IronPort-SDR: JCuh9H/hp4YFzm3n4ukF0/9cPkRoVB2FWwSZl79U6XjFPyn3ZlfO784xWpxfyjmANOsbTNVHqS
 zGY1qBPYO/7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,418,1583222400"; 
   d="scan'208";a="254062243"
Received: from dsrao-mobl.amr.corp.intel.com (HELO [10.255.229.80]) ([10.255.229.80])
  by orsmga007.jf.intel.com with ESMTP; 21 May 2020 11:10:54 -0700
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>
Cc:     alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>,
        Harsha Priya <harshapriya.n@intel.com>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
 <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com>
Date:   Thu, 21 May 2020 13:10:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/20 12:30 PM, Łukasz Majczak wrote:
> Hi Pierre
> 
> If you will take a look at the original kabylake_ssp_fixup() you will
> see that it is checking whether the related FE is "Kbl Audio Port",
> "Kbl Audio Headset Playback", "Kbl Audio Capture Port" or "Kbl Audio
> DMIC cap" - then for the first 3 cases it sets min/max channels to 2
> while for the "Kbl DMIC cap" it can be 2 or 4, that's is why I'm
> trying to split this, but maybe I'm missing here something.

I don't understand this code either.

I believe the intent is that for all SSP1-RT5663 usages, we should use

  		rate->min = rate->max = 48000;
		chan->min = chan->max = 2;
		snd_mask_none(fmt);
		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);

That is pretty easy to move to a dedicated ssp1 fixup.

for SSP0, we have RT5514 for capture and max98927 for playback, but the 
existing code does not explicitly deal with rate/channels/format for all 
cases, so it's not clear what should happen.

Harsha, can you help here?

> 
> Best regards,
> Lukasz
> 
> czw., 21 maj 2020 o 19:17 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisał(a):
>>
>>
>>
>> On 5/21/20 12:08 PM, Łukasz Majczak wrote:
>>>>
>>>> don't add a new dailink, this is not right.
>>>>
>>> Can you advise a better solution how to assign different fixup
>>> functions to mic and to speakers? I was looking at "dmic01" dailink in
>>> skl_nau88l25_max98357a.c as an example.
>>
>> I am not sure I follow. the DMICs are handled on a shared SSP, so how
>> would one set a different fixup? The word length have to be the same.
