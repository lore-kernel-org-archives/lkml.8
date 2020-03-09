Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B308C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795AA2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc3f2TGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCIVS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:18:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38435 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIVS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:18:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so4520021plz.5;
        Mon, 09 Mar 2020 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=75BMaXcAmO4F5Wh+UkrqpyAJEuiai75tQOLAGLzUruc=;
        b=Mc3f2TGua+mzWZqhqcBFy8xGR4f62bMfkZ533/dtz8uiLUdJhj/KUeALKn1cfWNrgL
         fIQti2Sr9jF85Y+rnxx4+60P16SUP3noRF2AljLUI1D2TFMmP1bonRiTwzjx4xNJ9Qwe
         5ZwVhdVsIL82iYY0GFFZP9ck6Ccro9zA/NCVMYqPyiZzOtN5c7Gv+TLxZguS9lB7Xon4
         hDadFff6ReYzd5WneH3sHbliE6rYSdrwuC0imPmRhArAKnt1MskwGQAGVLXRnAlhKQtL
         kwBImHlUMMDcum7ZL8MZBJ/YPV3RAGp0y3mQHGzC9a7UWHTJnrktv2CJw6iWWZrfotr5
         SlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=75BMaXcAmO4F5Wh+UkrqpyAJEuiai75tQOLAGLzUruc=;
        b=es/4Wbht8DaJxxvMiMaa35I1G40wlVuWeZavxp9DNxEds2cFBV+F70eJtjTuEv+Ct2
         i/i6jYnfO6Y4eONLgCmGFOliLUVI52U1muyHEaU/+9gEeGmAMxQ4ggVqNOVM+AtSqhVA
         pAh1pmbcA15Zg9kTtRzCqfKME4u2GIvchg8+hvJJ2Cw0iBWWXvS2Y4fzU8wvBxhK5CPG
         wJLhOF/aMnliY2tEraLZB1g4sPMUN3N1BDwOGAikwjFaQqCqzDj2Sup/DNZndcbms1Ho
         yXEbOOkHz9VzkWeW5eumZcQRuGfg+hiINPM1h35sCo9PuA7CEaXMynjBYMd4JPb5lvX1
         pnvA==
X-Gm-Message-State: ANhLgQ2fY0+KSU9ELtKJ2eHE22yub4lKCBGBTJhaRWXByKTovFU+GBdj
        tIy4UC4B7BjcF9RaEoGgcNg=
X-Google-Smtp-Source: ADFU+vt2yYWX7gJknQLuNcwuQzhGdS8aInh7+JZ9Mbaq0Z7M0IITbFjuVTv3VCNQfp0cXyneROITtg==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr17943042plt.2.1583788704865;
        Mon, 09 Mar 2020 14:18:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u24sm44614851pgo.83.2020.03.09.14.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 14:18:24 -0700 (PDT)
Date:   Mon, 9 Mar 2020 14:18:32 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] ASoC: fsl-asoc-card: Support new property
 fsl,asrc-format
Message-ID: <20200309211831.GA11333@Asurada-Nvidia.nvidia.com>
References: <cover.1583725533.git.shengjiu.wang@nxp.com>
 <266dccc836c11165ad91a301f24fe4f7ad2557be.1583725533.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <266dccc836c11165ad91a301f24fe4f7ad2557be.1583725533.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:58:29AM +0800, Shengjiu Wang wrote:
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 9ce55feaac22..32101b9a37b9 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -680,17 +680,19 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  
> -		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +		ret = of_property_read_u32(asrc_np, "fsl,asrc-format", &priv->asrc_format);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to get output rate\n");

Nice that your patch fixed my copy-n-paste typo here :)

> -			ret = -EINVAL;
> -			goto asrc_fail;
> -		}

It'd be nicer to have a line of comments:
			/* Fallback to old binding; translate to asrc_format */

> +			ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +			if (ret) {
> +				dev_err(&pdev->dev, "failed to get output width\n");
> +				return ret;
> +			}
>  
> -		if (width == 24)
> -			priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
> -		else
> -			priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
> +			if (width == 24)
> +				priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
> +			else
> +				priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
> +		}
