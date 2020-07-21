Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AE1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C619B206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgGUXqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:46:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:44145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:05 -0400
IronPort-SDR: x3QoV1+LF98YWDJqNk31cbAcVV+9gz5sCq1OacZdGjw9MvLWrnmxnLxvYxVlXVDFsZShOsyFbU
 MUufxjw/mcYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815368"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:04 -0700
IronPort-SDR: 9OdgNYNCRJPfOHlYoJIb2u8etUuI/Ux93Fx835GmF5ehJ37l+HIP2x55rIpf6ytNEo2RwH84QG
 6oWiwuaquARQ==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539374"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:04 -0700
Subject: Re: [PATCH v2 8/9] ASoC: qdsp6-dai: add gapless support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
 <20200721165306.29082-9-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <868d9768-a4c4-71c1-28fd-ca0e2f6564bf@linux.intel.com>
Date:   Tue, 21 Jul 2020 14:53:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721165306.29082-9-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





>   	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
> -		prtd->state = Q6ASM_STREAM_STOPPED;
> +		spin_lock_irqsave(&prtd->lock, flags);
> +		if (prtd->notify_on_drain) {
> +			if (substream->partial_drain) {
> +				/**

why the kernel-doc style comment?

[...]

> -static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
> -				      struct snd_compr_stream *stream,
> -				      struct snd_compr_params *params)
> +static int __q6asm_dai_compr_set_codec_params(struct snd_soc_component *component,
> +					      struct snd_compr_stream *stream,
> +					      struct snd_codec *codec,
> +					      int stream_id)

not sure I get why you added the __ prefix, does it have any semantic 
meaning?

>   {
>   	struct snd_compr_runtime *runtime = stream->runtime;
>   	struct q6asm_dai_rtd *prtd = runtime->private_data;
> -	struct snd_soc_pcm_runtime *rtd = stream->private_data;
> -	int dir = stream->direction;
> -	struct q6asm_dai_data *pdata;
>   	struct q6asm_flac_cfg flac_cfg;
>   	struct q6asm_wma_cfg wma_cfg;
>   	struct q6asm_alac_cfg alac_cfg;
> @@ -667,53 +718,18 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
>   	struct snd_dec_alac *alac;
>   	struct snd_dec_ape *ape;
>   
> -	codec_options = &(prtd->codec_param.codec.options);
> -
> -
> -	memcpy(&prtd->codec_param, params, sizeof(*params));
> -
> -	pdata = snd_soc_component_get_drvdata(component);
> -	if (!pdata)
> -		return -EINVAL;
> -
> -	if (!prtd || !prtd->audio_client) {
> -		dev_err(dev, "private data null or audio client freed\n");
> -		return -EINVAL;
> -	}
> -
> -	prtd->periods = runtime->fragments;
> -	prtd->pcm_count = runtime->fragment_size;
> -	prtd->pcm_size = runtime->fragments * runtime->fragment_size;
> -	prtd->bits_per_sample = 16;
> -	if (dir == SND_COMPRESS_PLAYBACK) {
> -		ret = q6asm_open_write(prtd->audio_client, prtd->stream_id,
> -				       params->codec.id, params->codec.profile,
> -				       prtd->bits_per_sample, true);
> -
> -		if (ret < 0) {
> -			dev_err(dev, "q6asm_open_write failed\n");
> -			q6asm_audio_client_free(prtd->audio_client);
> -			prtd->audio_client = NULL;
> -			return ret;
> -		}
> -	}
> +	codec_options = &(prtd->codec.options);
>   
> -	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
> -	ret = q6routing_stream_open(rtd->dai_link->id, LEGACY_PCM_MODE,
> -			      prtd->session_id, dir);
> -	if (ret) {
> -		dev_err(dev, "Stream reg failed ret:%d\n", ret);
> -		return ret;
> -	}
> +	memcpy(&prtd->codec, codec, sizeof(*codec));
>   
> -	switch (params->codec.id) {
> +	switch (codec->id) {
>   	case SND_AUDIOCODEC_FLAC:
>   
>   		memset(&flac_cfg, 0x0, sizeof(struct q6asm_flac_cfg));
>   		flac = &codec_options->flac_d;
>   
> -		flac_cfg.ch_cfg = params->codec.ch_in;
> -		flac_cfg.sample_rate =  params->codec.sample_rate;

all these indirection changes could have gone in a earlier patch, this 
adds a lot of changes that make this patch long to review. Same comment 
for all formats

> +		flac_cfg.ch_cfg = codec->ch_in;
> +		flac_cfg.sample_rate = codec->sample_rate;
>   		flac_cfg.stream_info_present = 1;
>   		flac_cfg.sample_size = flac->sample_size;
>   		flac_cfg.min_blk_size = flac->min_blk_size;

[...]

> -static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
> +static int q6asm_dai_compr_set_metadata(struct snd_soc_component *component,
> +					struct snd_compr_stream *stream,
>   					struct snd_compr_metadata *metadata)
>   {
>   	struct snd_compr_runtime *runtime = stream->runtime;
> @@ -884,6 +959,32 @@ static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
>   		break;
>   	case SNDRV_COMPRESS_ENCODER_DELAY:
>   		prtd->initial_samples_drop = metadata->value[0];
> +		if (prtd->next_track_stream_id) {
> +			ret = q6asm_open_write(prtd->audio_client,
> +					       prtd->next_track_stream_id,
> +					       prtd->codec.id,
> +					       prtd->codec.profile,
> +					       prtd->bits_per_sample,
> +				       true);
> +			if (ret < 0) {
> +				dev_err(component->dev, "q6asm_open_write failed\n");
> +				return ret;
> +			}
> +			ret = __q6asm_dai_compr_set_codec_params(component, stream,
> +								 &prtd->codec,
> +								 prtd->next_track_stream_id);
> +			if (ret < 0) {
> +				dev_err(component->dev, "q6asm_open_write failed\n");
> +				return ret;
> +			}
> +
> +			ret = q6asm_stream_remove_initial_silence(prtd->audio_client,
> +						    prtd->next_track_stream_id,
> +						    prtd->initial_samples_drop);
> +			prtd->next_track_stream_id = 0;
> +
> +		}
> +
>   		break;
>   	default:
>   		ret = -EINVAL;
> @@ -917,6 +1018,14 @@ static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
>   		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
>   				       CMD_PAUSE);
>   		break;
> +	case SND_COMPR_TRIGGER_NEXT_TRACK:
> +		prtd->next_track = true;
> +		prtd->next_track_stream_id = (prtd->stream_id == 1 ? 2 : 1);

it's rather odd, the initialization above uses next_track_stream_id = 0?

> +		break;
> +	case SND_COMPR_TRIGGER_DRAIN:
> +	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
> +		prtd->notify_on_drain = true;
> +		break;
>   	default:
>   		ret = -EINVAL;
>   		break;
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> index 69513ac1fa55..a8dddfeb28da 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.h
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -34,6 +34,7 @@ enum {
>   #define MAX_SESSIONS	8
>   #define NO_TIMESTAMP    0xFF00
>   #define FORMAT_LINEAR_PCM   0x0000
> +#define ASM_LAST_BUFFER_FLAG           BIT(30)
>   
>   struct q6asm_flac_cfg {
>           u32 sample_rate;
> 
