Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C25EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7897920656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGHMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:55:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:34172 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgGHMzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:55:31 -0400
IronPort-SDR: 54/6mK/DpLbtsCLzL6CQYF3HcMoVBy5NTWdeOxVCaaRFMg8kZ9DKOpFL86hEEFr6EhJUjVFdpY
 c/vBBoTJs5Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="212726291"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="212726291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 05:55:30 -0700
IronPort-SDR: Suofd+7AXM9bgYprsc3aXwnwRy34R3yv6fE2zBFww32epVdK9ww47VGE/BD3lLFPYFZ/t9GI1I
 5VBOwLBt5z7A==
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="323870355"
Received: from sare-mobl.amr.corp.intel.com (HELO [10.251.7.246]) ([10.251.7.246])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 05:55:30 -0700
Subject: Re: [PATCH v3 06/10] ASoC: sti: uniperif: fix 'defined by not used'
 warning
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "tiwai@suse.de" <tiwai@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
 <20200707191615.98296-7-pierre-louis.bossart@linux.intel.com>
 <a376393a-6a17-2836-204b-0d4ff60729c0@st.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31969204-1ada-3775-64da-092ded0bff8f@linux.intel.com>
Date:   Wed, 8 Jul 2020 07:55:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a376393a-6a17-2836-204b-0d4ff60729c0@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/20 4:11 AM, Arnaud POULIQUEN wrote:
> Hi Pierre-Louis,
> 
> On 7/7/20 9:16 PM, Pierre-Louis Bossart wrote:
>> Fix W=1 warning. The table uni_tdm_hw is declared in a header included
>> by multiple C file. This isn't really a good practice but for now
>> using __maybe_unused makes the following warning go away.
>>
>> sound/soc/sti/sti_uniperif.c:12:
>> sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but
>> not used [-Wunused-const-variable=]
>>   1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
>>        |                                      ^~~~~~~~~~
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Thanks for the patch,
> Seems that the same patch has already been proposed by Lee:
> https://www.spinics.net/lists/arm-kernel/msg820327.html

that's right, we both fixed the same things, and this is the merged series.
Do you mind providing a tag if you're ok with the change?

> Regards,
> Arnaud
> 
>> ---
>>   sound/soc/sti/uniperif.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
>> index 2dc2da5d458b..a16adeb7c1e9 100644
>> --- a/sound/soc/sti/uniperif.h
>> +++ b/sound/soc/sti/uniperif.h
>> @@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
>>   	struct sti_uniperiph_dai dai_data;
>>   };
>>   
>> -static const struct snd_pcm_hardware uni_tdm_hw = {
>> +static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
>>   	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>   		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
>>   		SNDRV_PCM_INFO_MMAP_VALID,
>>
