Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8867206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgGGT0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:26:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:56354 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGT0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:26:45 -0400
IronPort-SDR: vCyU8vc5+RJv7pIQdiH9GpymvcyKudBGKgJWwM17YGTl579gXCpdDQnx+5EtdDP3cAVUr6sAWn
 ojFkM0KssXZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135925956"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135925956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:45 -0700
IronPort-SDR: PJ2Pr9HKoJiDzpm/sNxhX0XcUkS+HhvcTX+0P0ERPRiYihnaaibWyQwnIrx3s0BYd+UwH1DFjt
 row3O05nQZsA==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="297493428"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62]) ([10.254.77.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:44 -0700
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
Date:   Tue, 7 Jul 2020 11:52:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> @@ -184,8 +186,8 @@ static void event_handler(uint32_t opcode, uint32_t token,
>   	switch (opcode) {
>   	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>   		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> -			q6asm_write_async(prtd->audio_client,
> -				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +				   prtd->pcm_count, 0, 0, 0);

sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00

is the change on the previous line intentional?

>   		break;
>   	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>   		prtd->state = Q6ASM_STREAM_STOPPED;
> @@ -194,8 +196,8 @@ static void event_handler(uint32_t opcode, uint32_t token,
>   		prtd->pcm_irq_pos += prtd->pcm_count;
>   		snd_pcm_period_elapsed(substream);
>   		if (prtd->state == Q6ASM_STREAM_RUNNING)
> -			q6asm_write_async(prtd->audio_client,
> -					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					   prtd->pcm_count, 0, 0, 0);

ditto for the timestamp change?


> @@ -501,8 +514,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
>   	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>   		spin_lock_irqsave(&prtd->lock, flags);
>   		if (!prtd->bytes_sent) {
> -			q6asm_write_async(prtd->audio_client, prtd->pcm_count,
> -					  0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					  prtd->pcm_count, 0, 0, 0);

and here as well.

>   			prtd->bytes_sent += prtd->pcm_count;
>   		}
>   
> @@ -527,8 +540,8 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
>   		avail = prtd->bytes_received - prtd->bytes_sent;
>   
>   		if (avail >= prtd->pcm_count) {
> -			q6asm_write_async(prtd->audio_client,
> -					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			q6asm_write_async(prtd->audio_client, prtd->stream_id,
> +					   prtd->pcm_count, 0, 0, 0);

and here.

