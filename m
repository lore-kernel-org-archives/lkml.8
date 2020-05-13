Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C41C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF5F206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="iFgMMOoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgEMVeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728711AbgEMVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:34:14 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECDC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:34:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u15so341312plm.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=LQvZ3cnoxWWWtAQPX/y16TnIryLF7O8ppBXXbOpkfJE=;
        b=iFgMMOoReZ85Q2Uo0jGImdbsoBegv49w87WiEqZhNYhvoog2bsz4o7CTmTLm4XieeO
         ftN9bDcc6DdF8g75K7+/B8AxEBdwcSwArR3cx8osqD/HZUKQIL30MKHIyvE4kfLfZv0e
         WHs5SKUsoKUegLPENvjP/IrrAoV/vZo88hU1ekN0L5yIyZDqBURGPxKqPWHQBxUH5AU8
         O/q8slAIWWgn4KCx7SlRdflaVne3T6kK9DAH6MJ+jYRcrlWjnvxApbpGt2v0ozBMIoy7
         kLowFy2v1voohCXt+Xyvm16PrqX4LdZu8yaSd82XbS4SewWsn9iTNMhbX/pZv0X57lK+
         jh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=LQvZ3cnoxWWWtAQPX/y16TnIryLF7O8ppBXXbOpkfJE=;
        b=d0/QDQsHhOOynYU0b86Jep9ccijKOaewISS49iP8gDk7o5dneteKEgjEe0ueo7stBt
         82Uj/P5qdRV7YpsyOD+wY3t4tQVLy8l13Oqz6KCEDmu4fAg269ocoXbXlEUmoZEEO9wt
         z7KM9ubN8ZPN3gzHi4zloTfO+rbFYhmYuvYTXOyTehR4C63hmIpjEvdxx84YQ9/ydTJ6
         34Jotss9+K3v+6aQR+k7cau2VAPKcohbXo6T/lUUUYf6P9K9mzdUavm9eNrhfVqjdHE8
         Ia0CfPU5xEomQ5rbFUpvmpUmqU+Lw02I4m+tlMpx1d+32+4u65naNx7uU/DdLqGgmiF6
         GJbQ==
X-Gm-Message-State: AGi0PubAI8GKV8D+XSM687JWLB6oMrAdrRlar3ExlquPqLTlz26AlojE
        BjUkcZYMyeBWxa+ZxE8hRoFLyYnxoR4=
X-Google-Smtp-Source: APiQypJZ5JtNOolKe9h9jvBj34XsfS2ZZKsgyQ9Jm2zRk6dWIknX6wZjxyDaGNCHsu/j+99GbU5+gg==
X-Received: by 2002:a17:90a:4e5:: with SMTP id g92mr36920442pjg.148.1589405652819;
        Wed, 13 May 2020 14:34:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id r21sm16167599pjo.2.2020.05.13.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:34:12 -0700 (PDT)
Date:   Wed, 13 May 2020 14:34:12 -0700 (PDT)
X-Google-Original-Date: Wed, 13 May 2020 14:33:02 PDT (-0700)
Subject:     Re: [PATCH] irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts
In-Reply-To: <20200512172636.96299-1-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, wesley@sifive.com,
        Atish Patra <Atish.Patra@wdc.com>, jason@lakedaemon.net,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>, Mark Zyngier <maz@kernel.org>,
        tglx@linutronix.de
Message-ID: <mhng-c1cfbecd-9399-4bcd-97d4-c5eb5692d1ed@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 10:26:36 PDT (-0700), Atish Patra wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
>
> A PLIC may not be connected to all the cores. In that case, nr_contexts
> may be less than num_possible_cpus. This requirement is only valid a single
> PLIC is the only interrupt controller for the whole system.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> [Atish: Modified the commit text]
> Signed-off-by: "Wesley W. Terpstra" <wesley@sifive.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index d0a71febdadc..822e074c0600 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -301,8 +301,6 @@ static int __init plic_init(struct device_node *node,
>  	nr_contexts = of_irq_count(node);
>  	if (WARN_ON(!nr_contexts))
>  		goto out_iounmap;
> -	if (WARN_ON(nr_contexts < num_possible_cpus()))
> -		goto out_iounmap;
>
>  	error = -ENOMEM;
>  	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm assuming this is going through the irqchip tree.

Thanks!
