Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E77520735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 05:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AnMCjUrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEDFg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgEDFg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:36:56 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 22:36:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r66so5695566oie.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 22:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEr7VDGO1sQzOvtIGcTs52hYhp3KlihYjjFwOGOE52E=;
        b=AnMCjUrc0dEBsDtyieZcjRyaWh1ZyG7DB345/RKRwunS9IbLIl18twCJWYDSN1f092
         M+39bCI4yvuMpohhu1PNnD5u4xGLJkdXBH8HGV9aN3NKRyM+x7PhL2wqb7fUdEqfSp2G
         EMFjB0nmBOpmz1FQ5lOB6Gg0RlZuz5dTYZYSHUfdX2CjGWT8Bn11GpCCF6FGOWIzLVlQ
         1mJ/ECtrVccBsw+S6DXsG6y0VmYSx8lOQyhEHD/s8//lfppknEQzqLzgvY59saAigEbN
         4+3P9sKuuzp5/wijfK1HjOZXqjJmmXFr/GsS8M0DI4H2KfG8Wfq/9ZYAQ5NRQlK/BuGf
         kvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEr7VDGO1sQzOvtIGcTs52hYhp3KlihYjjFwOGOE52E=;
        b=akdyaiWDB/1sb6inxCqFcDrzEQUZJFIUcxq68Rdc+fRNMCXTq0OXV4EW0NE+VACHnD
         +3+Vxizo2OKwh/yPjEGkFX9Q/It8/ivGcLKW0b8GJplhz65szAfVLkDyZ/BRPCkOBG7g
         Tt3aU71x/LDjVj8z0uCRsyxv2OqvM31y5NWa/zi/K2eGU+4lfOcW6eRWtnWMgeOn9YO6
         U/N9wnQvarq+/epq1qNVXJ0KWd7RI4YUXM5eK8IlOqkOiSi0e23/wECXUpvtiykz4CGg
         Fj5zEAbNsqL3JmTweEat91bRm/hoWHbCkTzYhR0dDR5LMcuQUnwTTM6HELP1B15xDj2n
         DIdg==
X-Gm-Message-State: AGi0PuYb85jJM0oi9rNuVx81jGvmOimI7lcV0DLvHhclGSGiHFwAMkwz
        7IL8RtQcl6Hj2l6lwpqE4mIvj9PQnoOuX5X+G+U90Q==
X-Google-Smtp-Source: APiQypIId44/BH5hF7x7zP3LxhrtvZZiDqySLw/fVersvjCbMawM6wZqXjmgu2YmTBc1Sm0vf9NHdFnE+jVSZSHQVss=
X-Received: by 2002:aca:c78d:: with SMTP id x135mr7835649oif.91.1588570614459;
 Sun, 03 May 2020 22:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200504040319.31423-1-atish.patra@wdc.com>
In-Reply-To: <20200504040319.31423-1-atish.patra@wdc.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 4 May 2020 13:36:43 +0800
Message-ID: <CANXhq0qrnS5DFC4sTHP1aBKd-32rjvzGBV4O56Fq4JujR5b7PQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 12:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> This patch removes the unused functions set_kernel_text_rw/ro.
> Currently, it is not being invoked from anywhere and no other architecture
> (except arm) uses this code. Even in ARM, these functions are not invoked
> from anywhere currently.
>
> Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b55be44ff9bd..ba60a581e9b6 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
>  #endif /* CONFIG_MMU */
>
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void set_kernel_text_rw(void)
> -{
> -       unsigned long text_start = (unsigned long)_text;
> -       unsigned long text_end = (unsigned long)_etext;
> -
> -       set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> -}
> -
> -void set_kernel_text_ro(void)
> -{
> -       unsigned long text_start = (unsigned long)_text;
> -       unsigned long text_end = (unsigned long)_etext;
> -
> -       set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> -}
> -
>  void mark_rodata_ro(void)
>  {
>         unsigned long text_start = (unsigned long)_text;
> --
> 2.26.2
>

Looks good to me. Thanks.
Reviewed-by: Zong Li <zong.li@sifive.com>
