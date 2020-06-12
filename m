Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDE020801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NqMKvKu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFLHKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFLHKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C445CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so3285478pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQZyIiBqc8KPdWdVqaey2IviWAM/6vRzniUCGgL2lS0=;
        b=NqMKvKu8SfII1N5LB8HmQ4nKLCgDNq/QVOTNwdGrhopXtJ6zghK/SW4C//kCe+67Vg
         xYnlsUo2GIaEnGN8D40HK8VcCNtwZK624oDUgaDCB/UTQiToPEK9zbJCyAFJFQPNCZoa
         4H236PyrB24fRPEyOJq/+pS43QLVQroyrqNgqQAp8NMCbsQfwCczQCkcbxT8ntTdtDRs
         GjHcaQDFq4fDWv0sEWpYUJtkWQmtnKIVEF4r7MmF4vHbB8yZImevsfeXDhvqHVwOL5i+
         MTXC6ANcnTHKa/LqtgYcPo8ZeUfS1K2fCrYvs937UMB+RQ6sy32Q6tpqWJmm9AMhsBTh
         YrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kQZyIiBqc8KPdWdVqaey2IviWAM/6vRzniUCGgL2lS0=;
        b=Eq3iBzZgxuOOqOkxpP6maVwyvKxzoZaXe7Bxm9fKimJiXF73aKOPdLq/NzsLl064fj
         7G/Hy0B3BL78cN4+1e+AoPYJGgyAM2a+2qYLpqeVq1Qn4OTndfnVy/0DVvDMH885kp1i
         toV8xJI4Iq5a3rPO3AmjH+5h3GSJnsukOmhCq24XpWgpIiOfZDpIEsPIy5BAvzm76AiK
         M+n3Tk1VE/90nBLAEqGr6YWUHThRYYr1X3iAK1n1nRaovCKAUAdP4YsigQZJLSbox5Ar
         giWEToBktFegKeGXenz8Y6JcyD0g/ZFIzlJCFo4J5wljwCKCqpWPzywGKGVANXP4+8RG
         8k6A==
X-Gm-Message-State: AOAM532M96dwPZLbNMS0pELJKjX5vaTheA77V0R64LB0YppK3TbpCNGf
        jQhOPrz7SfsoUv4OljubX2lXYw==
X-Google-Smtp-Source: ABdhPJx+gb/cdgFjOWNnJPgLUUmYHWGw1AaYHWBLRV9f7fSRlhLMqzpY2VxxbTthbT5iKhpGgFkcuw==
X-Received: by 2002:a17:902:fe95:: with SMTP id x21mr10511865plm.17.1591945810577;
        Fri, 12 Jun 2020 00:10:10 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:09 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/13] riscv: Add vector ISA support
Date:   Fri, 12 Jun 2020 15:09:49 +0800
Message-Id: <cover.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Guo Ren's v3 patchset to add dynamic vlen vector
support for all different kinds of vector length in riscv. To make this
happened we defined a new __riscv_v_state in sigcontext to save the vector
related registers. In kernel space, the datap pointer in __riscv_v_state
will be allocated dynamically to save vector registers. In user space,
datap will point to the address right after the __riscv_v_state data
structure to save vector registers in stack of signal handler. So does the
implementation in ptrace, they will be saved in ubuf in which we put the
__riscv_v_state data structure and datap pointer points to the address
right after the __riscv_v_state for saving vector registers. This patchset
also fixes several bugs for vector lazy save/restore mechanism and vtype
not saving issue. It also adds new vector CSRs support based on the 0.9
vector spec and clean up some unused macros.

This patchset is rebased to v5.7-rc4 and it is tested by running several
vector programs simultaneously. It also can get the correct ucontext_t in
signal handler and restore correct context after sigreturn. It is also
tested with ptrace() syscall to use PTRACE_GETREGSET/PTRACE_SETREGSET to
get/set the vector registers. I have tested vlen=128 and vlen=256 cases in
virt machine of qemu-system-riscv32 and qemu-system-riscv64 provided by
Zhiwei Lui and Frank Chang.

Since the vector spec is under developing, the implementation might be
changed. We may need to discuss the default value of MINSIGSTKSZ and
SIGSTKSZ. They might also need to set a proper number. They are 2048 and
8096 now. Since the stack in signal will be reserved for ucontext and the
vector registers might be larger and larger someday, these two macros will
need to be defined as a proper value or maybe we should provide a better
mechanism to provide user to get a better default signal stack size.

Vincent Chen is working on the glibc porting for vector, we will post it
later.

 [1] https://github.com/riscv/riscv-v-spec/blob/0.9/v-spec.adoc
 [2] https://github.com/sifive/riscv-qemu/tree/linux-vector-dev-rvv-0.9-phase-1
 [3] https://blog.linuxplumbersconf.org/2017/ocw/sessions/4671.html

---
Changelog V6
 - Replace vle.v/vse.v instructions with vle8.v/vse8.v based on 0.9 spec
 - Add comments based on mailinglist feedback
 - Fix rv32 build error

Changelog V5
 - Using regset_size() correctly in generic ptrace
 - Fix the ptrace porting
 - Fix compile warning

Changelog V4
 - Support dynamic vlen
 - Fix bugs: lazy save/resotre, not saving vtype
 - Update VS bit offset based on latest vector spec
 - Add new vector csr based on latest vector spec
 - Code refine and removed unused macros

Changelog V3
 - Rebase linux-5.6-rc3 and tested with qemu
 - Seperate patches with Anup's advice
 - Give out a ABI puzzle with unlimited vlen

Changelog V2
 - Fixup typo "vecotr, fstate_save->vstate_save".
 - Fixup wrong saved registers' length in vector.S.
 - Seperate unrelated patches from this one.

Greentime Hu (7):
  ptrace: Use regset_size() for dynamic regset
  riscv: Add new csr defines related to vector extension
  riscv: Add has_vector/riscv_vsize to save vector features.
  riscv: Add vector struct and assembler definitions
  riscv: Add task switch support for vector
  riscv: Add ptrace vector support
  riscv: Add sigcontext save/restore for vector

Guo Ren (5):
  riscv: Separate patch for cflags and aflags
  riscv: Rename __switch_to_aux -> fpu
  riscv: Extending cpufeature.c to detect V-extension
  riscv: Add vector feature to compile
  riscv: Reset vector register

Vincent Chen (1):
  riscv: signal: Report signal frame size to userspace via auxv

 arch/riscv/Kconfig                       |   9 ++
 arch/riscv/Makefile                      |  19 ++--
 arch/riscv/include/asm/csr.h             |  16 +++-
 arch/riscv/include/asm/elf.h             |  17 +++-
 arch/riscv/include/asm/processor.h       |   3 +
 arch/riscv/include/asm/switch_to.h       |  77 ++++++++++++++-
 arch/riscv/include/uapi/asm/auxvec.h     |   2 +
 arch/riscv/include/uapi/asm/elf.h        |   1 +
 arch/riscv/include/uapi/asm/hwcap.h      |   1 +
 arch/riscv/include/uapi/asm/ptrace.h     |  13 +++
 arch/riscv/include/uapi/asm/sigcontext.h |   2 +
 arch/riscv/kernel/Makefile               |   1 +
 arch/riscv/kernel/asm-offsets.c          |   8 ++
 arch/riscv/kernel/cpufeature.c           |  16 +++-
 arch/riscv/kernel/entry.S                |   6 +-
 arch/riscv/kernel/head.S                 |  49 +++++++++-
 arch/riscv/kernel/process.c              |  40 ++++++++
 arch/riscv/kernel/ptrace.c               | 114 +++++++++++++++++++++++
 arch/riscv/kernel/setup.c                |   5 +
 arch/riscv/kernel/signal.c               | 108 ++++++++++++++++++++-
 arch/riscv/kernel/vector.S               |  84 +++++++++++++++++
 include/uapi/linux/elf.h                 |   1 +
 kernel/ptrace.c                          |   2 +-
 23 files changed, 569 insertions(+), 25 deletions(-)
 create mode 100644 arch/riscv/kernel/vector.S

-- 
2.27.0

