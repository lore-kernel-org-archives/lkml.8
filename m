Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DD820720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wvQm3G58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgGHNfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:35:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1473 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729436AbgGHNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:35:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068DRj2o011050;
        Wed, 8 Jul 2020 15:33:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pjxuwpy57URCV3RNfmG0k+yUDPUR1i8G9e47WhJiwJM=;
 b=wvQm3G58IY1mGmGiLJFy9yVUMPPMmCcq5JlYvSnKh6rxJ1qnC5sjmJOWt0MLlB8LwgB9
 vIDMnP1xQ8yOULajq4rQthmSIMpSU4/4lW3nAyQkk3Zs3qUsksmLwLG6/4AgugCP0i2Q
 c0KK1CZuQ5yiQA7pLsW4uEIfbLoj/wRgPwaErO81wDqg6+ue3xnrZQLwYycdsIyXN6kn
 al9Lvwija1ialoQc7+C1CQJ0IBHuk6DtwBK6xO0NtGbDohDToQmAWIMlQdV+5CLQbScj
 Koh/NMNjwoK1X3TI4KBiuAJlB2kWzHOXvzc2QBK525oOrsiO2aGWIj9hgAjaUrTeWNRB hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 322fhv7tkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 15:33:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7370A10002A;
        Wed,  8 Jul 2020 15:33:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 51CFF2BF9B2;
        Wed,  8 Jul 2020 15:33:47 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.46) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 15:33:46 +0200
Subject: Re: [PATCH v3 06/10] ASoC: sti: uniperif: fix 'defined by not used'
 warning
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "tiwai@suse.de" <tiwai@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
 <20200707191615.98296-7-pierre-louis.bossart@linux.intel.com>
 <a376393a-6a17-2836-204b-0d4ff60729c0@st.com>
 <31969204-1ada-3775-64da-092ded0bff8f@linux.intel.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <b3cebdba-18fc-8df5-0463-a9620ab0224e@st.com>
Date:   Wed, 8 Jul 2020 15:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <31969204-1ada-3775-64da-092ded0bff8f@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi

On 7/8/20 2:55 PM, Pierre-Louis Bossart wrote:
> 
> 
> On 7/8/20 4:11 AM, Arnaud POULIQUEN wrote:
>> Hi Pierre-Louis,
>>
>> On 7/7/20 9:16 PM, Pierre-Louis Bossart wrote:
>>> Fix W=1 warning. The table uni_tdm_hw is declared in a header included
>>> by multiple C file. This isn't really a good practice but for now
>>> using __maybe_unused makes the following warning go away.
>>>
>>> sound/soc/sti/sti_uniperif.c:12:
>>> sound/soc/sti/uniperif.h:1351:38: warning: ‘uni_tdm_hw’ defined but
>>> not used [-Wunused-const-variable=]
>>>   1351 | static const struct snd_pcm_hardware uni_tdm_hw = {
>>>        |                                      ^~~~~~~~~~
>>>
>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Thanks for the patch,
>> Seems that the same patch has already been proposed by Lee:
>> https://www.spinics.net/lists/arm-kernel/msg820327.html
> 
> that's right, we both fixed the same things, and this is the merged series.
> Do you mind providing a tag if you're ok with the change?

Sure, just need to known which one i should tag... I saw that you are discussing with Lee 
by default i ack both, i let you decide which one will be merged :)

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

> 
>> Regards,
>> Arnaud
>>
>>> ---
>>>   sound/soc/sti/uniperif.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
>>> index 2dc2da5d458b..a16adeb7c1e9 100644
>>> --- a/sound/soc/sti/uniperif.h
>>> +++ b/sound/soc/sti/uniperif.h
>>> @@ -1348,7 +1348,7 @@ struct sti_uniperiph_data {
>>>   	struct sti_uniperiph_dai dai_data;
>>>   };
>>>   
>>> -static const struct snd_pcm_hardware uni_tdm_hw = {
>>> +static __maybe_unused const struct snd_pcm_hardware uni_tdm_hw = {
>>>   	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>>>   		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
>>>   		SNDRV_PCM_INFO_MMAP_VALID,
>>>
