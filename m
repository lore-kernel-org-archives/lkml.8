Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83991C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558762077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578639333;
	bh=mDdpGN6yAPTKX7BA5XVzBBicXNXPQHC6lQFxfVSspJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yNx+9Yvm55A6jIotWc/Jl1nOndoFKiPZSc3mNWx9J5yJ+MXZf7YE+/Kl75NVB+6j1
	 IhHFqaE+7eJPI+aMi6NFaVpAT9TMpnqckciTQGH63qWzubUDH/TP3G/gS1S3rW5USj
	 kGiqWH6wrfsgUXUe/xZpddWf2JpiSjD4d4ao8HcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgAJGzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:55:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731544AbgAJGzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:55:32 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555F520673;
        Fri, 10 Jan 2020 06:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578639331;
        bh=mDdpGN6yAPTKX7BA5XVzBBicXNXPQHC6lQFxfVSspJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SHCdJvtNhXFB0/NU0dDmLeGd+X9JoYG8hffqvDNSwBrFJOVvdlF4H7rOfVytunauI
         ziP7OwMBdmawlB6imnkyH8X4QKUmsz6ERAG7DadxbfdwC1H3sjsQtLS0qLzAgewNwW
         Mcaargnu6SfRqseS2HwXtOgRCSAkmTttWdf8U1Ls=
Date:   Fri, 10 Jan 2020 12:25:15 +0530
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
Subject: Re: [PATCH 4/6] soundwire: stream: do not update parameters during
 DISABLED-PREPARED transition
Message-ID: <20200110065515.GZ2818@vkoul-mobl>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108175438.13121-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-01-20, 11:54, Pierre-Louis Bossart wrote:
> After a system suspend, the ALSA/ASoC core will invoke the .prepare()
> callback and a TRIGGER_START when INFO_RESUME is not supported.
> 
> Likewise, when an underflow occurs, the .prepare callback will be invoked.
> 
> In both cases, the stream can be in DISABLED mode, and will transition
> into the PREPARED mode. We however don't want the bus bandwidth to be
> recomputed.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index bd0bddf73830..c28ce7f0d742 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1460,7 +1460,8 @@ static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
>  	}
>  }
>  
> -static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
> +static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
> +			       bool update_params)
>  {
>  	struct sdw_master_runtime *m_rt;
>  	struct sdw_bus *bus = NULL;
> @@ -1480,6 +1481,9 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  			return -EINVAL;
>  		}
>  
> +		if (!update_params)
> +			goto program_params;
> +
>  		/* Increment cumulative bus bandwidth */
>  		/* TODO: Update this during Device-Device support */
>  		bus->params.bandwidth += m_rt->stream->params.rate *
> @@ -1495,6 +1499,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  			}
>  		}
>  
> +program_params:
>  		/* Program params */
>  		ret = sdw_program_params(bus);
>  		if (ret < 0) {
> @@ -1544,6 +1549,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   */
>  int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  {
> +	bool update_params = true;
>  	int ret;
>  
>  	if (!stream) {
> @@ -1567,7 +1573,16 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  		goto state_err;
>  	}
>  
> -	ret = _sdw_prepare_stream(stream);
> +	/*
> +	 * when the stream is DISABLED, this means sdw_prepare_stream()
> +	 * is called as a result of an underflow or a resume operation.
> +	 * In this case, the bus parameters shall not be recomputed, but
> +	 * still need to be re-applied
> +	 */
> +	if (stream->state == SDW_STREAM_DISABLED)
> +		update_params = false;

Should this not be handled by the caller..? I do not like to deduce this
here as the info is already available in dai driver, so go ahead and
propagate it and get it from caller when it is required..

-- 
~Vinod
