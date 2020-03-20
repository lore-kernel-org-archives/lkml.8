Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE73320777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584713736;
	bh=iY20u/IgUH7ck1uzIJTEsr4J0NsnrcVYd97wLs96ABE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fyBIBLsvIhVqa9O5sZOJKboQJoci81BDIuZkMyhxbGPTLQTCyT9s3f7ZiKwAq275c
	 icmUp2BHcG05dE1aMqMOeFp1DmBFiQMrnEWW0w1gzEf/kKC+eizJo9r/dFZ3PA2vKj
	 T+YVtmLTwjpkSIjtmh8MEotIJDcS2/wns1LABMqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCTOPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTOPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:15:34 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4937220739;
        Fri, 20 Mar 2020 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584713733;
        bh=iY20u/IgUH7ck1uzIJTEsr4J0NsnrcVYd97wLs96ABE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6gOnR5ST2SPsthWP2DMt5zLXqGWOTdPzerYXOyXz9HbBgUUWJJuHs5BLT3HuznPe
         r1jlv6E5Zp6LeBJakOw7eZVupiM/ousyLYqJ1NXfzHVt38I7Z4BUnS75kKQcr2Z5wD
         tEjKA8VkJyoKcK1a8frGbti8KTYzTLBarbjcAyYc=
Date:   Fri, 20 Mar 2020 19:45:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH] soundwire: stream: only change state if needed
Message-ID: <20200320141528.GI4885@vkoul-mobl>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-03-20, 05:51, Pierre-Louis Bossart wrote:
> In a multi-cpu DAI context, the stream routines may be called from
> multiple DAI callbacks. Make sure the stream state only changes for
> the first call, and don't return error messages if the target state is
> already reached.

For stream-apis we have documented explicitly in Documentation/driver-api/soundwire/stream.rst

"Bus implements below API for allocate a stream which needs to be called once
per stream. From ASoC DPCM framework, this stream state maybe linked to
.startup() operation.

.. code-block:: c

  int sdw_alloc_stream(char * stream_name); "

This is documented for all stream-apis.

This can be resolved by moving the calling of these APIs from
master-dais/slave-dais to machine-dais. They are unique in the card.

> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 1b43d03c79ea..3319121cd706 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1572,6 +1572,7 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>  	sdw_acquire_bus_lock(stream);
>  
>  	if (stream->state == SDW_STREAM_PREPARED) {
> +		/* nothing to do */
>  		ret = 0;
>  		goto state_err;
>  	}
> @@ -1661,6 +1662,12 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_ENABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_PREPARED &&
>  	    stream->state != SDW_STREAM_DISABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
> @@ -1744,6 +1751,12 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_DISABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_ENABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
>  		       __func__, stream->name, stream->state);
> @@ -1809,6 +1822,12 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>  
>  	sdw_acquire_bus_lock(stream);
>  
> +	if (stream->state == SDW_STREAM_DEPREPARED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>  	if (stream->state != SDW_STREAM_PREPARED &&
>  	    stream->state != SDW_STREAM_DISABLED) {
>  		pr_err("%s: %s: inconsistent state state %d\n",
> -- 
> 2.20.1

-- 
~Vinod
