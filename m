Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5808520663
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VJffGKFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGJCn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJCnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:43:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259CDC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 19:43:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c25so3168150otf.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dy4AVqCcP7kztGsFeA5Fvb3GAiUWtChvdkBa1QUZbw=;
        b=VJffGKFCkiCfIhl//sN2TFR4d7nLOgxwKcao79heBIkTO6Ld6tufLnLyu/FoWWwYLP
         IARF1L4e2re0mmDqsUzYo9R0GgCiNjOBnSeVCkjQgOdxfxpmxt5pg7Oi9bos4oxMR3wi
         6xACx79JJkTqymJCNptZEVkRnBt7sRsUrErdSkBE2DLAv/rRMuJlZWWp+iF1aO3gC751
         99d6CjUBXeORsfUbyEbLYv7/Biw7XQYW5iPEFpAckftmv48DZlzbp7GtVjdP6W07PbFY
         mmOtmGIQgAiv6mxic1OoV1ezpp4EkpaKQeOGbfnSA9nUiOg2yHJXyEkp796PqHCKvIsV
         fpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dy4AVqCcP7kztGsFeA5Fvb3GAiUWtChvdkBa1QUZbw=;
        b=GTAHipO5Frtb4Op/sddqJmB6SIdYmwqHyxUdZ5TWV9kyBBoB17Fcs7d4EV3dp//lli
         J1b187yFZf8o5opnXno6ydMt3WyMjRI7y3k9OB1BOsSLsTNvnGl0yVgi83uZydPndxcc
         f+zPlbGnHLSJCup8Yah6wQ3373gtjdMInwK/O/hEhI9h21yGSlH2gQhJlDn8I8TGaSKh
         rqXzuA1veY8rFLqdn1LBRWJQro6DzppxSfmqXAIVoK/ZLPDGNrsc1btG5KhFPgLsqK8B
         UF4drfCNYQmP02ju54SoGhCQQKxfxI1/bUYQbyJlONmNz8eSVgjtfU5vd6s4sQBZZHbS
         2gRg==
X-Gm-Message-State: AOAM531H52HMke4MsNZ+u/dxcUyfgaDxi0uPoTd+TnvNnGoDbCBNKily
        NLKioJPNTKMGR5/MLJwv9Rfb9haUaUk0qr5LjV7EKw==
X-Google-Smtp-Source: ABdhPJwZaTrq+TyA81izHDBuSWWhfbuw/hLqSKJNZWb3zwst8fKOn5vdHPuCZ1CGPPBJ+gbL7BlSNgImIn+EmGN7oZU=
X-Received: by 2002:a9d:222:: with SMTP id 31mr34143429otb.127.1594349034129;
 Thu, 09 Jul 2020 19:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
 <mhng-d4637494-2072-41f6-9a8a-1b222d89d6c4@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-d4637494-2072-41f6-9a8a-1b222d89d6c4@palmerdabbelt-glaptop1>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 10 Jul 2020 10:43:42 +0800
Message-ID: <CANXhq0rOMFgr4j-oG_6G12XP2dKqWcXOKaCwOpg+FM7E+Qxx+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Support CONFIG_STRICT_DEVMEM
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 4:08 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 16 Jun 2020 00:45:47 PDT (-0700), zong.li@sifive.com wrote:
> > Implement the 'devmem_is_allowed()' interface for RISC-V, like some of
> > other architectures have done. It will be called from range_is_allowed()
> > when userpsace attempts to access /dev/mem.
>
> In fact, it's exactly the same (down to a few words of the comment) to the
> others that I checked.  I'm going to put a generic version in lib/ instead,
> I've sent out the patches.
>

OK, no problem, thanks for improving it.

> > Access to exclusive IOMEM and kernel RAM is denied unless
> > CONFIG_STRICT_DEVMEM is set to 'n'.
> >
> > Test it by devmem, the result as follows:
> >
> >  - CONFIG_STRICT_DEVMEM=y
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
> > @@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
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
> > + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> > + * is valid. The argument is a physical page number.
> > + *
> > + * Disallow access to system RAM as well as device-exclusive MMIO regions.
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
