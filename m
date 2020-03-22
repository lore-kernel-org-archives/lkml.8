Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34AEC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5812072E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCVLAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:00:37 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37813 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCVLAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:00:37 -0400
Received: from localhost.localdomain (lfbn-lyo-1-453-25.w2-7.abo.wanadoo.fr [2.7.45.25])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DD5E224000A;
        Sun, 22 Mar 2020 11:00:32 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 0/7] Introduce sv48 support 
Date:   Sun, 22 Mar 2020 07:00:21 -0400
Message-Id: <20200322110028.18279-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements sv48 support at runtime. The kernel will try to
boot with 4-level page table and will fallback to 3-level if the HW does not
support it.

The biggest advantage is that we only have one kernel for 64bit, which
is way easier to maintain.

Folding the 4th level into a 3-level page table has almost no cost at
runtime.

At the moment, there is no way to enforce 3-level if the HW supports
4-level page table: early parameters are parsed after the choice must be
made.

It is based on my relocatable patchset v3 that I have not posted yet,
you can try the sv48 support by using the branch
int/alex/riscv_sv48_runtime_v1 here:

https://github.com/AlexGhiti/riscv-linux

Any feedback appreciated,

Thanks,

Alexandre Ghiti (7):
  riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
  riscv: Allow to dynamically define VA_BITS
  riscv: Simplify MAXPHYSMEM config
  riscv: Implement sv48 support
  riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
  dt-bindings: riscv: Remove "riscv,svXX" property from device-tree
  riscv: Explicit comment about user virtual address space size

 .../devicetree/bindings/riscv/cpus.yaml       |  13 --
 arch/riscv/Kconfig                            |  34 ++---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi    |   4 -
 arch/riscv/include/asm/csr.h                  |   3 +-
 arch/riscv/include/asm/fixmap.h               |   1 +
 arch/riscv/include/asm/page.h                 |  15 +-
 arch/riscv/include/asm/pgalloc.h              |  36 +++++
 arch/riscv/include/asm/pgtable-64.h           |  98 +++++++++++-
 arch/riscv/include/asm/pgtable.h              |  24 ++-
 arch/riscv/include/asm/sparsemem.h            |   2 +-
 arch/riscv/kernel/cpu.c                       |  24 +--
 arch/riscv/kernel/head.S                      |  37 ++++-
 arch/riscv/mm/context.c                       |   4 +-
 arch/riscv/mm/init.c                          | 142 +++++++++++++++---
 14 files changed, 341 insertions(+), 96 deletions(-)

-- 
2.20.1

