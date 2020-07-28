Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6A5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29A02075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgG1MGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:06:08 -0400
Received: from mga17.intel.com ([192.55.52.151]:24733 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:06:07 -0400
IronPort-SDR: X9g2b5GFZoRBVT2lM6KaJlNCsrdP/DyVH89YxkkAzKgtX0HAJhJ6VngovrcJhBiDIKUmRbBg59
 TFcispr6f+xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="131259413"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="131259413"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:06:07 -0700
IronPort-SDR: eU0e3fnVpj0fmZD1AeZgpCuDK9ik87Y8q3k/d+ZfxYrbUZKdLn3JmnIBl9saLPu/FCNALdACcg
 UHgOK2zhCVgw==
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="312592771"
Received: from caradool-mobl.amr.corp.intel.com (HELO [10.251.24.77]) ([10.251.24.77])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 05:06:06 -0700
Subject: Re: [PATCH] ASoC: Intel: Atom: use hardware counter to update hw_ptr
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
References: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
 <7dec7fcd-0381-d279-4dac-77c27ea5f6fe@linux.intel.com>
 <DM6PR11MB3642BE84A5C91504D6AF4ECB97730@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <14fde5e9-a11a-077d-b533-1e6db4b7a262@linux.intel.com>
Date:   Tue, 28 Jul 2020 07:06:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3642BE84A5C91504D6AF4ECB97730@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/20 9:28 PM, Lu, Brent wrote:
>>
>> All the Atom firmware assumes data chunks in multiples of 1ms (typically 5,
>> 10 or 20ms). I have never seen anyone use 256 frames, that's asking for
>> trouble really.
>>
>> it's actually the same with Skylake and SOF in most cases.
>>
>> Is this a 'real' problem or a problem detected by the Chrome ALSA
>> compliance tests, in the latter case that would hint at a too generic value of
>> min_period.
>>
> 
> I've told them 240 is more reasonable since the sample rate is 48000 and our
> android bsp also uses 240 for multimedia use case for many years but they don't
> want to change the CRAS setting for some reason.
> 
> Google says it's a real issue for them: "The driver consumes frames quickly at the
> beginning will make CRAS underrun because CRAS fills samples in the fixed rate."
> 
> Currently they implement constraint in machine driver of atom machines to force
> 240 period size so CRAS is using 240 for atom platforms and 256 for other big cores.

So if there are already quirks in atom machine drivers to change the 
period size, why is this patch necessary?

> I'm curious why not just using hardware counter to update hw_ptr and get rid of
> the period setting in hw_param? It seems to me the ring buffer counter does not
> reflect the real status.

I don't recall precisely what this hardware counter does. I vaguely 
recall it's tied to the 19.2MHz external timer which is also used to 
schedule the 1ms SBA mixer and the SSP IOs. And by comparing with the 
ring buffer pointer you can infer the delay inside the DSP. I think you 
are also making an assumption that all streams are tied to the output 
rate, but that's most likely a bad assumption. The hard-coded topology 
supported media, speech and compressed data and the consumption rate on 
the DMA side could be faster with some buffering happening in the DSP. 
It's not a passthrough DMA in all cases.

This is really legacy code that no one really fully understands nor 
plans on improving, it'd be a bad idea to change the pcm pointer reports 
now, 6 years after the initial code release and after all initial 
contributors moved on. It's what it is.

>> and that seems also wrong? Why would the delay be zero?
>>
> 
> info->pcm_delay is the difference between ring buffer counter and hardware
> counter. Because the ring buffer counter (hw_ptr) is running faster then it should,
> so we add the info->pcm_delay to substream->runtime->delay as compensation.
> 
> Therefore, application could use snd_pcm_delay() to get the actual frame number
> which are still in buffer.
> 
> snd_pcm_delay() = buffer_size - snd_pcm_avail() + runtime->delay
> 
> We don't need pcm_delay to compensate anything if using hardware counter.

If you force info->pcm_delay to be zero, then runtime->delay is also zero:

see sst_soc_pointer():
	substream->runtime->delay = str_info->pcm_delay;

>>> -	info->pcm_delay = delay_frames;

