Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C058206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="a0agqxK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgDAHTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:19:03 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43871 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:19:03 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so24882855otb.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWNb23bvG43tvtDYflVRLL7xRdiOM0I/bVuwrcZ+sjE=;
        b=a0agqxK22RUr8z9MxKv9tv14LtU8MonFWWz7niFaVWHguVjdgtQfydx9atK7qk3dbs
         2gDzIP9xM2xaF3U27R655p7/PV9fULM/chP8iVji/p32gvrB4KyjdvJEejjzSju4N78l
         nDamZuEOyC9aECrt2a85JdHMNiU6kw09IJ+N8XN6oG7VMvWLXto6jcd7VATWHEu6mO6S
         wu+hTVFqus+Vx7Av9A0q2OX+RdlTrChEB/uwL5ApRRuZ6Kx7oDh3t4GX5mzti1Jjj9ko
         uUDGz3o4AcGjIhnOQSiKHJ4ENCXkS9SefXTAMezuCmwGIJ83KxWL41Taim/Jw3Mprk15
         kgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWNb23bvG43tvtDYflVRLL7xRdiOM0I/bVuwrcZ+sjE=;
        b=ukZATAgDyoWPoWbKQ0IQT7XOhUNck9mxIYPLbwFHpBGMJauckv1JGzsh6NCLunifst
         pegsUbyir2paxmJABRzO3aw5oTXfxr3vcgoKZJU4kjqQGb/PvZsdd5xghWi21h0g7B/o
         z+vV6odSQsIRSY2rRZdVlg6wJOv2s7Uiyjjh4ICMYjkrKHGt/T65bCFcLSjtE81B5jee
         Igm1e6Hr82rZbEV6e5qa9iNZ6wLDLrObumrsfO3YVmvA1X5Up/NbNMxHHvCr+wF9NY7P
         GkwDLi9a0szWBDq6tNnAflpBXD9QBeK8dQr6u83iv1y2FvE6vm8NHQo360oPqmn9PCkm
         /5Dg==
X-Gm-Message-State: ANhLgQ0yAzKNgCyHrAl9/o4L5JZmn4b1cMJRJiyAMrv9TUcuZaLOr0sf
        UnmxI8NVj1cPU43wBmfNApdn4RXyVB12htQSuiDbag==
X-Google-Smtp-Source: ADFU+vtzKsxY68182TQ7PSwuGG29gx2NjzcuiOIGWaybfm5PYHXJTIV0ibgQlUPctKZxdt1NZIfA9bk1Pdza1/Pl31s=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr4368298ota.127.1585725542448;
 Wed, 01 Apr 2020 00:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583772574.git.zong.li@sifive.com> <20200331223254.919b92750962fefed5a6646f@kernel.org>
In-Reply-To: <20200331223254.919b92750962fefed5a6646f@kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 1 Apr 2020 15:18:52 +0800
Message-ID: <CANXhq0rD5kWf=ZDeA0bWdnd2A_iFS-mX_=X8DdJTH4fw09_sKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Support strict kernel memory permissions for security
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 9:32 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Zong,
>
> On Tue, 10 Mar 2020 00:55:35 +0800
> Zong Li <zong.li@sifive.com> wrote:
>
> > The main purpose of this patch series is changing the kernel mapping permission
> > , make sure that code is not writeable, data is not executable, and read-only
> > data is neither writable nor executable.
> >
> > This patch series also supports the relevant implementations such as
> > ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> > ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
>
> The order of the patches seems a bit strange. Since the first 7 patches
> makes kernel read-only, at that point ftrace is broken and it is fixed
> by the last 2 patches. That is not bisect-friendly. Can you move the
> last 2 patches to the top?
>

OK. Let me rearrange the order. Thanks.

> Thank you,
>
> >
> > Changes in v3:
> >  - Fix build error on nommu configuration. We already support nommu on
> >    RISC-V, so we should consider nommu case and test not only rv32/64,
> >    but also nommu.
> >
> > Changes in v2:
> >  - Use _data to specify the start of data section with write permission.
> >  - Change ftrace patch text implementaion.
> >  - Separate DEBUG_WX patch to another patchset.
> >
> > Zong Li (9):
> >   riscv: add ARCH_HAS_SET_MEMORY support
> >   riscv: add ARCH_HAS_SET_DIRECT_MAP support
> >   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
> >   riscv: move exception table immediately after RO_DATA
> >   riscv: add alignment for text, rodata and data sections
> >   riscv: add STRICT_KERNEL_RWX support
> >   riscv: add macro to get instruction length
> >   riscv: introduce interfaces to patch kernel code
> >   riscv: patch code by fixmap mapping
> >
> >  arch/riscv/Kconfig                  |   6 +
> >  arch/riscv/include/asm/bug.h        |   8 ++
> >  arch/riscv/include/asm/fixmap.h     |   2 +
> >  arch/riscv/include/asm/patch.h      |  12 ++
> >  arch/riscv/include/asm/set_memory.h |  48 +++++++
> >  arch/riscv/kernel/Makefile          |   4 +-
> >  arch/riscv/kernel/ftrace.c          |  13 +-
> >  arch/riscv/kernel/patch.c           | 120 ++++++++++++++++++
> >  arch/riscv/kernel/traps.c           |   3 +-
> >  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
> >  arch/riscv/mm/Makefile              |   2 +-
> >  arch/riscv/mm/init.c                |  44 +++++++
> >  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
> >  13 files changed, 445 insertions(+), 15 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/patch.h
> >  create mode 100644 arch/riscv/include/asm/set_memory.h
> >  create mode 100644 arch/riscv/kernel/patch.c
> >  create mode 100644 arch/riscv/mm/pageattr.c
> >
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
