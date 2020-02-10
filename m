Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28FFC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ED620658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nnYvyvNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgBJPC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:02:26 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60672 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:02:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AF1JlZ009377;
        Mon, 10 Feb 2020 09:01:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581346879;
        bh=B/nOBT8Nq5yZ+RzogfXRvk5kf/L+erqu046VxjWWtjE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nnYvyvNudOMx7abul3CF1ecAWg13wKMSvZna3blAdDgGRYcgXYaFd/cQBMkkN7RBT
         ewfZjHv4+pP0P6CurzatKtza+2oFLxNVkK1gCJN+X2HqnLDEKdYCF4+IDgU1tyPJVF
         C31O1HpGm8HX2yXsmO2fYvaGEb+0RHvtxDrlRujA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AF1JBU048306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 09:01:19 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 09:01:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 09:01:19 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AF1G2T128816;
        Mon, 10 Feb 2020 09:01:17 -0600
Subject: Re: [PATCH] ASoC: dmaengine_pcm: Consider DMA cache caused delay in
 pointer callback
To:     Takashi Iwai <tiwai@suse.de>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <lars@metafoo.de>, <alsa-devel@alsa-project.org>,
        <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200210140423.10232-1-peter.ujfalusi@ti.com>
 <s5hmu9qfrq7.wl-tiwai@suse.de> <15c7df10-cf9f-109c-3cbf-e73af7f4f66a@ti.com>
 <s5hk14ufqx9.wl-tiwai@suse.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <084c2d48-96dd-4d57-84f9-f02204cfbece@ti.com>
Date:   Mon, 10 Feb 2020 17:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <s5hk14ufqx9.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 16.38, Takashi Iwai wrote:
> On Mon, 10 Feb 2020 15:28:44 +0100,
> Peter Ujfalusi wrote:
>>
>> Hi Takashi,
>>
>>>> --- a/sound/soc/soc-pcm.c
>>>> +++ b/sound/soc/soc-pcm.c
>>>> @@ -1151,7 +1151,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>>>>  	}
>>>>  	delay += codec_delay;
>>>>  
>>>> -	runtime->delay = delay;
>>>> +	runtime->delay += delay;
>>>
>>> Is it correct?
>>> delay already takes runtime->delay as its basis, so it'll result in a
>>> double.
>>
>> The delay here is coming from the DAI and the codec.
>> The runtime->delay hold the PCM (DMA) caused delay.
> 
> Well, let's take a look at soc_pcm_pointer():
> 
> 	/* clearing the previous total delay */
> 	runtime->delay = 0;
> 
> 	offset = snd_soc_pcm_component_pointer(substream);
> 
> 	/* base delay if assigned in pointer callback */
> 	delay = runtime->delay;
> 
> 	delay += snd_soc_dai_delay(cpu_dai, substream);
> 
> 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
> 		codec_delay = max(codec_delay,
> 				  snd_soc_dai_delay(codec_dai, substream));
> 	}
> 	delay += codec_delay;
> 
> 	runtime->delay = delay;
> 
> So, the code reads the current runtime->delay and saves it as delay
> variable.  Then it adds the max delay from codec DAIs, and stores back
> to runtime->delay.
> 
> If we change the last line to
> 	runtime->delay += delay;
> it'll add to the already existing value again, so it'll be doubly if
> runtime->delay was non-zero beforehand.

Yes, you are right.
The change is added by
9fb4c2bf130b ASoC: soc-pcm: Use delay set in component pointer function

which I have missed, apparently.

> That said, judging from the code, I believe the current soc-pcm.c code
> needs no change.

Yes, there is no need to change soc-pcm.

> 
> 
> thanks,
> 
> Takashi
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
