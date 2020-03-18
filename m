Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF81C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C968E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgCRWU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:20:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:19068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCRWU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:20:59 -0400
IronPort-SDR: uKxUIrPef57yofenjjnSiHD9vwRiai7S9VytKX/fkip/u8mcs+yvKr2XwEzOS4UfBL6vS7Dw4r
 zqg/GH+iXS5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 15:20:58 -0700
IronPort-SDR: 2SCiifmS6rxHGZhXP96YyEjN50BdilZG47iR22cF96i4uSIa1+rhuIUG/g2+WuJCq1uvtQ1Hmz
 Spj2sdjFoA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,569,1574150400"; 
   d="scan'208";a="238315637"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222]) ([10.249.155.222])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 15:20:56 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
Date:   Wed, 18 Mar 2020 23:20:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318215218.GA2439@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 22:52, Dominik Brodowski wrote:
> On Wed, Mar 18, 2020 at 09:43:54PM +0100, Cezary Rojewski wrote:
>> On 2020-03-18 20:22, Dominik Brodowski wrote:
>>> On Wed, Mar 18, 2020 at 07:27:58PM +0100, Cezary Rojewski wrote:
>>
>>>>
>>>> Due to pandemic I'm working remotely and right now won't be able to test
>>>> audio quality so focusing on the stream==NULL issue. And thus we got to help
>>>> each other out : )
>>>
>>> Sure, and thanks for taking a look at this!
>>>
>>>> Could you verify issue reproduces on 5.6.0-rc1 on your machine?
>>>
>>> It reproduces on 5.6.0-rc1 + i915-bugfix. I'm trying to bisect it further in
>>> the background, but that may take quite some time.
>>>
>>
>> Could you checkout v5.6-rc1 with following commit reverted:
>> 	ASoC: Intel: broadwell: change cpu_dai and platform components for SOF
>>
>> For my working v5.6-rc1 commit id is:
>> 64df6afa0dab5eda95cc4cc2269e3d4e83b6b6ce.
> 
> Hm, no joy -- after suspend/resume, no sound at first, and if I twiggle some
> options with pulseaudio, I get garbled output (even when using
> 
> 	aplay -f S16_LE -r 44100 -c 2 --device="sysdefault:CARD=broadwellrt286"
> 
> ). Will try to bisect further the next days.
> 

Thanks for quick reply. Revert of said commit fixes stream==NULL issue 
for me. See if there were any changes in dmesg.
Will ask technicians to assist me on site tomorrow.

Regards,
Czarek
