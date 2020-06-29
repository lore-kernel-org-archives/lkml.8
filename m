Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34D020675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461454;
	bh=lxhKP8mUk7NWPWZ5S591OwGbHEUQgWTP8rlI4jSLJjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=biITVhoJOQD7WHcGnMgxpNfeBH2EvQfNqkgTJfVSjttYXnavqThRsP9G4Edlvf87A
	 JiG5517d6TpgoXaFS+mInxL75tMC/+7IQr+l6+Jleg0PtIVxli7DMa2IWm6f+XqIYH
	 VNAj90HLGoix4A05Lf1TbiVq1x2nd5/IM5IdPqA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgF2UKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732907AbgF2TaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A6625294;
        Mon, 29 Jun 2020 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445003;
        bh=lxhKP8mUk7NWPWZ5S591OwGbHEUQgWTP8rlI4jSLJjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1EgqCQVtceaIXlgoCZqKpXCb+tyYdMtu1iWa1BW76C7IauegyFC7JTzThVGk1fXmC
         T+fxSRNpLyBJtMbntxlGJryN3wSKUeFkxe7BiCqLn7ae+AeUirhoNStF07jD+ben/j
         hCYhu0r2tXO2a9RY12pKupILOi8g8+82qeBfFXnU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yash Shah <yash.shah@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/131] RISC-V: Don't allow write+exec only page mapping request in mmap
Date:   Mon, 29 Jun 2020 11:34:34 -0400
Message-Id: <20200629153502.2494656-104-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yash Shah <yash.shah@sifive.com>

[ Upstream commit e0d17c842c0f824fd4df9f4688709fc6907201e1 ]

As per the table 4.4 of version "20190608-Priv-MSU-Ratified" of the
RISC-V instruction set manual[0], the PTE permission bit combination of
"write+exec only" is reserved for future use. Hence, don't allow such
mapping request in mmap call.

An issue is been reported by David Abdurachmanov, that while running
stress-ng with "sysbadaddr" argument, RCU stalls are observed on RISC-V
specific kernel.

This issue arises when the stress-sysbadaddr request for pages with
"write+exec only" permission bits and then passes the address obtain
from this mmap call to various system call. For the riscv kernel, the
mmap call should fail for this particular combination of permission bits
since it's not valid.

[0]: http://dabbelt.com/~palmer/keep/riscv-isa-manual/riscv-privileged-20190608-1.pdf

Signed-off-by: Yash Shah <yash.shah@sifive.com>
Reported-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
[Palmer: Refer to the latest ISA specification at the only link I could
find, and update the terminology.]
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/sys_riscv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index fb03a4482ad60..db44da32701f2 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -16,6 +16,7 @@
 #include <linux/syscalls.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm-generic/mman-common.h>
 
 static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 			   unsigned long prot, unsigned long flags,
@@ -24,6 +25,11 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
 {
 	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
 		return -EINVAL;
+
+	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
+		if (unlikely(!(prot & PROT_READ)))
+			return -EINVAL;
+
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
-- 
2.25.1

