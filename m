Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1428BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C29204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQiJm1Kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQGZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFQGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:25:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B06C06174E;
        Tue, 16 Jun 2020 23:25:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z63so632013pfb.1;
        Tue, 16 Jun 2020 23:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g3cuqw1MSyXPgpwfSctF0q4VjJu4I8Z3M0GkPzhFPXI=;
        b=uQiJm1KvSqhA+U+Rmq7T3vkBhQwaFWZe2j+ocuj3Vyq/u5pzs6ioJ5ccCn8x/fmbEk
         D+mupFc9PdPKhEnu1tBz8N1ZZRdzgRAEzCjKOiA97ngMztK5FiGeVm4aRe75tjg0YbGp
         beCEtKsmaET3KAIu2Hhw5+9wPy8altJfh0fqp+zladWB7rbFOuJgZu/BoqesFJSj9yPO
         wS3XiFM3c2jEVKpX3kaEDLiFyLTovbRh7asyxqnc+wiPfm/W6LdLkaHS+6KTKCpVYBx9
         +NzUfWKIgMxbggZA7xXMfMp1PDcG7A/ZMLCuz5MZ2NHbTeEPgcU8cJUvsmuASmXRA+X8
         HHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g3cuqw1MSyXPgpwfSctF0q4VjJu4I8Z3M0GkPzhFPXI=;
        b=EhM2E8wkhz8ujrdINrEHXngtG0OzMhS9sQDNIfhFb3wCAG99w/S5EQOGbREbNCgCVX
         MWBMyp0tAjt1XDBRKV2s2b9c+7S/lGCjd8kdLs9CajfN4jHGwRQkoA4m/0lJzx4NH+Zj
         5/tbzgnsMMxC05tBiRT/jcGorOjX2E/lMOGAoVWeyRfkzGlNq557xgLectu9SLDiGb94
         q0us0T/52NbTjNRDIdkCr5kZfg4BvhqTn2LTUGE0lEwGqGwK6p1+Ku4RxCMW2pxsp/6V
         iuLwq8UgKv0e4cO7ST45Cf0ZofsU8ryEoMADlKtkgEktKd7t5u+t0fqGIqtAF0cW/ZAD
         uDGA==
X-Gm-Message-State: AOAM533/HWObW4rtxukvL+CJgiD0n6jAe6+7I63cZ56ImVlESWl62e7V
        strWrF9GuoK9H4DLlMQZoVE=
X-Google-Smtp-Source: ABdhPJw1gU2G4M0g+SAUSO6VDblRQx1jBiF2PJ3y6iajq5no77C2746qSL/0k/jfXmN6z06pyK6esA==
X-Received: by 2002:aa7:9aee:: with SMTP id y14mr5269735pfp.105.1592375116437;
        Tue, 16 Jun 2020 23:25:16 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id j36sm3305919pgj.39.2020.06.16.23.25.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jun 2020 23:25:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 23:24:58 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
Message-ID: <20200617062457.GA6411@Asurada-Nvidia>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
 <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:30:17PM +0800, Shengjiu Wang wrote:
> The one difference on imx6sx platform is that the root clock
> is shared with ASRC module, so we add a new flags
> "shared_root_clock" which means the root clock is independent,

"shared" means "not independent", against "independent" ;)

> then we will not do the clk_set_rate and clk_round_rate to avoid
> impact ASRC module usage.
> 
> As add a new flags, we include the soc specific data struct.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Can add this once fixing the remaining comments:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

> +static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif,
> +					      int clk)

Can actually merge into single line as kernel has 100-character
limit now, though 80-char is still preferable for a good coding
style. But I think this one wouldn't be too bad at all.

> @@ -421,7 +456,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	sysclk_df = spdif_priv->sysclk_df[rate];
>  
>  	/* Don't mess up the clocks from other modules */

We can drop this comments now as it's out-of-date and the name of
the new helper function is straightforward enough.

> -	if (clk != STC_TXCLK_SPDIF_ROOT)
> +	if (!fsl_spdif_can_set_clk_rate(spdif_priv, clk))
>  		goto clk_set_bypass;
>  
>  	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
