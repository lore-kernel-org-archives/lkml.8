Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA09C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DE020791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMM5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:57:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:30638 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMM5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:57:38 -0400
IronPort-SDR: XMbXD5wOjMy9ylOIT79c5GULY32En/0TbSGuDlH2t3NjxCfD0ZjSbEkYXIkyifrbEQuuicv/L2
 1KQmnGV6YK0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="134262895"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="134262895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 05:57:38 -0700
IronPort-SDR: 4TbxNK5/QPQDHXXHIJNqMc9bTYRc/awbplus0DHvOH1EX6V8zHMPTO2JPHWk16GPlh3qi1OJok
 zcLByXumFfhA==
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="scan'208";a="333100702"
Received: from jsdraege-mobl1.amr.corp.intel.com (HELO [10.209.128.166]) ([10.209.128.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 05:57:36 -0700
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
To:     Takashi Iwai <tiwai@suse.de>, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     "Lu, Brent" <brent.lu@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
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
        Damian van Soelen <dj.vsoelen@gmail.com>
References: <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <d78f9adc-d583-f0f2-ce38-3c9175c939b8@linux.intel.com>
 <20200811172209.GM6967@sirena.org.uk>
 <CAGvk5PqGi7cXthLHFi4NyypxFiGnoHvD9vp+5nJdH-_VkVvcKw@mail.gmail.com>
 <s5hr1scz908.wl-tiwai@suse.de>
 <CAGvk5Pp+Gk5Uk-iLdhVPWuCL0FiL9OhsaAtwkotay5JAYUNxdQ@mail.gmail.com>
 <s5hlfikz6y8.wl-tiwai@suse.de>
 <CAGvk5Pq3rEGJX=WjriPfWg_sEAVWHGZ9S=4iySNfYaHX7Xcw0g@mail.gmail.com>
 <s5h8sekz4ox.wl-tiwai@suse.de>
 <e4cc6231-8b19-c145-1b18-91d3a00131d3@linux.intel.com>
 <s5hv9hnx6am.wl-tiwai@suse.de>
 <be45d821-57c6-6ca5-0864-ac3aa521d82e@linux.intel.com>
 <DM6PR11MB364242D3652EDC2F9B8B214897420@DM6PR11MB3642.namprd11.prod.outlook.com>
 <0714b222-d3fc-5744-1147-bfac7df2651e@linux.intel.com>
 <CAGvk5Pqg000SnrRhVD+8cOtAVokomRSa6MLdaKKnY2P6R_ruGA@mail.gmail.com>
 <DM6PR11MB364285D8B21B723EB88915CB97430@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PpvhjyvETcGS0212XnLPaL71A8D2qMW55rSQZxseOffmw@mail.gmail.com>
 <s5h8sejvsrs.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e836596b-8ed8-d85f-8226-a471ab4c23d3@linux.intel.com>
Date:   Thu, 13 Aug 2020 07:57:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5h8sejvsrs.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/20 3:45 AM, Takashi Iwai wrote:
> On Thu, 13 Aug 2020 10:36:57 +0200,
> Yu-Hsuan Hsu wrote:
>>
>> Lu, Brent <brent.lu@intel.com> 於 2020年8月13日 週四 下午3:55寫道：
>>>
>>>>>>
>>>>>> CRAS calls snd_pcm_hw_params_set_buffer_size_max() to use as large
>>>>>> buffer as possible. So the period size is an arbitrary number in
>>>>>> different platforms. Atom SST platform happens to be 256, and CML
>>>>>> SOF platform is 1056 for example.
>>>>>
>>>>> ok, but earlier in this thread it was mentioned that values such as
>>>>> 432 are not suitable. the statement above seems to mean the period
>>>>> actual value is a "don't care", so I don't quite see why this specific
>>>>> patch2 restricting the value to 240 is necessary. Patch1 is needed for
>>>>> sure,
>>>>> Patch2 is where Takashi and I are not convinced.
>>>>
>>>> I have downloaded the patch1 but it does not work. After applying patch1,
>>>> the default period size changes to 320. However, it also has the same issue
>>>> with period size 320. (It can be verified by aplay.)
>>>
>>> The period_size is related to the audio latency so it's decided by application
>>> according to the use case it's running. That's why there are concerns about
>>> patch 2 and also you cannot find similar constraints in other machine driver.
>> You're right. However, the problem here is the provided period size
>> does not work. Like 256, setting the period size to 320 also makes
>> users have big latency in the DSP ring buffer.
>>
>> localhost ~ # aplay -Dhw:1,0 --period-size=320 --buffer-size=640
>> /dev/zero -d 1 -f dat --test-position
>> Playing raw data '/dev/zero' : Signed 16 bit Little Endian, Rate 48000
>> Hz, Stereo
>> Suspicious buffer position (1 total): avail = 0, delay = 2640, buffer = 640
>> Suspicious buffer position (2 total): avail = 0, delay = 2640, buffer = 640
>> Suspicious buffer position (3 total): avail = 0, delay = 2720, buffer = 640
>> ...
> 
> It means that the delay value returned from the driver is bogus.
> I suppose it comes pcm_delay value calculated in sst_calc_tstamp(),
> but haven't followed the code closely yet.  Maybe checking the debug
> outputs can help to trace what's going wrong.

the problem is really that we add a constraint that the period size be a 
multiple of 1ms, and it's not respected. 320 samples is not a valid 
choice, I don't get how it ends-up being selected? there's a glitch in 
the matrix here.


