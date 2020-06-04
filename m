Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09984206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="tkKxIKie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgFDTu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgFDTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:50:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320AC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:50:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so6895488wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QO/6BjeguK8mrA6fllmvZIM7gHNPpG49boXFPpogN34=;
        b=tkKxIKiewto63M0SG2qFNXDBFpvfEqEPLNbJ8Zt60F1dAEevH9OJNLF1P+0KgFtdBj
         k/0pW7c4qBMDe0CTv3ro6o1KmeNreTlxtNAxMxqX6rkBmUBljzvyCfdCTqqGeuzK8nA1
         TQrjc1CY2Pu1fAMcz7J5P2RwrycTNb3tBlCzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO/6BjeguK8mrA6fllmvZIM7gHNPpG49boXFPpogN34=;
        b=NaP3R1USrYd7MjuyCnag6Lt4TrrdOVuN9vCRx8GNpJMWkr2Qkwgg6ywaDMlUIKYrLy
         +waQuKjtVaGm2WyJFeDCISXP1T1gVRQOS3s+qOlg5kjXoYWzTVr3Bf50J75LZGtP8mbv
         st6yU/h68o9kbeAUZy3k58hU/Y08rU+Wpg5J3SPZzWZc83CdxOQ0y3VCTOJHy2q1HxWe
         koI1sA9RU9hpm9KW/BX5hIyCM0Uad5zp/WMvFnXzspez032nTXRlBhJIAqD6Sfvi5J0S
         /T7p+Qt0skFTtokcd4LjxqUw/Fw0MFIOLDwQGp/IFw7Vqs5xp+zsDWw3toVfQddx+KNH
         7myQ==
X-Gm-Message-State: AOAM5333BG38rrJK8T3JVaR36UXz1ULVG9MkGBcuDEjSmFrkHyfWQ7PH
        QDH7yLe27y8NOiejsO8yZCkLNaWx5LTk1pAi7mVZEiZyFg==
X-Google-Smtp-Source: ABdhPJwHOjBmi4ly0fIxjA1zlig8yDFzdQsiZsMihqgNdo7kxsnP4tWA9/snPEG0UtfOn6ZL/LcnnZeFKhO8gjGg9Fk=
X-Received: by 2002:a7b:c622:: with SMTP id p2mr5478154wmk.55.1591300224725;
 Thu, 04 Jun 2020 12:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 4 Jun 2020 12:50:13 -0700
Message-ID: <CAOnJCU+jkYSVa-vMjabdnRpubK0c52VgjjVreC=07L_Vr3C64g@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 11:57 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:
>
>   Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw0
>
> for you to fetch changes up to 09c0533d129ce460e6214c14f744ddbac3733889:
>
>   soc: sifive: l2 cache: Mark l2_get_priv_group as static (2020-05-28 15:57:49 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.8 Merge Window, Part 1
>
> * The remainder of the code necessary to support the Kendryte K210.
>     * Support for building device trees into the kernel, as the K210 doesn't
>       have a bootloader that provides one.
>     * A K210 device tree and the associated defconfig update.
>     * Support for skipping PMP initialization on systems that trap on PMP
>       accesses rather than treating them as WARL.
> * Support for KGDB.
> * Improvements to text patching.
> * Some cleanups to the SiFive L2 cache driver.
>
> I may have a second part, but I wanted to get this out earlier rather than
> later as they've been ready to go for a while now.
>
Hi Palmer,
Can you also add the run time cpu hotplug fix patch if it is not too late?

https://patchwork.kernel.org/patch/11581221/

Without the patch, cpu hotplug will broken for 5.8-rc1 too.

> ----------------------------------------------------------------
> Damien Le Moal (1):
>       riscv: K210: Update defconfig
>
> Palmer Dabbelt (5):
>       riscv: Allow device trees to be built into the kernel
>       riscv: K210: Add a built-in device tree
>       RISC-V: Skip setting up PMPs on traps
>       soc: sifive: l2 cache: Eliminate an unsigned zero compare warning
>       soc: sifive: l2 cache: Mark l2_get_priv_group as static
>
> Vincent Chen (4):
>       kgdb: Add kgdb_has_hit_break function
>       riscv: Add KGDB support
>       riscv: Use the XML target descriptions to report 3 system registers
>       riscv: Add SW single-step support for KDB
>
> Yash Shah (2):
>       riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
>       riscv: Add support to determine no. of L2 cache way enabled
>
> Zong Li (3):
>       riscv: Remove the 'riscv_' prefix of function name
>       riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
>       riscv: Use text_mutex instead of patch_lock
>
>  arch/riscv/Kbuild                       |   1 +
>  arch/riscv/Kconfig                      |   7 +
>  arch/riscv/Kconfig.socs                 |  17 +-
>  arch/riscv/boot/dts/Makefile            |   2 +
>  arch/riscv/boot/dts/kendryte/Makefile   |   4 +-
>  arch/riscv/configs/nommu_k210_defconfig |   7 +-
>  arch/riscv/include/asm/cacheinfo.h      |  15 ++
>  arch/riscv/include/asm/gdb_xml.h        | 117 ++++++++++
>  arch/riscv/include/asm/kdebug.h         |  12 +
>  arch/riscv/include/asm/kgdb.h           | 112 +++++++++
>  arch/riscv/include/asm/parse_asm.h      | 219 ++++++++++++++++++
>  arch/riscv/include/asm/patch.h          |   4 +-
>  arch/riscv/include/asm/soc.h            |  39 ++++
>  arch/riscv/kernel/Makefile              |   1 +
>  arch/riscv/kernel/cacheinfo.c           |  17 ++
>  arch/riscv/kernel/ftrace.c              |  15 +-
>  arch/riscv/kernel/head.S                |  11 +-
>  arch/riscv/kernel/kgdb.c                | 390 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/patch.c               |  46 ++--
>  arch/riscv/kernel/setup.c               |   4 +
>  arch/riscv/kernel/soc.c                 |  27 +++
>  arch/riscv/kernel/traps.c               |   5 +
>  arch/riscv/kernel/vmlinux.lds.S         |   5 +
>  arch/riscv/mm/init.c                    |   9 +
>  drivers/soc/kendryte/k210-sysctl.c      |  12 +
>  drivers/soc/sifive/sifive_l2_cache.c    |  40 +++-
>  kernel/debug/debug_core.c               |  12 +
>  27 files changed, 1119 insertions(+), 31 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>  create mode 100644 arch/riscv/include/asm/gdb_xml.h
>  create mode 100644 arch/riscv/include/asm/kdebug.h
>  create mode 100644 arch/riscv/include/asm/kgdb.h
>  create mode 100644 arch/riscv/include/asm/parse_asm.h
>  create mode 100644 arch/riscv/kernel/kgdb.c
>


-- 
Regards,
Atish
