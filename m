Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8963FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5788A206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Yu41Qiek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFDS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgFDS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:57:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E13C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 11:57:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so3898597pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=x8TeNbeX47VlJr4ytm2nmwX/C12Vbww0juHrTV1hnpI=;
        b=Yu41QiekavR3LuHQhEaGdp1xnnE0odpHxlhtP56p1OBe6UEzTar/zSEB9KurLNZwQP
         VAhXPVj4YEcEQXGImbC43W9yTco3LDws4SdBVfJhu1Y2Q/33awR+ZlSeyyCoWiDeRY2K
         BEk6/lJfLEdVHtdauOWKfZ0dsMtTqEnoBn4wJpsigkCm8DoqEfhtd9LZ0woWXxcyqvQ9
         kC7MsWit5tufw1UBXQt1lB1EOvdMxJlWJpuscUkX3tN8O5Qh/VM4clFRPwquoV385sdm
         jXDdhdBm3+tfWLey9TV/gfi2axtsRsE48A5oS50o0ch4X01H+PYiFxqyWVqQig47YISQ
         qSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=x8TeNbeX47VlJr4ytm2nmwX/C12Vbww0juHrTV1hnpI=;
        b=qXi1/iJf67imCqu26AcP+gTEmlFW2h7GZlTBs2rI+NkbkGu5VUQaU/mMLN72yUtoeb
         2Cpl5fOP3kFlXlw5KO2dYnARmbQ7xJRcaK5wZWFN22k0pGg3UqMDAVMl+fdtALZGSShT
         kEgWq6DzYIUgHPNWeG8ZDLwk3EZ6P77Aht9ctl19wXTqrhmCu1OUHvfjCKDtDCCylgoV
         VsUpZT8t9Hj3tFpWFXvz8NKnUhms1zKtMzZSrWHvzuivD/vjel9DbAeg+XKA8AGx29X+
         BAcZEr5SBMK8rO37o8UXEGuEkwCkKcqLPlO7WdOFVNfi8Leaxc2lUgiFZBRMYl2FzDR4
         MENw==
X-Gm-Message-State: AOAM530UVKX5L8KZz3JyM8FA4vW/Kq6fHlRvWqa536VimtCQheoIkuRy
        el04tFikL1YAedZAySGbE/kq4Jtd48YmDA==
X-Google-Smtp-Source: ABdhPJwm5cs4Y7Kn5MQv209qRC18xQ4hfmpd0wRzl8FCOohp4Eynz1xmoRWdTTnfrNm5E9lnq4zDTQ==
X-Received: by 2002:a63:9d0e:: with SMTP id i14mr5564137pgd.55.1591297045776;
        Thu, 04 Jun 2020 11:57:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g17sm1360814pju.11.2020.06.04.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 11:57:25 -0700 (PDT)
Date:   Thu, 04 Jun 2020 11:57:25 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 11:56:43 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.8 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-8ec4417a-1930-4582-b309-e510ebbfb37c@palmerdabbelt-glaptop1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.8-mw0

for you to fetch changes up to 09c0533d129ce460e6214c14f744ddbac3733889:

  soc: sifive: l2 cache: Mark l2_get_priv_group as static (2020-05-28 15:57:49 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.8 Merge Window, Part 1

* The remainder of the code necessary to support the Kendryte K210.
    * Support for building device trees into the kernel, as the K210 doesn't
      have a bootloader that provides one.
    * A K210 device tree and the associated defconfig update.
    * Support for skipping PMP initialization on systems that trap on PMP
      accesses rather than treating them as WARL.
* Support for KGDB.
* Improvements to text patching.
* Some cleanups to the SiFive L2 cache driver.

I may have a second part, but I wanted to get this out earlier rather than
later as they've been ready to go for a while now.

----------------------------------------------------------------
Damien Le Moal (1):
      riscv: K210: Update defconfig

Palmer Dabbelt (5):
      riscv: Allow device trees to be built into the kernel
      riscv: K210: Add a built-in device tree
      RISC-V: Skip setting up PMPs on traps
      soc: sifive: l2 cache: Eliminate an unsigned zero compare warning
      soc: sifive: l2 cache: Mark l2_get_priv_group as static

Vincent Chen (4):
      kgdb: Add kgdb_has_hit_break function
      riscv: Add KGDB support
      riscv: Use the XML target descriptions to report 3 system registers
      riscv: Add SW single-step support for KDB

Yash Shah (2):
      riscv: cacheinfo: Implement cache_get_priv_group with a generic ops structure
      riscv: Add support to determine no. of L2 cache way enabled

Zong Li (3):
      riscv: Remove the 'riscv_' prefix of function name
      riscv: Use NOKPROBE_SYMBOL() instead of __krpobes annotation
      riscv: Use text_mutex instead of patch_lock

 arch/riscv/Kbuild                       |   1 +
 arch/riscv/Kconfig                      |   7 +
 arch/riscv/Kconfig.socs                 |  17 +-
 arch/riscv/boot/dts/Makefile            |   2 +
 arch/riscv/boot/dts/kendryte/Makefile   |   4 +-
 arch/riscv/configs/nommu_k210_defconfig |   7 +-
 arch/riscv/include/asm/cacheinfo.h      |  15 ++
 arch/riscv/include/asm/gdb_xml.h        | 117 ++++++++++
 arch/riscv/include/asm/kdebug.h         |  12 +
 arch/riscv/include/asm/kgdb.h           | 112 +++++++++
 arch/riscv/include/asm/parse_asm.h      | 219 ++++++++++++++++++
 arch/riscv/include/asm/patch.h          |   4 +-
 arch/riscv/include/asm/soc.h            |  39 ++++
 arch/riscv/kernel/Makefile              |   1 +
 arch/riscv/kernel/cacheinfo.c           |  17 ++
 arch/riscv/kernel/ftrace.c              |  15 +-
 arch/riscv/kernel/head.S                |  11 +-
 arch/riscv/kernel/kgdb.c                | 390 ++++++++++++++++++++++++++++++++
 arch/riscv/kernel/patch.c               |  46 ++--
 arch/riscv/kernel/setup.c               |   4 +
 arch/riscv/kernel/soc.c                 |  27 +++
 arch/riscv/kernel/traps.c               |   5 +
 arch/riscv/kernel/vmlinux.lds.S         |   5 +
 arch/riscv/mm/init.c                    |   9 +
 drivers/soc/kendryte/k210-sysctl.c      |  12 +
 drivers/soc/sifive/sifive_l2_cache.c    |  40 +++-
 kernel/debug/debug_core.c               |  12 +
 27 files changed, 1119 insertions(+), 31 deletions(-)
 create mode 100644 arch/riscv/include/asm/cacheinfo.h
 create mode 100644 arch/riscv/include/asm/gdb_xml.h
 create mode 100644 arch/riscv/include/asm/kdebug.h
 create mode 100644 arch/riscv/include/asm/kgdb.h
 create mode 100644 arch/riscv/include/asm/parse_asm.h
 create mode 100644 arch/riscv/kernel/kgdb.c
