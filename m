Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA72C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F5520873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581502563;
	bh=0ZfvCJyD4aws5BJOETfWcvOs5Q4TcRSl+cvngTFFj4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rkfbB5bZARLfQvI87X1DDIEj2LNsoE66oFW21b+iE1KaxGGFyX1myEL4dICYJrZv9
	 ZNfNfkJYhpUGp3N1FWiBUB+5PZqIP7F19bTv3q4AcnIhDGEhMGMXVEjvmo7WPyxdPH
	 kIH1jtsLjxlMq37AGWDb7j33/xXHTm+P+HMFQews=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgBLKQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgBLKQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:16:00 -0500
Received: from localhost (unknown [223.226.122.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3841C2073C;
        Wed, 12 Feb 2020 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581502559;
        bh=0ZfvCJyD4aws5BJOETfWcvOs5Q4TcRSl+cvngTFFj4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRXxX5tKi7piaFyca09jdXFxsKPiEvspBonnyZ0Dz+rdmgDlp7PZWbfSQxiu5WByV
         uSSt22QM8Rq5SK4NtQ7xuJBzHjHJlZAwd9cBlQeefylCVNRDA1MgMWStiu98e6C1QR
         SaA06dY+p9Nyoth4MBm5Pu7Hy3oewdHYwCIRyVbA=
Date:   Wed, 12 Feb 2020 15:45:54 +0530
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
Subject: Re: [PATCH v2 5/5] soundwire: intel: free all resources on hw_free()
Message-ID: <20200212101554.GB2618@vkoul-mobl>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114234257.14336-6-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 17:42, Pierre-Louis Bossart wrote:
> Make sure all calls to the SoundWire stream API are done and involve
> callback
> 
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 40 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index c498812522ab..e0c1fff7c4a0 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -550,6 +550,25 @@ static int intel_params_stream(struct sdw_intel *sdw,
>  	return -EIO;
>  }
>  
> +static int intel_free_stream(struct sdw_intel *sdw,
> +			     struct snd_pcm_substream *substream,
> +			     struct snd_soc_dai *dai,
> +			     int link_id)
> +{
> +	struct sdw_intel_link_res *res = sdw->link_res;
> +	struct sdw_intel_stream_free_data free_data;

where is this struct sdw_intel_stream_free_data defined. I dont see it
in this patch or this series..

> +
> +	free_data.substream = substream;
> +	free_data.dai = dai;
> +	free_data.link_id = link_id;
> +
> +	if (res->ops && res->ops->free_stream && res->dev)
> +		return res->ops->free_stream(res->dev,
> +					     &free_data);
> +
> +	return 0;
> +}
> +
>  /*
>   * bank switch routines
>   */
> @@ -817,6 +836,7 @@ static int
>  intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>  {
>  	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
> +	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_cdns_dma_data *dma;
>  	int ret;
>  
> @@ -824,12 +844,28 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>  	if (!dma)
>  		return -EIO;
>  
> +	ret = sdw_deprepare_stream(dma->stream);
> +	if (ret) {
> +		dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
> +		return ret;
> +	}
> +
>  	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
>  			dma->stream->name, ret);
> +		return ret;
> +	}
>  
> -	return ret;
> +	ret = intel_free_stream(sdw, substream, dai, sdw->instance);
> +	if (ret < 0) {
> +		dev_err(dai->dev, "intel_free_stream: failed %d", ret);
> +		return ret;
> +	}
> +
> +	sdw_release_stream(dma->stream);

I think, free the 'name' here would be apt

-- 
~Vinod
