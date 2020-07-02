Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0B6208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593689770;
	bh=p0YH01x3WZMVkR6PI1s0jg/nyY9gF98YHIOHeOJG2qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w8ZJlNCAjdbNZWdHsSHPYoqR/ii39JLI+8k7magyh/BkuMdIk2w7KMFbiD+/DAZXQ
	 uSUf/i/AKeEw90NDHGWEqSrviGebPFAu20r07FUEV6p3VEC66BqlnDxCJ2em8UeSTq
	 uNYv8WdznTCW/hRyvZx2sUZR7B17M2LsJ5Kyf7/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgGBLgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728677AbgGBLgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:36:09 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 676F220780;
        Thu,  2 Jul 2020 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593689768;
        bh=p0YH01x3WZMVkR6PI1s0jg/nyY9gF98YHIOHeOJG2qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tq3OfLtPV4nIin6WJOdiCHY+Fp4eQINFGZqFEKQ5d6Oa9jg74lBzERCVcEZ72HuTF
         mpQAeWsX9xDWsdZ5ZCKyWnooffexQoeC14qG1o8pywKtyZNVNi1KQCFTbdN9hQRHwB
         ZnF/0hg/D30ZG0bdkbV+hD62oO6PAt3rW5b0eHtI=
Date:   Thu, 2 Jul 2020 17:06:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Subject: Re: [RFC PATCH] ALSA: compress: add support to change codec profile
 in gapless playback
Message-ID: <20200702113602.GA273932@vkoul-mobl>
References: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702111114.32217-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srini,

On 02-07-20, 12:11, Srinivas Kandagatla wrote:
> For gapless playback its possible that each track can have different

s/its/it is 

> codec profile with same decoder, for example we have WMA album,
> we may have different tracks as WMA v9, WMA v10 and so on
> 
> Existing code does not allow to change this profile while doing gapless
> playback.
> 
> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
> userspace to set this new parameters required for new codec profile.

Thanks, this looks good and in line with discussions done in Audio uConf

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/sound/compress_driver.h       |  5 +++
>  include/sound/soc-component.h         |  3 ++
>  include/sound/soc-dai.h               |  5 +++
>  include/uapi/sound/compress_offload.h |  1 +
>  sound/core/compress_offload.c         | 54 ++++++++++++++++++++++++---
>  sound/soc/soc-compress.c              | 30 +++++++++++++++
>  sound/soc/soc-dai.c                   | 14 +++++++

Can we split the ALSA changes and ASoC changes to different patches
please?

Also please post driver support for this API..

Lastly, documentation needs update about this call

>  7 files changed, 106 insertions(+), 6 deletions(-)
> 
> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> index 70cbc5095e72..8d23351f7ad7 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -93,6 +93,9 @@ struct snd_compr_stream {
>   * @set_params: Sets the compressed stream parameters, mandatory
>   * This can be called in during stream creation only to set codec params
>   * and the stream properties
> + * @set_codec_params: Sets the compressed stream codec parameters, mandatory

This should be optional as gapless is optional

> --- a/include/uapi/sound/compress_offload.h
> +++ b/include/uapi/sound/compress_offload.h
> @@ -172,6 +172,7 @@ struct snd_compr_metadata {
>  						 struct snd_compr_metadata)
>  #define SNDRV_COMPRESS_GET_METADATA	_IOWR('C', 0x15,\
>  						 struct snd_compr_metadata)
> +#define SNDRV_COMPRESS_SET_CODEC_PARAMS	_IOW('C', 0x16, struct snd_codec)
>  #define SNDRV_COMPRESS_TSTAMP		_IOR('C', 0x20, struct snd_compr_tstamp)
>  #define SNDRV_COMPRESS_AVAIL		_IOR('C', 0x21, struct snd_compr_avail)
>  #define SNDRV_COMPRESS_PAUSE		_IO('C', 0x30)

I think we should bump the compress version too for checking in userland
about this support

>  static int snd_compress_check_input(struct snd_compr_params *params)
>  {
>  	/* first let's check the buffer parameter's */
> @@ -574,14 +586,41 @@ static int snd_compress_check_input(struct snd_compr_params *params)
>  	    params->buffer.fragments == 0)
>  		return -EINVAL;
>  
> -	/* now codec parameters */
> -	if (params->codec.id == 0 || params->codec.id > SND_AUDIOCODEC_MAX)
> -		return -EINVAL;
> +	return snd_compress_check_codec_params(&params->codec);

Can this be 1st patch to prepare for this change?

>  
> -	if (params->codec.ch_in == 0 || params->codec.ch_out == 0)
> -		return -EINVAL;
> +}
>  
> -	return 0;
> +static int snd_compr_set_codec_params(struct snd_compr_stream *stream,
> +				      unsigned long arg)
> +{
> +	struct snd_codec *params;
> +	int retval;
> +
> +	if (!stream->ops->set_codec_params)
> +		return -EPERM;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> +		return -EPERM;
> +
> +	/* codec params can be only set when next track has been signalled */
> +	if (stream->next_track == false)
> +		return -EPERM;
> +
> +	params = memdup_user((void __user *)arg, sizeof(*params));
> +	if (IS_ERR(params))
> +		return PTR_ERR(params);
> +
> +	retval = snd_compress_check_codec_params(params);
> +	if (retval)
> +		goto out;
> +
> +	retval = stream->ops->set_codec_params(stream, params);
> +	if (retval)
> +		goto out;

this jump is superfluous

> +
> +out:
> +	kfree(params);
> +	return retval;
>  }

...

> +static int soc_compr_set_codec_params(struct snd_compr_stream *cstream,
> +				      struct snd_codec *codec)
> +{
> +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> +	struct snd_soc_component *component;
> +	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
> +	int i, ret;
> +
> +	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
> +
> +	ret = snd_soc_dai_compr_set_codec_params(cpu_dai, cstream, codec);
> +	if (ret < 0)
> +		goto err;
> +
> +	for_each_rtd_components(rtd, i, component) {
> +		if (!component->driver->compress_ops ||
> +		    !component->driver->compress_ops->set_codec_params)
> +			continue;
> +
> +		ret = component->driver->compress_ops->set_codec_params(component, cstream,
> +								     codec);

maybe use a compress_ops pointer to make this look and read better :)
-- 
~Vinod
