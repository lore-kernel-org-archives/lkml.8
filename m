Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536FF20842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7jhmR9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgCEEIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:08:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39869 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEEIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:08:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id f10so4470060ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F4nT6mKBap4vm5qfP7xfH33JMJmzl6MC92A1Bml8TEo=;
        b=c7jhmR9y1Yu0lHVpa1e0nV77xQLpcwnleBw20sQX8t6jCKhYXNQnGg3eYuuOA/exXx
         XQIVyt/p+ZbVet1xmli9wXneWk/WepDtRU2hs2c3ur0QQPbYRDhZ3hXsqiK5CIkLTZ3G
         Qi0w80RjzQ2B6Qu7bCpoB7Aw9Iw2MwpodQw+I0AkB2XTpKtwfJ8veFo7x4dM8+moFRTJ
         i94lXSAIkgl0vOKPBIY+0ozQ9hABiJtSBLV9BYEglbK/H6paxzfHr+y540/4FrFF5jel
         6KuTz/lVppDq2wL0j/kUk1W4rt8btrPjIcfnMrYw6tDpSfuiBm4+3CFxysTrqe2e/4tU
         ZtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F4nT6mKBap4vm5qfP7xfH33JMJmzl6MC92A1Bml8TEo=;
        b=jJT5CeGp4SVvPBz0ZZ/Vcjxg04sjOb8WS+DQbhtBI9vGro/7x52Y0TrYwfjwlG1lF2
         I/6cdunxtuLvp2DYiDU0IXsanj3WfbOirJEk65rtfmZ6sVN3m0Dvj7h3sMinGs2Qqr9R
         p5jNTIfMnA2HmP6CmcAVbNO9+gwt8PwQ/IyhAjrRWXIWHXVlL4fqTDknbJgWheHZydS8
         XE75leIVw7CDvf948s08vHrMl8cPkVB+mcbT3r6qJbQGbZoda2DV3l26s8/0escJxeqi
         X3bOSmrhNSQBs6e5qTtNB6k7u78ctvdE9wny8wgE0GaYGGC1zHiHJds9ki23IOfRbY11
         vOOg==
X-Gm-Message-State: ANhLgQ2coi3vVpjj0tw1/PXDUyZxCWXg7Wr7yT5/2nzQ1dnC7+uwHRi6
        gtce+q1b1EMZ+OsdYrdN4NHW2AZOvt72k0d7LyD6IdQO
X-Google-Smtp-Source: ADFU+vu5238HL/C4cfABKy7zKLFstF4P0T26bIA6SldHKJTQeM8ctVdkBmXvAbxZyyp7oist7ame3rgFBpsODcBuLYU=
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr3923936ljl.83.1583381312277;
 Wed, 04 Mar 2020 20:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20200217083223.2011-7-zong.li@sifive.com> <mhng-5d8ed200-0200-4198-946f-ae41ba71cc06@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-5d8ed200-0200-4198-946f-ae41ba71cc06@palmerdabbelt-glaptop1>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 5 Mar 2020 12:08:21 +0800
Message-ID: <CA+ZOyajG2uNg8VMVbD9MiW1=ga_dJvs2rYi-mrV4n5Ld2Dfh2w@mail.gmail.com>
Subject: Re: [PATCH 6/8] riscv: add STRICT_KERNEL_RWX support
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=885=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 17 Feb 2020 00:32:21 PST (-0800), zong.li@sifive.com wrote:
> > The commit contains that make text section as non-writable, rodata
> > section as read-only, and data section as non-executable.
> >
> > The init section should be changed to non-executable.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/Kconfig                  |  1 +
> >  arch/riscv/include/asm/set_memory.h |  8 +++++
> >  arch/riscv/mm/init.c                | 45 +++++++++++++++++++++++++++++
> >  3 files changed, 54 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index f524d7e60648..308a4dbc0b39 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -62,6 +62,7 @@ config RISCV
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_SET_DIRECT_MAP
> >       select ARCH_HAS_SET_MEMORY
> > +     select ARCH_HAS_STRICT_KERNEL_RWX
> >       select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> >       select SPARSEMEM_STATIC if 32BIT
> >       select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> > diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/a=
sm/set_memory.h
> > index a91f192063c2..d3076087cb34 100644
> > --- a/arch/riscv/include/asm/set_memory.h
> > +++ b/arch/riscv/include/asm/set_memory.h
> > @@ -15,6 +15,14 @@ int set_memory_rw(unsigned long addr, int numpages);
> >  int set_memory_x(unsigned long addr, int numpages);
> >  int set_memory_nx(unsigned long addr, int numpages);
> >
> > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > +void set_kernel_text_ro(void);
> > +void set_kernel_text_rw(void);
> > +#else
> > +static inline void set_kernel_text_ro(void) { }
> > +static inline void set_kernel_text_rw(void) { }
> > +#endif
> > +
> >  int set_direct_map_invalid_noflush(struct page *page);
> >  int set_direct_map_default_noflush(struct page *page);
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 965a8cf4829c..09fa643e079c 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -12,11 +12,13 @@
> >  #include <linux/sizes.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/libfdt.h>
> > +#include <linux/set_memory.h>
> >
> >  #include <asm/fixmap.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/sections.h>
> >  #include <asm/pgtable.h>
> > +#include <asm/ptdump.h>
> >  #include <asm/io.h>
> >
> >  #include "../kernel/head.h"
> > @@ -477,6 +479,49 @@ static void __init setup_vm_final(void)
> >       csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_=
MODE);
> >       local_flush_tlb_all();
> >  }
> > +
> > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > +void set_kernel_text_rw(void)
> > +{
> > +     unsigned long text_start =3D (unsigned long)_text;
> > +     unsigned long text_end =3D (unsigned long)_etext;
> > +
> > +     set_memory_rw(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > +}
> > +
> > +void set_kernel_text_ro(void)
> > +{
> > +     unsigned long text_start =3D (unsigned long)_text;
> > +     unsigned long text_end =3D (unsigned long)_etext;
> > +
> > +     set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > +}
> > +
> > +void mark_rodata_ro(void)
> > +{
> > +     unsigned long text_start =3D (unsigned long)_text;
> > +     unsigned long text_end =3D (unsigned long)_etext;
> > +     unsigned long rodata_start =3D (unsigned long)__start_rodata;
> > +     unsigned long data_start =3D (unsigned long)_sdata;
> > +     unsigned long max_low =3D (unsigned long)(__va(PFN_PHYS(max_low_p=
fn)));
> > +
> > +     set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> > +     set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_S=
HIFT);
> > +     set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_S=
HIFT);
>
> Ya, this'll risk barfing because of srodata.

It might be OK because the range includes .rodata, .srodata and
__ex_table sections, but I need another symbol instead of _sdata as
you mentioned in other patch.

>
> > +     set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> > +}
> > +#endif
> > +
> > +void free_initmem(void)
> > +{
> > +     unsigned long init_begin =3D (unsigned long)__init_begin;
> > +     unsigned long init_end =3D (unsigned long)__init_end;
> > +
> > +     /* Make the region as non-execuatble. */
> > +     set_memory_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> > +     free_initmem_default(POISON_FREE_INITMEM);
> > +}
> > +
> >  #else
> >  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >  {
>
