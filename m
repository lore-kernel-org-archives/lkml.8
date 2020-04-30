Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC230C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57CD2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5oxdiVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD3Osp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3Oso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:48:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A213C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so2185839wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNF6UHAWqMkyYuIU0QRud/LtidR5txVpCjgq6hRS/rs=;
        b=G5oxdiVzQ6WQl8M6UOHfwP4pdHBU+qv5OHGvlNbCBI0z9EBiG+qssCu1yXAnrFN8gv
         lfko0Ni7uJjsvIxBetErtcwMm+mV2hclOUvBYr+lHY8ApffvotwdYZ9dxALl9nv92YtG
         ROYpq0EMuXYqoMaD8whW/Fjg8RSl+BhJYFo1rMpfzXKwF1hZRGTBo0M+YcbGHkp6zzbT
         G1k70B02KruRIlOfpfIyHn1hA+13411yMCiF3hwc3ZYt+xhsDWBoy8vjYIfZ/Y6/KMcN
         AzA0R3zvornaAnFTrqqiD/YsU76Cz4LdR6w7VuvVnoVzWhYndo+J2qimTWachzUtMCKQ
         5PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SNF6UHAWqMkyYuIU0QRud/LtidR5txVpCjgq6hRS/rs=;
        b=NWA2YUev0hEo4drXlgzh4HVNNG2X72bJt7UumuiI7/qZ1FXHML/Bl4HoFaGgLve3NO
         iyaTiHTmlikPKbl4dJRolLk1DnletI+Zc8HQicXepK9TjKTK4+Z5DHkeEGTGh8Rf1VU8
         mNFzp+VhOxSwy+rbKeA6/yAtZCpIY9ltkW4p0Gcd6379mMBxeH0uZmb46zq0Fmpj7i/n
         VJSLgr8Zbz6AqF/4vehriVvNrDHz6ih1oP6hg5qwAl2pdRiXjzENRHgTgqioqdvbbtRc
         4159hcmXmoOqwP7R1YXKyPKEaiPigbWJx5FtmutWEFprP7qbzrMwACM8bBajkMcYs2fC
         hgQw==
X-Gm-Message-State: AGi0PuYdrzlEuwI1AGi2rw1rot3WPOMEOcnqOc27STRpB7pdTt0VjMyf
        NpR0c7HsNgbKsBsLuoNamcb70A==
X-Google-Smtp-Source: APiQypKNM79/w8ZSyytfmzDWXe1CAhLCYA5tA2YOUJb4Z3naBNIFJxsLCPvYaCkYw96MVWpA4gCx5w==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr3222316wmj.113.1588258122596;
        Thu, 30 Apr 2020 07:48:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d4b6:9828:8bd2:ce6f])
        by smtp.gmail.com with ESMTPSA id s8sm4287714wru.38.2020.04.30.07.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 07:48:41 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 00/15] Split off nVHE hyp code
Date:   Thu, 30 Apr 2020 15:48:16 +0100
Message-Id: <20200430144831.59194-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor files in arch/arm64/kvm/hyp to compile all code which runs in EL2
under nVHE into separate object files from the rest of KVM. This is done in
preparation for being able to unmap .hyp.text from EL1 but has other benefits,
notably:
 * safe use of KASAN/UBSAN/GCOV instrumentation on VHE code,
 * cleaner HVC API,
 * no need for __hyp_text annotations.

nVHE-specific code is moved to hyp/nvhe and compiled with custom build rules
similar to those used by EFI stub. Shared source files are compiled under both
VHE and nVHE build rules. Where a source file contained both VHE and nVHE code,
it is split into a shared header file and two C source files. This is done one
file per commit to make review easier.

All nVHE symbols are prefixed with "__hyp_text_" to avoid collisions with VHE
variants (also inspired by EFI stub). Since this prefixes unresolved symbols
too, image-vars.h contains a list of kernel symbol aliases where nVHE code
still refers to kernel proper. This list will be further reduced in the future.

No functional changes are intended but code was simplified whenever the
refactoring made it possible.

Tested by running kvm-unit-tests on QEMU 5.0 with VHE/nVHE and GIC v2/v3.

This is based off Fuad Tabba's patch series "KVM: arm64: Tidy up arch Kconfig
and Makefiles". Available in branch 'topic/el2-obj' of git repo:
  https://android-kvm.googlesource.com/linux

-David

David Brazdil (13):
  arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
  arm64: kvm: Add build rules for separate nVHE object files
  arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
  arm64: kvm: Move __smccc_workaround_1_smc to .rodata
  arm64: kvm: Split hyp/tlb.c to VHE/nVHE
  arm64: kvm: Split hyp/switch.c to VHE/nVHE
  arm64: kvm: Split hyp/debug-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/sysreg-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/timer-sr.c to VHE/nVHE
  arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
  arm64: kvm: Add comments around __hyp_text_ symbol aliases
  arm64: kvm: Remove __hyp_text macro, use build rules instead
  arm64: kvm: Lift instrumentation restrictions on VHE

Quentin Perret (2):
  arm64: kvm: Unify users of HVC instruction
  arm64: kvm: Formalize host-hyp hypcall ABI

 arch/arm64/include/asm/kvm_asm.h             |  26 +-
 arch/arm64/include/asm/kvm_emulate.h         |   2 +-
 arch/arm64/include/asm/kvm_host.h            |  32 +-
 arch/arm64/include/asm/kvm_host_hypercalls.h |  62 ++
 arch/arm64/include/asm/kvm_hyp.h             |  15 +-
 arch/arm64/include/asm/kvm_mmu.h             |  13 +-
 arch/arm64/include/asm/mmu.h                 |   7 -
 arch/arm64/include/asm/virt.h                |  33 +-
 arch/arm64/kernel/cpu_errata.c               |   2 +-
 arch/arm64/kernel/hyp-stub.S                 |  34 -
 arch/arm64/kernel/image-vars.h               |  44 ++
 arch/arm64/kvm/arm.c                         |   6 +-
 arch/arm64/kvm/hyp.S                         |  13 +-
 arch/arm64/kvm/hyp/Makefile                  |  12 +-
 arch/arm64/kvm/hyp/aarch32.c                 |   6 +-
 arch/arm64/kvm/hyp/debug-sr.c                | 214 +-----
 arch/arm64/kvm/hyp/debug-sr.h                | 165 +++++
 arch/arm64/kvm/hyp/entry.S                   |   1 -
 arch/arm64/kvm/hyp/fpsimd.S                  |   1 -
 arch/arm64/kvm/hyp/hyp-entry.S               |  62 +-
 arch/arm64/kvm/hyp/nvhe/Makefile             |  42 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  77 +++
 arch/arm64/kvm/hyp/nvhe/host_hypercall.c     |  22 +
 arch/arm64/kvm/hyp/nvhe/switch.c             | 271 ++++++++
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c          |  56 ++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c           |  43 ++
 arch/arm64/kvm/hyp/nvhe/tlb.c                |  67 ++
 arch/arm64/kvm/hyp/switch.c                  | 688 +------------------
 arch/arm64/kvm/hyp/switch.h                  | 438 ++++++++++++
 arch/arm64/kvm/hyp/sysreg-sr.c               | 227 +-----
 arch/arm64/kvm/hyp/sysreg-sr.h               | 211 ++++++
 arch/arm64/kvm/hyp/timer-sr.c                |  38 +-
 arch/arm64/kvm/hyp/tlb.c                     | 168 +----
 arch/arm64/kvm/hyp/tlb.h                     | 126 ++++
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c     |   4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c              | 130 ++--
 arch/arm64/kvm/va_layout.c                   |   2 +-
 scripts/kallsyms.c                           |   1 +
 38 files changed, 1887 insertions(+), 1474 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_host_hypercalls.h
 create mode 100644 arch/arm64/kvm/hyp/debug-sr.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/nvhe/debug-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/host_hypercall.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/switch.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/timer-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/switch.h
 create mode 100644 arch/arm64/kvm/hyp/sysreg-sr.h
 create mode 100644 arch/arm64/kvm/hyp/tlb.h

-- 
2.26.1

