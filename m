Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E27FC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B1E206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK5Znhf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDFXsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:48:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42968 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgDFXsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:48:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id g6so817779pgs.9;
        Mon, 06 Apr 2020 16:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=psBSxuaBNWcdi2NVQndMbrRmw2QOSVTd4FihS4xTMPs=;
        b=sK5Znhf+DEGRMW9PNI6HsCghnazO3u7g0hr51W9/9isojiLKRVchov7ujMhuvk+wjA
         2UyAa7bidTy3ebHar7q9lCb9K5hfBqjbxwVu6RJYJNWCEYs998KAA/ccwQ5lHpvU9xK5
         n8zLnby7TbdOYK+kGmjyvzNUzF37cU2662HTXRFUFxmJY4FWhvofVewvcxT9zi1XLBit
         AoK40mxzLSXI+Pa94R3MmYxpgzvdOGOO+oPmq4oPveWUO3JlgG4EaM3ONIlVwKEfFLXC
         ol9xSkdhfYueNFiVAA+F0MijH0o4r0IPUsTuks1Ij43xYY/g8N1GEpXc2tTcDoG6U2Yp
         Ox6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=psBSxuaBNWcdi2NVQndMbrRmw2QOSVTd4FihS4xTMPs=;
        b=mW8FR9bH3D3u2e2UKHNNf5gSDXZl8kv2e8Xfh4PqEn/P2/qa5R5zeCoAoAx/7LgHtA
         7X11k2+bYVtJLZuuDH9uns3h0KtMp5Iw/6mSlqBizfpUw53Y8slZB6CWbmGqYdbdA0g9
         FdEgp2uaG04KuD1Ap77KodxC15smjZoawlPaRpcacw5IHXf4G+PArxQx98DAEuDSvlqY
         2vyJk10/aAClGIhaAVT8Uu+OQQFLN3IgWNLeY21iPH21Xf8nDsUfxl1HTdVegCwhbTxr
         JcMqr4XDY2yyHyL3ZCztlz4QRizTDrkLrCfhQFL+SrXVrDSB1+xXBQvb7ZA0PBouPgfy
         imjQ==
X-Gm-Message-State: AGi0Puboa1saUKfCSQ8V69f8Dq5hsp1b/3GlBTMsAIzzlMjhNBP7GEpC
        wZl/SwFquUAwe2otrV47SB8=
X-Google-Smtp-Source: APiQypI465/ioBR3iYY/5HiEHM/tdrYAyoPeHWSHEtbZTA997lCuyYZm02hTkj/dL+M8Q+EoyZFZdA==
X-Received: by 2002:a62:7b84:: with SMTP id w126mr1923173pfc.202.1586216895626;
        Mon, 06 Apr 2020 16:48:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w27sm12479257pfq.211.2020.04.06.16.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 16:48:15 -0700 (PDT)
Date:   Mon, 6 Apr 2020 16:48:20 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:45:38PM +0800, Shengjiu Wang wrote:

>  static int fsl_asrc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct fsl_asrc *asrc;
> +	struct fsl_asrc_priv *asrc_priv;

Could we move it before "struct fsl_asrc *asrc;"?

> diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
> new file mode 100644
> index 000000000000..5c93ccdfc30a
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_asrc_common.h

> +#define PAIR_CTX_NUM  0x4
> +#define PAIR_PRIVAT_SIZE 0x400

"PRIVAT_" => "PRIVATE_"

> +/**
> + * fsl_asrc_pair: ASRC common data

"fsl_asrc_pair" => "fsl_asrc"

> + */
> +struct fsl_asrc {

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index b15946e03380..5cf0468ce6e3 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c

> @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
>  		return ret;
>  	}
>  
> -	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> +	pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);

If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
define in this file too, rather than in the header file.

And could fit 80 characters:

+	pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
