Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48272C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6DB2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgGAQsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:48:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:6577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732161AbgGAQsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:48:21 -0400
IronPort-SDR: bsxF/NLPFlMDrn5eMNYaXqtWeQD/O7E9ann8WKBYCEf49bYl50D9+aN0Sy/cW+zmE4NhoCIZFn
 MryJDES3pWbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="134929227"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="134929227"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:48:20 -0700
IronPort-SDR: ywwjct/MbgHFM/ViP9O9jEEhk1M7aKesW/NJjeFQnWmYsFWc6cSzOYE9BcpU3t2rIRRgEn4U84
 lRc91hDufqxg==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="455167707"
Received: from dsapozni-mobl1.amr.corp.intel.com (HELO [10.251.16.243]) ([10.251.16.243])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:48:18 -0700
Subject: Re: [PATCH v3] ASoC: Intel: kbl_rt5663_rt5514_max98927: Split
 be_hw_params_fixup function
To:     "N, Harshapriya" <harshapriya.n@intel.com>,
        =?UTF-8?Q?=c5=81ukasz_Majczak?= <lma@semihalf.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Ross Zwisler <zwisler@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Bob Brandt <brndt@google.com>, Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@chromium.org>
References: <20200521162518.1809995-1-lma@semihalf.com>
 <3c89e614-81f5-ba87-19a9-fbe9f5c73925@linux.intel.com>
 <CAFJ_xbr8TN3ynfELJ3NQnkuRg0VRbkjB7=Cyb8yu2L==JGXJiw@mail.gmail.com>
 <475fb5c0-9b26-a8f6-c102-25c7775bc2ca@linux.intel.com>
 <CAFJ_xbq-QotvPG=AxSp7=Etc5P5f4ePRWLCvSNnTkzUO9o_qjQ@mail.gmail.com>
 <268b11b6-9f4c-d769-a7f9-536d77198705@linux.intel.com>
 <CAFJ_xboUTDtnpvskb2dY4fGhGLNkEgT0sH3dU0NYJV_Cb_gqPw@mail.gmail.com>
 <BY5PR11MB4307284BAE6DA415CFC0865CFD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <CAFJ_xbq3DU8NMmymYHLjy0z+QbGRAOmB4NaiXPphAr2Zu0MPAg@mail.gmail.com>
 <BY5PR11MB4307CBA736456853777A9FD9FD6E0@BY5PR11MB4307.namprd11.prod.outlook.com>
 <BY5PR11MB4307C20278F32D17551112FAFD6C0@BY5PR11MB4307.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7e38bb2e-2132-d305-e94d-043fa53bd836@linux.intel.com>
Date:   Wed, 1 Jul 2020 11:48:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR11MB4307C20278F32D17551112FAFD6C0@BY5PR11MB4307.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/20 11:37 AM, N, Harshapriya wrote:
>>
>>>> For speakers and headsets its 48Khz, 2 ch and 24 bit and this
>>>> setting is done based on the front-end dai For speakers, however
>>>> support only
>>>> 16 bit, so we set it back to 16 bit If the front end dai is dmic,
>>>> then the channel
>>> is set to either 2 or 4 dmic_constraints. No other formats need to be set.
>>>>
>>>> All the SSP1 usages do not have the same parameters (as dmic is on
>>>> SSP1 and its different as given above) Most parameters are same for
>>> speakers and headset which are on different SSP. This is the reason we
>>> had a single fixup function.
>> On SSP1, for dmic we need to fix the channels which is derived from dmic_num
>> of the snd_soc_acpi_mach structure based on the number of dmic on the
>> board.
>> The channel is something that might be different from speakers.
>> We might not want to constraint the dmic capture to always be 48Khz as well.
>> Given this, there seems to me, 2 ways to set it:
>> 1. Derive if the fixup is being called for dmic or speaker 2. Having a new dailink
>>
>> If #2 is not preferred (going by Pierre's comments), can we use rtd-
>>> cpu_dai/codec_dai->name to figure out if its for dmic or speaker?
>> I can test this and get back to you.
> Tested and the following is something we can use without creating a new dailink.
>         	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
> 	if (!strcmp(codec_dai->name, KBL_REALTEK_DMIC_CODEC_DAI)) {
> 		if (params_channels(params) == 2 ||  DMIC_CH(dmic_constraints) == 2)
> 			channels->min = channels->max = 2;
> 		else
> 			channels->min = channels->max = 4;
> 	} else {
> 		rate->min = rate->max = 48000;
> 		channels->min = channels->max = 2;
> 		snd_mask_none(fmt);
> 		snd_mask_set_format(fmt, pcm_fmt);
> 	}
> 
> Pierre, thoughts?

thanks Harsha, that looks like what I had in mind, but my earlier 
question was why we deal with the rates and formats only in the last case?

