Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3C420644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8SbpV8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgFOXJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:09:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:09:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g12so7480533pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CZIooZOYrM4oHys2Fguf/RcobpmlQgsMJE5D3+t8a3E=;
        b=s8SbpV8WwE+0uXdhNI+KLlpCRXLu8JhAicTSsZd0QWEyp3xzmM+kv6/b09cNFeZR9b
         NyDyr9O3fHTyZZJbC35tGVkkhhhK4fQrNJKWcNsYu1cqWPa2Nz8U4H8G8oMx1/titCIq
         vcri45A7ClhV3TX54H+qbPHW+B7ZDeh0gkkggjoSwyWs2jF2GB8i5k3qHHKv8cndJBg+
         TLQZ+Rmd/pUaljPEbAAPV2TfUCqTa10psxgQqGI6kclZPUFV4zdvu09hIwCikTBLrFqD
         fjjTXYau6ovMG3DnPd9pHdBQcwxKgHebLUrUIckOzZroEG5NFovC9Qt/FA7t3JC07Dax
         8ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CZIooZOYrM4oHys2Fguf/RcobpmlQgsMJE5D3+t8a3E=;
        b=BmN5P5FrbNlOxQUonLdartuZi7dhwLryhtwKd5GgSm5OcMcRfXUXpK1lyYSugJ+dhf
         gkDjQOZ7AZ0acvnsUNKr8xrzhzA/8DNBRJzhCWAcFR3HNH+9rq4X+ouxa1JYYYSztBa5
         SwN4UP8g5AhwFLiHDEJ29R0VW7XAhZcMuDhQCHJCcQzF13zB4qwLGfrm3XGXxW8so1yk
         sZb/3OD78MtInsHhqBYKQAhryfJCI9LFiSKQXPo9X3U2t7WbiO9WqHlXM+l92MKawVRC
         sz8q6lEVusweyO4gvrqqQJhFnII5tzrWWeeTs4jSEMHU4+lUx9lvg0XPR2VelfulMwMb
         P+rg==
X-Gm-Message-State: AOAM530MXHumZ5Rc/kmrFKqCIrWPatN/ZG7VuV3jBf1O2z4YwgJvOmvB
        RmxmnQI2KJDExvpiGz5NrgU=
X-Google-Smtp-Source: ABdhPJzYmMCqNo7Tvi3y7s2FcqEPRPMQmasSc/gLlXeb0diBiZXjM3JRbdNbuH7POcVtectfAliYtA==
X-Received: by 2002:a17:90b:18c:: with SMTP id t12mr218974pjs.53.1592262570188;
        Mon, 15 Jun 2020 16:09:30 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u4sm466277pjn.42.2020.06.15.16.09.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 16:09:29 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:09:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200615230912.GA16681@Asurada-Nvidia>
References: <b5cf5e3cc39c62f6bb3660b7588b037ffc57f780.1592200690.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5cf5e3cc39c62f6bb3660b7588b037ffc57f780.1592200690.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 01:56:18PM +0800, Shengjiu Wang wrote:
> For mono channel, SSI will switch to Normal mode.
> 
> In Normal mode and Network mode, the Word Length Control bits
> control the word length divider in clock generator, which is
> different with I2S Master mode (the word length is fixed to
> 32bit), it should be the value of params_width(hw_params).
> 
> The condition "slots == 2" is not good for I2S Master mode,
> because for Network mode and Normal mode, the slots can also
> be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
> to check if it is I2S Master mode.

The fsl_ssi_set_bclk is only called when fsl_ssi_is_i2s_master,
though I agree that that line of comments sounds confusing now.

> So we refine the famula for mono channel, otherwise there

famula => formula?

> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> - refine patch for Network mode and Normal mode.
> 
>  sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index bad89b0d129e..cbf67d132fda 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -678,7 +678,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  	struct regmap *regs = ssi->regs;
>  	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
>  	unsigned long clkrate, baudrate, tmprate;
> -	unsigned int slots = params_channels(hw_params);
> +	unsigned int channels = params_channels(hw_params);
> +	unsigned int slots;
>  	unsigned int slot_width = 32;
>  	u64 sub, savesub = 100000;
>  	unsigned int freq;
> @@ -688,9 +689,15 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  	/* Override slots and slot_width if being specifically set... */
>  	if (ssi->slots)
>  		slots = ssi->slots;
> -	/* ...but keep 32 bits if slots is 2 -- I2S Master mode */
> -	if (ssi->slot_width && slots != 2)
> -		slot_width = ssi->slot_width;
> +	else
> +		/* Apply two slots for mono channel, because DC = 2 */
> +		slots = (channels == 1) ? 2 : channels;
> +
> +	/* ...but keep 32 bits if I2S Master mode */
> +	if ((ssi->i2s_net & SSI_SCR_I2S_MODE_MASK) != SSI_SCR_I2S_MODE_MASTER ||
> +	    channels == 1)
> +		slot_width = ssi->slot_width ? ssi->slot_width :

This looks very complicated...can you review and try mine?
(Basically, take 32-bit out of default but force it later)

@@ -678,8 +678,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
        struct regmap *regs = ssi->regs;
        u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
        unsigned long clkrate, baudrate, tmprate;
-       unsigned int slots = params_channels(hw_params);
-       unsigned int slot_width = 32;
+       unsigned int channels = params_channels(hw_params);
+       unsigned int slot_width = params_width(hw_params);
+       unsigned int slots = 2;
        u64 sub, savesub = 100000;
        unsigned int freq;
        bool baudclk_is_used;
@@ -688,10 +689,16 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
        /* Override slots and slot_width if being specifically set... */
        if (ssi->slots)
                slots = ssi->slots;
-       /* ...but keep 32 bits if slots is 2 -- I2S Master mode */
-       if (ssi->slot_width && slots != 2)
+       if (ssi->slot_width)
                slot_width = ssi->slot_width;
 
+       /*
+        * ...but force 32 bits for stereo audio. Note that mono audio is also
+        * sent in 2 slots via NORMAL mode, so check both slots and channels.
+        */
+       if (slots == 2 && channels == 2)
+               slot_width = 32;
+
        /* Generate bit clock based on the slot number and slot width */
        freq = slots * slot_width * params_rate(hw_params);
 
