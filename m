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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABF5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B7A2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkE9AAaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgCEFxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:53:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40476 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgCEFxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:53:54 -0500
Received: by mail-lf1-f67.google.com with SMTP id p5so3541728lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 21:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OLZQk5H+gmDXNMVLZ+oRJufK+h7dOlNTyaf6cOwRd+E=;
        b=jkE9AAaRlZx3UZcG1QwUzSj58GhGLQwrKMF4CLrJVUx5I6jj4I8R6NC/WVMrhtCY0u
         KXlH73UyQozrdMMmEgKNprrrWzj5FyEBfSYselBLjoBnzsiEibSh6h44mraRFDgUVp1C
         T2k+XshZggpgBfpA7cRsx7W77Tp6Jwf29X4pnElJXBUPN4Y+4i3ZCt+VnSpazPnSIlp1
         pDWcOb3qqcaCHpSTtY+ZJou17pwrGMvWURubrycw3KIsxfVXwWAQtZKVhZgHPZI7E+Va
         XbAFKv+sJumWtzfMZ0tvLDJijKlEbOxPD523FjUF78HDpFSyLJ71TPaQ0Hfj+ZxLneiH
         N/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OLZQk5H+gmDXNMVLZ+oRJufK+h7dOlNTyaf6cOwRd+E=;
        b=VGnfYOz/OY+VbeYlCAVZZZG1rr0DSxFKvBbnhW7BDDMhyko1DflYx/4T7Ugm2+czoG
         A1BJASMmO1CoCDD+LFg8AN7ARdxn6f++WMHTrnarkwqlUL8N1sCxyNvLfqbfeVVg/EZD
         vGzqqL+tni04olpa7U6i+DeesB/JFCkTbmd6ydmRpFAmHrETCFcK4QKsqLf3Vq30rOUR
         GUkuOxKpanfl8/7J3wysUKhUHsNmVPhPvNfO9pEFfuDoHO7qw6ZolIGpxc8HZAcpdnAT
         OYN5wwN2ls01YGJMVmSWfp58yZVZCi3/VVAhw7UK3u2HGRnT4ctcqyPTUlDV2+vHy/2b
         fz9g==
X-Gm-Message-State: ANhLgQ0Zmz1uyyt2ddtXeVjdzXIOZW4vQ74SweicG/kq6wwq9hFBCRal
        aNehT3HLvbYruafW4ki12d5u54Z+VCbymAMqj28=
X-Google-Smtp-Source: ADFU+vv70zomwvXOzyTIwR+9Mqd/acmQSjPI/apXIDKIjBOQiLZl2mipGI7MlwEWxxRp7FsSULfFbvgyM3vF7v/wW4g=
X-Received: by 2002:ac2:5e8d:: with SMTP id b13mr309351lfq.113.1583387631784;
 Wed, 04 Mar 2020 21:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20200217083223.2011-8-zong.li@sifive.com> <mhng-0d866567-f710-4d27-8ae9-1f78454d7d85@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-0d866567-f710-4d27-8ae9-1f78454d7d85@palmerdabbelt-glaptop1>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 5 Mar 2020 13:53:41 +0800
Message-ID: <CA+ZOyahuV=Y427S_dWjOvbfQQNSWS3aK8SXxeEEiGBxt3n8WiA@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: add DEBUG_WX support
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
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 17 Feb 2020 00:32:22 PST (-0800), zong.li@sifive.com wrote:
> > Support DEBUG_WX to check whether there are mapping with write and
> > execute permission at the same time.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/Kconfig.debug        | 30 ++++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/ptdump.h |  6 ++++++
> >  arch/riscv/mm/init.c            |  2 ++
> >  3 files changed, 38 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> > index e69de29bb2d1..2bcd88e75626 100644
> > --- a/arch/riscv/Kconfig.debug
> > +++ b/arch/riscv/Kconfig.debug
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config DEBUG_WX
> > +     bool "Warn on W+X mappings at boot"
> > +     select PTDUMP_CORE
> > +     help
> > +       Generate a warning if any W+X mappings are found at boot.
> > +
> > +       This is useful for discovering cases where the kernel is leavin=
g
> > +       W+X mappings after applying NX, as such mappings are a security=
 risk.
> > +       This check also includes UXN, which should be set on all kernel
> > +       mappings.
> > +
> > +       Look for a message in dmesg output like this:
> > +
> > +         riscv/mm: Checked W+X mappings: passed, no W+X pages found.
> > +
> > +       or like this, if the check failed:
> > +
> > +         riscv/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
> > +
> > +       Note that even if the check fails, your kernel is possibly
> > +       still fine, as W+X mappings are not a security hole in
> > +       themselves, what they do is that they make the exploitation
> > +       of other unfixed kernel bugs easier.
> > +
> > +       There is no runtime or memory usage effect of this option
> > +       once the kernel has booted up - it's a one time check.
> > +
> > +       If in doubt, say "Y".
>
> It looks like this comes verbatim from the arm64 port, at least.  I think=
 we
> should just refactor this to some sort of ARCH_HAS_DEBUG_WX so we can sha=
re the
> code.  I usually do this by adding the shared support, using it for RISC-=
V, and
> then converting the other ports over.
>

OK. It seems to be different work, maybe I could separate this patch
in next version. Thanks.

> > diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/p=
tdump.h
> > index e29af7191909..eb2a1cc5f22c 100644
> > --- a/arch/riscv/include/asm/ptdump.h
> > +++ b/arch/riscv/include/asm/ptdump.h
> > @@ -8,4 +8,10 @@
> >
> >  void ptdump_check_wx(void);
> >
> > +#ifdef CONFIG_DEBUG_WX
> > +#define debug_checkwx() ptdump_check_wx()
> > +#else
> > +#define debug_checkwx() do { } while (0)
> > +#endif
> > +
> >  #endif /* _ASM_RISCV_PTDUMP_H */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 09fa643e079c..a05d76e5fefe 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -509,6 +509,8 @@ void mark_rodata_ro(void)
> >       set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_S=
HIFT);
> >       set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_S=
HIFT);
> >       set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> > +
> > +     debug_checkwx();
> >  }
> >  #endif
>
