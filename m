Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCCEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD2420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgGFPOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:14:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:3412 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:14:33 -0400
IronPort-SDR: o/zzohaCYpA3NA6mwkD2M/k0PY8sp6m/QedYcf4XyK7Hnh+e9z00OE8GERqmADzqSFQx6yVsEZ
 yfo2F8boO3eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="146506828"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="146506828"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 08:14:32 -0700
IronPort-SDR: jp+xSpM0hz4RXPelb813+eh1Xv2NFOLsPZD+jeKCERs+hs6W1K7rsAx5C6G9hslF567dRAI2gk
 RMVTXLTYELsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="313989791"
Received: from aislam-mobl1.amr.corp.intel.com ([10.212.167.133])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2020 08:14:31 -0700
Subject: Re: [RFC PATCH] ALSA: compress: add support to change codec profile
 in gapless playback
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        plai@codeaurora.org
Cc:     alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vathota@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com
References: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
 <90ed95e0-8b01-6c87-b86b-dfa463181527@linux.intel.com>
 <2444711a-319e-1f9b-1289-7744bb1a2987@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ee34dac9-715c-6e6c-aa33-bb46f0c8261a@linux.intel.com>
Date:   Mon, 6 Jul 2020 10:14:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <2444711a-319e-1f9b-1289-7744bb1a2987@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 4:47 AM, Srinivas Kandagatla wrote:
> Thanks Pierre for the comments,
> 
> +Adding Patric Lai into loop,
> 
> 
> 
> On 02/07/2020 16:00, Pierre-Louis Bossart wrote:
>>
>>
>> On 7/2/20 6:11 AM, Srinivas Kandagatla wrote:
>>> For gapless playback its possible that each track can have different
>>> codec profile with same decoder, for example we have WMA album,
>>> we may have different tracks as WMA v9, WMA v10 and so on
>>>
>>> Existing code does not allow to change this profile while doing gapless
>>> playback.
>>>
>>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>>> userspace to set this new parameters required for new codec profile.
>>
>> That does not seem fully correct to me. WMA profiles are actually 
>> different encoding schemes - specifically the WMA 10 LBR.
>>
>> The premise for gapless playback was that the same codec and profile 
>> be used between tracks, so that the same internal delay was used. If 
>> you look at the output data, it's made of zeroes for N samples, and 
>> then you see decoded data. When you change tracks, the first N samples 
>> actually come from the previous track.
>>
>> If you change coding schemes between tracks, you cannot call this 
>> gapless playback. You will both remove the last N samples of the 
>> previous track and insert M zeroes (for the new decoder).
>>
>> If you wanted to support such a mode, you would need to provide an 
>> indication of the delay difference, e.g. by looking at the ID3 tags 
>> and let firmware realign. Unfortunately, you don't send this 
>> information with the new IOCTL? You would also need firmware tricks 
>> for the first decoder to flush out its output and the new decoder to 
>> realign.
>>
>> I also don't see how one might end-up with different profiles for an 
>> album in the first place. The gapless use came mostly from ripping 
>> live music recorded on audio CDs in different tracks, and it would 
>> have taken a twisted mind to select different encodings between tracks.
>>
>> If the 'album' is really a playlist, then the gapless playback as 
>> supported by the ASoC compressed layer is nearly useless. What you 
>> would really want is cross-fade but that's a different use case and 
>> implementation that would be needed.
> 
> Patrick seems to have discussed this topic in detail at one of the audio 
> conf!
> 
> He might want to add more to this discussion.

One more counter-argument I thought of after sending my response. If the 
samples for the previous track and the next track are not generated by 
the *same* filterbank, then you would lose the implicit averaging 
between tracks performed by the filterbank (usually an inverse MDCT), 
which will likely result in sample discontinuities and pop noise on 
transitions. If we have different filterbanks we should really look into 
explicit cross-fading which is a much larger change than what this patch 
suggests.


