Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA919C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99778206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv1TwQ4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCMTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:52:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37630 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:52:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id z25so9809639qkj.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDh+B8ezDyS7P1M5dHGOp61NFK6nBb9D6/mMiEKkThY=;
        b=gv1TwQ4WfMGa0bIyP7sheC/vrqt7SmVT1bAgS4wl30b5vBvEg9G3tI7pkK36AuTy8Z
         8QdwdpLpxEsdUYUxQKW7Az8sxO/GoYbmEt4zox1v7PYz+59BUXX+336Ut1INvj5nt4mw
         vwt7SVKxmTniNlRVn56RVaL1ON8x5O/GQiawHzXT1ddchhX439SfxNaEbQ9bGYNA6zP7
         qnN4PTyUKvqmfSDb1BwcxA+taeI+e6m+pFzSykjzednNa5L1A8/ZuDt9vSxq8YqfBQpp
         0UWOB1V6pwaBuzCkwzvjWVyectvj6SDqqYSzFp49X65rTjO6yOt8s38TmWoEYt2f+DHd
         +Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eDh+B8ezDyS7P1M5dHGOp61NFK6nBb9D6/mMiEKkThY=;
        b=RvpAbtG4RwME5JdvLcEqYH/s6taFWolxeZ7doi943aS6s/ljAXObmWNViFJcNH3qf/
         GvX5MzQZgTaWfaJfFb8JNMl2O5h1+O9sz5FMZFBSkOeOO93bdHq4NDc/g1Whp8xeNDQE
         oCevr4WhcIk3Qp6wLEI++Zl+o82S0zZ4g1fCqnj550Ihs/6ntFZnh2rXqTinox2Esdqr
         DZutHEetQend7LLGMe+6DANwkhyDHBAX7ExWYnyRTDaDCXxQ0Zi/TJCxl2QNTAr+i/2n
         We28iLndt0tfTG2dcgr4EUtbPqBVlOgHLKTvnNH5QjfeCsGh7yeir7qaqX/EXhUDZFnz
         5F+w==
X-Gm-Message-State: ANhLgQ3QHgEXjcUqgd25qR27ocgW48IiEwRIlQrGhLDoIDMf+7Pl+dTR
        0buA9SbuSsnfRjxr8rRdrziuYnw=
X-Google-Smtp-Source: ADFU+vs8oyPEjGCxkZJzqb1FopUx8jhGJeEZLfiq2SRn6qL03D6jXwG7eOfjpnfvwy9JOgDOmUO+2A==
X-Received: by 2002:a37:6357:: with SMTP id x84mr12291892qkb.490.1584129128966;
        Fri, 13 Mar 2020 12:52:08 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id i28sm31475599qtc.57.2020.03.13.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 12:52:08 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 00/18] x86: syscall wrapper cleanups
Date:   Fri, 13 Mar 2020 15:51:26 -0400
Message-Id: <20200313195144.164260-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series cleans up the x86 syscall wrapper code and converts
the 32-bit native kernel over to pt_regs based syscalls.  This makes
the 32-bit syscall interface consistent with 64-bit, and a bit more
effecient by not blindly pushing all 6 potential arguments onto the
stack.

Changes since v3:
- Addressed feedback from v3
- Split the X32 syscall table into its own file
- Move the ABI prefix from the syscall table to the wrapper macros
- Additional cleanups
- Changed series title due to broader scope

Changes since v2:
- Moved adding the [compat_]sys_ prefix to the ABI-level macros

Changes since v1:
- Split patch 1 into multiple patches
- Updated comments and patch notes to clarify changes

Brian Gerst (18):
  x86, syscalls: Refactor SYSCALL_DEFINEx macros
  x86, syscalls: Refactor SYSCALL_DEFINE0 macros
  x86, syscalls: Refactor COND_SYSCALL macros
  x86, syscalls: Refactor SYS_NI macros
  x86-64: Use syscall wrappers for x32_rt_sigreturn
  x86-64: Move sys_ni_syscall stub to common.c
  x86-64: Split X32 syscall table into its own file
  x86: Move max syscall number calculation to syscallhdr.sh
  x86-64: Remove ptregs qualifier from syscall table
  x86: Remove syscall qualifier support
  x86-64: Add __SYSCALL_COMMON()
  x86: Remove ABI prefixes from functions in syscall tables
  x86: Clean up syscall_32.tbl
  x86, syscalls: Rename 32-bit specific syscalls
  x86: Use IA32-specific wrappers for syscalls taking 64-bit arguments
  x86-32: Enable pt_regs based syscalls
  x86: Drop asmlinkage from syscalls
  x86: Remove unneeded includes

 arch/x86/Kconfig                            |   2 +-
 arch/x86/entry/Makefile                     |   1 +
 arch/x86/entry/common.c                     |  18 +-
 arch/x86/entry/syscall_32.c                 |  19 +-
 arch/x86/entry/syscall_64.c                 |  39 +-
 arch/x86/entry/syscall_x32.c                |  29 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 818 ++++++++++----------
 arch/x86/entry/syscalls/syscall_64.tbl      | 740 +++++++++---------
 arch/x86/entry/syscalls/syscallhdr.sh       |   7 +
 arch/x86/entry/syscalls/syscalltbl.sh       |  44 +-
 arch/x86/entry/vdso/vdso32/vclock_gettime.c |   1 +
 arch/x86/ia32/Makefile                      |   2 +-
 arch/x86/include/asm/sighandling.h          |   5 -
 arch/x86/include/asm/syscall.h              |  11 +-
 arch/x86/include/asm/syscall_wrapper.h      | 287 +++----
 arch/x86/include/asm/syscalls.h             |  34 -
 arch/x86/include/asm/unistd.h               |   7 +
 arch/x86/kernel/Makefile                    |   2 +
 arch/x86/kernel/asm-offsets_32.c            |   9 -
 arch/x86/kernel/asm-offsets_64.c            |  36 -
 arch/x86/kernel/ldt.c                       |   1 -
 arch/x86/kernel/process.c                   |   1 -
 arch/x86/kernel/process_32.c                |   1 -
 arch/x86/kernel/process_64.c                |   1 -
 arch/x86/kernel/signal.c                    |   4 +-
 arch/x86/{ia32 => kernel}/sys_ia32.c        | 143 ++--
 arch/x86/kernel/sys_x86_64.c                |   1 -
 arch/x86/um/Makefile                        |   1 +
 arch/x86/um/sys_call_table_32.c             |   6 +-
 arch/x86/um/sys_call_table_64.c             |   9 +-
 arch/x86/um/user-offsets.c                  |  15 -
 31 files changed, 1086 insertions(+), 1208 deletions(-)
 create mode 100644 arch/x86/entry/syscall_x32.c
 rename arch/x86/{ia32 => kernel}/sys_ia32.c (78%)

-- 
2.24.1

