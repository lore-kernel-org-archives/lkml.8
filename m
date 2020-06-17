Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7608DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396032098B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="andbOErg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFQAtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQAtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:49:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6882C061573;
        Tue, 16 Jun 2020 17:49:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so392129pgu.13;
        Tue, 16 Jun 2020 17:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qm0blJqnv9I61KRJJiBPA33J2Aw0IBsqKNB8aVPh6EU=;
        b=andbOErg6vHaVvZwsZ5AQQOmi8cnqX78ltCWGPVM0y3E4tFLZGGOK6qjkD7yGu0Hxn
         OohchWNrpk77aQXwkddEUJKsh/OkVMqWgcGUL0dVmqsKNzutldsaMZkAPZtcnJdLF25M
         b6JDWGZcCyvi2lCTvhIz9wnNdetyiOWupqtdp2uMI6KXIr0kVueuVJ3zc55kYZw/50Nr
         SfMjqQ+xj3MEVowUilpsfvy3rDZeVwhvHroSWywepJ+MG9kRywebgbm03v6eo+ij+LhA
         jSBP+uXU+K5y1+7NmJBqLV2YesfQF6fdnMmZ4oVAuoIjs/iHgi5h9P30gsTPtML8Kx6b
         8byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qm0blJqnv9I61KRJJiBPA33J2Aw0IBsqKNB8aVPh6EU=;
        b=msrAYoSg2/vlLpjzxEJp7snWgZP200bZFTV/sf3S52cnW9iYqRMK07HRVghhFfDTqx
         Gsxud+BAmAOrztWf8zOwLgGkMH6VSl6R1heDo+U86UdSZ2fKriUet3GOC81+56GvsH7R
         amyzNMMdFUfw+QFEbJaY5znOTeQ8WLAoVNk6565hDABOD9AlQvBrPHHGxdI1vMmcvc1U
         xOVhXAGxwRGEr+795u2m5r87R57GHH4YZQXAsOZuFDuQi4+sxuIFNy/EkqG2qF/uqgAJ
         3k4HrkSChp+6JDlpv05TWEH43KpjBHFPrc578LK5OOHXk4RT/j4JcWfEplr/ucuPKfbK
         rwvA==
X-Gm-Message-State: AOAM533TLpnvSBcw+tzh48dKVUifLb4SHatzDEWTsHVR5svWysjuN2ke
        gNDcssQ6lcKideKlWhc3aSw=
X-Google-Smtp-Source: ABdhPJz65jhSqLsQAU9g8oW3jm/d4pDNC49/CvWZhBX+8bG7IjvN5c7fILW3zJY3g7Bev/JmV1mBMQ==
X-Received: by 2002:a63:5b04:: with SMTP id p4mr4356358pgb.315.1592354943128;
        Tue, 16 Jun 2020 17:49:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id i196sm1591208pgc.55.2020.06.16.17.49.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 17:49:02 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:48:47 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: fsl-asoc-card: Add MQS support
Message-ID: <20200617004845.GB19896@Asurada-Nvidia>
References: <1592292637-25734-1-git-send-email-shengjiu.wang@nxp.com>
 <1592292637-25734-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592292637-25734-2-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:30:37PM +0800, Shengjiu Wang wrote:
> The MQS codec isn't an i2c device, so add a new platform device for it.
> 
> MQS only support playback, so add a new audio map.
> 
> Add there maybe "model" property or no "audio-routing" property insertions

"Add" => "And"

> devicetree, so add some enhancement for these two property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 70 ++++++++++++++++++++++++++---------
>  1 file changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 00be73900888..2ac8cb9ddd10 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c

> @@ -482,6 +489,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  {
>  	struct device_node *cpu_np, *codec_np, *asrc_np;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct platform_device *codec_pdev = NULL; /* used for non i2c device*/

Having both codec_pdev and codec_dev duplicates things. Actually
only a couple of places really need "codec_dev" -- most of them
need codec_dev->dev pointer instead. So we could have a cleanup:

-	struct i2c_client *codec_dev;
+	struct device *codec_dev = NULL;

> @@ -512,10 +520,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	}
>  
>  	codec_np = of_parse_phandle(np, "audio-codec", 0);
> -	if (codec_np)
> +	if (codec_np) {
>  		codec_dev = of_find_i2c_device_by_node(codec_np);
> -	else
> +		if (!codec_dev)
> +			codec_pdev = of_find_device_by_node(codec_np);
> +	} else {
>  		codec_dev = NULL;
> +	}

Here can have something like (feel free to simplify):

	if (codec_np) {
		struct platform_device *codec_pdev;
		struct i2c_client *codec_i2c;

		codec_i2c = of_find_i2c_device_by_node(codec_np);
		if (codec_i2c)
			codec_dev = &codec_i2c->dev;

		if (!codec_dev) {
			codec_pdev = of_find_device_by_node(codec_np);
			codec_dev = &codec_pdev->dev;
		}
	}
>  	asrc_np = of_parse_phandle(np, "audio-asrc", 0);
>  	if (asrc_np)
> @@ -525,6 +536,13 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	if (codec_dev) {
>  		struct clk *codec_clk = clk_get(&codec_dev->dev, NULL);

Then here:

-  		struct clk *codec_clk = clk_get(&codec_dev->dev, NULL);
+  		struct clk *codec_clk = clk_get(codec_dev, NULL);

> @@ -538,6 +556,11 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	/* Assign a default DAI format, and allow each card to overwrite it */
>  	priv->dai_fmt = DAI_FMT_BASE;
>  
> +	memcpy(priv->dai_link, fsl_asoc_card_dai,
> +	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));

> @@ -573,13 +596,25 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		codec_dai_name = "ac97-hifi";
>  		priv->card.set_bias_level = NULL;
>  		priv->dai_fmt = SND_SOC_DAIFMT_AC97;
> +		priv->card.dapm_routes = audio_map_ac97;
> +		priv->card.num_dapm_routes = ARRAY_SIZE(audio_map_ac97);
> +	} else if (of_device_is_compatible(np, "fsl,imx-audio-mqs")) {
> +		codec_dai_name = "fsl-mqs-dai";
> +		priv->card.set_bias_level = NULL;
> +		priv->dai_fmt = SND_SOC_DAIFMT_LEFT_J |
> +				SND_SOC_DAIFMT_CBS_CFS |
> +				SND_SOC_DAIFMT_NB_NF;
> +		priv->dai_link[1].dpcm_playback = 1;
> +		priv->dai_link[2].dpcm_playback = 1;

dpcm_playback = 1? That's the default value in fsl_asoc_card_dai.

> @@ -601,19 +636,18 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		priv->cpu_priv.sysclk_id[0] = FSL_SAI_CLK_MAST1;
>  	}
>  
> -	snprintf(priv->name, sizeof(priv->name), "%s-audio",
> -		 fsl_asoc_card_is_ac97(priv) ? "ac97" :
> -		 codec_dev->name);
> -
>  	/* Initialize sound card */
>  	priv->pdev = pdev;
>  	priv->card.dev = &pdev->dev;
> -	priv->card.name = priv->name;
> +	ret = snd_soc_of_parse_card_name(&priv->card, "model");
> +	if (ret) {
> +		snprintf(priv->name, sizeof(priv->name), "%s-audio",
> +			 fsl_asoc_card_is_ac97(priv) ? "ac97" :
> +			 (codec_dev ? codec_dev->name : codec_pdev->name));

We can just use dev_name() if codec_dev is struct device *
Or having a codec_dev_name to cache codec_pdev/i2c->name.

> -	ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
> -		goto asrc_fail;
> +	if (of_property_read_bool(np, "audio-routing")) {
> +		ret = snd_soc_of_parse_audio_routing(&priv->card, "audio-routing");
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to parse audio-routing: %d\n", ret);
> +			goto asrc_fail;

Hmm...audio-routing is a required property in DT binding doc.
So you might need to update that too.
