Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A766DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FxZt9q69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgD3OrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbgD3OrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:47:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB9DC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:47:08 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so5942000qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQZ8f3nWspkcMVyQxaM9lki0jYoUn+ENmpwlQM54tJI=;
        b=FxZt9q69WeDISYW/u+FapX+g4AcoQ60SHR3rObRVjDCxZJ6UlTOi0dDCo80/JgOZxn
         DXt30paSE9HJByZpd9MN/9bqoaSpWnTTzk8huYKSl43IenhzSPYC/6nqzrHL/ZM7l3m0
         ZYx4yU6m6RbIlqhaO29As71mAiNpfB+eFLqeN8uhtMe8aNYNMnCt2+mMYYBBP3BK56ls
         5xIIg/Rbx93ERJ0KI+y9BtFSxWflV/zzBmS6MLyPYWkeJj0lVjQfi/iAxyBdd07EIs6i
         MUrvs4ayiVBB0q/LP8J/0bQNgyfH/yXLTdnOQbJAEkTzD6vHAusumKAYkH7MyPfImSVN
         UqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQZ8f3nWspkcMVyQxaM9lki0jYoUn+ENmpwlQM54tJI=;
        b=BXgwSZcNnTFpJ2B73aXx2pdspg4UXrj+KeWZEU3zlvTx8TmInV0H3iE5EPfgDffqMX
         Qj2HQtvSwW0650BcL3rJGKsTmC39H3Kg00TFxgYBivPoJqUMqKrhbfAgmYCxan7qANYe
         PrldHEx5w1/Pjg+1DSfRo7uW9tSHz8K+3nSV/tQt7A1JEwH4gb87imQoDltQNwxb8Zkc
         yBgHe3xHWj26XpV92X3Tv19kV4MqpMExKfQbzSZOwAzBFVbZnfQdeuXVGNmCYY5NAs5N
         Zl4dZg6DcL4grfUlKmMXJWHDEmXbcr7jouosczr0Lk2BogfbJTcks3U0xYdLPEirVwuU
         wTRg==
X-Gm-Message-State: AGi0PuYhFbvRIrCvk5HvB9mvGZhED7X8BrGIT0Zg4bbszqqEUfCeFeIs
        hpfRflVdzJLwBzPIatcCnCAjSEtgWZxNInZGyTgJALlOmxQ=
X-Google-Smtp-Source: APiQypI4BcCVLkg5AN9fc3sf6hgpcY3Uycdlk5eEMR0cZLkzEcOAknCav+JRxX81uhcEm63uJ9YZeUIFuFufJtosWy4=
X-Received: by 2002:a37:4792:: with SMTP id u140mr2610211qka.327.1588258027121;
 Thu, 30 Apr 2020 07:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200430095325.111441-1-zong.li@sifive.com>
In-Reply-To: <20200430095325.111441-1-zong.li@sifive.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Thu, 30 Apr 2020 22:45:47 +0800
Message-ID: <CAHCEehJ2pbGUe79Kq6q5DFSHNWwg0FEOinqqL=PRNmTt1nT_kg@mail.gmail.com>
Subject: Re: [PATCH] riscv: force __cpu_up_ variables to put in data section
To:     Zong Li <zong.li@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zong Li <zong.li@sifive.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8830=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Put __cpu_up_stack_pointer and __cpu_up_task_pointer in data section.
> Currently, these two variables are put in bss section, there is a
> potential risk that secondary harts get the uninitialized value before
> main hart finishing the bss clearing. In this case, all secondary
> harts would go through the waiting loop and enable the MMU before
> main hart set up the page table.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/cpu_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index c4c33bf02369..0ec22354018c 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -15,8 +15,8 @@
>
>  const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;
>
> -void *__cpu_up_stack_pointer[NR_CPUS];
> -void *__cpu_up_task_pointer[NR_CPUS];
> +void *__cpu_up_stack_pointer[NR_CPUS] __section(.data);
> +void *__cpu_up_task_pointer[NR_CPUS] __section(.data);
>
>  extern const struct cpu_operations cpu_ops_sbi;
>  extern const struct cpu_operations cpu_ops_spinwait;

Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
