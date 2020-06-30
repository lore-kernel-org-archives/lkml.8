Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED643C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DC5206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593533036;
	bh=m7bZWP2joANZChJ6MhUAkqCWwrdxb/SV7J2T8q0fe/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufudFEucgRNNPjUfWEiz+KH9qsiDj6amHmAJ/s1chZcHnOPukp63weYtBCF00bmt5
	 O2X0UTvrwcS8Iq690AKF1/i/8JM5z/JuUSXyiyEgJ7viyxGSNSuYVyJRyPGAvg3gNW
	 MMvuypwxpzcXlJQMGwtVxONQw4i8dc98BbOzxyJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbgF3QDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389792AbgF3QDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:03:54 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAA1D206B6;
        Tue, 30 Jun 2020 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593533033;
        bh=m7bZWP2joANZChJ6MhUAkqCWwrdxb/SV7J2T8q0fe/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fB5gffAU8qe8AYGHLC7/rY/DsixukA2syobwl3+zuu+8MvM2B5K5g7N/ASQlQ3Nfg
         v1ikgcLy457otS1waweRAUEtFNjwTG0Pq7vyks35wytfCWCb6/3st3nBUQLH6CLTzo
         RKFbRG3FY75ubBj9jmmcoKlmfmywcuDEo0l73qng=
Date:   Tue, 30 Jun 2020 21:33:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 2/5] soundwire: stream: add helper to startup/shutdown
 streams
Message-ID: <20200630160349.GR2599@vkoul-mobl>
References: <20200622212332.16277-1-yung-chuan.liao@linux.intel.com>
 <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622212332.16277-3-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-20, 05:23, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> To handle streams at the dailink level, expose two helpers that will
> be called from machine drivers.
> 
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/stream.c    | 90 +++++++++++++++++++++++++++++++++++
>  include/linux/soundwire/sdw.h |  2 +
>  2 files changed, 92 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index a9a72574b34a..48daf4b48f51 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -13,6 +13,9 @@
>  #include <linux/slab.h>
>  #include <linux/soundwire/sdw_registers.h>
>  #include <linux/soundwire/sdw.h>
> +#include <sound/core.h>

Do we really need core header?

> +#include <sound/pcm.h>
> +#include <sound/soc.h>
>  #include "bus.h"
>  
>  /*
> @@ -1826,3 +1829,90 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  	return ret;
>  }
>  EXPORT_SYMBOL(sdw_deprepare_stream);
> +
> +static int set_stream(struct snd_pcm_substream *substream,
> +		      struct sdw_stream_runtime *sdw_stream)

sdw_set_stream() please

> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *dai;
> +	int ret = 0;
> +	int i;
> +
> +	/* Set stream pointer on all DAIs */
> +	for_each_rtd_dais(rtd, i, dai) {
> +		ret = snd_soc_dai_set_sdw_stream(dai, sdw_stream,
> +						 substream->stream);
> +		if (ret < 0) {
> +			dev_err(rtd->dev,
> +				"failed to set stream pointer on dai %s",
> +				dai->name);

lets use one line and shiny new 100 char limit, would make code read
better!

> +			break;

So on error should unset of stream pointer be done?

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +int sdw_startup_stream(void *sdw_substream)

Can we have kernel doc style Documentation for exported APIs?

> +{
> +	struct snd_pcm_substream *substream = sdw_substream;
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sdw_stream_runtime *sdw_stream;
> +	char *name;
> +	int ret;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		name = kasprintf(GFP_KERNEL, "%s-Playback", substream->name);
> +	else
> +		name = kasprintf(GFP_KERNEL, "%s-Capture", substream->name);
> +
> +	if (!name)
> +		return -ENOMEM;
> +
> +	sdw_stream = sdw_alloc_stream(name);
> +	if (!sdw_stream) {
> +		dev_err(rtd->dev, "alloc stream failed for substream DAI %s",
> +			substream->name);
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ret = set_stream(substream, sdw_stream);
> +	if (ret < 0)
> +		goto release_stream;
> +	return 0;
> +
> +release_stream:
> +	sdw_release_stream(sdw_stream);
> +	set_stream(substream, NULL);
> +error:
> +	kfree(name);
> +	return ret;
> +}
> +EXPORT_SYMBOL(sdw_startup_stream);
-- 
~Vinod
