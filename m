Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873AFC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DED220656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHayiyg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGPXUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgGPXU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:20:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AABC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:20:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cv18so3446134pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rRlvvHVOlssZOjqWIkzRzCMnvlmtUd7Tnvbrt5nzg9E=;
        b=eHayiyg0bfJPU1GbuLYA++YcuhbGdyxqWe29Vgabr+F//AYpjSn5hx+bdQvykpDmsc
         ezsY+2hZn+5I7jW0hkEAVggqN2D1cABrwQQ1q1jdU9obkJLL5ze9Cv5A0xsfXpFZfjqo
         gajcWV9fpnCR9mpdItqaY1+cFqI+OC3yuo9qcpH69Fg1SZS9t8nAJN3ZsRrct2vVjaye
         //CVtLwhW8SMwVwggvOItzEYVUWRWUC28SBV/Bem0hfFp2g20SIgJKyU/VBeVAqn9/8l
         IScUuZSAgaFQypVHjyJ2AYP5k/PTvyLAtyC+ZIy2gLxHfdbl9vspQM3mNujgf4GtaFJH
         lsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rRlvvHVOlssZOjqWIkzRzCMnvlmtUd7Tnvbrt5nzg9E=;
        b=DR5DkHgw5OEZokoMsiKiQ+9LsJGoxB6521SlmVMiWzr4xff0wofSfG4g50g4pYWTmP
         FPxySnhHQbVeOtZT31ThgHl8FE7BwAICv4MCd7N/lpG+3q6JWBnjsMRYTRV4dKkQwTc0
         +TEGEyKY1GOVgs6NMCRxyGHhRBIdb1UwDZSMjH8qshTwAhxkEsLVheyKWFJw9TELP9fQ
         D8zk6HlYTe4y9I9wMlcchFR9kxKmTduDjynfBUw6Af59xGF4uubcmPLQri+Bk6pCf4k2
         3pWFw8/Pn6MtVMmpr0u/2+TNnKs2RU+jNqmVWpCRvN2e7/2r0E3Oh1kRoUJbTEy3DR5c
         Ir0A==
X-Gm-Message-State: AOAM532hdP6OZ6S34S9BC8AvzAP9IaKk2DaZqTsn/IMcwrAQZ9/0SrRu
        NqrH2A8fpXWqIrv2EG/5F1/Owb4uTvMK8Q==
X-Google-Smtp-Source: ABdhPJwccEGhJhK3ui84CiJebJJII81e0U4AhifSXr6ZP/zd5rdwyPeQYX8mPtghFCLxzkHPX38VBQ==
X-Received: by 2002:a17:90a:7c4f:: with SMTP id e15mr6671510pjl.133.1594941628897;
        Thu, 16 Jul 2020 16:20:28 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id nk22sm912733pjb.51.2020.07.16.16.20.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jul 2020 16:20:28 -0700 (PDT)
Date:   Thu, 16 Jul 2020 16:20:02 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/2] ASoC: fsl_asrc: make sure the input and output
 clocks are different
Message-ID: <20200716232000.GA27246@Asurada-Nvidia>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-1-arnaud.ferraris@collabora.com>
 <20200716151352.193451-2-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716151352.193451-2-arnaud.ferraris@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:13:52PM +0200, Arnaud Ferraris wrote:
> The current clock selection algorithm might select the same clock for
> both input and output. This can happen when, for instance, the output
> sample rate is a multiple of the input rate.

What's the issue when selecting the same clock source for both
input and output? Please explain it in the commit logs.

> This patch makes sure it always selects distinct input and output
> clocks.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  sound/soc/fsl/fsl_asrc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 02c81d2e34ad..6d43cab6c885 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -608,8 +608,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  {
>  	struct fsl_asrc_pair_priv *pair_priv = pair->private;
>  	struct asrc_config *config = pair_priv->config;
> -	int rate[2], select_clk[2]; /* Array size 2 means IN and OUT */
> -	int clk_rate, clk_index;
> +	int rate[2], select_clk[2], clk_index[2]; /* Array size 2 means IN and OUT */
> +	int clk_rate;
>  	int i = 0, j = 0;
>  
>  	rate[IN] = in_rate;
> @@ -618,11 +618,12 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
>  	/* Select proper clock source for internal ratio mode */
>  	for (j = 0; j < 2; j++) {
>  		for (i = 0; i < ASRC_CLK_MAP_LEN; i++) {
> -			clk_index = asrc_priv->clk_map[j][i];
> -			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
> +			clk_index[j] = asrc_priv->clk_map[j][i];
> +			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index[j]]);
>  			/* Only match a perfect clock source with no remainder */

Better to update the comments here as there's a new condition.

>  			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
> -			    (clk_rate % rate[j]) == 0)
> +			    (clk_rate % rate[j]) == 0 &&
> +			    (j == 0 || clk_index[j] != clk_index[j-1]))

clk_index[j - 1]
