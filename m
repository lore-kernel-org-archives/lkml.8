Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2485120724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCRRfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:35:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:45611 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRRfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:35:18 -0400
IronPort-SDR: zpzwjBLSBwnxruslyqDKeT3LSFxmJ1Y3xiPK0cIOwicVodvIwfg6DvAlYvmHMFT0htIFjO7H4P
 vOuV6J2+dbdg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 10:35:18 -0700
IronPort-SDR: eJivAF03MtxgvsTXnASYh8F1xz/kOR7FSU4Cp2MrlO1F/UdHlJ1Rn5TNDLMm6PfeXMMUGb+vQc
 3YtylSxZg9nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="238253292"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222]) ([10.249.155.222])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 10:35:14 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     alsa-devel@alsa-project.org, curtis@malainey.com,
        Keyon Jie <yang.jie@linux.intel.com>, tiwai@suse.com,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <d974b46b-2899-03c2-0e98-88237f23f1e2@linux.intel.com>
 <20200318171912.GA6203@light.dominikbrodowski.net>
 <ea09e20f-d7d3-fde2-2c52-07c554d78e5e@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <4cd918e3-bf1a-8345-2fd6-cdcb08fd82cc@intel.com>
Date:   Wed, 18 Mar 2020 18:35:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ea09e20f-d7d3-fde2-2c52-07c554d78e5e@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-03-18 18:29, Pierre-Louis Bossart wrote:
> 
> 
> On 3/18/20 12:19 PM, Dominik Brodowski wrote:
>> On Wed, Mar 18, 2020 at 12:08:24PM -0500, Pierre-Louis Bossart wrote:
>>> On 3/18/20 11:20 AM, Dominik Brodowski wrote:
>>>> On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
>>>>>
>>>>>
>>>>>>>> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) 
>>>>>>>> causes me
>>>>>>>> some sound-related trouble: after boot, the sound works fine -- 
>>>>>>>> but once I
>>>>>>>> suspend and resume my broadwell-based XPS13, I need to switch to 
>>>>>>>> headphone
>>>>>>>> and back to speaker to hear something. But what I hear isn't 
>>>>>>>> music but
>>>>>>>> garbled output.
>>>>>
>>>>> It's my understanding that the use of the haswell driver is opt-in 
>>>>> for Dell
>>>>> XPS13 9343. When we run the SOF driver on this device, we have to 
>>>>> explicitly
>>>>> bypass an ACPI quirk that forces HDAudio to be used:
>>>>>
>>>>> https://github.com/thesofproject/linux/commit/944b6a2d620a556424ed4195c8428485fcb6c2bd 
>>>>>
>>>>>
>>>>> Have you tried to run in plain vanilla HDAudio mode?
>>>>
>>>> I had (see 18d78b64fddc), but not any more in years (and I'd like to 
>>>> keep
>>>> using I2S, which has worked flawlessly in these years).
>>>
>>> ok. I don't think Intel folks have this device available, or it's 
>>> used for
>>> other things, but if you want to bisect on you may want to use [1] to 
>>> solve
>>> DRM issues. I used it to make Broadwell/Samus work again with SOF.
>>>
>>> [1] 
>>> https://gitlab.freedesktop.org/drm/intel/uploads/ef10c6c27fdc53d114f827bb72b078aa/0001-drm-i915-psr-Force-PSR-probe-only-after-full-initial.patch.txt 
>>>
>>>
>>> An alternate path would be to switch to SOF. It's still viewed as a
>>> developer option but Broadwell/Samus work reliably for me and we have a
>>> Broadwell-rt286 platform used for CI.
>>
>> What do you mean with SOF? And no other ideas on the root cause than a
>> tedious bisect?
> 
> Sound Open Firmware (SOF) [1]. You can build your own audio firmware for 
> Broadwell and the driver is supported in the mainline (you'd need to 
> disable the legacy driver [2]).
> 
> I can't think of any changes to that haswell/broadwell legacy driver, 
> apart from Takashi's buffer management changes 3f93b1ed4ac1e2.
> 
> But there were multiple changes to the ASoC core, so it's possible that 
> they impact suspend/resume. Just a blind guess.
> 
> [1] https://thesofproject.github.io/latest/index.html
> [2] 
> https://github.com/thesofproject/kconfig/blob/023cc25cd0b26a9757592d0bbbbe719825dd728d/sof-dev-defconfig#L20 
> 
> 

Please refrain from advertising SOF as a solution for this problem.

There were plenty changes done to dmaengine and ASoC during that time. 
Right now we are digging through the code.

While we might not have Dell XPS 13 available currently on our site, 
issue reproduces on our RVPs.

Regards,
Czarek
