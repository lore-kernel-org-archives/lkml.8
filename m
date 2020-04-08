Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF9DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AE120747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hsIE8Vof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDHH5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:57:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55179 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDHH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:57:10 -0400
Received: by mail-pj1-f65.google.com with SMTP id np9so842712pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5l9yaDnHPviFSInTMtO+H9cjGUVnhLTSkCrNG5sx0k=;
        b=hsIE8Vof28DJJncFl3vY8jPdw0T1oKCjs5IiYyxl69aiOHSiFTj0bX1wenWPJ3kJRJ
         iIj07JLR0wgA6ZytV1SzqwxkatW3ZHpuqQIIFgLjLm9YXf1otQUmRJfab1OAWw59S6p2
         RgWZljcud7M27JOTSdcvfdaQd+QNYcK78ifndNxpxIe7UmfEP2abrFi0CblVWumtA3Fe
         bxHimMyQBCPLy92QZtfcnT6uyM6JDpXPllxJlmdPPfzmrKECAIIsIFelasO0muZUKILY
         TA0QJ0589Dv1hXf2bIXA4h4y3D99sHzzLVQa4oS+//ptAKKDuPF7i7l9DbG2rMNzjz7C
         jTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R5l9yaDnHPviFSInTMtO+H9cjGUVnhLTSkCrNG5sx0k=;
        b=S92SAaF67DGcpiRNDS3FezNfnCHLNpN3HRRHknj5Nt3nF4QTCYVMkgRkewZ7h/oQaU
         7x5N0q2wI8ZGwjK9H8iBDV9/tQgAbD+FubC67r0UDK55a49dhNVM5OUAdLPN4QLd8UWB
         jC6rU/sn+MB3ShNAosIbnGkS2vTL3RTN2dQM5uK8TbwZcRPMbETjJYw/EbUFdARTmOp0
         b6sOYspoYm0ztv0kK6GwLCJsOUKA20R9tnSmTgBRxmlWIrP64+YEODB23k9Of+n80WDV
         0KDcnZFIMrYUWdPXxqcNsRTPWWn2CVTA01ZSw0OeF1qRqnvvYZn6QH372TT4775gzvh9
         QJhA==
X-Gm-Message-State: AGi0PuZnreaaUMrvbiQ/D84UlltKb5gzqCHfs6x6w/SE1bc/yLr5UpoV
        JcesrzvZoZ/9QAnZ2Zwrb4Y1gQ==
X-Google-Smtp-Source: APiQypIdPE+cKH1o87dImXX8C4kNxwaWuMVEsYtc+353GjjJ1cP5svGrxcEtvT6nMOrjhFMmd8aMUA==
X-Received: by 2002:a17:902:8e84:: with SMTP id bg4mr5738299plb.50.1586332629297;
        Wed, 08 Apr 2020 00:57:09 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d85sm485599pfd.157.2020.04.08.00.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 00:57:08 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v5 0/9] Support strict kernel memory permissions for security
Date:   Wed,  8 Apr 2020 15:56:55 +0800
Message-Id: <cover.1586332296.git.zong.li@sifive.com>
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

Changes in v5:
 - Add lockdep_assert_held and more comments for text_mutex.

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
 arch/riscv/kernel/patch.c           | 128 +++++++++++++++++++
 arch/riscv/kernel/traps.c           |   3 +-
 arch/riscv/kernel/vmlinux.lds.S     |  11 +-
 arch/riscv/mm/Makefile              |   2 +-
 arch/riscv/mm/init.c                |  44 +++++++
 arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
 13 files changed, 466 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/include/asm/patch.h
 create mode 100644 arch/riscv/include/asm/set_memory.h
 create mode 100644 arch/riscv/kernel/patch.c
 create mode 100644 arch/riscv/mm/pageattr.c

-- 
2.26.0

