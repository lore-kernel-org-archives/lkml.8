Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC6CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA792076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgHKQym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:54:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:26275 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgHKQym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:54:42 -0400
IronPort-SDR: SXyN+1518Zs/4UK2pM6sjLiVJ879785iGvkq2hcphgBq3kkefsqs8Ur8MW0VIiCD1nOLFSpphO
 Os6sa+eupjmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133307073"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133307073"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:54:41 -0700
IronPort-SDR: R+rgW4VXEi6GPdVsNSPPelRJdde1YATjsp7hTZyCXnQW5hDkJKLhGtxzcFZx76HOtN6UvBV43J
 NaFi2AsXBeTA==
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="495211140"
Received: from lwhitehe-mobl.amr.corp.intel.com (HELO [10.212.97.49]) ([10.212.97.49])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:54:39 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     Mark Brown <broonie@kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.de>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com>
 <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
 <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de>
 <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de>
 <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
 <20200811145353.GG6967@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
Date:   Tue, 11 Aug 2020 11:54:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811145353.GG6967@sirena.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> ... Why only 240?  That's the next logical question.
>>> If you have a clarification for it, it may be the rigid reason to
>>> introduce such a hw constraint.
> 
>> According to Brent, the DSP is using 240 period regardless the
>> hw_param. If the period size is 256, DSP will read 256 samples each
>> time but only consume 240 samples until the ring buffer of DSP is
>> full. This behavior makes the samples in the ring buffer of kernel
>> consumed quickly.
> 
>> Not sure whether the explanation is correct. Hi Brent, can you confirm it?
> 
> This seems to be going round and round in circles.  Userspace lets the
> kernel pick the period size, if the period size isn't 240 (or a multiple
> of it?) the DSP doesn't properly pay attention to that apparently due to
> internal hard coding in the DSP firmware which we can't change so the
> constraint logic needs to know about this DSP limitation - it seems like
> none of this is going to change without something new going into the
> mix?  We at least need a new question to ask about the DSP firmware I
> think.

I just tested aplay -Dhw: on a Cyan Chromebook with the Ubuntu kernel 
5.4, and I see no issues with the 240 sample period. Same with 432, 960, 
9600, etc.

I also tried just for fun what happens with 256 samples, and I don't see 
any underflows thrown either, so I am wondering what exactly the problem 
is? Something's not adding up. I would definitively favor multiple of 
1ms periods, since it's the only case that was productized, but there's 
got to me something a side effect of how CRAS programs the hw_params.

root@chrx:~# aplay -Dhw:0,0 --period-size=240 --buffer-size=480 -v 1.wav
Playing WAVE '1.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Hardware PCM card 0 'chtmax98090' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 480
   period_size  : 240
   period_time  : 5000
   tstamp_mode  : NONE
   tstamp_type  : MONOTONIC
   period_step  : 1
   avail_min    : 240
   period_event : 0
   start_threshold  : 480
   stop_threshold   : 480
   silence_threshold: 0
   silence_size : 0
   boundary     : 8646911284551352320
   appl_ptr     : 0
   hw_ptr       : 0

root@chrx:~# aplay -Dhw:0,0 --period-size=256 --buffer-size=512 -v 1.wav
Playing WAVE '1.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Hardware PCM card 0 'chtmax98090' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 512
   period_size  : 256
   period_time  : 5333
   tstamp_mode  : NONE
   tstamp_type  : MONOTONIC
   period_step  : 1
   avail_min    : 256
   period_event : 0
   start_threshold  : 512
   stop_threshold   : 512
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 0
   hw_ptr       : 0


