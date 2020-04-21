Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506B4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZubqHoCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDUFg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbgDUFg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:36:28 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D942DC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:36:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so10088740lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AIWZXgS77Ir/SPE/LgDDTYSKUqCrSGFqeCh61sg+ljU=;
        b=ZubqHoCsycaWo7iaiVk1qk595aGYOcv3lrgjJRcsuiXwSPOoqbqxtXQ95gnRQK5igK
         +Bp73pk6rOVCuiGlEscwZyef1oEiVwo0cRSQTOMDT1jrqO8ZvzaucJ4L13mCj/bYh59y
         D9MqUmPTdkPiQvxIyruD+wJ2B51kGw2O6htQp05s6lg7t62grAl1o9+qIiK8cUG3pQMT
         rB/j0SaiWSDJ2+FB9dfb8onuO9bFZC/w2LxHr9zgccVPyyTDAFB8ktEX6jAV+qA86kgQ
         wE/ACg0ogPGNabqHH7keteJ1d7BvSXmkZAwADcKysKRoGG3dNToPchUjORdrD9tYMlld
         W+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AIWZXgS77Ir/SPE/LgDDTYSKUqCrSGFqeCh61sg+ljU=;
        b=iUicEgYEP1lP+mXArQ9wFddiuP7NPN2HpzcU3rrHAaf1eZwSZ/uVk9KZniIafgpLtg
         gBCeWvSMD7yvRejA8QeuG0pqofIhoyycv54cxzsqvtAyRQmkBFdLuImtmZ2+uRFR0SaW
         VkPxdBIjp6P7UD5FCDBr8AsOU9iDpnSJaTeuY0YdxYWVnkdZ6SmP9SlTZOaBVC5eKxRh
         xfObUVloFC0iAoi6SsWEYvKebIBAYDSGGIchh4xvMlpt93IImXlH1hFQmzR3rJ/pbrfp
         U57bciGl5jjrh+zcebYU/05+L2dRDLKtR+2qE7tk2bTdTGuAisLVuYp3yASVzktZHjrZ
         yVCA==
X-Gm-Message-State: AGi0PuY433iXTGdNFZBpXC5AvTNbyzVSxxQMBBKenbU9+HbZyMzY5s4z
        bVlapvT8Ze8gk6JZyB6qTxEgphstbl3DKlpxv5Vkrg==
X-Google-Smtp-Source: APiQypKyftd20zHHllV4YwSQYjYqZTpegXvOD+X/xdRU/Sxe9EmaGPPvJoknWJOPja7P7a8z29jmiVCXKh1MPY/UyO0=
X-Received: by 2002:a19:946:: with SMTP id 67mr10836485lfj.142.1587447386297;
 Mon, 20 Apr 2020 22:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586332296.git.zong.li@sifive.com> <mhng-103aea95-cf25-47c5-8e8d-56534f40c570@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-103aea95-cf25-47c5-8e8d-56534f40c570@palmerdabbelt-glaptop1>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 21 Apr 2020 13:36:14 +0800
Message-ID: <CA+ZOyajXsNYZZwQgdV9Y2szN+=QbHu7GDA6Lc5iLk+92yx1WSw@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Support strict kernel memory permissions for security
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Zong Li <zong.li@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mhiramat@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8821=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 08 Apr 2020 00:56:55 PDT (-0700), zong.li@sifive.com wrote:
> > The main purpose of this patch series is changing the kernel mapping pe=
rmission
> > , make sure that code is not writeable, data is not executable, and rea=
d-only
> > data is neither writable nor executable.
> >
> > This patch series also supports the relevant implementations such as
> > ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> > ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
> >
> > Changes in v5:
> >  - Add lockdep_assert_held and more comments for text_mutex.
> >
> > Changes in v4:
> >  - Use NOKPROBE_SYMBOL instead of __kprobe annotation
> >  - Use text_mutex instead of patch_lock
> >  - Remove 'riscv_' prefix of function name
> >
> > Changes in v3:
> >  - Fix build error on nommu configuration. We already support nommu on
> >    RISC-V, so we should consider nommu case and test not only rv32/64,
> >    but also nommu.
> >
> > Changes in v2:
> >  - Use _data to specify the start of data section with write permission=
.
> >  - Change ftrace patch text implementaion.
> >  - Separate DEBUG_WX patch to another patchset.
> >
> > Zong Li (9):
> >   riscv: add macro to get instruction length
> >   riscv: introduce interfaces to patch kernel code
> >   riscv: patch code by fixmap mapping
> >   riscv: add ARCH_HAS_SET_MEMORY support
> >   riscv: add ARCH_HAS_SET_DIRECT_MAP support
> >   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
> >   riscv: move exception table immediately after RO_DATA
> >   riscv: add alignment for text, rodata and data sections
> >   riscv: add STRICT_KERNEL_RWX support
> >
> >  arch/riscv/Kconfig                  |   6 +
> >  arch/riscv/include/asm/bug.h        |   8 ++
> >  arch/riscv/include/asm/fixmap.h     |   2 +
> >  arch/riscv/include/asm/patch.h      |  12 ++
> >  arch/riscv/include/asm/set_memory.h |  48 +++++++
> >  arch/riscv/kernel/Makefile          |   4 +-
> >  arch/riscv/kernel/ftrace.c          |  26 ++--
> >  arch/riscv/kernel/patch.c           | 128 +++++++++++++++++++
> >  arch/riscv/kernel/traps.c           |   3 +-
> >  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
> >  arch/riscv/mm/Makefile              |   2 +-
> >  arch/riscv/mm/init.c                |  44 +++++++
> >  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
> >  13 files changed, 466 insertions(+), 15 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/patch.h
> >  create mode 100644 arch/riscv/include/asm/set_memory.h
> >  create mode 100644 arch/riscv/kernel/patch.c
> >  create mode 100644 arch/riscv/mm/pageattr.c
>
> Looks like there are quite a few conflicts here.  Do you mind re-spinning=
 the
> patch set for me?  It's a bit early to spin off for-next right now so the=
re
> might be some more conflicts, but hopefully not too many.
>

Sure, let me rebase it and send the next version. Thanks.

> Thanks!
>
