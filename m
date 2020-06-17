Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1B1212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DjR6KJBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgFQB4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQB4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:56:16 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5954EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:56:15 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id v26so76289oof.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hueFxKmaWgxaYnZqPYZLcFE7MzSKwI+qlPQx/I7HVg8=;
        b=DjR6KJBs0GVk8e3e6mESOLOxYZDnPhsh9skuYIeX8ZMTFWprcSBL0ilfas5wRvvGLf
         9SPKOWSDYJvLUCuMSHgpHSEim4qmhyucox1YZe42p8+ta0zSOD8f0upRKZb+IhxeHz5O
         QQDmBu7o4VhdP137MfxBcnxySdk7lOXwp0J4Bilgxqsy8FfUVXtO+11ht0BukTuBH9Dx
         hVLRxUJ+ka3ioCyBupVQBdg1nOrg9AkFRuyYzSXcxuM8TC0oKQfm+SdQgLu9x/hKYujV
         yqRhVefqCosdqNGYYnKUDk7iKYsiBIpE7IBWpOBwtEuYsENBQeynNMhJO03AZAqrD3M6
         XyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hueFxKmaWgxaYnZqPYZLcFE7MzSKwI+qlPQx/I7HVg8=;
        b=ClOJBlN74mn8/bxPxC/dMVld8JkxU6ten2oL8B8dspwnPBMQ38veU7dZ55QaYr/hWZ
         VZBqboAoDGrq+/gdltu9sQSS6syAjR52stvuw5CE3VFnS8NcXgpCnB7sVdJHxhBhKE/1
         LDiMlsxCHNNVIhqmdbpbTBu58IRVckQK5IWyRr/QkA91yluYK1wlvqUKK2B4SlTaVKrH
         xMlmgRW9yOk/IBDoUp41nYEG16ED7CwCM9XG5wfpzm/O3KVzJ4e61vfXEavzpPsq2zMy
         LNDejQUsMFVApR6ux4cJ8aYV7/Cwaencngd7JbcszcxO6x9GIFyVwfrEM4APap/AzN6x
         AKxA==
X-Gm-Message-State: AOAM533gSpledKihoRAAc413h0YWeB/az/rN2WBq7r9jKW1tnlL50Jn9
        mIxVr7AdievB5E1eWxLo/9ZymVnejrHlYsXvYF3qASWDPU4=
X-Google-Smtp-Source: ABdhPJzozlgjeoLYevl9MryJG4sq1soVP3JLYrEpk+qUP02FK3EsjTRUIoFkm7eU7n4GJ9PMzlVSGLCVbv8hYmT+AzI=
X-Received: by 2002:a4a:a10e:: with SMTP id i14mr4890142ool.68.1592358975167;
 Tue, 16 Jun 2020 18:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592292685.git.zong.li@sifive.com> <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
 <29425dbf7d54bab2733d28480d3adb61@mailhost.ics.forth.gr>
In-Reply-To: <29425dbf7d54bab2733d28480d3adb61@mailhost.ics.forth.gr>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 17 Jun 2020 09:56:04 +0800
Message-ID: <CANXhq0pMutK0+hHchQPOaZLqm9B-=MTKv8Xig4hM71_B=5+2bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Support CONFIG_STRICT_DEVMEM
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 8:27 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2020-06-16 10:45, Zong Li =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > Implement the 'devmem_is_allowed()' interface for RISC-V, like some of
> > other architectures have done. It will be called from
> > range_is_allowed()
> > when userpsace attempts to access /dev/mem.
> >
> > Access to exclusive IOMEM and kernel RAM is denied unless
> > CONFIG_STRICT_DEVMEM is set to 'n'.
> >
> > Test it by devmem, the result as follows:
> >
> >  - CONFIG_STRICT_DEVMEM=3Dy
> >       $ devmem 0x10010000
> >       0x00000000
> >       $ devmem 0x80200000
> >       0x0000106F
> >
> >  - CONFIG_STRICT_DEVMEM is not set
> >       $ devmem 0x10010000
> >       devmem: mmap: Operation not permitted
> >       $ devmem 0x80200000
> >       devmem: mmap: Operation not permitted
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/Kconfig          |  1 +
> >  arch/riscv/include/asm/io.h |  2 ++
> >  arch/riscv/mm/init.c        | 19 +++++++++++++++++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 128192e14ff2..ffd7841ede4c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -16,6 +16,7 @@ config RISCV
> >       select ARCH_HAS_BINFMT_FLAT
> >       select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >       select ARCH_HAS_DEBUG_WX
> > +     select ARCH_HAS_DEVMEM_IS_ALLOWED
> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >       select ARCH_HAS_GIGANTIC_PAGE
> >       select ARCH_HAS_MMIOWB
> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> > index 3835c3295dc5..04ac65ab93ce 100644
> > --- a/arch/riscv/include/asm/io.h
> > +++ b/arch/riscv/include/asm/io.h
> > @@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(),
> > __io_paw())
> >
> >  #include <asm-generic/io.h>
> >
> > +extern int devmem_is_allowed(unsigned long pfn);
> > +
> >  #endif /* _ASM_RISCV_IO_H */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index bbe816e03b2f..5e7e61519acc 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -517,6 +517,25 @@ void mark_rodata_ro(void)
> >  }
> >  #endif
> >
> > +#ifdef CONFIG_STRICT_DEVMEM
> > +#include <linux/ioport.h>
> > +/*
> > + * devmem_is_allowed() checks to see if /dev/mem access to a certain
> > address
> > + * is valid. The argument is a physical page number.
> > + *
> > + * Disallow access to system RAM as well as device-exclusive MMIO
> > regions.
> > + * This effectively disable read()/write() on /dev/mem.
> > + */
> > +int devmem_is_allowed(unsigned long pfn)
> > +{
> > +     if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> > +             return 0;
> > +     if (!page_is_ram(pfn))
> > +             return 1;
> > +     return 0;
> > +}
> > +#endif
> > +
> >  void __init resource_init(void)
> >  {
> >       struct memblock_region *region;
>
> This shouldn't be part of /mm/init.c, it has nothing to do with memory
> initialization, I suggest we move it to another file like mmap.c on

Let me move it, thanks.

> arm/arm64. Also before using iomem_is_exclusive we should probably also
> mark any reserved regions with the no-map attribute as busy|exclusive,
> reserved-memory regions are not necessarily part of the main memory so
> the page_is_ram check may pass and iomem_is_exclusive won't do any good.

What do you think if we mark the reserved region in
kdump_resource_init, and change the kdump_resource_init to a more
generic name for initializing resources?
