Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C6C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96232065F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="aspgwufK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgGYFo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGYFo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:44:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA7C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:44:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so10025818wrl.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PQj9ccC0T2ST2ZfkavHWQYqC20FZrWjTgxjI2qSwG4=;
        b=aspgwufKMWdT6LlSIycvc/mF1mibIXRjxegLhn49Q5PoMmwE2OKL3fRADw0prXS4XX
         ITB9g3RiUJUzOEgdB62lp8+qwK7HZahaElH1RP2PQdW/yWVyEy/CNzmB0nf+JmA4udpi
         c4nKcAjQjs4kuuOVxHfvDdzpazgVaiXjxWvwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PQj9ccC0T2ST2ZfkavHWQYqC20FZrWjTgxjI2qSwG4=;
        b=HxFD96KSnMaVSnkhWjsjwg+4BgH6k7xihLtWjU6yfs9fvk1jAdbSGI3iYlsOak/vsM
         nuJvjsqDaYOA5KpA8qbDyq+ODuH8UZhqsIQtCY0rqzl0fOqJbbaRMN7gYNTBiI2XuzTN
         vKF1hqlUROIeT4MsiAKPGm9l2+w1DTiv0EnZ+1cmxpMSl3/E00fI64CCPfDARgHFgVys
         Fq72oaUygNkYQYM3wKeOBHOqtSs2t3awsPdcgaBRA5Xl7a6/PjuqFu4TBimkTL4fOdds
         VOfolgP4AYuppDmn9BX/FN+9heuHMtAmwGpRWbhPnJ/xfwvX5N5AvYKolVys0x7EoWpm
         QNJA==
X-Gm-Message-State: AOAM531hLP3sv2v44NmN4jz+DOvdNRMv72y8k+xVyYsdiPndepbCjD/m
        hSTVK1geczShrh9MoksiEI5yyopX0fop1eWbuuKeodui4bQt
X-Google-Smtp-Source: ABdhPJyNZe0Ag8eKYvy84kgqtogkTSDSPqOHPMV0D3jwdbjZauytIOPUlRkdHh2EMukxp3eRRV8xU5vy39aqwSggYiY=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr11046727wrv.162.1595655896577;
 Fri, 24 Jul 2020 22:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200715233009.27183-4-atish.patra@wdc.com> <mhng-cb081342-c17d-40ed-8ecb-b58fe259af2c@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-cb081342-c17d-40ed-8ecb-b58fe259af2c@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jul 2020 22:44:45 -0700
Message-ID: <CAOnJCUJMjGWvhB5i6-N7POGX=oaTnh559JhTVWreocj61Z1zaQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Do not rely on initrd_start/end computed
 during early dt parsing
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        sudeep.holla@arm.com, Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 10:12 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 15 Jul 2020 16:30:08 PDT (-0700), Atish Patra wrote:
> > Currently, initrd_start/end are computed during early_init_dt_scan
> > but used during arch_setup. We will get the following panic if initrd is used
> > and CONFIG_DEBUG_VIRTUAL is turned on.
> >
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] kernel BUG at arch/riscv/mm/physaddr.c:33!
> > [    0.000000] Kernel BUG [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc4-00015-ged0b226fed02 #886
> > [    0.000000] epc: ffffffe0002058d2 ra : ffffffe0000053f0 sp : ffffffe001001f40
> > [    0.000000]  gp : ffffffe00106e250 tp : ffffffe001009d40 t0 : ffffffe00107ee28
> > [    0.000000]  t1 : 0000000000000000 t2 : ffffffe000a2e880 s0 : ffffffe001001f50
> > [    0.000000]  s1 : ffffffe0001383e8 a0 : ffffffe00c087e00 a1 : 0000000080200000
> > [    0.000000]  a2 : 00000000010bf000 a3 : ffffffe00106f3c8 a4 : ffffffe0010bf000
> > [    0.000000]  a5 : ffffffe000000000 a6 : 0000000000000006 a7 : 0000000000000001
> > [    0.000000]  s2 : ffffffe00106f068 s3 : ffffffe00106f070 s4 : 0000000080200000
> > [    0.000000]  s5 : 0000000082200000 s6 : 0000000000000000 s7 : 0000000000000000
> > [    0.000000]  s8 : 0000000080011010 s9 : 0000000080012700 s10: 0000000000000000
> > [    0.000000]  s11: 0000000000000000 t3 : 000000000001fe30 t4 : 000000000001fe30
> > [    0.000000]  t5 : 0000000000000000 t6 : ffffffe00107c471
> > [    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> > [    0.000000] random: get_random_bytes called from print_oops_end_marker+0x22/0x46 with crng_init=0
> >
> > To avoid the error, initrd_start/end can be computed from phys_initrd_start/size
> > in setup itself. It also improves the initrd placement by aligning the start
> > and size with the page size.
> >
> > Fixes: 6435f773d81f (riscv: mm: add support for CONFIG_DEBUG_VIRTUAL)
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 33 +++++++++++++++++++++++++++------
> >  1 file changed, 27 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 8d22973bde40..f818a47a72d1 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -95,19 +95,40 @@ void __init mem_init(void)
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  static void __init setup_initrd(void)
> >  {
> > +     phys_addr_t start;
> >       unsigned long size;
> >
> > -     if (initrd_start >= initrd_end) {
> > -             pr_info("initrd not found or empty");
> > +     /* Ignore the virtul address computed during device tree parsing */
> > +     initrd_start = initrd_end = 0;
> > +
> > +     if (!phys_initrd_size)
> > +             return;
> > +     /*
> > +      * Round the memory region to page boundaries as per free_initrd_mem()
> > +      * This allows us to detect whether the pages overlapping the initrd
> > +      * are in use, but more importantly, reserves the entire set of pages
> > +      * as we don't want these pages allocated for other purposes.
> > +      */
> > +     start = round_down(phys_initrd_start, PAGE_SIZE);
> > +     size = phys_initrd_size + (phys_initrd_start - start);
> > +     size = round_up(size, PAGE_SIZE);
> > +
> > +     if (!memblock_is_region_memory(start, size)) {
> > +             pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
> > +                    (u64)start, size);
> >               goto disable;
> >       }
> > -     if (__pa_symbol(initrd_end) > PFN_PHYS(max_low_pfn)) {
> > -             pr_err("initrd extends beyond end of memory");
> > +
> > +     if (memblock_is_region_reserved(start, size)) {
> > +             pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
> > +                    (u64)start, size);
> >               goto disable;
> >       }
> >
> > -     size = initrd_end - initrd_start;
> > -     memblock_reserve(__pa_symbol(initrd_start), size);
> > +     memblock_reserve(start, size);
> > +     /* Now convert initrd to virtual addresses */
> > +     initrd_start = (unsigned long)__va(phys_initrd_start);
> > +     initrd_end = initrd_start + phys_initrd_size;
> >       initrd_below_start_ok = 1;
> >
> >       pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
>
> I'm going to put this one on fixes, but I don't think that's the right:
> DEBUG_VIRTUAL just catches the bug, but as far as I can tell it's been there
> since the beginning.  I'm going to replace this with
>
> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
>
> It's not going to apply back that far, but we can always backport it where it
> fails.
>

Yeah. That's that reason I didn't want to go that far.
I am afraid Greg may be not too happy with the stable tree compilation
failures (if there are any) :)

> Thanks!
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
