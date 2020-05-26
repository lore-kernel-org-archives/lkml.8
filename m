Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5075D207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aXUx6bNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbgEZHCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEZHCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:02:50 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so7286901plv.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjFuuSKELZJU3yFdtYh4Z/EGvp9SJKWa4PnxR5+tAUc=;
        b=aXUx6bNmgfjjt0m0x/gBRk4kkDjzjjPdsHKRQfw/za19fhkOinm23rO4fKimciBUi9
         iXdqSgO8FBIVRvy6mUxWfRlbKoJ5zpK3X1UxyjnBCbYS4XNt1v49IlRABE5kTdQMJIDO
         RlCKJbxtewhJfsBd4PkQpOGuQj1sq4VHIoBC6EtudpG1glB4uFWBks/omfItYtK8Da+O
         sUVk2pHGvZYA59xVDcNpIoQV8ahLz0gRGbt5OhXxp3LWcDWbH6OrL7uFGMOMp6c8c0dj
         OYQ1vTNeQf+RvRx4InsrpRTLy3Aics6yqrFgzIIrdvsyeiY6zBosjN38mmrAIDYFrpqh
         WpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KjFuuSKELZJU3yFdtYh4Z/EGvp9SJKWa4PnxR5+tAUc=;
        b=plaBTZsesiwNMcO/c4uzFduH20+V2u+Acfk4M8moD9fJL5LYCKCTXxw6TrxF8JnoWT
         qZlBhICeDKKt4g4G792m3dmCnkSDzbbZWorrspygccI7WQNdjpf2eXAk3Fq9+B5x81zW
         KZviAJ8MRjUJGRUcTXYJ7OxEfJs00qPsd9xKHvFs06/Bgup+hnZ+zSH9SDZLBkDqKHYa
         dOAHnZjmBCMx4chDPGoZVQnIwyYUv3KU65Svw8bjtM9zxPmmDYcjOFgU5be0VUWHPyqQ
         nRDYMvn1q+E+f+3JfOFqu1Wnd7OlEgc7gKML4vePCt5S+r8oUo6Ryp0vKN3A6C+oUE5Y
         kn1w==
X-Gm-Message-State: AOAM532y6cdyDVVl+G3cxw+XkMTdPiQ3+txGSN7m/tcsepxWGz35f7K9
        sbkpf3YiRVJhv0kOzKTh8wHnuw==
X-Google-Smtp-Source: ABdhPJzP/P48fy25UjHW+3pSJA97CRI7sDm1P9f8kSFHvii5IH14tVS7IKNrGUT9hLhkyiUcrf4tCQ==
X-Received: by 2002:a17:902:d689:: with SMTP id v9mr30690110ply.283.1590476569960;
        Tue, 26 May 2020 00:02:49 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:49 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 00/13] riscv: Add vector ISA support
Date:   Tue, 26 May 2020 15:02:29 +0800
Message-Id: <cover.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is based on Guo Ren's v3 patchset to add dynamic vlen vector
support for all different kinds of vector length in riscv. To make this
happened we defined a new __riscv_v_state in sigcontext to save the vector
related registers. The datap pointer will be allocated dynamically in
kernel space and it will be put right after the __riscv_v_state data
structure to save all the vector registers in signal handler stack for user
space. So does the implementation in ptrace, they will be saved in ubuf
in which we put the __riscv_v_state data structure and datap pointer right
after it for vector registers. This patchset also fixes several bugs for
vector lazy save/restore and vtype not saving issue. It also adds new CSR
support for vector based on the 0.9 vector spec and clean up some unused
macros.

This patchset is rebased to v5.7-rc4 and it is tested by running several
vector programs simultaneously. It also can get the correct ucontext_t in
signal handler and restore correct context after sigreturn. It is also
tested with ptrace() syscall to use PTRACE_GETREGSET/PTRACE_SETREGSET to
get/set the vector registers. I have tested vlen=128 and vlen=256 cases in
virt machine of qemu-system-riscv32 and qemu-system-riscv64 provided by
Zhiwei Lui.

Since the vector spec is under developing, there might still need some
changes. For example the vle.v/vse.v instructions will be replaced with
proper instructions. The reason that I don't replace the instruction in
this patchset is because that the Qemu doesn't fully support 0.9 spec yet.
I have no simulator to test. We also like to discuss the default setting of
MINSIGSTKSZ and SIGSTKSZ. They might also need to set a proper number. They
are 2048 and 8096 now. Since the stack in signal will be reserved for
ucontext and the vector registers might be larger and larger someday, these
two macros will need to be defined as a proper value or maybe we should
provide a better mechanism to provide user to get a better default signal
stack size.


 [1] https://github.com/romanheros/qemu/tree/linux-vector-dev
 [2] https://blog.linuxplumbersconf.org/2017/ocw/sessions/4671.html
 [3] https://github.com/riscv/riscv-v-spec/blob/master/v-spec.adoc

---
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

Greentime Hu (1):
  ptrace: Use regset_size() for dynamic regset size.

Guo Ren (11):
  riscv: Separate patch for cflags and aflags
  riscv: Rename __switch_to_aux -> fpu
  riscv: Extending cpufeature.c to detect V-extension
  riscv: Add new csr defines related to vector extension
  riscv: Add vector feature to compile
  riscv: Add has_vector/riscv_vsize to save vector features.
  riscv: Reset vector register
  riscv: Add vector struct and assembler definitions
  riscv: Add task switch support for vector
  riscv: Add ptrace vector support
  riscv: Add sigcontext save/restore for vector

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
 arch/riscv/kernel/cpufeature.c           |  15 ++-
 arch/riscv/kernel/entry.S                |   2 +-
 arch/riscv/kernel/head.S                 |  49 +++++++++-
 arch/riscv/kernel/process.c              |  40 ++++++++
 arch/riscv/kernel/ptrace.c               | 114 +++++++++++++++++++++++
 arch/riscv/kernel/setup.c                |   5 +
 arch/riscv/kernel/signal.c               | 108 ++++++++++++++++++++-
 arch/riscv/kernel/vector.S               |  84 +++++++++++++++++
 include/uapi/linux/elf.h                 |   1 +
 kernel/ptrace.c                          |  11 ++-
 23 files changed, 573 insertions(+), 25 deletions(-)
 create mode 100644 arch/riscv/kernel/vector.S

-- 
2.26.2

