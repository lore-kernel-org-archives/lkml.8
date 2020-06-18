Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17AB92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gd24eF75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgFRM0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFRMZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:25:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2094C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so6570776wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL1DIO0Um282w1LusP3OkbueNNi/xXncIiGXY/5CLKU=;
        b=gd24eF75g+GeGHpy1q5qd4YNJzVzElMcEoE+UqRCGCiSkmANcjHRQaAM+NNIvoJ4H8
         oP4inNjea9XXfxyGdveSPCiNoaZ6r9kH/slrN3XgOu5R2f79Ek3NG3gW0wzHuALF3qfq
         gW1ee9PvqyEWvRjGmRUjjJ2ECq4E5mUx53mbVpG7lIESu5LvmNusvl6VtskiEEXi+G1z
         suZu1BM85BwNItFsCIXbILtAd5LDzu0PYx45ycDkM4CBqnLE4h2sd8gn5zBGmtX8oORK
         P38Y/6Gd1elWy8InUF2ZR6bh08viP754JWJXnr8H1jE/GjY83iPKqC9iYNYSS/fM9GzB
         EzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tL1DIO0Um282w1LusP3OkbueNNi/xXncIiGXY/5CLKU=;
        b=fHdujIEAwdqKJ49m+mtNrAzgFKJtBJJ5P+v5SnKmHzzEAK4Pj+mwThUqWk0EofrUQi
         UULEdLYCNeU/YF2EbJ4AN2BhMT6h8gERkRGulpi7Fm4xRUN8QpNNx7tVWjk/BIUIIsbB
         2zTjqG4f1sk5joHXO4iS6MJ7LF2EbLIMqvrFc5iA/ymhOjVv7lipZReu/fBVXcSLmYu+
         xSkUqWgkMxP3BrzKHwrsRR8HBaXHBlZBEmTsJ78Jtlgr7o01h5pANYBH7QXryY/sIiIU
         vIYbaBqHPUQ20IqLzp/ic9AchJ2vuAAuYOKGXlr32C+yRBUQXTgvgkIRWQ21IsTYC3zM
         6XqQ==
X-Gm-Message-State: AOAM530eROfVaaZrws1JV0Q6sh+IS/Kzld27u8HFCn+UPn8RiTKO1PtB
        fc97y3aMMXrR4dAajM0+IuQ5Iw==
X-Google-Smtp-Source: ABdhPJzo3QXG++Ce0NFW+yOOsp1n8WoCq7YAkbgNHM8sTdEjItNvZO5CyQBXSHzTSazAiBiu27JalQ==
X-Received: by 2002:a1c:544a:: with SMTP id p10mr3978511wmi.183.1592483149158;
        Thu, 18 Jun 2020 05:25:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:c1af:c724:158a:e200])
        by smtp.gmail.com with ESMTPSA id v7sm3469822wrp.45.2020.06.18.05.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:48 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 00/15] Split off nVHE hyp code
Date:   Thu, 18 Jun 2020 13:25:22 +0100
Message-Id: <20200618122537.9625-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor files in arch/arm64/kvm/hyp to compile all code which runs in EL2
under nVHE into separate object files from the rest of KVM. This is done in
preparation for being able to unmap hyp code from EL1 and kernel code/data
from EL2 but has other benefits too, notably:
 * safe use of KASAN/UBSAN/GCOV instrumentation on VHE code,
 * no need for __hyp_text annotations.

nVHE-specific code is moved to hyp/nvhe and compiled with custom build rules
similar to those used by EFI stub. Shared source files are compiled under both
VHE and nVHE build rules. Where a source file contained both VHE and nVHE code,
it is split into a shared header file and two C source files. This is done one
file per commit to make review easier.

All nVHE symbols are prefixed with "__kvm_nvhe_" to avoid collisions with VHE
variants (also inspired by EFI stub). Since this prefixes unresolved symbols
too, image-vars.h contains a list of kernel symbol aliases where nVHE code
still refers to kernel proper. The list grows fairly large as the patch series
progresses and code is moved around, but at the end contains 20 symbols. These
remaining dependencies on kernel proper will be further reduced in the future.

No functional changes are intended but code was simplified whenever the
refactoring made it possible.

Tested by running kvm-unit-tests on QEMU 5.0 with VHE/nVHE and GIC v2/v3.

Dual compilation of code shared by VHE/nVHE increase the size of the kernel.
Bloat-o-meter vmlinux diff shows an increase of 21 KB on the ELF symbol level.
Size of Image.gz is up by 10 KB; size of Image is unchanged, presumably due
to ELF section alignment.

This is based off v5.8-rc1. Available in branch 'topic/el2-obj-v3' of git repo:
  https://android-kvm.googlesource.com/linux

Changes v2 -> v3:
 * rebase onto v5.8-rc1
 * remove patch changing hypcall interface to function IDs
 * move hyp-init.S to nVHE
 * fix symbol aliasing under CONFIG_ARM64_PSEUDO_NMI and CONFIG_ARM64_SVE
 * remove VHE's unused __kvm_enable_ssbs()
 * make nVHE use VHE's hyp_panic_string for consistent use of absolute relocs
   when returning pointers back to kernel
 * replace __noscs annotation (added to __hyp_text macro) with build rule

Changes v1 -> v2:
 * change nVHE symbol prefix from __hyp_text_ to __kvm_nvhe_
 * rename __HYPERVISOR__ macro to __KVM_NVHE_HYPERVISOR__
 * use hcall jump table instead of array of function pointers
 * drop patch to unify HVC callers
 * move __smccc_workaround_1_smc to own file
 * header guards for hyp/*.h
 * improve helpers for handling VHE/nVHE hyp syms in kernel proper
 * improve commit messages, cover letter

-David


Andrew Scull (2):
  arm64: kvm: Handle calls to prefixed hyp functions
  arm64: kvm: Move hyp-init.S to nVHE

David Brazdil (13):
  arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
  arm64: kvm: Move __smccc_workaround_1_smc to .rodata
  arm64: kvm: Add build rules for separate nVHE object files
  arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
  arm64: kvm: Split hyp/tlb.c to VHE/nVHE
  arm64: kvm: Split hyp/switch.c to VHE/nVHE
  arm64: kvm: Split hyp/debug-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/sysreg-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/timer-sr.c to VHE/nVHE
  arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
  arm64: kvm: Add comments around __kvm_nvhe_ symbol aliases
  arm64: kvm: Remove __hyp_text macro, use build rules instead
  arm64: kvm: Lift instrumentation restrictions on VHE

 arch/arm64/include/asm/kvm_asm.h         |  32 +-
 arch/arm64/include/asm/kvm_emulate.h     |   2 +-
 arch/arm64/include/asm/kvm_host.h        |  19 +-
 arch/arm64/include/asm/kvm_hyp.h         |  13 +-
 arch/arm64/include/asm/kvm_mmu.h         |  16 +-
 arch/arm64/include/asm/mmu.h             |   7 -
 arch/arm64/kernel/cpu_errata.c           |   4 +-
 arch/arm64/kernel/image-vars.h           |  50 ++
 arch/arm64/kvm/Makefile                  |   2 +-
 arch/arm64/kvm/arm.c                     |   8 +-
 arch/arm64/kvm/hyp/Makefile              |  11 +-
 arch/arm64/kvm/hyp/aarch32.c             |   6 +-
 arch/arm64/kvm/hyp/debug-sr.c            | 210 +------
 arch/arm64/kvm/hyp/debug-sr.h            | 170 +++++
 arch/arm64/kvm/hyp/entry.S               |   1 -
 arch/arm64/kvm/hyp/fpsimd.S              |   1 -
 arch/arm64/kvm/hyp/hyp-entry.S           |  21 +-
 arch/arm64/kvm/hyp/nvhe/Makefile         |  43 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c       |  77 +++
 arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S |   0
 arch/arm64/kvm/hyp/nvhe/switch.c         | 271 ++++++++
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c      |  56 ++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c       |  43 ++
 arch/arm64/kvm/hyp/nvhe/tlb.c            |  68 ++
 arch/arm64/kvm/hyp/smccc_wa.S            |  30 +
 arch/arm64/kvm/hyp/switch.c              | 749 +----------------------
 arch/arm64/kvm/hyp/switch.h              | 504 +++++++++++++++
 arch/arm64/kvm/hyp/sysreg-sr.c           | 215 +------
 arch/arm64/kvm/hyp/sysreg-sr.h           | 204 ++++++
 arch/arm64/kvm/hyp/timer-sr.c            |  38 +-
 arch/arm64/kvm/hyp/tlb.c                 | 169 +----
 arch/arm64/kvm/hyp/tlb.h                 | 131 ++++
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |   4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c          | 130 ++--
 arch/arm64/kvm/mmu.c                     |   2 +-
 arch/arm64/kvm/va_layout.c               |   2 +-
 scripts/kallsyms.c                       |   1 +
 37 files changed, 1829 insertions(+), 1481 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/debug-sr.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/nvhe/debug-sr.c
 rename arch/arm64/kvm/{ => hyp/nvhe}/hyp-init.S (100%)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/switch.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/timer-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/smccc_wa.S
 create mode 100644 arch/arm64/kvm/hyp/switch.h
 create mode 100644 arch/arm64/kvm/hyp/sysreg-sr.h
 create mode 100644 arch/arm64/kvm/hyp/tlb.h

-- 
2.27.0

