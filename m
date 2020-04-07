Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B5C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F239C20747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rgrgkl7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgDGOrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:00 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46822 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id s23so1309479plq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUCjo9QZAUVS89qJ6P7brNM+fVg1xR17iXj6Oki2mTI=;
        b=Rgrgkl7+XZSy0uaZKgjq7G4b5KdnzXQYp6HNdVeqnaMt0SPjON6QS8lZgEQ3VNpXdN
         2fuuAR2XIKM70S4jIm2LgVnImFpZXwdtPCre3ZdsjQCHPemtGjD3WEBM4hprGIpcA4ab
         uuCtJy2jl9FC7VuKj4aSAlyCu4011jno3x9mt+BBa6M0PxkKfBDSgQn/+XwJJbJusaSH
         cvmybpw10vvkDh3lxpjZTepa3zugIDIhm4fUA1WVEg0JqLowLkCOPu4PqaN5ePORfjke
         WW2v0eF2/bulJybL9eD9RcLraeScTA2KKLlKdicuOSbduojjtBIn5Y7aYGfImxa0Qq1k
         Os+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUCjo9QZAUVS89qJ6P7brNM+fVg1xR17iXj6Oki2mTI=;
        b=LV/zQ6khrB/Tg5fFGjhpnMA7p7s8I3xSrGbbBecKAIwVq4OzN6k1G73Liq4QXYyG2q
         RGoqHHPrbEFDpL0rs3d9k8qS5TtQs3LqbcbbjaaZngGruNEQVVdyoTXrlYa6ZNrPtq97
         FSBf0DM1jIXwkhuleRyCgHORk6A6qwohmwFXf6NrXzcRvOVMpfXh6ux3U4K94DHhMngq
         4JRC4aMGbOfiFhMuI/R+3MDpVW1qKHAAOLbBVGnJ32dk422BrJLUHVHzXxr6temB+AWn
         xuzarfKuai81HPy57QhrOxz1nICAdatT0kvDEyp6pCFDzf/oUqUbu+I1+m46A070y6Yq
         qMjQ==
X-Gm-Message-State: AGi0PuaZA/IeSkEyIJPMEe8ORT/M5Q2CulRCvhmM5tO6vgSsNZ6s0ujh
        Tg4/OCf9mDwZhS1RsOTjYgb4LA==
X-Google-Smtp-Source: APiQypKu9CFmS/qJ++0L0X58ZipmpZ0VvjOdNEzfVfwpm6RLPRR1u0lRH2HMg/my/AEQfHGgAfYZhA==
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr2992619pjb.96.1586270818816;
        Tue, 07 Apr 2020 07:46:58 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:46:58 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v4 0/9] Support strict kernel memory permissions for security
Date:   Tue,  7 Apr 2020 22:46:45 +0800
Message-Id: <cover.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose of this patch series is changing the kernel mapping permission
, make sure that code is not writeable, data is not executable, and read-only
data is neither writable nor executable.

This patch series also supports the relevant implementations such as
ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.

Changes in v4:
 - Use NOKPROBE_SYMBOL instead of __kprobe annotation
 - Use text_mutex instead of patch_lock
 - Remove 'riscv_' prefix of function name

Changes in v3:
 - Fix build error on nommu configuration. We already support nommu on
   RISC-V, so we should consider nommu case and test not only rv32/64,
   but also nommu.

Changes in v2:
 - Use _data to specify the start of data section with write permission.
 - Change ftrace patch text implementaion.
 - Separate DEBUG_WX patch to another patchset.

Zong Li (9):
  riscv: add macro to get instruction length
  riscv: introduce interfaces to patch kernel code
  riscv: patch code by fixmap mapping
  riscv: add ARCH_HAS_SET_MEMORY support
  riscv: add ARCH_HAS_SET_DIRECT_MAP support
  riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
  riscv: move exception table immediately after RO_DATA
  riscv: add alignment for text, rodata and data sections
  riscv: add STRICT_KERNEL_RWX support

 arch/riscv/Kconfig                  |   6 +
 arch/riscv/include/asm/bug.h        |   8 ++
 arch/riscv/include/asm/fixmap.h     |   2 +
 arch/riscv/include/asm/patch.h      |  12 ++
 arch/riscv/include/asm/set_memory.h |  48 +++++++
 arch/riscv/kernel/Makefile          |   4 +-
 arch/riscv/kernel/ftrace.c          |  26 ++--
 arch/riscv/kernel/patch.c           | 120 ++++++++++++++++++
 arch/riscv/kernel/traps.c           |   3 +-
 arch/riscv/kernel/vmlinux.lds.S     |  11 +-
 arch/riscv/mm/Makefile              |   2 +-
 arch/riscv/mm/init.c                |  44 +++++++
 arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
 13 files changed, 458 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/kernel/patch.c
 create mode 100644 arch/riscv/mm/pageattr.c

-- 
2.26.0

