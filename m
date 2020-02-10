Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47681C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1842082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="If5zr7ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBJP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:27:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39182 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgBJP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:27:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01AFQtd0029300;
        Mon, 10 Feb 2020 09:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581348415;
        bh=PE0/niZ0NJN+ktbHMsqTxiXJMvJZVgZpeLZrw49S0gA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=If5zr7ng27VO4qW11rsYUoXwaWY8sxlS9ywIycau1SdqM86om6cEz+EukdwsCtBEW
         JPznHvE/BwJCWjPBMPaz77OLMoPqS3cQkXS+MQAKPOsqaUEMaXEp+Fc8dScKwMcfhZ
         lU0tH87xBxL5vB1pgV7r81ul5HVOl46lTQ9c8bYE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01AFQtiG084574
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 09:26:55 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 09:26:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 09:26:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01AFQqr0041110;
        Mon, 10 Feb 2020 09:26:52 -0600
Subject: Re: [PATCH v2] ALSA: dmaengine_pcm: Consider DMA cache caused delay
 in pointer callback
To:     Takashi Iwai <tiwai@suse.de>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <lars@metafoo.de>, <alsa-devel@alsa-project.org>,
        <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200210151402.29634-1-peter.ujfalusi@ti.com>
 <s5ha75qfoum.wl-tiwai@suse.de>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7b2014d6-3c85-0f2b-c01f-3bfd8112dca1@ti.com>
Date:   Mon, 10 Feb 2020 17:26:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <s5ha75qfoum.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 17.23, Takashi Iwai wrote:
> On Mon, 10 Feb 2020 16:14:02 +0100,
> Peter Ujfalusi wrote:
>>
>> Some DMA engines can have big FIFOs which adds to the latency.
>> The DMAengine framework can report the FIFO utilization in bytes. Use this
>> information for the delay reporting.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since v1:
>> - use bytes_to_frames() for the DMA delay calculation
>> - Drop changes to soc-pcm
>>
>> 5.6-rc1 now have support for reporting the DMA cached data.
>> With this patch we can include it to the delay calculation.
>> The first DMA driver which reports this is the TI K3 UDMA driver.
>>
>> Regards,
>> Peter
>>
>>  sound/core/pcm_dmaengine.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
>> index 5749a8a49784..d8be7b488162 100644
>> --- a/sound/core/pcm_dmaengine.c
>> +++ b/sound/core/pcm_dmaengine.c
>> @@ -247,9 +247,14 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
>>  
>>  	status = dmaengine_tx_status(prtd->dma_chan, prtd->cookie, &state);
>>  	if (status == DMA_IN_PROGRESS || status == DMA_PAUSED) {
>> +		struct snd_pcm_runtime *runtime = substream->runtime;
>> +
>>  		buf_size = snd_pcm_lib_buffer_bytes(substream);
>>  		if (state.residue > 0 && state.residue <= buf_size)
>>  			pos = buf_size - state.residue;
>> +
>> +		runtime->delay = bytes_to_frames(runtime,
>> +						 state.in_flight_bytes);
> 
> Another call of bytes_to_frames() below...
> 
>>  	}
>>  
>>  	return bytes_to_frames(substream->runtime, pos);
> 
> ... refers to substream->runtime.
> Better to align both places, either runtime or substream->runtime.

Sure, I'll use the runtime as with substream->runtime the delay part is
not nicely wrapping.

> With that minor nitpick, the change looks good:
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> thanks,
> 
> Takashi
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
