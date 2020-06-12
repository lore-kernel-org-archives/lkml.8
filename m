Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE46CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7199207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrnP4M4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLT35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLT34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:29:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F827C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:29:55 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so4771770pfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4a2Pl1CFSq1GWe8QgYdCA4ph+xymGtgDfDZzT+4IG4=;
        b=MrnP4M4KchL7FJOLTbUbPeOpodea9cEMKXenI/A9XfvsliD4gdI1bSGbPo1HCq+PeH
         oUhU47XbIwNvM0D9ph7ctwVBwr6W40VlCNZqs43FVd5nzcvHLD8M3/uHBHRYkXCtQEHA
         cxH82FsGLEeN7WqHFmUaIBmBaCyCejKE+QWjR20w+l2Bu/ILF2kFdtUMYtYx8UjGpkZN
         wUnCINgTl53WsnF/rjdzmuwWp7QCP+QFIaJdK85+DncHWScwDNghqbdUEfYwLtmHe+XC
         MiRMHphwN+URaJvMgL+HNSAasFx3k3VYwsdevmtFcSaot4+UFugcdAPD0ynpq9es6vxi
         WVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4a2Pl1CFSq1GWe8QgYdCA4ph+xymGtgDfDZzT+4IG4=;
        b=kL7PKeqhIX5If4eBfPfsjMJfTf5d8RPMmMgBk3ShWJPHB2o73riXpjelVDKxkV47f7
         J5XVDEKkrpB7buoKlsFU49ZqQ+A9qSxNjyOoH1SgCEMJT0KH4WTsGW0fhN4gJBhMTlsU
         AT7D5Kfk+gK53oOyAyJZ2tM5cq2hZS1p5CHOjwI47U0JjBZZPzoVLO9bUV8Dl31eLJ5d
         bwJ0dmbrE3WIHOAVZ/fY2doOrds2u4pA58Co6/mtBMxJU3r3qUEU2lzMq2sLmH9e4XtS
         zHTmybIWVmgzgM4kOtKxkxKBRQAYFt5Vo2Uy3JbgW2JAtQqqj+poztx75YJN/zj6IP1U
         5vzg==
X-Gm-Message-State: AOAM530VDc2LoL+cABvXtKcgTPu+NXE5kJsCE650t/NKWKfJJrJCVlHB
        6avSDdChNJDKAX/cPJxj/lQ=
X-Google-Smtp-Source: ABdhPJwseWqOvjBDHGRP7yoAe1UiXi1K4/GCKgBeAGhWekH7P5Vblc/Zm0oGbIJRoz6jgvwLhh+5gA==
X-Received: by 2002:a65:5349:: with SMTP id w9mr12392157pgr.281.1591990194780;
        Fri, 12 Jun 2020 12:29:54 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c1sm6977123pfo.197.2020.06.12.12.29.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 12:29:54 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:29:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200612192942.GA26587@Asurada-Nvidia>
References: <1591690768-1691-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591690768-1691-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:19:28PM +0800, Shengjiu Wang wrote:
> For mono channel, ssi will switch to normal mode. In normal
> mode, the Word Length Control bits control the word length
> divider in clock generator, which is different with I2S master
> mode, the word length is fixed to 32bit.
> 
> So we refine the famula for mono channel, otherwise there
> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/fsl/fsl_ssi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index bad89b0d129e..e347776590f7 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -695,6 +695,11 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  	/* Generate bit clock based on the slot number and slot width */
>  	freq = slots * slot_width * params_rate(hw_params);
>  
> +	/* The slot_width is not fixed to 32 for normal mode */
> +	if (params_channels(hw_params) == 1)

This function has a local variable that you can reuse here:
	unsigned int slots = params_channels(hw_params);

> +		freq = (slots <= 1 ? 2 : slots) * params_width(hw_params) *
> +		       params_rate(hw_params);

We have a small section of slots and slot_width calculation
at the top of this function where we can squash these in.
