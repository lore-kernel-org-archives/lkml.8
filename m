Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DC3208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jeG4FjV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFQGaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgFQGaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:30:11 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25386C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:30:11 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id j202so715943ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xyNqLKkTkvhzaA5WIPNmUhrKUCZ/UNf8ZXPhmsM3X28=;
        b=jeG4FjV0hqv4kB0BcxsmpyNd4zjKL6ficNUfH93IC2J1884QNcosr9HycGBrsTPv/q
         LmSvrISeT8v6kC4YnEGAlsIZmgfxXlMMWN10yCoXrOe6ZHWndNq0GtrPoKIojS58AhQZ
         pxJgXPdE4QFzmV7iebWvHWUn9aZ9Bk/u8Zh4pFFNJaZN5oXsjH/1crWyAAyKzrZzkzKG
         z8micmgTnmFlVMl2AMmykSHgc+m2QzKEmbXOlh9jIEF4SgI9srlGewJ6IUgGK7yo8wbI
         GOt47oJjXfy23FPYiDT6T5KM0LWxai87OTjEkl3UD7r6ukE3gbkHGuRM2ijvG2lu/Z3p
         t4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xyNqLKkTkvhzaA5WIPNmUhrKUCZ/UNf8ZXPhmsM3X28=;
        b=Ndb9vCrKA6EVUvWlhfaGCyiE1ZJShXSqjvZrAWvwPi6lxirjy8kIXPcbHcPaACbZaD
         JGHGYjxmrlyaeAC1ADZY0D31HTqDrjfvck+wJPu0JtacZOHK6xfPDDO7Yhj3xgxfJyCM
         2CL1mj+Ntt+Lll1aJlMgEyDzUjbvDyifPrTLZV43BDl2BQs4ZWjIuaPPfwVq3LEFsJAW
         ywnCyOnaI7siGQiGlEuwXDqECdWtTdD/ky/jxmjU3KRQkxTRPIkxBTXXwYbaDLTCLItz
         r4V533MBaaxIiazXTIhPJru2gPrglF2rJb14Fl5Lz6mpAc+UkYPQWkJ7fuWBgybHHzvT
         JK5g==
X-Gm-Message-State: AOAM532I9MrotwTQqQ6iHATnPp0EDEXKghuk3/Gedbo4bPqCTt7AI1NO
        sjgvU7VGg56cju3j2YJQUARFEltzC3XC3qE8SHgNSC7Hds4=
X-Google-Smtp-Source: ABdhPJyafZnN0ctIFbYd/5SRMcYycPseuNzhF5a0gXfZLMaBVK661uHzzcWhI4C66oUf5llSdJqZ2D3pLGub+3UYvZc=
X-Received: by 2002:a25:2f4f:: with SMTP id v76mr10953670ybv.7.1592375409854;
 Tue, 16 Jun 2020 23:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200616045108.GP75760@lianli.shorne-pla.net> <mhng-b86477b3-4134-4023-968e-532ca0b33125@palmerdabbelt-glaptop1>
 <CANN689GkUUfpTn+fkjsC-a=RwGsxVwsg-QXKDnVe6zXLjvuZWA@mail.gmail.com>
 <20200616191943.GA1401039@lianli.shorne-pla.net> <CAOnJCUL52Ch3QHikik=DYJYciFE0e8zhrSL-AgaZPensXyZqyg@mail.gmail.com>
 <CANN689Ek3szVSVC4H0NKpkdZes82VW_Xvs4+GLTGCWES7A-ySQ@mail.gmail.com>
 <20200617053539.GB1401039@lianli.shorne-pla.net> <20200617060734.GC1401039@lianli.shorne-pla.net>
In-Reply-To: <20200617060734.GC1401039@lianli.shorne-pla.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 16 Jun 2020 23:29:56 -0700
Message-ID: <CANN689F=LKGprNx9_Wb5HOvT-Fvv8WUR_T2DJPhy0u2HeT-A7g@mail.gmail.com>
Subject: Re: mm lock issue while booting Linux on 5.8-rc1 for RISC-V
To:     Stafford Horne <shorne@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 11:07 PM Stafford Horne <shorne@gmail.com> wrote:
> On Wed, Jun 17, 2020 at 02:35:39PM +0900, Stafford Horne wrote:
> > On Tue, Jun 16, 2020 at 01:47:24PM -0700, Michel Lespinasse wrote:
> > > This makes me wonder actually - maybe there is a latent bug that got
> > > exposed after my change added the rwsem_is_locked assertion to the
> > > lockdep_assert_held one. If that is the case, it may be helpful to
> > > bisect when that issue first appeared, by testing before my patchset
> > > with VM_BUG_ON(!rwsem_is_locked(&walk.mm->mmap_lock)) added to
> > > walk_page_range() / walk_page_range_novma() / walk_page_vma() ...
> >
> > Hello,
> >
> > I tried to bisect it, but I think this issue goes much further back.
> >
> > Just with the below patch booting fails all the way back to v5.7.
> >
> > What does this mean by they way, why would mmap_assert_locked() want to assert
> > that the rwsem_is_locked() is not true?

It's the opposite - VM_BUG_ON(cond) triggers if cond is true, so in
other words it asserts that cond is false. Yeah, I agree it is kinda
confusing. But in our case, it asserts that the rwsem is locked, which
is what we want.

> The openrisc code that was walking the page ranges was not locking mm. I have
> added the  below patch to v5.8-rc1 and it seems to work fine.  I will send a
> better patch in a bit.
>
> iff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index c152a68811dd..bd5f05dd9174 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -74,8 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
>          * We need to iterate through the pages, clearing the dcache for
>          * them and setting the cache-inhibit bit.
>          */
> +       mmap_read_lock(&init_mm);
>         error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
>                         NULL);
> +       mmap_read_unlock(&init_mm);
>         if (error)
>                 return ERR_PTR(error);
>         return cpu_addr;
> @@ -85,9 +87,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
>  {
>         unsigned long va = (unsigned long)cpu_addr;
>
> +       mmap_read_lock(&init_mm);
>         /* walk_page_range shouldn't be able to fail here */
>         WARN_ON(walk_page_range(&init_mm, va, va + size,
>                         &clear_nocache_walk_ops, NULL));
> +       mmap_read_unlock(&init_mm);
>  }

Thanks a lot for getting to the bottom of this. I think this is the proper fix.
