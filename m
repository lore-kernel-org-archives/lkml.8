Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588D820658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4g5l41v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGNVPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:15:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518DC061755;
        Tue, 14 Jul 2020 14:15:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so8169302pfi.2;
        Tue, 14 Jul 2020 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gUsxgEIbOCPN/g+dhdnfdWC6Rsm4WcdiQ4zDxdYgS80=;
        b=c4g5l41vPTzdfvBku6Gyyd9dtF0BOhHeYH39FPISi5h5zu/7m0KQBQAauU6DRWwCNI
         aJFxK5Oqe96j7ceibK0CyVHiTNei10p4jHaC3l7OVoXMCCEeHsi/Q8ezd90xrh3x8oJ6
         UwDEyUiPh3Ja1sl8MrwnF5+o4DsaE+nx8NDmDwYw98Nea3ZKmlTfZx3CCP800NIM0SOY
         CXa3j3AUDNMdDH2KvVLhkxmyCWqXWjSov+f1nxIO31O0Gx6YS7hwxXt8puB0/xHjTd2f
         u1Y3X+ybA8mclQRcyyvl59frNzSpsGVtHfR6Mbi41HgC+bFjI9xSl+k3C4ePbPUODuiP
         oeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gUsxgEIbOCPN/g+dhdnfdWC6Rsm4WcdiQ4zDxdYgS80=;
        b=CJhBoUyDKNAruOx9OlNPhIoFgub1z5G0UVntrJbF7BH0UlDhUOHY2OeCF7qdukYk2x
         LvSLo4QvZsXPo4cY3H1bvyVPaW5XjGtG0Pi4HystgE4CjNb06GST0IMvPqXGXbzA3Ht0
         7H88S9W/E66zCuD3JQK2ALBrS6+/aljYpLFSE18PAYEDNoh3yf8dqfz0GAG/6ZfP7/bL
         h3Ihb+ActDEtzNubyiUbXcqIa9NTlT7b2S6Jc8JEm6YwpR2l2csdryfSO7bhkgfXpCyI
         NWcm9+1sQUVOIS8BiM6x7j2sMCz2Uw545aqQeq5OecsQM4a0fSKTtSCJIqRPHLW0c+6E
         4FsA==
X-Gm-Message-State: AOAM530nD/P9ReNRmgkjA3FXYbCPnY7LBZDD/Z93oh6cYwj5iMffVkWQ
        3ySCFp9XTSg2MvoKsdX6H0I=
X-Google-Smtp-Source: ABdhPJwsRQ9mKCwSTE8ucb75FPjtcLbouSD8dQj1J5mA3EExVAJ2tJ3R4hWiETcAhJVqwmV+N1o7rA==
X-Received: by 2002:a63:441c:: with SMTP id r28mr4965134pga.372.1594761309828;
        Tue, 14 Jul 2020 14:15:09 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y17sm105760pfe.30.2020.07.14.14.15.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 14:15:09 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:14:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        katsuhiro@katsuster.net, samuel@sholland.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] ASoC: fsl-asoc-card: Support Headphone and
 Microphone Jack detection
Message-ID: <20200714211432.GA10818@Asurada-Nvidia>
References: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
 <1594717536-5188-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594717536-5188-4-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

The whole series looks good to me. Just a couple of small
questions inline:

On Tue, Jul 14, 2020 at 05:05:36PM +0800, Shengjiu Wang wrote:
> Use asoc_simple_init_jack function from simple card to implement
> the Headphone and Microphone detection.
> Register notifier to disable Speaker when Headphone is plugged in
> and enable Speaker when Headphone is unplugged.
> Register notifier to disable Digital Microphone when Analog Microphone
> is plugged in and enable DMIC when Analog Microphone is unplugged.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/Kconfig         |  1 +
>  sound/soc/fsl/fsl-asoc-card.c | 69 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 68 insertions(+), 2 deletions(-)

>  static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
>  {
>  	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
> @@ -745,8 +789,29 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	snd_soc_card_set_drvdata(&priv->card, priv);
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
> -	if (ret && ret != -EPROBE_DEFER)
> -		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);

I think we may move this EPROBE_DEFER to the asrc_fail label.

> +		goto asrc_fail;
> +	}
> +
> +	if (of_property_read_bool(np, "hp-det-gpio")) {

Could we move this check inside asoc_simple_init_jack? There's no
problem with doing it here though, yet I got a bit confused by it
as I thought it's a boolean type property, which would be against
the DT bindings until I saw asoc_simple_init_jack() uses the same
string to get the GPIO. Just it probably would be a bit tricky as
we need it to be optional here.

Otherwise, I think we may add a line of comments to indicate that
the API would use the same string to get the GPIO.

> +		ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
> +					    1, NULL, "Headphone Jack");
> +		if (ret)
> +			goto asrc_fail;
> +
> +		snd_soc_jack_notifier_register(&priv->hp_jack.jack, &hp_jack_nb);
> +	}
