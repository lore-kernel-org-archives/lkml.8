Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD7AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4113207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgG1Rap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:30:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:24865 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731988AbgG1Rap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:30:45 -0400
IronPort-SDR: RA2b/Jk8wjJJ3P243C7k7YuA6nK3cEDZ6uk3ivoNtn7upawLTc8zP54tCJSHjbcOT6a6Dfefuf
 hh768PereTdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="169388602"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="169388602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 10:30:44 -0700
IronPort-SDR: DwxaHGXDLk42xrkK1saXPf7wGs4U/NCt5iDKo6m7GLtJjdB9RNEc15K7nKAZRrVJDCxtyzYJ2s
 pqqOuNDOlNKA==
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="312709438"
Received: from bsabi-sp.amr.corp.intel.com (HELO [10.212.23.21]) ([10.212.23.21])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 10:30:43 -0700
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
 <14fde5e9-a11a-077d-b533-1e6db4b7a262@linux.intel.com>
 <DM6PR11MB3642AF0905E0CF57B094906297730@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <216b86eb-aec6-dab9-7901-9e0f2cc5af7f@linux.intel.com>
Date:   Tue, 28 Jul 2020 12:30:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3642AF0905E0CF57B094906297730@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/20 12:02 PM, Lu, Brent wrote:
>>
>> So if there are already quirks in atom machine drivers to change the period
>> size, why is this patch necessary?
>>
> 
> The story is: google implemented the constraint but doesn't know why it works
> so asked us to explain. After checking the two counters I realized the increase of
> ring buffer pointer follows the period size setting in hw_param (256) but the
> period of interrupt is always 5ms instead of 5.33 so it's running little bit too fast.
> It seems the LPE keeps tracking the difference of two counters. When the
> difference exceeds 2160 samples, the next interrupt will be canceled so the
> hardware counter could catch up a little.
> 
> [   43.208299] intel_sst_acpi 808622A8:00: mrfld ring_buffer_counter 107520 hardware_counter 98880 pcm delay 8640 (in bytes)
> [   43.208306] intel_sst_acpi 808622A8:00: buffer ptr 26880 pcm_delay rep: 2160
> [   43.208321] sound pcmC1D0p: [Q] pos 26880 hw_ptr 26880 appl_ptr 40000 avail 191680
> => one interrupt is skipped.
> [   43.218299] intel_sst_acpi 808622A8:00: mrfld ring_buffer_counter 108544 hardware_counter 100800 pcm delay 7744 (in bytes)
> [   43.218307] intel_sst_acpi 808622A8:00: buffer ptr 27136 pcm_delay rep: 1936
> [   43.218336] sound pcmC1D0p: [Q] pos 27136 hw_ptr 27136 appl_ptr 40000 avail 191936
> 
> So I think why not using the hardware counter? It increases 240 samples every 5ms
> perfectly match the 48000 sample rate. The test result is good but I know there must
> be a reason for the original designer to use ring buffer counter instead of hardware
> counter. I uploaded this patch to see if anyone still remember the reason and share
> some insight with me.
> 
> I totally agree that we shouldn't touch this part of design. Do you think it make sense
> to add a constraint to enforce the period size in machine driver? If yes then I would
> upload patches for Chrome atom machines for google.

I think it'd make sense to add this constraint, either in the machine 
driver or in the platform driver, so that we don't change the position 
updates and introduce more issues by accident by doing so. As you 
rightly said, I don't think anyone tested periods multiple of 256 
samples so it's not a regression, more aligning with the internal design.
