Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1259FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9B3208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FXRK29J+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgIJINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6610AC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id c196so4326048pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIxpQhbgonx8nlKAxkVhSGRouo/g4ZEWjtm8/CRy5aY=;
        b=FXRK29J+v4F+YBc420YkHOyHLh7jwTadoKM/lNVSCpVD7MYPy7Lo5T3tDw6LP8REDC
         h+zW9PCfrWEEbfBU4uLw1F027VrDeaTw/byn/DJvswLplWwnD9OfTwlE3KHXwn4XWsbH
         n6EdU4DWYd1YbfqXb+W7Wo/v2LDo+ky4nZJpD2zpzTvcZ1NGmmvDn45fpxhp1NlAYqml
         2GLH8bG+oCvWhcQhSqbN895sXBNkP9PH/r7uYijb8jfrjL2WFOCLxiNW0jYLdhRXryFL
         Zx0TXrsozNinLi0TJTX99DCZdJAiiqJRddN0qvteaEWsW+fwGxyGRu1eQsfo17ep82CV
         BUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hIxpQhbgonx8nlKAxkVhSGRouo/g4ZEWjtm8/CRy5aY=;
        b=sV10tKLPJguROUxA9ZcMwFanGiCZVUVMzGVN8H1Uwx8/BhzjtcljYQjJIR+pNxLei4
         whBuaHeuyWJn5QjoVaLNziiuczx2dFWkvVT9pyDBvM7eWy9ROE71bKxUIbIegEoZncQ8
         jK9CZOWHE1VdqzrwXua/x5LBl024wa1T3FcDNGozDbcF19HITYtWYPaXQ6mGnI5QSoe9
         qeB1MfQ/rRJl5Blc6p2a51KPNotVspHWmzlG5KUyRe9ETnSd52GHfMKRD4JVYodg5xBQ
         sSoNKgKHKXnk17qaEGYPr1LkzRFmLOOzXuFqCxP9Xq5swTReCcIJ4t/JdkzZ4zmyBD5z
         OJHA==
X-Gm-Message-State: AOAM532tm2wifb1WpdCnyxOC9PF+3HFaiFa7g2nYU/L3n2VxiRYwWz8x
        TmbN+x4sc4qp36OPjdqvE94Fu8X1k1CWhogp
X-Google-Smtp-Source: ABdhPJwuBJkNNxY8b+LyEc92/ARvkWCjxC8Rleny4O12LG9s+CSiC/NeDIIHAqvIoRxGvqu6TIAafw==
X-Received: by 2002:a65:66c6:: with SMTP id c6mr3679317pgw.206.1599725556826;
        Thu, 10 Sep 2020 01:12:36 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:36 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: [RFC PATCH v7 00/21] riscv: Add vector ISA support
Date:   Thu, 10 Sep 2020 16:11:55 +0800
Message-Id: <cover.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is implemented based on vector 0.9+ spec to add vector support
in riscv Linux kernel. To make this happen, we defined a new structure
__riscv_v_state to save the vector related registers. It is used for both
kernel space and user space. In kernel space, the datap pointer in
__riscv_v_state will be allocated dynamically to save vector registers.
In signal handler of user space, datap will point to the address right
after the __riscv_v_state data structure to save vector registers in stack.
In ptrace, the data will be put in ubuf in which we can get/put the
__riscv_v_state data structure from/to it, datap pointer would be zeroed and
vector registers will be copied to the address right after the
__riscv_v_state structure in ubuf. This patchset also adds support for kernel
mode vector, kernel XOR implementation with vector ISA and includes several
bug fixes and code refinement.

This patchset is rebased to v5.9-rc4 and it is tested by running several
vector programs simultaneously. It also can get the correct ucontext_t in
signal handler and restore correct context after sigreturn. It is also
tested with ptrace() syscall to use PTRACE_GETREGSET/PTRACE_SETREGSET to
get/set the vector registers. I have tested vlen=128 and vlen=256 cases in
spike machine of qemu-system-riscv64 provided by Zhiwei Lui and Frank Chang
and also tested in spike with vlen=64 to vlen=4096 settings.

We also sent patches to glibc mailing list for ifunc support and sigcontext
changes.

 [1] https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc
 [2] https://github.com/sifive/qemu/tree/rvv-1.0-upstream-v4
 [3] https://blog.linuxplumbersconf.org/2017/ocw/sessions/4671.html
 [4] https://sourceware.org/pipermail/libc-alpha/2020-July/116059.html
 [5] https://sourceware.org/pipermail/libc-alpha/2020-July/116108.html
 [6] https://linuxplumbersconf.org/event/7/contributions/811/

---
Changelog V7
 - Add support for kernel mode vector
 - Add vector extension XOR implementation
 - Optimize task switch codes of vector
 - Allocate space for vector registers in start_thread()
 - Fix an illegal instruction exception when accessing vlenb
 - Optimize vector registers initialization
 - Initialize vector registers with proper vsetvli then it can work normally
 - Refine ptrace porting due to generic API changed
 - Code clean up

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

Greentime Hu (16):
  riscv: Extending cpufeature.c to detect V-extension
  riscv: Add new csr defines related to vector extension
  riscv: Add has_vector/riscv_vsize to save vector features.
  riscv: Add vector struct and assembler definitions
  riscv: Add task switch support for vector
  riscv: Add task switch support for vector
  riscv: Add ptrace vector support
  riscv: Add sigcontext save/restore for vector
  riscv: Add support for kernel mode vector
  riscv: Use CSR_STATUS to replace sstatus in vector.S
  riscv: Add vector extension XOR implementation
  riscv: Initialize vector registers with proper vsetvli then it can
    work normally
  riscv: Optimize vector registers initialization
  riscv: Fix an illegal instruction exception when accessing vlenb
    without enable vector first
  riscv: Allocate space for vector registers in start_thread()
  riscv: Optimize task switch codes of vector

Guo Ren (4):
  riscv: Separate patch for cflags and aflags
  riscv: Rename __switch_to_aux -> fpu
  riscv: Add vector feature to compile
  riscv: Reset vector register

Vincent Chen (1):
  riscv: signal: Report signal frame size to userspace via auxv

 arch/riscv/Kconfig                       |   9 ++
 arch/riscv/Makefile                      |  19 ++-
 arch/riscv/include/asm/csr.h             |  16 ++-
 arch/riscv/include/asm/elf.h             |  17 ++-
 arch/riscv/include/asm/processor.h       |   3 +
 arch/riscv/include/asm/switch_to.h       |  67 +++++++++-
 arch/riscv/include/asm/vector.h          |  18 +++
 arch/riscv/include/asm/xor.h             |  74 +++++++++++
 arch/riscv/include/uapi/asm/auxvec.h     |   2 +
 arch/riscv/include/uapi/asm/hwcap.h      |   1 +
 arch/riscv/include/uapi/asm/ptrace.h     |  31 +++++
 arch/riscv/include/uapi/asm/sigcontext.h |   2 +
 arch/riscv/kernel/Makefile               |   7 +
 arch/riscv/kernel/asm-offsets.c          |   8 ++
 arch/riscv/kernel/cpufeature.c           |  16 +++
 arch/riscv/kernel/entry.S                |   6 +-
 arch/riscv/kernel/head.S                 |  22 +++-
 arch/riscv/kernel/kernel_mode_vector.c   | 158 +++++++++++++++++++++++
 arch/riscv/kernel/process.c              |  48 +++++++
 arch/riscv/kernel/ptrace.c               |  74 +++++++++++
 arch/riscv/kernel/setup.c                |   5 +
 arch/riscv/kernel/signal.c               | 108 +++++++++++++++-
 arch/riscv/kernel/vector.S               |  81 ++++++++++++
 arch/riscv/lib/Makefile                  |   1 +
 arch/riscv/lib/xor.S                     |  81 ++++++++++++
 include/uapi/linux/elf.h                 |   1 +
 26 files changed, 852 insertions(+), 23 deletions(-)
 create mode 100644 arch/riscv/include/asm/vector.h
 create mode 100644 arch/riscv/include/asm/xor.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
 create mode 100644 arch/riscv/kernel/vector.S
 create mode 100644 arch/riscv/lib/xor.S

-- 
2.28.0

