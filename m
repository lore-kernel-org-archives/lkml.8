Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CE7C07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD759206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqzAkTQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIJRrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIJRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:46:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92399C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:46:27 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so380714pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7GfQG+sKNUFe8kKRZiVLdxc1h3BX3Djc8swi3u8Dlg=;
        b=vqzAkTQ42n997JbrvglJfJuexQRV6SqlYvm28/feMx6Nj6Ndr0zYyeFVI1KJUCqLyr
         ujE3lIcsS5OTpKNEValbrhW4vMoRXak+f81SDeZMKcDCQii5YMeRX0ob+3L61KVatELx
         icyIsGTFGXT5LGbRy3HfNyqVrJSLCA7Ri3W7Qc1h180pcMd3O7Z/M+ThFoI7krQaIhq8
         EUm99wTWjbbeBb+4K1tZKKhzf5PBilwANvYDEvhMl0QTNgrYjxnoUcm6AdtL8VSqLjHW
         jHwUQHsheIfGdzi4UfSqUHMDba9FMij5vub4Es/a3246Da6+RC87A0l/c7NQDg1syIin
         B9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7GfQG+sKNUFe8kKRZiVLdxc1h3BX3Djc8swi3u8Dlg=;
        b=XG5Yaz03whRA3TZAYcTOM7UtZjO96sqTswQuUUvxiOTYTHkG7py3Wo+0RTBe2XmwEM
         M1AkEhc1DQIrEC8KrWUGDIUH3HAwj/QjnApZ7Ho5Xod6YSR4cgAhdGT1WakhtBK8ve2m
         DknV23c+FBTERVoZDr8RUY97Z3JrN+nEA+i7TS4NK/pahwwT7sYbSChcyXvCfVwCpMZJ
         emBbq5YLz5q4crqEvKul4C/qBkOip3OF3KO1qFD2+2y6vyPy0ejjLZ8wyqAjSOo13ZBR
         VNdBDyAC+onLPxAsl25iQQh4Q8QzA15m3HC0ukf6j3u3oV6KEe21wnw9E6HUsHN+qCAe
         YwZw==
X-Gm-Message-State: AOAM531wwL8p7/zIr7yp0N2cVp75iEfcYFbz6sJCMwoB2F5bY+7rAYCI
        HtfjnZXVpEmnU6rglN6uuQm6jaor7cYdMZZo7mWXmg==
X-Google-Smtp-Source: ABdhPJy4J3oMmneoZGHbDel8CuQPKIQJWCOvZRFhk4NDP/nOu7CqKgEewV5ntWRWXX8gANIrmWN1PD8BJryw/VFPevs=
X-Received: by 2002:a17:902:d88e:b029:d0:89f4:6222 with SMTP id
 b14-20020a170902d88eb02900d089f46222mr6538920plz.10.1599759986870; Thu, 10
 Sep 2020 10:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Sep 2020 10:46:15 -0700
Message-ID: <CAKwvOdkbkvXdfXLzTNOj8m8_YWjL6=bSn4-AbRyd-5oYGJVNSw@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
To:     ian.bearman@microsoft.com
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ian,
It was nice to meet you at Linux plumbers.  You might want to take a
look at this series.  It implements builds of the Linux kernel with
LTO.  It would be good to get eyes on it and help review it from folks
working on this from the GCC angle.  The series has some configs that
split where Clang specific changes need to be made; it might be of
interest to think about what would the similar changes be needed for
GCC.  Also, congrats on your LWN article!
https://lwn.net/Articles/830300/

On Thu, Sep 3, 2020 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).
>
> In addition to performance, the primary motivation for LTO is
> to allow Clang's Control-Flow Integrity (CFI) to be used in the
> kernel. Google has shipped millions of Pixel devices running three
> major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
>
> Note that patches 1-4 are not directly related to LTO, but are
> needed to compile LTO kernels with ToT Clang, so I'm including them
> in the series for your convenience:
>
>  - Patches 1-3 are required for building the kernel with ToT Clang,
>    and IAS, and patch 4 is needed to build allmodconfig with LTO.
>
>  - Patches 3-4 are already in linux-next, but not yet in 5.9-rc.
>
> ---
> Changes in v2:
>
>   - Fixed -Wmissing-prototypes warnings with W=1.
>
>   - Dropped cc-option from -fsplit-lto-unit and added .thinlto-cache
>     scrubbing to make distclean.
>
>   - Added a comment about Clang >=11 being required.
>
>   - Added a patch to disable LTO for the arm64 KVM nVHE code.
>
>   - Disabled objtool's noinstr validation with LTO unless enabled.
>
>   - Included Peter's proposed objtool mcount patch in the series
>     and replaced recordmcount with the objtool pass to avoid
>     whitelisting relocations that are not calls.
>
>   - Updated several commit messages with better explanations.
>
>
> Arvind Sankar (2):
>   x86/boot/compressed: Disable relocation relaxation
>   x86/asm: Replace __force_order with memory clobber
>
> Luca Stefani (1):
>   RAS/CEC: Fix cec_init() prototype
>
> Nick Desaulniers (1):
>   lib/string.c: implement stpcpy
>
> Peter Zijlstra (1):
>   objtool: Add a pass for generating __mcount_loc
>
> Sami Tolvanen (23):
>   objtool: Don't autodetect vmlinux.o
>   kbuild: add support for objtool mcount
>   x86, build: use objtool mcount
>   kbuild: add support for Clang LTO
>   kbuild: lto: fix module versioning
>   kbuild: lto: postpone objtool
>   kbuild: lto: limit inlining
>   kbuild: lto: merge module sections
>   kbuild: lto: remove duplicate dependencies from .mod files
>   init: lto: ensure initcall ordering
>   init: lto: fix PREL32 relocations
>   PCI: Fix PREL32 relocations for LTO
>   modpost: lto: strip .lto from module names
>   scripts/mod: disable LTO for empty.c
>   efi/libstub: disable LTO
>   drivers/misc/lkdtm: disable LTO for rodata.o
>   arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
>   arm64: vdso: disable LTO
>   KVM: arm64: disable LTO for the nVHE directory
>   arm64: allow LTO_CLANG and THINLTO to be selected
>   x86, vdso: disable LTO only for vDSO
>   x86, relocs: Ignore L4_PAGE_OFFSET relocations
>   x86, build: allow LTO_CLANG and THINLTO to be selected
>
>  .gitignore                            |   1 +
>  Makefile                              |  65 ++++++-
>  arch/Kconfig                          |  67 +++++++
>  arch/arm64/Kconfig                    |   2 +
>  arch/arm64/Makefile                   |   1 +
>  arch/arm64/kernel/vdso/Makefile       |   4 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile      |   4 +-
>  arch/x86/Kconfig                      |   3 +
>  arch/x86/Makefile                     |   5 +
>  arch/x86/boot/compressed/Makefile     |   2 +
>  arch/x86/boot/compressed/pgtable_64.c |   9 -
>  arch/x86/entry/vdso/Makefile          |   5 +-
>  arch/x86/include/asm/special_insns.h  |  28 +--
>  arch/x86/kernel/cpu/common.c          |   4 +-
>  arch/x86/tools/relocs.c               |   1 +
>  drivers/firmware/efi/libstub/Makefile |   2 +
>  drivers/misc/lkdtm/Makefile           |   1 +
>  drivers/ras/cec.c                     |   9 +-
>  include/asm-generic/vmlinux.lds.h     |  11 +-
>  include/linux/init.h                  |  79 +++++++-
>  include/linux/pci.h                   |  19 +-
>  kernel/trace/Kconfig                  |   5 +
>  lib/string.c                          |  24 +++
>  scripts/Makefile.build                |  55 +++++-
>  scripts/Makefile.lib                  |   6 +-
>  scripts/Makefile.modfinal             |  31 ++-
>  scripts/Makefile.modpost              |  26 ++-
>  scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
>  scripts/link-vmlinux.sh               |  94 ++++++++-
>  scripts/mod/Makefile                  |   1 +
>  scripts/mod/modpost.c                 |  16 +-
>  scripts/mod/modpost.h                 |   9 +
>  scripts/mod/sumversion.c              |   6 +-
>  scripts/module-lto.lds                |  26 +++
>  tools/objtool/builtin-check.c         |  13 +-
>  tools/objtool/builtin.h               |   2 +-
>  tools/objtool/check.c                 |  83 ++++++++
>  tools/objtool/check.h                 |   1 +
>  tools/objtool/objtool.h               |   1 +
>  39 files changed, 883 insertions(+), 108 deletions(-)
>  create mode 100755 scripts/generate_initcall_order.pl
>  create mode 100644 scripts/module-lto.lds
>
>
> base-commit: e28f0104343d0c132fa37f479870c9e43355fee4
> --
> 2.28.0.402.g5ffc5be6b7-goog
>


-- 
Thanks,
~Nick Desaulniers
