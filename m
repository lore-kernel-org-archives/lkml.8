Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DB7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C32F207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbBPv/Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgFZO3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:29:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F502C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:29:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so7593515qts.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eLVHWQWk1SSSBHBVpMH1pv4y2o7pnoH/LjhqcMoV61E=;
        b=pbBPv/ZfquVY+1nbrGUTQ97tUGXF1nfs9YSbzSwbUgSCV0B/tnAhXFtkx/Vk+V2ly0
         2cIuZSca4qM51OHpjluJsW6T/vAsr3I7/U1RQsomAweCk212f+J+WReARHDAJge5Snrw
         vgtyPTqz+5ExK40S+KMCwAMc4ruBN3ON55/6asBJGjBpfEfojhC6SVCyLcSi20hDWJdo
         W04DGHZ8Q/0+6VNj0eSZM7tpiPet29vls5CIqD+zTKASy5gM0c7wGRTPpqi+VoG5Aina
         RDLKvBAJsqvPlh7qeLXvgo8JR0sysqF5jWoeClHfano8r2XtzEps/Tcht8OUnFmSqPig
         QsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eLVHWQWk1SSSBHBVpMH1pv4y2o7pnoH/LjhqcMoV61E=;
        b=kZ3G9I3dWkC2I9wAf7u2HVsaz7qJZT+5/WHl0KvMPkz52/BbiLMaRvuH43ia9U+lC2
         Wqt/WJJENy6CvPD+36Zq6PUwaLPVA6wMeg2XUniJ3fSqO9LpZPD3qzUOzZZgfnJlLHlE
         VaVSalb555ZwbiDiNEnRHWHJNg1kHuHv/4Xx1E7QfCo44Z04GUHSJBFLKRRjtuphbNBT
         RtvqzeMshPo2GcnaVmCOJscW2/CrOO7FIHtu6zOHCPmcd25IY1NU1hvtj8RIRKvS5Ymq
         u0TMszuxC+lGGAmAclngHYHx4ZVF2GI9l5oDfHZXU9MgJp97riKWhF36KDZxL27vsThD
         7X1A==
X-Gm-Message-State: AOAM532rf79Hk+W97L5KB8QCPjkzS2LEUWuq2t8i1gRH9FnexWZJR6IQ
        fb7fPw+4X5t7tC1/ZM3Tid7bc872t2apR38+m6T8sg==
X-Google-Smtp-Source: ABdhPJx+CuQHQu45R0dHB8cK5wbKlRpVevV5VmxeywBJQbQ86qydwjJXCEbaiEzS/sMMG+9ifC4icG/s9ovLltgSxZ4=
X-Received: by 2002:ac8:260b:: with SMTP id u11mr3074244qtu.380.1593181745726;
 Fri, 26 Jun 2020 07:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200625183941.23093-1-tklauser@distanz.ch> <20200626124056.29708-1-tklauser@distanz.ch>
In-Reply-To: <20200626124056.29708-1-tklauser@distanz.ch>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jun 2020 16:28:54 +0200
Message-ID: <CACT4Y+ZqbsyCQp8NJq9=TFvu92EMysQRyVe6yyarHhR2L2M4RQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Allow building with kcov coverage
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 2:40 PM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Add ARCH_HAS_KCOV and HAVE_GCC_PLUGINS to the riscv Kconfig.
> Also disable instrumentation of some early boot code and vdso.
>
> Boot-tested on QEMU's riscv64 virt machine.
>
> Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>


Assuming it boots now :)

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/riscv/Kconfig              | 2 ++
>  arch/riscv/boot/Makefile        | 2 ++
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  arch/riscv/mm/Makefile          | 2 ++
>  4 files changed, 7 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 089293e4ad46..a7d7f8184f15 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -19,6 +19,7 @@ config RISCV
>         select ARCH_HAS_DEBUG_WX
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_GIGANTIC_PAGE
> +       select ARCH_HAS_KCOV
>         select ARCH_HAS_MMIOWB
>         select ARCH_HAS_PTE_SPECIAL
>         select ARCH_HAS_SET_DIRECT_MAP
> @@ -57,6 +58,7 @@ config RISCV
>         select HAVE_DMA_CONTIGUOUS if MMU
>         select HAVE_EBPF_JIT if MMU
>         select HAVE_FUTEX_CMPXCHG if FUTEX
> +       select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_VDSO if MMU && 64BIT
>         select HAVE_PCI
>         select HAVE_PERF_EVENTS
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 3530c59b3ea7..c59fca695f9d 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -14,6 +14,8 @@
>  # Based on the ia64 and arm64 boot/Makefile.
>  #
>
> +KCOV_INSTRUMENT :=3D n
> +
>  OBJCOPYFLAGS_Image :=3D-O binary -R .note -R .note.gnu.build-id -R .comm=
ent -S
>
>  targets :=3D Image loader
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Mak=
efile
> index 29cf052f6541..4b0d3bcc44e5 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -29,6 +29,7 @@ CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
>
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE :=3D n
> +KCOV_INSTRUMENT :=3D n
>
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 363ef01c30b1..c0185e556ca5 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -5,6 +5,8 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_init.o =3D -pg
>  endif
>
> +KCOV_INSTRUMENT_init.o :=3D n
> +
>  obj-y +=3D init.o
>  obj-y +=3D extable.o
>  obj-$(CONFIG_MMU) +=3D fault.o pageattr.o
> --
> 2.27.0
>
