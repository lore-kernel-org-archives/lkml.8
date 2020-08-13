Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE8F20639
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="UvMOetG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgHMFmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMFmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:42:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A23BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:42:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so3950891wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pO83i01MAyD94ySqpQBUGi1TfGYRhwJn4iuYrQxpj8s=;
        b=UvMOetG8xfT+hNTYbhURfXf/xX2xdzUfhZuAo8WFAxQaBFBFQ2j+CJqZ1sTU18QBeo
         ZjNnRLtZwsC8zZqohO/kBjQBYy/KL/a7eSzt3kC3NFACa87pWVcwXrKDu6fvBVDwzY35
         jqzSL3LMijIrfIvVeCxAJJsm8rlpo182KHa/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO83i01MAyD94ySqpQBUGi1TfGYRhwJn4iuYrQxpj8s=;
        b=iv6SksIXRDLjmla01YLAihzaPauFzFDDilb+DL3lZNhI1rzbCj/hL0t4N4qeGncpkF
         V77CIPImE7iaSCYlIR4cCIWRXJ9/iadJuprUacldBVT9o3Ab/Tf4qRg8gwo+GJ96Qzt0
         sDKbnHk15NCluIDa+RGKBACAG5IJMeQALA6WfD/vB3KxDzzc/YVpwIuATjEcfQNWWLr6
         jw+gs/9CBt/OBguyHGJ/vkHCkHeVuR+SklzuK1bLeOeswhELEljV5QeNB1f1Y6ScYJDH
         2UUC3bL3t0r4cn0HG53v2MhCDTNshmatbCa45BRNjA+ANTBS3Vj1lND+UNQu/CYqBYyT
         12iQ==
X-Gm-Message-State: AOAM530pzHL4K4v5MQ6+Wlve18UwWbpTHBV58Yo3VHOPDa/TNKd+AfEw
        hqqkUC6NDyM8NhW40PO+AUDRrVQDfX2Ve9pqENLF
X-Google-Smtp-Source: ABdhPJyNBSrjkfumnP0doFOfQZ3WewhpNshS2jsvT1AWk7RGbMk0hLP766JXhK7xK+N9BGMOr9zbixnw3xipzzkJ5kQ=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr2653434wmh.55.1597297365586;
 Wed, 12 Aug 2020 22:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
In-Reply-To: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 12 Aug 2020 22:42:34 -0700
Message-ID: <CAOnJCUJzLfbMgdyYY58ssQGyJaX9KJJ-MjHKPnOK=gcdRvPk8A@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Setup exception vector for nommu platform
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 8:40 PM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>
> Exception vector is missing on nommu platform and that is an issue.
> This patch is tested in Sipeed Maix Bit Dev Board.
>
> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> Suggested-by: Anup Patel <anup@brainfault.org>
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> ---
>  arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index d0c5c316e9bb..0a4e81b8dc79 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -77,16 +77,10 @@ relocate:
>         csrw CSR_SATP, a0
>  .align 2
>  1:
> -       /* Set trap vector to exception handler */
> -       la a0, handle_exception
> +       /* Set trap vector to spin forever to help debug */
> +       la a0, .Lsecondary_park
>         csrw CSR_TVEC, a0
>
> -       /*
> -        * Set sup0 scratch register to 0, indicating to exception vector that
> -        * we are presently executing in kernel.
> -        */
> -       csrw CSR_SCRATCH, zero
> -
>         /* Reload the global pointer */
>  .option push
>  .option norelax
> @@ -144,9 +138,23 @@ secondary_start_common:
>         la a0, swapper_pg_dir
>         call relocate
>  #endif
> +       call setup_trap_vector
>         tail smp_callin
>  #endif /* CONFIG_SMP */
>
> +.align 2
> +setup_trap_vector:
> +       /* Set trap vector to exception handler */
> +       la a0, handle_exception
> +       csrw CSR_TVEC, a0
> +
> +       /*
> +        * Set sup0 scratch register to 0, indicating to exception vector that
> +        * we are presently executing in kernel.
> +        */
> +       csrw CSR_SCRATCH, zero
> +       ret
> +
>  .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart */
>         wfi
> @@ -240,6 +248,7 @@ clear_bss_done:
>         call relocate
>  #endif /* CONFIG_MMU */
>
> +       call setup_trap_vector
>         /* Restore C environment */
>         la tp, init_task
>         sw zero, TASK_TI_CPU(tp)
> --
> 2.28.0
>
@palmer: Can you queue this for the next part2 PR ?

Reviewed-by: Atish Patra <atish.patra@wdc.com>
-- 
Regards,
Atish
