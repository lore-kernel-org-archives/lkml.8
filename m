Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B708AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CBA20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="btuEYiTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgDUGUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgDUGUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:20:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9895C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:20:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k11so15070367wrp.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YkirgEO7Fq+NMC8oPjIVlSmMh+As/hMUFNWcguxE1dQ=;
        b=btuEYiTXkMbAbWo2V5lDgmJdH3r1AaVj/MfSy6+LLrqyqFlfuRYNZug1kHujsbuxuE
         i7136PZ2UgSQzw2mJ/b4EywNXrCsef27MkKhEcuHcChHCltv1arkWr2Wk+LQllY0koUa
         nwuncvdCyidAQCoxcDvuoxsBzvmx53agQHPyHOcOq3KHaUA3QDT9yBhkd12yvqTlQBV8
         uO/svQUNZd0yOVOLcntALZIr/MeRzRLe9wzSlU+h3LeDP721gcCD2bNRzQ1/DKug0wuH
         /2ekQUZtntbNvBh1Z6LDOYaX0rFQ+BPh5viVyHLMJ6SU8FcaEdt24pw8EOukJMVq4Wdt
         HAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YkirgEO7Fq+NMC8oPjIVlSmMh+As/hMUFNWcguxE1dQ=;
        b=O56QtqFCoBL+HuPQjss6qQe+7AVsH24nnuS4P/kXcS1Zy+ajO+QMD14hsSI8TYdEhf
         JaZBZ+mQQVEs2UBYQY2iObW1BCxzy7juFzYgFfDvVwje6Inn2o2y/e41ji+BebgG8uhu
         8pS01DSsrmDuRKuFiFTiR9voc0tlVRkPAkYB/z/HT5zF3SUHDGvlnoJmHNBHj1zUGi6N
         tWRb7O9vGZ1AEadvCIP8SAXIJW18mXjCnUwqnpUp6pMLPsSjpsdZP6u7AvGI9O/edKnu
         P391l4YsAWmapET5FaiiSHnfDBeV3+dZXBvrLoRL9RwxSFSZsTkNNF9h7bBsghKjXQdx
         8LEg==
X-Gm-Message-State: AGi0PubDXFI8umi0P21jOdF3PAhhIs7Y61nE1gHm5eopx7pe7kUqqf2N
        IA5iOwX96M94gQfw7MyqePUSHO8N2k3gazGlnwI4SA==
X-Google-Smtp-Source: APiQypJzCpRELizuzVA4FdCnZgerTYyzZLwhuujO8WC4l/YN83iXtngXh4zjl+gid12EevC94b10GjtiQEjWOBSXSAM=
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr24396762wrn.0.1587450052318;
 Mon, 20 Apr 2020 23:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586332296.git.zong.li@sifive.com> <mhng-103aea95-cf25-47c5-8e8d-56534f40c570@palmerdabbelt-glaptop1>
 <CA+ZOyajXsNYZZwQgdV9Y2szN+=QbHu7GDA6Lc5iLk+92yx1WSw@mail.gmail.com>
In-Reply-To: <CA+ZOyajXsNYZZwQgdV9Y2szN+=QbHu7GDA6Lc5iLk+92yx1WSw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 21 Apr 2020 11:50:40 +0530
Message-ID: <CAAhSdy3K2+72FJs1hj1G5qWD4cYAoumHuf7UhMcQM3EeMrVpzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Support strict kernel memory permissions for security
To:     Zong Li <zongbox@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mhiramat@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:06 AM Zong Li <zongbox@gmail.com> wrote:
>
> Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Wed, 08 Apr 2020 00:56:55 PDT (-0700), zong.li@sifive.com wrote:
> > > The main purpose of this patch series is changing the kernel mapping =
permission
> > > , make sure that code is not writeable, data is not executable, and r=
ead-only
> > > data is neither writable nor executable.
> > >
> > > This patch series also supports the relevant implementations such as
> > > ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> > > ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
> > >
> > > Changes in v5:
> > >  - Add lockdep_assert_held and more comments for text_mutex.
> > >
> > > Changes in v4:
> > >  - Use NOKPROBE_SYMBOL instead of __kprobe annotation
> > >  - Use text_mutex instead of patch_lock
> > >  - Remove 'riscv_' prefix of function name
> > >
> > > Changes in v3:
> > >  - Fix build error on nommu configuration. We already support nommu o=
n
> > >    RISC-V, so we should consider nommu case and test not only rv32/64=
,
> > >    but also nommu.
> > >
> > > Changes in v2:
> > >  - Use _data to specify the start of data section with write permissi=
on.
> > >  - Change ftrace patch text implementaion.
> > >  - Separate DEBUG_WX patch to another patchset.
> > >
> > > Zong Li (9):
> > >   riscv: add macro to get instruction length
> > >   riscv: introduce interfaces to patch kernel code
> > >   riscv: patch code by fixmap mapping
> > >   riscv: add ARCH_HAS_SET_MEMORY support
> > >   riscv: add ARCH_HAS_SET_DIRECT_MAP support
> > >   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
> > >   riscv: move exception table immediately after RO_DATA
> > >   riscv: add alignment for text, rodata and data sections
> > >   riscv: add STRICT_KERNEL_RWX support
> > >
> > >  arch/riscv/Kconfig                  |   6 +
> > >  arch/riscv/include/asm/bug.h        |   8 ++
> > >  arch/riscv/include/asm/fixmap.h     |   2 +
> > >  arch/riscv/include/asm/patch.h      |  12 ++
> > >  arch/riscv/include/asm/set_memory.h |  48 +++++++
> > >  arch/riscv/kernel/Makefile          |   4 +-
> > >  arch/riscv/kernel/ftrace.c          |  26 ++--
> > >  arch/riscv/kernel/patch.c           | 128 +++++++++++++++++++
> > >  arch/riscv/kernel/traps.c           |   3 +-
> > >  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
> > >  arch/riscv/mm/Makefile              |   2 +-
> > >  arch/riscv/mm/init.c                |  44 +++++++
> > >  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++=
++
> > >  13 files changed, 466 insertions(+), 15 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/patch.h
> > >  create mode 100644 arch/riscv/include/asm/set_memory.h
> > >  create mode 100644 arch/riscv/kernel/patch.c
> > >  create mode 100644 arch/riscv/mm/pageattr.c
> >
> > Looks like there are quite a few conflicts here.  Do you mind re-spinni=
ng the
> > patch set for me?  It's a bit early to spin off for-next right now so t=
here
> > might be some more conflicts, but hopefully not too many.
> >
>
> Sure, let me rebase it and send the next version. Thanks.

This series is already merged in Linux kernel and it is available
in Linux-5.7-rc2.

I don't see the point in rebasing this series or commenting on
this series.

If you have fixes then send as separate patches based on
latest Linux-5.7-rcX release.

Regards,
Anup
