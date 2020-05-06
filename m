Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E95C47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C0B206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 00:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="Wnv9h8DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgEFAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 20:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgEFAPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 20:15:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E739C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 17:15:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so50867wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 17:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2hLm6+zbJEAyEVfAYowpOyewzOW+kIv+YTbZQ2i84M=;
        b=Wnv9h8DFu6J1kDi8bq3i9rgHlErQOSO5b2nOTXCK2bc54VFNTOkk5Kd/ClmcCuHm4Q
         VwfRWOEr1NhchIQ8XeAqwgX4bGh1orWeSO4dAmSha799JFEOKbletI8XUJ7QmZdDatsG
         kqU09jDULZN8sx1sg/VAu8E3+7D6iQ374zGLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2hLm6+zbJEAyEVfAYowpOyewzOW+kIv+YTbZQ2i84M=;
        b=B7+XOwWcfRcLiCAnSijMTAUqgDH+LsmP3IN2mXflxZ+kex7awXg0iKbIQEYGKMAllk
         Fo2CKiR/Ogmu8D6dLZL7DM2Th7Bdke0URdzhTzMuh9dAAj1D19IjEVLDes9odTouyF0m
         O7vpw/WRzkrS7SH49zEtUsnhy7wTrXqUA8CnfCOaahG9FFOyS7onQQBAMWOIyIA8JB0W
         eAE/4j9NQpS+ZW+JikuFWOwp4AbIuKszwnYhCyMnkm9owreyjLAZ+c1gCYcwmRvLTqJ4
         q2e1wyU6AnqY8OviaLi/jP20wJolzPJEaLqqaYLcaXgGe0SzNL9kCFEXAy6i3xsDPCr4
         5Zrg==
X-Gm-Message-State: AGi0Pub3EQB0HNB4hHUOdGlReQGEfUIS9pzkkoWKyX2p1x505ri/QEg0
        yPDqd/jVLLxZAAFmu8WouU5Ewuu2DCAfN1ONvNb/
X-Google-Smtp-Source: APiQypJ1u2GBFKhtFoqPNkbEjRt4MRHKXVYXGuuImjbH5C0ppvHZvK7OPliGzhwpMWEylhO8hEeXVUJxUpx+Nj3jUXE=
X-Received: by 2002:a5d:5703:: with SMTP id a3mr6910168wrv.53.1588724150121;
 Tue, 05 May 2020 17:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOnJCUJtnVjYwfaHbiUdO4SqPk8rY0q0uYckNJpQpc7jK0Pz7g@mail.gmail.com>
 <mhng-3b48ef6b-d427-40af-b8f7-1bdccc117927@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-3b48ef6b-d427-40af-b8f7-1bdccc117927@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 5 May 2020 17:15:38 -0700
Message-ID: <CAOnJCU+LrLSbf2HqFJY6PkOYqt6_dHSj_zwKrEHYQCvmKrZQaQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Remove unused code from STRICT_KERNEL_RWX
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 5:03 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 05 May 2020 17:00:05 PDT (-0700), atishp@atishpatra.org wrote:
> > On Tue, May 5, 2020 at 4:55 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Sun, 03 May 2020 21:03:19 PDT (-0700), Atish Patra wrote:
> >> > This patch removes the unused functions set_kernel_text_rw/ro.
> >> > Currently, it is not being invoked from anywhere and no other architecture
> >> > (except arm) uses this code. Even in ARM, these functions are not invoked
> >> > from anywhere currently.
> >> >
> >> > Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
> >> >
> >> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> > ---
> >> >  arch/riscv/mm/init.c | 16 ----------------
> >> >  1 file changed, 16 deletions(-)
> >> >
> >> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> > index b55be44ff9bd..ba60a581e9b6 100644
> >> > --- a/arch/riscv/mm/init.c
> >> > +++ b/arch/riscv/mm/init.c
> >> > @@ -501,22 +501,6 @@ static inline void setup_vm_final(void)
> >> >  #endif /* CONFIG_MMU */
> >> >
> >> >  #ifdef CONFIG_STRICT_KERNEL_RWX
> >> > -void set_kernel_text_rw(void)
> >> > -{
> >> > -     unsigned long text_start = (unsigned long)_text;
> >> > -     unsigned long text_end = (unsigned long)_etext;
> >> > -
> >> > -     set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> >> > -}
> >> > -
> >> > -void set_kernel_text_ro(void)
> >> > -{
> >> > -     unsigned long text_start = (unsigned long)_text;
> >> > -     unsigned long text_end = (unsigned long)_etext;
> >> > -
> >> > -     set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> >> > -}
> >> > -
> >> >  void mark_rodata_ro(void)
> >> >  {
> >> >       unsigned long text_start = (unsigned long)_text;
> >>
> >> Thanks, this is on fixes.  Are you going to remove the ARM code as well?
> >>
> >
> > Yeah and also I realized that I forgot to remove the declarations from
> > the header file.
> > My bad. I will send out a v2. Please drop this one and take v2.
>
> I just fixed it up
>

Thanks. I was going over the code again and found one usage for
set_kernel_text_rw for ARM.
It is used in kexec while set_kernel_text_ro is not invoked anywhere.
I am not sure if it is required
for kexec implementation for RISC-V.

@nick: Can you please comment ?

> commit 73cb8e2a5863ccc5215660f5123db621bd57dff7
> gpg: Signature made Tue 05 May 2020 05:02:17 PM PDT
> gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
> Author: Atish Patra <atish.patra@wdc.com>
> Date:   Sun May 3 21:03:19 2020 -0700
>
>     RISC-V: Remove unused code from STRICT_KERNEL_RWX
>
>     This patch removes the unused functions set_kernel_text_rw/ro.
>     Currently, it is not being invoked from anywhere and no other architecture
>     (except arm) uses this code. Even in ARM, these functions are not invoked
>     from anywhere currently.
>
>     Fixes: d27c3c90817e ("riscv: add STRICT_KERNEL_RWX support")
>     Signed-off-by: Atish Patra <atish.patra@wdc.com>
>     Reviewed-by: Zong Li <zong.li@sifive.com>
>     Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index c38df4771c09..4c5bae7ca01c 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -22,14 +22,6 @@ static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>
> -#ifdef CONFIG_STRICT_KERNEL_RWX
> -void set_kernel_text_ro(void);
> -void set_kernel_text_rw(void);
> -#else
> -static inline void set_kernel_text_ro(void) { }
> -static inline void set_kernel_text_rw(void) { }
> -#endif
> -
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 5b813532db59..27a334106708 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -502,22 +502,6 @@ static inline void setup_vm_final(void)
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
>


-- 
Regards,
Atish
