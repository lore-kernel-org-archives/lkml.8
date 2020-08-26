Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F075C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E9C20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598435204;
	bh=xqg0uPoIsVRT6yhZLnpmkmckUCu1vQcTgykvXhOQk4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pioNfZl+ICWwI2HBa37kZzRXyvXlETlFlBoeMtejAkLd6H98qMSI3ieHCNJV/lLSa
	 RPzfsGv9PwaBIcBUtcJwOnS6L+GJfs2+mvYlzprBAh+ipWMt3+dsaN5sp6bG8bDmdn
	 5j0q92BB4GZc6B7tYnK9PDB7Iy753Ly9hiXhpLVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgHZJqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgHZJql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:46:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C802075E;
        Wed, 26 Aug 2020 09:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598435200;
        bh=xqg0uPoIsVRT6yhZLnpmkmckUCu1vQcTgykvXhOQk4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDEVZ6pUUy3KFjaL+7TIb/v++RViP+I9EUHWTesVAAN8ap7NpBUO0uUPXDllMr8YX
         7RH6J+xGVF4b9v099nyVEgm0FXKh0WdTNmPXWDj85ZXDsEmGjybOs4Qand/ZnzBgCU
         IZKOmP5X2z3+b7JDlIEcD3P4HIP9IThclEIwlF4E=
Date:   Wed, 26 Aug 2020 15:16:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for
 the first cpu_dai
Message-ID: <20200826094636.GB2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-08-20, 10:41, Bard Liao wrote:
> We should call these APIs once per stream. So we can only call it
> when the dai ops is invoked for the first cpu dai.
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 45 +++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 89a8ad1f80e8..7c63581270fd 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -941,11 +941,13 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
>  static int intel_prepare(struct snd_pcm_substream *substream,
>  			 struct snd_soc_dai *dai)
>  {
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>  	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_cdns_dma_data *dma;
>  	int ch, dir;
> -	int ret;
> +	int ret = 0;
>  
>  	dma = snd_soc_dai_get_dma_data(dai, substream);
>  	if (!dma) {
> @@ -985,7 +987,13 @@ static int intel_prepare(struct snd_pcm_substream *substream,
>  			goto err;
>  	}
>  
> -	ret = sdw_prepare_stream(dma->stream);
> +	/*
> +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
> +	 * is called once per stream, we should call it only when
> +	 * dai = first_cpu_dai.
> +	 */
> +	if (first_cpu_dai == dai)
> +		ret = sdw_prepare_stream(dma->stream);

Hmmm why not use the one place which is unique in the card to call this,
hint machine dais are only called once.

>  
>  err:
>  	return ret;
> @@ -994,9 +1002,19 @@ static int intel_prepare(struct snd_pcm_substream *substream,
>  static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
>  			 struct snd_soc_dai *dai)
>  {
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>  	struct sdw_cdns_dma_data *dma;
>  	int ret;
>  
> +	/*
> +	 * All cpu dais belong to a stream. To ensure sdw_enable/disable_stream
> +	 * are called once per stream, we should call them only when
> +	 * dai = first_cpu_dai.
> +	 */
> +	if (first_cpu_dai != dai)
> +		return 0;
> +
>  	dma = snd_soc_dai_get_dma_data(dai, substream);
>  	if (!dma) {
>  		dev_err(dai->dev, "failed to get dma data in %s", __func__);
> @@ -1031,6 +1049,8 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
>  static int
>  intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>  {
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *first_cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>  	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_cdns_dma_data *dma;
> @@ -1040,12 +1060,25 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
>  	if (!dma)
>  		return -EIO;
>  
> -	ret = sdw_deprepare_stream(dma->stream);
> -	if (ret) {
> -		dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
> -		return ret;
> +	/*
> +	 * All cpu dais belong to a stream. To ensure sdw_deprepare_stream
> +	 * is called once per stream, we should call it only when
> +	 * dai = first_cpu_dai.
> +	 */
> +	if (first_cpu_dai == dai) {
> +		ret = sdw_deprepare_stream(dma->stream);
> +		if (ret) {
> +			dev_err(dai->dev, "sdw_deprepare_stream: failed %d", ret);
> +			return ret;
> +		}
>  	}
>  
> +	/*
> +	 * The sdw stream state will transition to RELEASED when stream->
> +	 * master_list is empty. So the stream state will transition to
> +	 * DEPREPARED for the first cpu-dai and to RELEASED for the last
> +	 * cpu-dai.
> +	 */
>  	ret = sdw_stream_remove_master(&cdns->bus, dma->stream);
>  	if (ret < 0) {
>  		dev_err(dai->dev, "remove master from stream %s failed: %d\n",
> -- 
> 2.17.1

-- 
~Vinod
