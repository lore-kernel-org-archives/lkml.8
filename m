Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88BC320838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHLOqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:46:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:44428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgHLOqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:46:45 -0400
IronPort-SDR: TgRbw0C1BDKKoNjdba/I/l3aCUTBPALjXiVRUtaBZJwFIS19pbPznkQp7p0E1IODrDBlilwwD/
 U+4V2jOZ7X+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="141808420"
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="141808420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 07:46:43 -0700
IronPort-SDR: o8Cq+YOgWp9qmw+FblQ9WE1g+XI0I+lCaQ85lcRakeBxWtHTZVHrRkPiUyBFVnvecIHwHDQV7P
 KVCXC9lOfGfw==
X-IronPort-AV: E=Sophos;i="5.76,304,1592895600"; 
   d="scan'208";a="469844036"
Received: from rkiran1x-mobl1.amr.corp.intel.com (HELO [10.212.203.28]) ([10.212.203.28])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 07:46:42 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     Takashi Iwai <tiwai@suse.de>, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de>
 <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de>
 <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
 <20200811145353.GG6967@sirena.org.uk>
 <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
 <20200811172209.GM6967@sirena.org.uk>
 <CAGvk5PqGi7cXthLHFi4NyypxFiGnoHvD9vp+5nJdH-_VkVvcKw@mail.gmail.com>
 <s5hr1scz908.wl-tiwai@suse.de>
 <CAGvk5Pp+Gk5Uk-iLdhVPWuCL0FiL9OhsaAtwkotay5JAYUNxdQ@mail.gmail.com>
 <s5hlfikz6y8.wl-tiwai@suse.de>
 <CAGvk5Pq3rEGJX=WjriPfWg_sEAVWHGZ9S=4iySNfYaHX7Xcw0g@mail.gmail.com>
 <s5h8sekz4ox.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e4cc6231-8b19-c145-1b18-91d3a00131d3@linux.intel.com>
Date:   Wed, 12 Aug 2020 09:46:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5h8sekz4ox.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>>> After doing some experiments, I think I can identify the problem more precisely.
>>>>>> 1. aplay can not reproduce this issue because it writes samples
>>>>>> immediately when there are some space in the buffer. However, you can
>>>>>> add --test-position to see how the delay grows with period size 256.
>>>>>>> aplay -Dhw:1,0 --period-size=256 --buffer-size=480 /dev/zero -d 1 -f dat --test-position
>>>>>> Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
>>>>>> Hz, Stereo
>>>>>> Suspicious buffer position (1 total): avail = 0, delay = 2064, buffer = 512
>>>>>> Suspicious buffer position (2 total): avail = 0, delay = 2064, buffer = 512
>>>>>> Suspicious buffer position (3 total): avail = 0, delay = 2096, buffer = 512
>>>>>> ...
>>>>>
>>>>> Isn't this about the alignment of the buffer size against the period
>>>>> size, not the period size itself?  i.e. in the example above, the
>>>>> buffer size isn't a multiple of period size, and DSP can't handle if
>>>>> the position overlaps the buffer size in a half way.
>>>>>
>>>>> If that's the problem (and it's an oft-seen restriction), the right
>>>>> constraint is
>>>>>    snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
>>>>>
>>>>>
>>>>> Takashi
>>>> Oh sorry for my typo. The issue happens no matter what buffer size is
>>>> set. Actually, even if I want to set 480, it will change to 512
>>>> automatically.
>>>> Suspicious buffer position (1 total): avail = 0, delay = 2064, buffer
>>>> = 512 <-this one is the buffer size
>>>
>>> OK, then it means that the buffer size alignment is already in place.
>>>
>>> And this large delay won't happen if you use period size 240?
>>>
>>>
>>> Takashi
>> Yes! If I set the period size to 240, it will not print "Suspicious
>> buffer position ..."
> 
> So it sounds like DSP handles the delay report incorrectly.
> Then it comes to another question: the driver supports both SOF and
> SST.  Is there the behavior difference between both DSPs wrt this
> delay issue?

I still don't get what the issue is. The two following cases work fine 
with the SST/Atom driver:

root@chrx:~# aplay -Dhw:0,0 --period-size=240 --buffer-size=480 
/dev/zero -d 2 -f dat --test-position
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000 
Hz, Stereo
root@chrx:~# aplay -Dhw:0,0 --period-size=960 --buffer-size=4800 
/dev/zero -d 2 -f dat --test-position
Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000 
Hz, Stereo

The existing code has this:

	/* Make sure, that the period size is always even */
	snd_pcm_hw_constraint_step(substream->runtime, 0,
			   SNDRV_PCM_HW_PARAM_PERIODS, 2);

	return snd_pcm_hw_constraint_integer(runtime,
			 SNDRV_PCM_HW_PARAM_PERIODS);

and with the addition of period size being a multiple of 1ms all 
requirements should be met?
