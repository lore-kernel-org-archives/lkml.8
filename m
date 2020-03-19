Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA23C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD872071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCSRll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:41:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:50883 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727034AbgCSRll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:41:41 -0400
IronPort-SDR: d0Uyhel5dPjZk+EZ7aC8u1OlEcMiqdyS9Mwr9FZNlv6fE+Fw+cEAAkqJhgUjE4vBc5g+p5/QKe
 aB8XxHZ4GalA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 10:41:40 -0700
IronPort-SDR: M+4pdbi+zVZ2HdNL26EbrDS7Nh29gZE9Qh/vZepeJyokUYRJ09ibtOf5M5lQA8VK42SY5c5EAR
 0dDvtY7TShhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="245232025"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.128.140]) ([10.249.128.140])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 10:41:37 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <45108a58-da11-3b6a-9e3b-072ac0c63ea1@intel.com>
Date:   Thu, 19 Mar 2020 18:41:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 18:21, Pierre-Louis Bossart wrote:
> On 3/19/20 11:51 AM, Dominik Brodowski wrote:
>> On Thu, Mar 19, 2020 at 04:48:03PM +0100, Cezary Rojewski wrote:

>>>
>>> Requested for tests with following diff applied:
>>>
>>> diff --git a/sound/soc/intel/boards/broadwell.c
>>> b/sound/soc/intel/boards/broadwell.c
>>> index db7e1e87156d..6ed4c1b0a515 100644
>>> --- a/sound/soc/intel/boards/broadwell.c
>>> +++ b/sound/soc/intel/boards/broadwell.c
>>> @@ -212,7 +212,6 @@ static struct snd_soc_dai_link 
>>> broadwell_rt286_dais[] =
>>> {
>>>                  .init = broadwell_rt286_codec_init,
>>>                  .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>>>                          SND_SOC_DAIFMT_CBS_CFS,
>>> -               .ignore_suspend = 1,
>>>                  .ignore_pmdown_time = 1,
>>>                  .be_hw_params_fixup = broadwell_ssp0_fixup,
>>>                  .ops = &broadwell_rt286_ops,
>>
>> That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
>> ("ASoC: Intel: broadwell: change cpu_dai and platform components for 
>> SOF")
>> on top of that. But you can assess better whether that patch needs 
>> care for
>> other reasons; for me, this one-liner you have suggested is perfect.
> 
> .ignore_suspend is set for bdw-rt5677.c and bdw-rt5650.c as well. I 
> don't know if that was intentional.

haswell has it too.

My guess is that it's supposed to mimic offload behaviour on Windows: 
offload pin playback allows for non-interrupted playback during sleep 
while system pin follows standard path: breaks on sleep and resumes once 
sleep concludes. This of course also involves cooperation from 
application side.

However, one pin cannot serve two masters. Either it's offload or it's not.

This is just a guess of course, and my vision might be clouded becuase 
of Windows background.
Other SSP0 examples: rt286 (SKL/ KBL) rt298 (APL) and rt274 (CNL) do not 
have .ignore_suspend enabled for their links, except when DMIC is 
involved. So it might be just a bug that has been covered by another bug 
present in ASoC core, which Morimoto' San fixed during his cleanup series.

Czarek
