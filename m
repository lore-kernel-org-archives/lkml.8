Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBB5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658FD206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T7yeJuzz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgBNORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:17:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33071 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbgBNORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:17:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so4973678pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=76JpXRWS3a2ABcUF6vWy9HDRZvc+hNwLnaKgXe8RuAI=;
        b=T7yeJuzzh3K1vLn8EbNBqnwsROHUoo7JAuFO2lfAi/M9FGp05QdjtlRKRIaW6kz+QA
         j1aBkAbc/kbGlTkKVndGe6TTW/WIto0NBk340o5Eu0J8w5IctHiKj00LkC6RhuMXMHyC
         02X9Rd1PY0OWnHCWchXDkOeseUL+RBCx64kPQc3fXCq26P5YhdchWt1Nqd476EwPZVED
         afnHKQlvu9WzWxrc97n0LaUvCyx5ARwBJtJNAo1LcWnjMaIjWigYWr2lbjsbDQoWSKvv
         qpbD98HgYf3Cgo7j6UUM+EYCo1qb5Fe8F4Ho1CF+E7b3/jLic1oi5zXCrtdY9wLIYgxY
         AwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=76JpXRWS3a2ABcUF6vWy9HDRZvc+hNwLnaKgXe8RuAI=;
        b=oJFBQVL4F7pe2v0Lb7U/v41EdDyBb5o8Y2QrNjzOHA9YuhRBLOmuYsmcqq6EACrf6m
         aN9PdX1P8yqH80dt6sOlfB+shFV6qC9/e55BrOQQ5ZjW+FS8wTCaAnz1ASF0YhM4xj+J
         Op4Ngr1kyzEhYMMvpaNJ45/IShffkZYJTMSiil7+Oleo2xGJNUJ+JQ2sq362xDU50Fyx
         jkPJO00OiuJcNP1CPELczaqoVASeRpNR2POEdM+JLaQNnD5d0wWnsRxWo3+7XcZk6Nux
         0Iv8Qe/BAWiCuGoG80P9jZhnnNzBjNcss3nSJfD5faHnXgo7FRZBNL9nF8MthKrYNwvK
         LqRw==
X-Gm-Message-State: APjAAAU31ffE5//W1tCPadl+6yq3Ia2NkljeMGq4hGaCwegsRm7Mo99a
        cQ5h10pPvOyy8ObmWOaPq5vQCJWUjQ==
X-Google-Smtp-Source: APXvYqxYdTLclVLetZph+T3I3PhZRBBc7kOHye8qPgArAilW71/kx17mkRrpQINw3y89d4QYXJ2Y3g==
X-Received: by 2002:a65:641a:: with SMTP id a26mr3686775pgv.425.1581689841979;
        Fri, 14 Feb 2020 06:17:21 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:482:690f:50bb:adfb:86f:a4bf])
        by smtp.gmail.com with ESMTPSA id c11sm7295050pfo.170.2020.02.14.06.17.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:17:20 -0800 (PST)
Date:   Fri, 14 Feb 2020 19:47:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: owl: Improve owl_timer_init fail messages
Message-ID: <20200214141714.GA30872@Mani-XPS-13-9360>
References: <20200214064923.190035-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214064923.190035-1-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the patch!

On Fri, Feb 14, 2020 at 03:49:23AM -0300, Matheus Castello wrote:
> Adding error messages, in case of not having a defined clock property
> and in case of an error in clocksource_mmio_init, which may not be
> fatal, so just adding a pr_err to notify that it failed.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
> 
> Tested on my Caninos Labrador s500 based board. If the clock property is not
> set this message would help debug:
> 
> ...
> [    0.000000] Failed to get OF clock for clocksource
> [    0.000000] Failed to initialize '/soc/timer@b0168000': -2
> [    0.000000] timer_probe: no matching timers found
> ...
> 
>  drivers/clocksource/timer-owl.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-owl.c b/drivers/clocksource/timer-owl.c
> index 900fe736145d..f53596f9e86c 100644
> --- a/drivers/clocksource/timer-owl.c
> +++ b/drivers/clocksource/timer-owl.c
> @@ -135,8 +135,10 @@ static int __init owl_timer_init(struct device_node *node)
>  	}
> 
>  	clk = of_clk_get(node, 0);
> -	if (IS_ERR(clk))
> +	if (IS_ERR(clk)) {
> +		pr_err("Failed to get OF clock for clocksource\n");

No need to mention OF here. Just, "Failed to get clock for clocksource"
is good enough.

>  		return PTR_ERR(clk);
> +	}
> 
>  	rate = clk_get_rate(clk);
> 
> @@ -144,8 +146,11 @@ static int __init owl_timer_init(struct device_node *node)
>  	owl_timer_set_enabled(owl_clksrc_base, true);
> 
>  	sched_clock_register(owl_timer_sched_read, 32, rate);
> -	clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
> -			      rate, 200, 32, clocksource_mmio_readl_up);
> +	ret = clocksource_mmio_init(owl_clksrc_base + OWL_Tx_VAL, node->name,
> +				    rate, 200, 32, clocksource_mmio_readl_up);
> +
> +	if (ret)
> +		pr_err("Failed to register clocksource %d\n", ret);
> 

Do you want to continue if it fails? I'd bail out.

Thanks,
Mani

>  	owl_timer_reset(owl_clkevt_base);
> 
> --
> 2.25.0
> 
