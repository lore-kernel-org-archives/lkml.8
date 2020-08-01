Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6075C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B7A20725
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEJxdjnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgHAIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 04:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgHAIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 04:00:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE51C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 01:00:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w19so5452780plq.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i64OqGOKUX2vRbPCdcwPu4hJ7VHYiYruzv3gOuWclhA=;
        b=CEJxdjnQCINWOcopnZ4Wu5K7tT+eBGOPqTLjCGe07JxfaHDZnQ4FDVxWeQr/je90Mf
         KYxMbtfrx6Pk8e7SeDv57mGg6JGW/Zv0G1af6LAmKB3EkEYNCfu76G86T9uIQPJ7eFgK
         0lk4PK/El+KSfNGOYoSpeflHAns3aqDX8cfwxnfv1H9pnwQnjCG0K+KVrbGmf3mFhn+2
         p6s69ml2dp/5goOx1TBru+VHAwmiAJUHKaw1d3ZP61ofCwm2XiO4mDrY08EUWMU81Fgd
         avj3VZOBOgTE2APc8mLX3jz+3T/oDph4xsU0bBFu20PGvvxrjp4cb43ZlhSapub8Kd7t
         oBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i64OqGOKUX2vRbPCdcwPu4hJ7VHYiYruzv3gOuWclhA=;
        b=GM8JgUOAIad0rUq8BpWGhf8I2RQaBSvSfmsS2weKr4VL+F/I6KW7iJFs0BblIm3fLX
         xDpDceh3oaIawOsSL4yq48UUmuCgjTNUmyPDT4S5MtApabgN0C8PaoqfCNoCs0idb0Le
         dS2HWFFGlS6SYmzduDNdXZNFOspvaTz0O8bihrdJTAKgTP6Y/OKvvStgNtfCJIllomer
         j95XZPm2NgC93eznoPNMGvMhxsafGF6L8osv9Z19L3K50I+ImuxQksOkfaVqLTUs7ypq
         ffitVxVnx3Huaco3DCSK5zwby5aeTbpu3itN8sWl5GHnDj5I29I5DTgTpvGIaOlNY64L
         koUQ==
X-Gm-Message-State: AOAM530JRvFXi/OKGS5ukTEUydmONtkcnhztHeG7QtGzNZFg8YLN4n8S
        eksoqJ6X0AoEMhzYC/cVRvw=
X-Google-Smtp-Source: ABdhPJyX87jF7+C/BEL9ElATQshMUqsrjaIT8uJiXDwTgR1Lg3kd7vr7cKVtr/cp+/DBXHYU2vE0KA==
X-Received: by 2002:a17:902:7688:: with SMTP id m8mr6794990pll.12.1596268803816;
        Sat, 01 Aug 2020 01:00:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f6sm13342385pfa.23.2020.08.01.01.00.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Aug 2020 01:00:03 -0700 (PDT)
Date:   Sat, 1 Aug 2020 00:59:54 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Remove
 fsl_asoc_card_set_bias_level function
Message-ID: <20200801075954.GA19629@Asurada-Nvidia>
References: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596102422-14010-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Having two nits and one question, inline:

On Thu, Jul 30, 2020 at 05:47:02PM +0800, Shengjiu Wang wrote:
> @@ -182,6 +180,69 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
>  					       cpu_priv->slot_width);
>  		if (ret && ret != -ENOTSUPP) {
>  			dev_err(dev, "failed to set TDM slot for cpu dai\n");
> +			goto out;
> +		}
> +	}
> +
> +	/* Specific configuration for PLL */
> +	if (codec_priv->pll_id && codec_priv->fll_id) {
> +		if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
> +			pll_out = priv->sample_rate * 384;
> +		else
> +			pll_out = priv->sample_rate * 256;
> +
> +		ret = snd_soc_dai_set_pll(asoc_rtd_to_codec(rtd, 0),
> +					  codec_priv->pll_id,
> +					  codec_priv->mclk_id,
> +					  codec_priv->mclk_freq, pll_out);
> +		if (ret) {
> +			dev_err(dev, "failed to start FLL: %d\n", ret);
> +			goto out;
> +		}
> +
> +		ret = snd_soc_dai_set_sysclk(asoc_rtd_to_codec(rtd, 0),
> +					     codec_priv->fll_id,
> +					     pll_out, SND_SOC_CLOCK_IN);

Just came into my mind: do we need some protection here to prevent
PLL/SYSCLK reconfiguration if TX/RX end up with different values?

> +	return 0;
> +
> +out:
> +	priv->streams &= ~BIT(substream->stream);
> +	return ret;

Rather than "out:" which doesn't explicitly indicate an error-out,
"fail:" would be better, following what we used in probe().

> +static int fsl_asoc_card_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	struct codec_priv *codec_priv = &priv->codec_priv;
> +	struct device *dev = rtd->card->dev;
> +	int ret;
> +
> +	priv->streams &= ~BIT(substream->stream);
> +

> +	if (!priv->streams && codec_priv->pll_id &&
> +	    codec_priv->fll_id) {

This now can fit into single line :)
