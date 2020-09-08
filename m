Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F8CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F7312078E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbgIHSHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:07:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:41276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbgIHSGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:06:53 -0400
IronPort-SDR: x7RsxPmeG5o2j4oFSk9KjHIbilmK8xv0+/nFKkWxbXq7Q3YSWOlkU4fcg+GW3sSE8Oub5hGEpU
 VMe7cZRxT8zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219755489"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="219755489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 11:06:52 -0700
IronPort-SDR: D7lRjq0KnUeXpg79c/qKhFkGQnu4BR8K3/rz8BD9r9u56NUWaK9fhKhKDjKq1GB86GOcKRfwTs
 XPwilyYLhDsQ==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="328583674"
Received: from mschen-mobl2.amr.corp.intel.com (HELO [10.213.174.122]) ([10.213.174.122])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 11:06:50 -0700
Subject: Re: [PATCH V2] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To:     =?UTF-8?Q?Rados=c5=82aw_Biernacki?= <rad@semihalf.com>
Cc:     Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
        Todd Broch <tbroch@google.com>,
        Harshapriya <harshapriya.n@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        John Hsu <KCHSU0@nuvoton.com>, Takashi Iwai <tiwai@suse.com>,
        "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
        linux-kernel@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Marcin Wojtas <mw@semihalf.com>,
        Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
        Alex Levin <levinale@google.com>
References: <20200501193141.30293-1-rad@semihalf.com>
 <3ad44b75-387f-da75-d7b2-3a16ed00550c@linux.intel.com>
 <CAOs-w0LPeKgooa_98x_Jkzus-Y5Kad7pDby0CriDGb6nTp_6sA@mail.gmail.com>
 <8b97bf43-ddd8-df81-90e7-9e87c19af1ab@linux.intel.com>
 <CAOs-w0KvKcRnDkMtdAV2n_3XLfwk9KgM65QEO=6+qNshobJx3g@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <2a88f81f-c7a3-f9fc-06a3-c39496b57d0c@linux.intel.com>
Date:   Tue, 8 Sep 2020 13:06:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOs-w0KvKcRnDkMtdAV2n_3XLfwk9KgM65QEO=6+qNshobJx3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/20 12:42 PM, Radosław Biernacki wrote:
> Sorry for missing the response for so long.
> Somehow lost this thread in my mailbox.

That happens to all of us!

> śr., 6 maj 2020 o 00:04 Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> napisał(a):
>>
>>
>>>>> This single fix address two issues on machines with nau88125:
>>>>> 1) Audio distortion, due to lack of required clock rate on MCLK line
>>>>> 2) Loud audible "pops" on headphones if there is no sysclk during nau8825
>>>>>       playback power up sequence
>>>>>
>>>>> Explanation for:
>>>>> 1) Due to Skylake HW limitation, MCLK pin can only output 24MHz clk
>>>>>       rate (it can be only connected to XTAL parent clk). The BCLK pin
>>>>>       can be driven by dividers and therefore FW is able to set it to rate
>>>>>       required by chosen audio format. According to nau8825 datasheet, 256*FS
>>>>>       sysclk gives the best audio quality and the only way to achieve this
>>>>>       (taking into account the above limitations) its to regenerate the MCLK
>>>>>       from BCLK on nau8825 side by FFL. Without required clk rate, audio is
>>>>>       distorted by added harmonics.
>>>>
>>>> The BCLK is going to be a multiple of 50 * Fs due to clocking
>>>> restrictions. Can the codec regenerate a good-enough sysclk from this?
>>>
>>> According to Intel, silicon has a limitation, on SKL/KBL only clk_id =
>>> SKL_XTAL, .name = "xtal" is available for IO domain.
>>> As mentioned in the commit:
>>> MCLK is generated by using 24MHz Xtal directly or applying a divider
>>> (so no way of achieving the rate required by audio format).
>>> BCLK/FS is generated from 24MHz and uses dividers and additional
>>> padding bits are used to match the clock source.
>>> Next gen silicon has the possibility of using additional clock sources.
>>>
>>> Summing up, using MCLK from SKL to NAU88L25 is not an option.
>>> The only option we found is to use BCLK and regen the required clock
>>> rate by FLL on the NAU88l25 side.
>>
>> Right, this 24 MHz is a recurring problem.
>> But what I was asking was if the NAU8825 is fine working with e.g. a
>> 2.4MHz bit clock. i.e. with 25 bit slots or padding at the end of the frame?
> 
>  From our tests NAU8825 is working fine with these parameters.
> Also the output audio signal looks fine on the scope and FFT and there
> are no audible glitches.
> 
>>
>>>
>>>>>
>>>>> 2) Currently Skylake does not output MCLK/FS when the back-end DAI op
>>>>>       hw_param is called, so we cannot switch to MCLK/FS in hw_param.  This
>>>>>       patch reduces pop by letting nau8825 keep using its internal VCO clock
>>>>>       during widget power up sequence, until SNDRV_PCM_TRIGGER_START when
>>>>>       MCLK/FS is available. Once device resumes, the system will only enable
>>>>>       power sequence for playback without doing hardware parameter, audio
>>>>>       format, and PLL configure. In the mean time, the jack detecion sequence
>>>>>       has changed PLL parameters and switched to internal clock. Thus, the
>>>>>       playback signal distorted without correct PLL parameters.  That is why
>>>>>       we need to configure the PLL again in SNDRV_PCM_TRIGGER_RESUME case.
>>>>
>>>> IIRC the FS can be controlled with the clk_ api with the Skylake driver,
>>>> as done for some KBL platforms. Or is this not supported by the firmware
>>>> used by this machine?
>>>
>>> According to Ben, SKL had limitations in FW for managing the clk's
>>> back in the days.
>>> Can you point to the other driver you mention so we can cross check?
>>
>> There are two KBL drivers that control the SSP clocks from the machine
>> driver, but indeed I don't know if this would work on Firmware, it'd be
>> a question for Lech/Cezary.
>>
>> kbl_rt5663_max98927.c:          ret = clk_prepare_enable(priv->mclk);
>> kbl_rt5663_max98927.c:          ret = clk_prepare_enable(priv->sclk);
>> kbl_rt5663_rt5514_max98927.c:           ret =
>> clk_prepare_enable(priv->mclk);
>> kbl_rt5663_rt5514_max98927.c:           ret =
>> clk_prepare_enable(priv->sclk);
>> kbl_rt5663_rt5514_max98927.c:                   ret =
>> clk_prepare_enable(priv->mclk);
>>
> 
> Czarek answered this and we got the same response from other Intel
> devs while consulting this change:
> FW cannot request a chosen rate (48k) for MCLK pin as it does not
> "align with what's present on SKL hw".
> 
> The only way we found out for NAU8825 to cooperate at chosen rate with
> SKL HW is to regen the MCLK from BCLK by FLL as mentioned above.
> NHTL is used to set SSP0 (48k, 24/25 bit on 24MHz crystal).
> If I get all of this right, use of NHTL and HW "abilities" would
> explain why there is no call to change SSP from a machine driver.
> 
> 
> If all of this is ok I will send V3 with msleep() removed.

Sounds good.

You may want to simplify your commit message and just state what you 
described, e.g.

"Since 64xfs clocks cannot be generated, the NAU8825 is configured to 
re-generate its system clock from the BCLK using the FLL. The link is 
configured to use a 48kHz frame rate, and 24 bits in 25-bit slot. The 
SSP configuration is extracted from NHLT settings and not dynamically 
changed. Listening tests and measurements do not show any distortion or 
issues".



