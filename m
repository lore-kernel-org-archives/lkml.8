Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E5C20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGGT0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:26:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:56354 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGT0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:26:50 -0400
IronPort-SDR: KOhf59dy+0yv/Hzj4LMKVYPPl6j6lGtWLIaSoc7kBdTYHZmp2EfCSZJMSJFgemqIftEm0bFVGn
 EeAnVt4fbaZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135925962"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135925962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:49 -0700
IronPort-SDR: w9lL4KLb6oitgxodPkM7v7cQh/LYMpU/kacWdpwAN5ZOZTn3GFeUT44qcp6dwirJ3UmRaQC9IG
 zi47uV7izF/w==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="297493442"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62]) ([10.254.77.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:48 -0700
Subject: Re: [PATCH 07/11] ASoC: q6asm: add support to gapless flag in asm
 open
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-8-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b05e5503-6a47-5b52-1339-f1243d952cea@linux.intel.com>
Date:   Tue, 7 Jul 2020 11:57:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-8-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index c3558288242a..8c214436a2c2 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -258,7 +258,7 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
>   				       FORMAT_LINEAR_PCM,
> -				       0, prtd->bits_per_sample);
> +				       0, prtd->bits_per_sample, false);

nit-pick: it's a bit ironic that is_gapless is false for PCM, when there 
is no gap in the first place..

>   	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
>   		ret = q6asm_open_read(prtd->audio_client, prtd->stream_id,
>   				      FORMAT_LINEAR_PCM,
> @@ -685,7 +685,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
>   	if (dir == SND_COMPRESS_PLAYBACK) {
>   		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
>   				       params->codec.id, params->codec.profile,
> -				       prtd->bits_per_sample);
> +				       prtd->bits_per_sample, true);
