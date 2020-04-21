Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEE2C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24D12071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bR5C37TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDUG3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgDUG3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:29:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D2CC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:29:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a2so6507378oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RvESK7CglgiS5xErjdXAyAHVMUUWew15wYnWDQZ4CeU=;
        b=bR5C37TQrYaaMJpuPVERI7GydgZMs9DM5ra0WXlGWnTCoSr7fcQ78d7xG4mgAHxlDN
         pmLauJGUwJdpHRGc23LQedt7MUvcn8A1t+qfDj9Lkg0WVAM2g/BUNyaMos9NIcVKZ9eD
         OhUNyO6YB6WOlBdnCI/orD5bE0/XokTWtgV+YGOSGdvQLXjtb9G/qM3m5ZCY1YedVUtW
         HiWEcfcG5fOB+4cXDbu0I5hsz2BTY3R8Am/+gob3w8dQYCeZTpU+tQ224Fskojs+7pzP
         Pi/qsD8NYHkX/tjsTqoIoPB/ad/xKO1b44/e7mL1yM+YSFFtecg3v+zCODdWeWChCt5O
         ciwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RvESK7CglgiS5xErjdXAyAHVMUUWew15wYnWDQZ4CeU=;
        b=dUT/bAqDkSNYy7VtBYF7AmYhSvKaCl6z/T9gGx/OpUqH5x9oW5OO+HBJgJ4Ks66JT0
         W/LI+fclOI7jZCAWE5eKMHoyJfk7GVXnbqAiJ9pfdiK+wEHWVT2EKKIlZraHRx/Sii8X
         Zv8KiLcul9F4qvDtzYI3JMIPXOw+6R2OZ5DuYXWiHjFNkLtMGN3QAo1ovbpWQu2zTV6m
         2MSk5305gUwh/kIH215dYHp/UoVSdP5Et0FQ4Eyj+XdFtPJMQeteJdVghqc02DL3dJWO
         UzANlIUwppyf9BMhUgUNyDOoxXUALfnsXMJULBPn2LuqMuzAkWuB/nogHQKJbVs7KpJZ
         yLeg==
X-Gm-Message-State: AGi0PuaxWraNwrXHJAfn11MvK/mTr0CI3mKyd4K6UcHR/AwTmPWLni0/
        1Z39e4NrLdR56RYSqXQSqC8pIctrL+44L0uGGJXpkVWK
X-Google-Smtp-Source: APiQypJSFz/5DbvUSS7U4ehQSnfk38alSu2zkVD61gbfZJFdakjx8CyUtFAU5Fuz8uKJuebMCGrJDdBqqmC8mq8JKeY=
X-Received: by 2002:aca:3283:: with SMTP id y125mr2163575oiy.91.1587450555283;
 Mon, 20 Apr 2020 23:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586332296.git.zong.li@sifive.com> <mhng-103aea95-cf25-47c5-8e8d-56534f40c570@palmerdabbelt-glaptop1>
 <CA+ZOyajXsNYZZwQgdV9Y2szN+=QbHu7GDA6Lc5iLk+92yx1WSw@mail.gmail.com> <CAAhSdy3K2+72FJs1hj1G5qWD4cYAoumHuf7UhMcQM3EeMrVpzw@mail.gmail.com>
In-Reply-To: <CAAhSdy3K2+72FJs1hj1G5qWD4cYAoumHuf7UhMcQM3EeMrVpzw@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 21 Apr 2020 14:29:03 +0800
Message-ID: <CANXhq0oYKb35YVOk=fsg_djWCkS2Vs_E5y0+AotLt1i1GTaPYA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Support strict kernel memory permissions for security
To:     Anup Patel <anup@brainfault.org>
Cc:     Zong Li <zongbox@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 2:20 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Apr 21, 2020 at 11:06 AM Zong Li <zongbox@gmail.com> wrote:
> >
> > Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > On Wed, 08 Apr 2020 00:56:55 PDT (-0700), zong.li@sifive.com wrote:
> > > > The main purpose of this patch series is changing the kernel mappin=
g permission
> > > > , make sure that code is not writeable, data is not executable, and=
 read-only
> > > > data is neither writable nor executable.
> > > >
> > > > This patch series also supports the relevant implementations such a=
s
> > > > ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> > > > ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
> > > >
> > > > Changes in v5:
> > > >  - Add lockdep_assert_held and more comments for text_mutex.
> > > >
> > > > Changes in v4:
> > > >  - Use NOKPROBE_SYMBOL instead of __kprobe annotation
> > > >  - Use text_mutex instead of patch_lock
> > > >  - Remove 'riscv_' prefix of function name
> > > >
> > > > Changes in v3:
> > > >  - Fix build error on nommu configuration. We already support nommu=
 on
> > > >    RISC-V, so we should consider nommu case and test not only rv32/=
64,
> > > >    but also nommu.
> > > >
> > > > Changes in v2:
> > > >  - Use _data to specify the start of data section with write permis=
sion.
> > > >  - Change ftrace patch text implementaion.
> > > >  - Separate DEBUG_WX patch to another patchset.
> > > >
> > > > Zong Li (9):
> > > >   riscv: add macro to get instruction length
> > > >   riscv: introduce interfaces to patch kernel code
> > > >   riscv: patch code by fixmap mapping
> > > >   riscv: add ARCH_HAS_SET_MEMORY support
> > > >   riscv: add ARCH_HAS_SET_DIRECT_MAP support
> > > >   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
> > > >   riscv: move exception table immediately after RO_DATA
> > > >   riscv: add alignment for text, rodata and data sections
> > > >   riscv: add STRICT_KERNEL_RWX support
> > > >
> > > >  arch/riscv/Kconfig                  |   6 +
> > > >  arch/riscv/include/asm/bug.h        |   8 ++
> > > >  arch/riscv/include/asm/fixmap.h     |   2 +
> > > >  arch/riscv/include/asm/patch.h      |  12 ++
> > > >  arch/riscv/include/asm/set_memory.h |  48 +++++++
> > > >  arch/riscv/kernel/Makefile          |   4 +-
> > > >  arch/riscv/kernel/ftrace.c          |  26 ++--
> > > >  arch/riscv/kernel/patch.c           | 128 +++++++++++++++++++
> > > >  arch/riscv/kernel/traps.c           |   3 +-
> > > >  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
> > > >  arch/riscv/mm/Makefile              |   2 +-
> > > >  arch/riscv/mm/init.c                |  44 +++++++
> > > >  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++=
++++
> > > >  13 files changed, 466 insertions(+), 15 deletions(-)
> > > >  create mode 100644 arch/riscv/include/asm/patch.h
> > > >  create mode 100644 arch/riscv/include/asm/set_memory.h
> > > >  create mode 100644 arch/riscv/kernel/patch.c
> > > >  create mode 100644 arch/riscv/mm/pageattr.c
> > >
> > > Looks like there are quite a few conflicts here.  Do you mind re-spin=
ning the
> > > patch set for me?  It's a bit early to spin off for-next right now so=
 there
> > > might be some more conflicts, but hopefully not too many.
> > >
> >
> > Sure, let me rebase it and send the next version. Thanks.
>
> This series is already merged in Linux kernel and it is available
> in Linux-5.7-rc2.
>
> I don't see the point in rebasing this series or commenting on
> this series.
>
> If you have fixes then send as separate patches based on
> latest Linux-5.7-rcX release.
>

Yes, I would send the separate patches for the difference from the
merged version. Thanks.

> Regards,
> Anup
