Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF9EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896CD21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581502362;
	bh=/31DSUbyPT9wvjIWjWYSvPsSt0/Uzn2WXGcTVsBqR4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elFZMRSQHTU1F1OGtCLVA/kfuIzpIrZZHcvjbMjQzhtZp35rxIl8UGmcPqUDw3e+J
	 3RTFuYxFcn8MFtzilUeABc9s2HnQtsa9ypwEujgd/slLb9Ja2bCd26Og4VwIpRgN1s
	 xvBVX6nCmNIUoiNBvEQdyuwNyGcw6CqwWa1W1Mz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBLKMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgBLKMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:12:41 -0500
Received: from localhost (unknown [223.226.122.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085742082F;
        Wed, 12 Feb 2020 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581502360;
        bh=/31DSUbyPT9wvjIWjWYSvPsSt0/Uzn2WXGcTVsBqR4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3KLHJfwWM5DHICrdvCb93YHo1u/HKp2PkWx0Hrp/vQvwo+SJkYyj/IMTFf5cX14S
         +nitThSNqpqLK2WPbX6qIrDRa4CH8uyAomaNW1qeVl+MXtMiA84M98sHqti59BTnN1
         g4s7coO9TL6NAKV3ulLgiYrC4GNxlE6XSHYWZNo8=
Date:   Wed, 12 Feb 2020 15:42:33 +0530
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
Subject: Re: [PATCH v2 4/5] soundwire: intel: add sdw_stream_setup helper for
 .startup callback
Message-ID: <20200212101233.GA2618@vkoul-mobl>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
 <20200114234257.14336-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114234257.14336-5-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-20, 17:42, Pierre-Louis Bossart wrote:
> From: Rander Wang <rander.wang@linux.intel.com>
> 
> The sdw stream is allocated and stored in dai to share the sdw runtime
> information.
> 
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel.c | 64 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index 999aa2cd9fea..c498812522ab 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -617,6 +617,68 @@ static int intel_post_bank_switch(struct sdw_bus *bus)
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
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		name = kasprintf(GFP_KERNEL, "%s-Playback", dai->name);
> +	else
> +		name = kasprintf(GFP_KERNEL, "%s-Capture", dai->name);

I don't see name being feed on success. It is nicely freed on error but on
success it should be freed when you close

-- 
~Vinod
