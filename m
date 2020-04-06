Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C516EC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B49206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0jnGpAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDFW7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:59:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44594 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDFW7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:59:46 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so458167plr.11;
        Mon, 06 Apr 2020 15:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QabBQhlHvDhp4mCqAg3c+5phsRTL1odJr+vofj/Jd6U=;
        b=N0jnGpAQZkHqM2qyCjOqgHLclBH0mnCHDoPt2hEx5cT4hQMCCfS7llAe9nHscseUpJ
         M36pwwnl+ap0A9KQ8nuvLFxWLtV9TZRXoNVMF6PLUPb8g90jUoFcpxfghOXwdwslq99v
         DY9sdaA2//pFIAFXL4OXhjlf4fx9Nk2vmjOOX05h4V/vB9WaZPNmHQL7uukQCasVjF9s
         f5Tt7K93PUsZ/BEZaB9B+nydUbQVtYFZAFIaqn92j4FsYNs6UnVHT1qnk8q8+kAYRvI3
         7/dPM94KZRoOcVwKkd0mkF+XEQm3LgglgAgeSeMlUpD/JfZ4P1cDu+b/49TQI5C6QGQB
         vtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QabBQhlHvDhp4mCqAg3c+5phsRTL1odJr+vofj/Jd6U=;
        b=Bq5rQRcYf2fq8lqc2ktHrd2rLnWNNssFMYSz3SGZv4EQTx5bvE6/urYokh6TrDyOsK
         BNhhtpO5CemlERU8ZopR6mMDPv/eL2WctQXqWlCbAhVabuxT0i0g1Vju1kxaoOcmRGqX
         BfPYD6gH3JNZMo7o/HLhHMT3i/+t+3n4YQlS0kbKdCs9xpv7x7sBBaNjkPUehSTQ03g/
         sKp26qNTR69cm/MGM9KcpqIvZYgY2ASGbVDil8Bth3mT1qqAYVJR8RQOd/aBYmLZlwFl
         ti+YztrMPfRW4GyaxocIlqbpo70LOv3/0W4HK7puP/5lVcPeE2V7QouPLmn9E1xB8Mh6
         pCCA==
X-Gm-Message-State: AGi0PubpYo2Y1nUM0v+LaeiUmbT7NnwoNr7xHodb5imtMeYPrpAxu3j1
        sp3nmmtEIELi2yg56DABJ34=
X-Google-Smtp-Source: APiQypJ1B/70Ak3FAawANFmM+3TECFxtBax+d2t7PbnhnVBThvOaaEXHLohLyb1PG3QFqsxDwm3y8A==
X-Received: by 2002:a17:90b:3c4:: with SMTP id go4mr1656393pjb.162.1586213985103;
        Mon, 06 Apr 2020 15:59:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 66sm12650177pfb.150.2020.04.06.15.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 15:59:44 -0700 (PDT)
Date:   Mon, 6 Apr 2020 15:59:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] ASoC: fsl-asoc-card: Support new property
 fsl,asrc-format
Message-ID: <20200406225949.GB20891@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <b8d6d9322e865f61f0c9cb17c69a399624e07676.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8d6d9322e865f61f0c9cb17c69a399624e07676.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:36PM +0800, Shengjiu Wang wrote:
> In order to align with new ESARC, we add new property fsl,asrc-format.
> The fsl,asrc-format can replace the fsl,asrc-width, driver
> can accept format from devicetree, don't need to convert it to
> format through width.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl-asoc-card.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index bb33601fab84..a0f5eb27d61a 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -680,17 +680,20 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  
> -		ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +		ret = of_property_read_u32(asrc_np, "fsl,asrc-format", &priv->asrc_format);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to get output rate\n");
> -			ret = -EINVAL;
> -			goto asrc_fail;
> -		}
> +			/* Fallback to old binding; translate to asrc_format */
> +			ret = of_property_read_u32(asrc_np, "fsl,asrc-width", &width);
> +			if (ret) {
> +				dev_err(&pdev->dev, "failed to get output width\n");

Should warn 'format' over 'width', since it's preferable.

> +				return ret;

Should goto asrc_fail as we did prior to the change.

And some of lines are over 80 characters.

Let's try this:
		ret = of_property_read_u32(asrc_np, "fsl,asrc-format",
					   &priv->asrc_format);
		if (ret) {
			/* Fallback to old binding; translate to asrc_format */
			ret = of_property_read_u32(asrc_np, "fsl,asrc-width",
						   &width);
			if (ret) {
				dev_err(&pdev->dev,
					"failed to decide output format\n");
				goto asrc_fail;
			}

			if (width == 24)
				priv->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
			else
				priv->asrc_format = SNDRV_PCM_FORMAT_S16_LE;
		}
