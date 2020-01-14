Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A44CC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F32187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578982511;
	bh=Bvg/p2APBIXoLXN92+QfE3MG7q8+n3xAIpTyfePVQ9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UtnC4ezomVVdD9S0W59L9HUDKf/UtATmh2b4/cVDNlG3CI4IYePe7QZ09zwRRLssu
	 3k3k6C78isI/0k6pr0OfZBm3hAYkuULxAYtksTSZmFUJMgRQ1OqGiG4OPXpL+PcmzH
	 F0/ygvdI8GOv/yXNtM09oQbuAbvCEK0hVqBGAtGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANGPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgANGPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:15:09 -0500
Received: from localhost (unknown [49.207.51.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B12E2084D;
        Tue, 14 Jan 2020 06:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578982508;
        bh=Bvg/p2APBIXoLXN92+QfE3MG7q8+n3xAIpTyfePVQ9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ecCzcFXtAc1P9IgW3Tg2kmrIZV/ocoYgiCF/WjlbiW/73Ub0eugd9hOHa38I20TKa
         X+yjnXBFIDq3NuM3DTlGf2hytbj0DDUO1Ok2Ftcqz6T5OMDqPvM+5PfXdtptVVuN6m
         7m7IJUJBZEgov+WQkKH5QenGMOeO1M1mDJOjnjhs=
Date:   Tue, 14 Jan 2020 11:44:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 4/5] soundwire: intel: add sdw_stream_setup helper for
 .startup callback
Message-ID: <20200114061441.GB2818@vkoul-mobl>
References: <20200110214609.30356-1-pierre-louis.bossart@linux.intel.com>
 <20200110214609.30356-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110214609.30356-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 15:46, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
> 
> The sdw stream is allocated and stored in dai to share the sdw runtime
> information.
> 
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 65 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index aa80c46156cb..f4554386d832 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -617,6 +617,69 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
>   * DAI routines
>   */
>  
> +static int sdw_stream_setup(struct snd_pcm_substream *substream,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sdw_stream_runtime *sdw_stream = NULL;
> +	char *name;
> +	int i, ret;
> +
> +	name = kzalloc(32, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		snprintf(name, 32, "%s-Playback", dai->name);
> +	else
> +		snprintf(name, 32, "%s-Capture", dai->name);

How about use DAI_SIZE instead of 32 here and above few places? Lets not
code number like this please

> +
> +	sdw_stream = sdw_alloc_stream(name);
> +	if (!sdw_stream) {
> +		dev_err(dai->dev, "alloc stream failed for DAI %s", dai->name);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Set stream pointer on CPU DAI */
> +	ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream, substream->stream);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "failed to set stream pointer on cpu dai %s",
> +			dai->name);
> +		goto release_stream;
> +	}
> +
> +	/* Set stream pointer on all CODEC DAIs */
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		ret = snd_soc_dai_set_sdw_stream(rtd->codec_dais[i], sdw_stream,
> +						 substream->stream);
> +		if (ret < 0) {
> +			dev_err(dai->dev, "failed to set stream pointer on codec dai %s",
> +				rtd->codec_dais[i]->name);
> +			goto release_stream;
> +		}
> +	}
> +
> +	return 0;
> +
> +release_stream:
> +	sdw_release_stream(sdw_stream);
> +error:
> +	kfree(name);
> +	return ret;
> +}
> +
> +static int intel_startup(struct snd_pcm_substream *substream,
> +			 struct snd_soc_dai *dai)
> +{
> +	/*
> +	 * TODO: add pm_runtime support here, the startup callback
> +	 * will make sure the IP is 'active'
> +	 */
> +
> +	return sdw_stream_setup(substream, dai);
> +}
> +
>  static int intel_hw_params(struct snd_pcm_substream *substream,
>  			   struct snd_pcm_hw_params *params,
>  			   struct snd_soc_dai *dai)
> @@ -796,6 +859,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
>  }
>  
>  static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
> +	.startup = intel_startup,
>  	.hw_params = intel_hw_params,
>  	.prepare = intel_prepare,
>  	.trigger = intel_trigger,
> @@ -805,6 +869,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
>  };
>  
>  static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
> +	.startup = intel_startup,
>  	.hw_params = intel_hw_params,
>  	.prepare = intel_prepare,
>  	.trigger = intel_trigger,
> -- 
> 2.20.1

-- 
~Vinod
