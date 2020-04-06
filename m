Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D166C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD25206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh907092"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDFXTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:19:45 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38478 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgDFXTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:19:45 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so578641pje.3;
        Mon, 06 Apr 2020 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qiEMQ3MnZPBtfcN59NTsvK6kDONkxcqt/LljkK1BS58=;
        b=Wh9070924djEGtjlOfMWm3UFGyjc2B4vmxZxdcBAFkiAc1QiSjxqTx9d0m8DBopdP7
         HuDT/VhNJC+8tM727HYCqdlOtJZVUQ8xhLKP2twBf5CUd4KQ15FMv7A9rkzcX3JPOUpe
         MV6It+FIRA2BIRSbq/bI6iw3+sXW8cqRPbwa7Y9KrRro2K3Nv0TiNBsKtmLZ2SErQfJl
         YJcpMjKVh/0EVzznKwspgZgcDJLvG/D4bnd9eBi1I62eZKe5iKtbub4+5EnPwyRRTtC5
         TIZskK/zQ/mhyIhM7l8BYnFwGJTpp6KELsy9FFTvN0Uq67B2kLRPOSKlceAnBHUE/iAw
         sPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qiEMQ3MnZPBtfcN59NTsvK6kDONkxcqt/LljkK1BS58=;
        b=TSh3PiWv1LzwJqWZsgj28/aMCpuG8lHq+uBmARDvGVrIXTaYUW9ykXVZVFFX/N9N1J
         uo8bys8HfdJzBJQ/qWOaFqgEuhRTpyH8EFuuguqq52kZVCLCzs7po+R6xf66nDPW6y2R
         6of6x+gNxY8H8DTdxzPqQPfXWAbf47mOxwqxkWlmHKvmams+9stpLrM+/EW/ncnjqE3I
         SGrhiXj6bUsiEK7GVXOSp33Y7PCdW5sCxWGYfh1ZplOszxMdGny+W1cnk63U7JjjqpEp
         Pm6I1EfcwV4soqCFjwN78PUBqK8mQLUcAH9cFT2RyB3QgXRYfECz+jqVs5jWvP2bNeiF
         BEIQ==
X-Gm-Message-State: AGi0Puak77a+QwFBIjD2VOAWde+5uj74a0OxLc2Uagy5rtiRT40nuJhf
        E/z4nwngd3eOJR0dDZT1eJ4=
X-Google-Smtp-Source: APiQypKNp8VZ9mr4GVNmcAt4ce9e6kNxf3ZHvIuLkebI0RqZykks7BQ7hyl/mOXDC3laCG4n/sp25w==
X-Received: by 2002:a17:90a:324b:: with SMTP id k69mr1963136pjb.50.1586215183169;
        Mon, 06 Apr 2020 16:19:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id c126sm12625459pfb.83.2020.04.06.16.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 16:19:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 16:19:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] ASoC: fsl_asrc: Support new property
 fsl,asrc-format
Message-ID: <20200406231945.GA20945@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <496f49f1fe20b969f4456b591f62223d430c6d74.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <496f49f1fe20b969f4456b591f62223d430c6d74.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some small comments.

On Wed, Apr 01, 2020 at 04:45:37PM +0800, Shengjiu Wang wrote:
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_asrc.c     | 40 ++++++++++++++++++++++--------------
>  sound/soc/fsl/fsl_asrc.h     |  4 ++--
>  sound/soc/fsl/fsl_asrc_dma.c | 15 +++++++++++---
>  3 files changed, 39 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 4d3e51bfa949..eea19e2b723b 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -1052,16 +1047,31 @@ static int fsl_asrc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ret = of_property_read_u32(np, "fsl,asrc-width",
> -				   &asrc->asrc_width);
> +	ret = of_property_read_u32(np, "fsl,asrc-format", &asrc->asrc_format);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to get output width\n");
> -		return ret;
> +		ret = of_property_read_u32(np, "fsl,asrc-width", &width);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to get output width\n");

Similar to the comments against sound card driver:
"failed to decide output format"

> +			return ret;
> +		}
> +
> +		switch (width) {
> +		case 16:
> +			asrc->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
> +			break;
> +		case 24:
> +			asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
> +			break;
> +		default:
> +			dev_warn(&pdev->dev, "unsupported width, switching to 24bit\n");

Should match what the code does after the change:
+			dev_warn(&pdev->dev,
+				 "unsupported width, use default S24_LE\n");

> +			asrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
> +			break;
> +		}
>  	}
>  
> -	if (asrc->asrc_width != 16 && asrc->asrc_width != 24) {
> -		dev_warn(&pdev->dev, "unsupported width, switching to 24bit\n");
> -		asrc->asrc_width = 24;
> +	if (!(FSL_ASRC_FORMATS & (1ULL << asrc->asrc_format))) {
> +		dev_warn(&pdev->dev, "unsupported format, switching to S24_LE\n");

Could fit 80 characters:
+		dev_warn(&pdev->dev, "unsupported width, use default S24_LE\n");

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index 5fe83aece25b..b15946e03380 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c
> @@ -230,10 +230,19 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
>  		return -EINVAL;
>  	}
>  
> -	if (asrc->asrc_width == 16)
> +	bits = snd_pcm_format_physical_width(asrc->asrc_format);

Can we just use 'width' to match the function name?
