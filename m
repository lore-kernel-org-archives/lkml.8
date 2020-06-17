Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0182C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB802080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LNtcijz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFQGdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgFQGdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:33:03 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3787C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:33:03 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n5so773188otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 23:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NJtcH+Zl3aW0pdnpXXzWAHOYw4o/s0gIIF2Ozd7IcyU=;
        b=LNtcijz2EjSWn4+QP/vIc9et+pU4V3K/KtVzpo0/xDAIEg34OAnRohHYB+gnWcYpl+
         p50tWaJMauOYRO45kI9FovvB3At2hAT21AUeoDmdYRoFjh2mwZr7pLEEEBxsh7lrKrHi
         8zrceX0dAsvN/u7x3YXiteEfzM09pRIUYX3YDt9uz78/GkgbM9kagnh5sQfG2j+zCspT
         9z5QEVcIDzmoLXnH/1ecg8VaCS1upS/yeoGbaBd9EDaqRQXkDkUWfplC5/8T4QaaSJcc
         Teu/fNE3r9YroPeBzdwJQc0bS7rtCnRnTvodhMtoSQ36KJ3ezJ6KHjEI9HVNoPAybC25
         jM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NJtcH+Zl3aW0pdnpXXzWAHOYw4o/s0gIIF2Ozd7IcyU=;
        b=nDmn4J/Q3DzMjynZaBkmBT8QxrRwAP2/T/4NJlQ51Fdo2ymNB2F5XT8+Ms92BqujQP
         V3rt/Tj3CgR7aAGOoOAiuI1Venfm9h1kZPpAe//jGZVNd9EqoJXu3Tx631ZFB+Gx1KJ7
         ssFfIDBqlkRnyMjyvltrZsmv5Eh2g4hTllz+eKpn2M496Mty3hrEYFwdldeOLibxoZ2a
         pJRomkOvnt6HHOVidqV3xVS5rqIUGksSo6P2kwQXB4BxEeP9hTyaOhT2rvgoD9/Dbdvt
         cJHKXBfl6nS0f8oJUk8M0O6xMZJr9+z2MUYlZzWDY0i1k1Buea0+1OmuZwqOgpkXrS+B
         eWrQ==
X-Gm-Message-State: AOAM532BsMC8DgP727IVnruToUhs16DYXsbea9wjDvz5aqMa1mrFJZzb
        MP1fuxdy10ejDXQyss+f59TQ995VumqYMfVNgFk0Wr4q
X-Google-Smtp-Source: ABdhPJy+di3/n+tbg1hHGYwH6syU/4A2Rg/MjyjcVy0VZ1QQzMYXZaQ0UOJRuIT1I5ZceKhhcvAGPPt2bOee079ZZvs=
X-Received: by 2002:a05:6830:1e59:: with SMTP id e25mr5933962otj.127.1592375583098;
 Tue, 16 Jun 2020 23:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592292685.git.zong.li@sifive.com> <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
 <29425dbf7d54bab2733d28480d3adb61@mailhost.ics.forth.gr> <CANXhq0pMutK0+hHchQPOaZLqm9B-=MTKv8Xig4hM71_B=5+2bg@mail.gmail.com>
 <6e6cf39ae6ed91bbe086adbade5786cb@mailhost.ics.forth.gr>
In-Reply-To: <6e6cf39ae6ed91bbe086adbade5786cb@mailhost.ics.forth.gr>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 17 Jun 2020 14:32:51 +0800
Message-ID: <CANXhq0pU=RjO=T39-UDOE-34c=RAg7d8v9xdOPjTtcw8uMnx9A@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 1:28 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2020-06-17 04:56, Zong Li =CE=AD=CE=B3=CF=81=CE=
=B1=CF=88=CE=B5:
> > On Tue, Jun 16, 2020 at 8:27 PM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >>
> >> =CE=A3=CF=84=CE=B9=CF=82 2020-06-16 10:45, Zong Li =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> >> > Implement the 'devmem_is_allowed()' interface for RISC-V, like some =
of
> >> > other architectures have done. It will be called from
> >> > range_is_allowed()
> >> > when userpsace attempts to access /dev/mem.
> >> >
> >> > Access to exclusive IOMEM and kernel RAM is denied unless
> >> > CONFIG_STRICT_DEVMEM is set to 'n'.
> >> >
> >> > Test it by devmem, the result as follows:
> >> >
> >> >  - CONFIG_STRICT_DEVMEM=3Dy
> >> >       $ devmem 0x10010000
> >> >       0x00000000
> >> >       $ devmem 0x80200000
> >> >       0x0000106F
> >> >
> >> >  - CONFIG_STRICT_DEVMEM is not set
> >> >       $ devmem 0x10010000
> >> >       devmem: mmap: Operation not permitted
> >> >       $ devmem 0x80200000
> >> >       devmem: mmap: Operation not permitted
> >> >
> >> > Signed-off-by: Zong Li <zong.li@sifive.com>
> >> > ---
> >> >  arch/riscv/Kconfig          |  1 +
> >> >  arch/riscv/include/asm/io.h |  2 ++
> >> >  arch/riscv/mm/init.c        | 19 +++++++++++++++++++
> >> >  3 files changed, 22 insertions(+)
> >> >
> >> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> >> > index 128192e14ff2..ffd7841ede4c 100644
> >> > --- a/arch/riscv/Kconfig
> >> > +++ b/arch/riscv/Kconfig
> >> > @@ -16,6 +16,7 @@ config RISCV
> >> >       select ARCH_HAS_BINFMT_FLAT
> >> >       select ARCH_HAS_DEBUG_VIRTUAL if MMU
> >> >       select ARCH_HAS_DEBUG_WX
> >> > +     select ARCH_HAS_DEVMEM_IS_ALLOWED
> >> >       select ARCH_HAS_GCOV_PROFILE_ALL
> >> >       select ARCH_HAS_GIGANTIC_PAGE
> >> >       select ARCH_HAS_MMIOWB
> >> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io=
.h
> >> > index 3835c3295dc5..04ac65ab93ce 100644
> >> > --- a/arch/riscv/include/asm/io.h
> >> > +++ b/arch/riscv/include/asm/io.h
> >> > @@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(),
> >> > __io_paw())
> >> >
> >> >  #include <asm-generic/io.h>
> >> >
> >> > +extern int devmem_is_allowed(unsigned long pfn);
> >> > +
> >> >  #endif /* _ASM_RISCV_IO_H */
> >> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> > index bbe816e03b2f..5e7e61519acc 100644
> >> > --- a/arch/riscv/mm/init.c
> >> > +++ b/arch/riscv/mm/init.c
> >> > @@ -517,6 +517,25 @@ void mark_rodata_ro(void)
> >> >  }
> >> >  #endif
> >> >
> >> > +#ifdef CONFIG_STRICT_DEVMEM
> >> > +#include <linux/ioport.h>
> >> > +/*
> >> > + * devmem_is_allowed() checks to see if /dev/mem access to a certai=
n
> >> > address
> >> > + * is valid. The argument is a physical page number.
> >> > + *
> >> > + * Disallow access to system RAM as well as device-exclusive MMIO
> >> > regions.
> >> > + * This effectively disable read()/write() on /dev/mem.
> >> > + */
> >> > +int devmem_is_allowed(unsigned long pfn)
> >> > +{
> >> > +     if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> >> > +             return 0;
> >> > +     if (!page_is_ram(pfn))
> >> > +             return 1;
> >> > +     return 0;
> >> > +}
> >> > +#endif
> >> > +
> >> >  void __init resource_init(void)
> >> >  {
> >> >       struct memblock_region *region;
> >>
> >> This shouldn't be part of /mm/init.c, it has nothing to do with memory
> >> initialization, I suggest we move it to another file like mmap.c on
> >
> > Let me move it, thanks.
> >
> >> arm/arm64. Also before using iomem_is_exclusive we should probably
> >> also
> >> mark any reserved regions with the no-map attribute as busy|exclusive,
> >> reserved-memory regions are not necessarily part of the main memory so
> >> the page_is_ram check may pass and iomem_is_exclusive won't do any
> >> good.
> >
> > What do you think if we mark the reserved region in
> > kdump_resource_init, and change the kdump_resource_init to a more
> > generic name for initializing resources?
>
> Sounds good to me, I'll work on this within the week. Do you agree with
> marking the no-map reserved-memory regions as exclusive ?

It's OK to me, It seems to me that exclusive is more suitable than
busy when initialization.
