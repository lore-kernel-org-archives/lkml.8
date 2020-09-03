Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9E2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FC52072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvyXWN2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgICDlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICDlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:41:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C207C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:41:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so969680pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBeaj4GslqMe7lBSDn/HfENqDsSeU06fhFfemnqQHrs=;
        b=lvyXWN2OCgC6gJzpb3Z1iQXwUlrghIjBMO3LVlTBotvEtrri2tbmSI+QbAcu9NNk+3
         xD8WkDH7VB8w5fWoJFXkRBzc6PwVWRVy2CJUBQwZYa+AHVfTiful/lvI21qyMGPcvK9M
         fRdJGomPzh9cVQIQcRRGEZqV+JcnfruIZJ3P2I0lLoNGHtL0uSEONY/cCPrIpb/ZMLMr
         fYLJRqg+xeZaD6sTMJmxwfsj5i+S8j0b7uUkgTEuoWYkV32rXAgx8QfhbHwd2EwLMx7R
         FqSaz/cd0d69vDp4XhTzuBrNYbnu0CwDJ7pkkTdVqAWh2TN8FU2N43NAbqKJ9hYpBixf
         YZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBeaj4GslqMe7lBSDn/HfENqDsSeU06fhFfemnqQHrs=;
        b=HRK/iFAmwenuVyjMHwKdYqVU9avXPpBNZV90SFLjkRtwA1vvafDOUBRzMWRSnWWABY
         +DgfCudnEwuYvzerosfFML9cRK5jducDLu1uxULOGZL+JS105pTyvEnxVjGmyEPRTcBP
         pqWKafAFLDTHieccyVSmjoi3MNLog2Ml+Dgrx9vio9Hsmd2t1NYL2cYFWptMFsIDApB2
         GsXpby7hWVsylz30nkEY1ZHeb11RWOQZO3F9aeJIJ4hpUFX6tKJbUW12KLrspIv9iN07
         Cfd1yp9onuWpBelHrDLNvXknUzBRdz5gunKwUmBX7Q+BEHbVIXP0+Url1H56qashMPIG
         6Z1Q==
X-Gm-Message-State: AOAM531vtUQRCFEDt4jbJsdqQlXd9uNhh3TFXFGZ0ouPWDdwk/miGOZ7
        AEO/Lk29GOhwLE8sI6N8FA8=
X-Google-Smtp-Source: ABdhPJya4MbfYMPJGamccyeZvWUKTgUg99OxovxOa46VtlzI1OXbxU1wx4FTT7tNScnfNz4lR9HKCg==
X-Received: by 2002:a63:4a09:: with SMTP id x9mr1069530pga.291.1599104463748;
        Wed, 02 Sep 2020 20:41:03 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 187sm1067061pfx.174.2020.09.02.20.41.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 20:41:03 -0700 (PDT)
Date:   Wed, 2 Sep 2020 20:40:19 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-ID: <20200903034018.GC4517@Asurada-Nvidia>
References: <1599102555-17178-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599102555-17178-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 11:09:15AM +0800, Shengjiu Wang wrote:
> Transmit data pins will output zero when slots are masked or channels
> are disabled. In CHMOD TDM mode, transmit data pins are tri-stated when
> slots are masked or channels are disabled. When data pins are tri-stated,
> there is noise on some channels when FS clock value is high and data is
> read while fsclk is transitioning from high to low.
> 
> Signed-off-by: Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Though one nit inline:

> ---
>  sound/soc/fsl/fsl_sai.c | 12 ++++++++++--
>  sound/soc/fsl/fsl_sai.h |  2 ++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 62c5fdb678fc..33b194a5c1dc 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -486,6 +486,12 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  
>  	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
>  
> +	/* Output Mode - data pins transmit 0 when slots are masked
> +	 * or channels are disabled
> +	 */

Coding style for multi-line comments. Yet, probably can simplify?

	/* Set to output mode to avoid tri-stated data pins */
