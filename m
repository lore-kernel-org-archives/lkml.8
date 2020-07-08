Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C306CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A383220720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgGHNcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:32:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:44215 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728210AbgGHNcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:32:04 -0400
IronPort-SDR: VdQtDux9/BcQOzmEpbALdQgJ7bFREd2NopcT0GqVUFQMIUSbYKHdWBhk3dlmYWkHVaVWGgYnym
 yMCHAZZK44Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="145893465"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="145893465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:32:04 -0700
IronPort-SDR: JpZagW8MXgMBvYL2D8nB9CPV8hqSBf7SjbpT5EbikngkLv4RhwnVp/V/1aWGE07okKPQTvc2KL
 8xAPSOsMJkdw==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="306046990"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246]) ([10.251.7.246])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 06:32:03 -0700
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
 <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
 <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
Date:   Wed, 8 Jul 2020 08:32:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> Add support to gapless playback by implementing metadata,
>>> next_track, drain and partial drain support.
>>>
>>> Gapless on Q6ASM is implemented by opening 2 streams in a single asm 
>>> stream
>>
>> What does 'in a single asm stream' means?
> 
> 
> So in QDSP6 ASM (Audio Stream Manager) terminology we have something 
> called "asm session" for each ASoC FE DAI, Each asm session can be 
> connected with multiple streams (upto 8 I think). However there will be 
> only one active stream at anytime. Also there only single data buffer 
> associated with each asm session.
> 
> For Gapless usecase, we can keep two streams open for one asm-session, 
> allowing us to fill in data on second stream while first stream is playing.

Ah, that's interesting, thanks for the details. So you have one DMA 
transfer and the data from the previous and next track are provided in 
consecutive bytes in a ring buffer, but at the DSP level you have a 
switch that will feed data for the previous and next tracks into 
different decoders, yes?

If that is the case, indeed the extension you suggested earlier to 
change the profile is valid. You could even change the format I guess.

To avoid confusion I believe the capabilities would need to be extended 
so that applications know that gapless playback is supported across 
unrelated profiles/formats. The point is that you don't want a 
traditional implementation to use a capability that isn't supported in 
hardware or will lead to audio issues.

>>> and toggling them on next track.
>>
>> It really seems to me that you have two streams at the lowest level, 
>> along with the knowledge of how many samples to remove/insert and 
>> hence could do a much better job - including gapless support between 
>> unrelated profiles and cross-fading - without the partial drain and 
>> next_track mechanism that was defined assuming a single stream/profile.
> At the end of the day its a single session with one data buffer but with 
> multiple streams.
> 
> Achieving cross fade should be easy with this design.

looks like it indeed.

> We need those hooks for partial drain and next track to allow us to 
> switch between streams and pass silence information to respective stream 
> ids.

right, but the key point is 'switch between streams'. That means a more 
complex/capable implementation that should be advertised as such to 
applications. This is not the default behavior assumed initially: to 
allow for minimal implementations in memory-constrained devices, we 
assumed gapless was supported with a single decoder.

Maybe the right way to do this is extend the snd_compr_caps structure:

/**
  * struct snd_compr_caps - caps descriptor
  * @codecs: pointer to array of codecs
  * @direction: direction supported. Of type snd_compr_direction
  * @min_fragment_size: minimum fragment supported by DSP
  * @max_fragment_size: maximum fragment supported by DSP
  * @min_fragments: min fragments supported by DSP
  * @max_fragments: max fragments supported by DSP
  * @num_codecs: number of codecs supported
  * @reserved: reserved field
  */
struct snd_compr_caps {
	__u32 num_codecs;
	__u32 direction;
	__u32 min_fragment_size;
	__u32 max_fragment_size;
	__u32 min_fragments;
	__u32 max_fragments;
	__u32 codecs[MAX_NUM_CODECS];
	__u32 reserved[11];
} __attribute__((packed, aligned(4)));


and use a reserved field to provide info on capabilities, and filter the 
set_codec_params() addition based this capability - i.e. return -ENOTSUP 
in 'traditional' implementations based on a single 'stream'/decoder 
instance.
