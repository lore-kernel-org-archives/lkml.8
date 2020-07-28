Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B51C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5025220714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 04:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595909413;
	bh=6WjCx9p86yw48QkeqBlnsPDOEVF7czvj6LeXQBs/i+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S6kxIvV9yn6oVF5hiNUEQCblAEZTGa7FdC6vZskxzWhQMfu0rIh3+R20Got0yoylT
	 jyjE/DHtgKzhLCfX76IKTI0iqlyYmwdbZLwW6YVhWAO4KuC2gU8p7WSPkSci4fNXlk
	 yeoQLSwE9p31gXfMzHISr0NS4NqDJLIh28uvW9GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgG1EKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 00:10:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgG1EKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 00:10:11 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF9D20714;
        Tue, 28 Jul 2020 04:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595909411;
        bh=6WjCx9p86yw48QkeqBlnsPDOEVF7czvj6LeXQBs/i+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xdUP/Vg/zGrm1cg9jqUxyH72NvvRzlftvFlJfmNbv4mklkIAJmUitpCxsAk35ZgC8
         quwg3inaTrSn38oA1BMjNGsqbdbXBKyKZ3AcsHnuNKZj0s9CSiMlZQXz5y7yCgR2Yx
         bQmAMgXy0McGx4/rxZKHketQj5iK+dW5ou2o6928=
Received: by mail-lj1-f179.google.com with SMTP id q4so19635766lji.2;
        Mon, 27 Jul 2020 21:10:10 -0700 (PDT)
X-Gm-Message-State: AOAM5327EK3rylxO99kEO6lHqjP4iL9ACzporbhOVxKLblu+99DCMiXU
        Y+bJQNqF5NxelofRRQsmjo5wCh5SEkZJbZbX42g=
X-Google-Smtp-Source: ABdhPJyDSAgz26K8vU68dxkOR3PlbcBCmPLXWLF7PPY78bP4JM0P67j4Q1wJ/tCsyd4trl+NBGId06Kk3kxxgaUqc2I=
X-Received: by 2002:a2e:b0ed:: with SMTP id h13mr10728794ljl.250.1595909409351;
 Mon, 27 Jul 2020 21:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200728033405.78469-1-npiggin@gmail.com> <20200728033405.78469-7-npiggin@gmail.com>
In-Reply-To: <20200728033405.78469-7-npiggin@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Jul 2020 12:09:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-SmgFjyU5H75=xYihwKK5tSggGXP=D_4am06-wdLM4w@mail.gmail.com>
Message-ID: <CAJF2gTT-SmgFjyU5H75=xYihwKK5tSggGXP=D_4am06-wdLM4w@mail.gmail.com>
Subject: Re: [PATCH 06/24] csky: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

On Tue, Jul 28, 2020 at 11:34 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/csky/include/asm/mmu_context.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
> index abdf1f1cb6ec..b227d29393a8 100644
> --- a/arch/csky/include/asm/mmu_context.h
> +++ b/arch/csky/include/asm/mmu_context.h
> @@ -24,11 +24,6 @@
>  #define cpu_asid(mm)           (atomic64_read(&mm->context.asid) & ASID_MASK)
>
>  #define init_new_context(tsk,mm)       ({ atomic64_set(&(mm)->context.asid, 0); 0; })
> -#define activate_mm(prev,next)         switch_mm(prev, next, current)
> -
> -#define destroy_context(mm)            do {} while (0)
> -#define enter_lazy_tlb(mm, tsk)                do {} while (0)
> -#define deactivate_mm(tsk, mm)         do {} while (0)
>
>  void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
>
> @@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
>
>         flush_icache_deferred(next);
>  }
> +
> +#include <asm-generic/mmu_context.h>
> +
>  #endif /* __ASM_CSKY_MMU_CONTEXT_H */
> --
> 2.23.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
