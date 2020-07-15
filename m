Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC37C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A282065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfhBj627"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGOUsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOUse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:48:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A213AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:48:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so3688784pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwtQ+qIZRMu1aHjFHPtF40fPrwJ9tfeRwj/jvnsJYBE=;
        b=WfhBj627Y0WOtyr1wRjCUf4CYVWiv9xzOas2x0/JPpSflqWZmNEp95WvwJiPslkU2d
         Kios/eGN2XcbMmUIQ9klS1VhHOTkfjtPmpIyJJFaAHb8FJTBq5kGR2CZ5/HY+l2RjpVi
         i2grx16HFurjU299NUhstWKgdpL5bNT08QT9ZevBaeFxDI/+RZ00qhq2VPxTxwsiKmce
         UdGnoQzlQXNtlhig++nO4/kAuwBPXjZL9/gLz8HWgggqzUUDW+WHz1bxHPcvq1ta8lSr
         6+f9FCbLIynLkNZbyxGHPGbSHsrIRaKOoIb8D841N/GpaWFnWcg4hUlqmD0RJpDt+jrL
         bWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwtQ+qIZRMu1aHjFHPtF40fPrwJ9tfeRwj/jvnsJYBE=;
        b=lEdiy4XyhrbGGJScG6MhH43PY4ou1Hq1U8bXEnEx67mlcleVBb3oPuchOHPkr847nN
         VVDo9VXNqwZDR2F53vopI8NtdpxNqENEgyddbchHe5+lhN79Q36i3wd71MipgdW+mzgR
         Te1ke16H825JAUx5YjKlZ/V/IvQnL1rj/d9KAiB6avr4u/J01cwXYwqT8w8TPWwOn45X
         1AJnW62qskgJ5uJQEUuqRvjFqokpAP7VeyXH7hGua5iHXMJFRQPgvxzyqqNKp8sf/mcZ
         E7QG2tLKf+M3Ocnnd0oqt6W3jkbmHk0apZc/Rz+mXYswocU0Em3aw1E2dWL4W1QXIJAJ
         JM7Q==
X-Gm-Message-State: AOAM530VUdBELtvWyhemNV3cxp5w6YiOtGaNQ20luD81x+i2j0HzBTLs
        KIe0f6WWv7xMNPfkbpw/Yr4=
X-Google-Smtp-Source: ABdhPJz1GJ2Ik7lZDPIUXV5ePwyu/YwogLbPU4apDaOlkhisq+aJKtFRAA1r//dZtZBvcY/zN4hOBQ==
X-Received: by 2002:a17:90a:a413:: with SMTP id y19mr1460097pjp.59.1594846114095;
        Wed, 15 Jul 2020 13:48:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id w9sm2983563pja.39.2020.07.15.13.48.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 13:48:33 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:48:09 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix
 misspelling of 'exists'
Message-ID: <20200715204809.GA14565@Asurada-Nvidia>
References: <20200715150009.407442-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715150009.407442-1-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:00:09PM +0100, Lee Jones wrote:
> Cc: Timur Tabi <timur@kernel.org>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index faac6ce9a82cb..dbacdd25dfe76 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -92,7 +92,7 @@ struct fsl_asoc_card_priv {
>  };
>  
>  /*
> - * This dapm route map exits for DPCM link only.
> + * This dapm route map exists for DPCM link only.
>   * The other routes shall go through Device Tree.
>   *
>   * Note: keep all ASRC routes in the second half
> -- 
> 2.25.1
> 
