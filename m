Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087B8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D172D20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qECpGkVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG0A4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 20:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgG0A4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 20:56:40 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20390C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 17:56:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k1so8196273pjt.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9VytBfcaiiwF/SVBWcvrj4CgGXad34ZD6/IzLtTN6BY=;
        b=qECpGkVDv2cow+e4GmXBbUtYwC2BxMmasbbOkXzXC7gU3EnKJiQrQUcAu0XkqsTpOC
         fNV/XKKsMoVQazhJZMbF13OfNde2LKYJ6yZgLqG4SvH2h/tpIP1KXfgtpxmSHrAchFwH
         WUkP2EXnU4NOvRq9EO84tuWkBUbCqLK6kVzooFZTCZQAHOF6QjQ+UyFvv2sTqqvoGNDR
         6WwJ1U7hbYF2979H608Y7jli0PJGd7skrHfasilFDLh77gMysD4ADYn4sRaxLkkIZ3pz
         AiOM3jwD1JYr1H/cguYxLEcWe/x+pbdfnBGoIzt6NYAz66CXYDgTaz693+Cuz7d3jcdv
         OMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9VytBfcaiiwF/SVBWcvrj4CgGXad34ZD6/IzLtTN6BY=;
        b=Y8om9XIszsFrmkm60J9qIPDh+LsickqVvbYJD+WYj6735/tycCmQZjJ358xRntt6wL
         FWRWsAW+EWHajtR0gs8CUZV9C+MlSW4CfDyJRmenGszs9HeT0chpNR6lmyqLdx52+Ciq
         gnsRYwiMivObm4ewhAMkfW7iYyPnAFF9533pf+KeBMNPkJmSXnPLcdz9QorTc2JTrdTd
         QwwvZ8JGClnaBd4Kt85wBe+8nMmgEaz3x+Gq5nZerijO0rePDq6a09jlUac75ekVYLtd
         7o/0xzFaGmN7aOJbzk/IP+NFu73Wzv1NI0HqMuAhq6Wu0g4cvVH77j14Ct4niJTvlRLM
         bSvQ==
X-Gm-Message-State: AOAM533OjQK997iDc53pZYfR0eZV7JH0iJ1FCivFMj2Lc85NZ19NJjFZ
        WT7yIsP96Df+vEFdqhAKPPY=
X-Google-Smtp-Source: ABdhPJxjbwFwZRPOhq8ClPjborSekOfOe3pyNf+GPEnnAFAc44svuxU+ktHfX7yMtMp1WpWUDb709Q==
X-Received: by 2002:a17:902:988b:: with SMTP id s11mr16232999plp.229.1595811399410;
        Sun, 26 Jul 2020 17:56:39 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id k23sm12499712pgb.92.2020.07.26.17.56.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 17:56:39 -0700 (PDT)
Date:   Sun, 26 Jul 2020 17:55:59 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level
 function
Message-ID: <20200727005558.GA30124@Asurada-Nvidia>
References: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595762417-2190-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 07:20:17PM +0800, Shengjiu Wang wrote:
> With this case:
> aplay -Dhw:x 16khz.wav 24khz.wav
> There is sound distortion for 24khz.wav. The reason is that setting
> PLL of WM8962 with set_bias_level function, the bias level is not
> changed when 24khz.wav is played, then the PLL won't be reset, the
> clock is not correct, so distortion happens.
> 
> The resolution of this issue is to remove fsl_asoc_card_set_bias_level.
> Move PLL configuration to hw_params and hw_free.

Hmm...using set_bias_level() instead of hw_params/hw_free() was
strongly suggested by Mark when I got imx-wm8962 machine driver
upstream. So we will need his input here, although I personally
don't have a problem with it...

> After removing fsl_asoc_card_set_bias_level, also test WM8960 case,
> it can work.
> 
> Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 149 +++++++++++++++-------------------
>  1 file changed, 66 insertions(+), 83 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 4848ba61d083..0517dbb3e908 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -73,6 +73,7 @@ struct cpu_priv {
>   * @codec_priv: CODEC private data
>   * @cpu_priv: CPU private data
>   * @card: ASoC card structure
> + * @is_stream_in_use: flags for release resource in hw_free

Would love to see something shorter... Could we reuse similar
one below, borrowing from fsl_ssi driver?

 * @streams: Mask of current active streams: BIT(TX) and BIT(RX)

>  static int fsl_asoc_card_audmux_init(struct device_node *np,
>  				     struct fsl_asoc_card_priv *priv)
>  {
> @@ -611,7 +600,6 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	/* Diversify the card configurations */
>  	if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
>  		codec_dai_name = "cs42888";
> -		priv->card.set_bias_level = NULL;

Can check if set_bias_level is still being used with this change.
