Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D50A207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387514AbgE0Hbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:35 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42166 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgE0Hbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TzmtQ-6_1590564679;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzmtQ-6_1590564679)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:20 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4/5] x86/entry: remove unused sync_regs()
Date:   Wed, 27 May 2020 07:31:06 +0000
Message-Id: <20200527073107.2127-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527073107.2127-1-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more users.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/include/asm/traps.h |  1 -
 arch/x86/kernel/traps.c      | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index f5a2e438a878..20b9db7a1d49 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -21,7 +21,6 @@ asmlinkage void xen_page_fault(void);
 dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 
 #ifdef CONFIG_X86_64
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
 void __init trap_init(void);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3bef95934644..8291f84933ff 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -642,19 +642,6 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 }
 
 #ifdef CONFIG_X86_64
-/*
- * Help handler running on a per-cpu (IST or entry trampoline) stack
- * to switch to the normal thread stack if the interrupted code was in
- * user mode. The actual stack switch is done in entry_64.S
- */
-asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
-{
-	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
-	if (regs != eregs)
-		*regs = *eregs;
-	return regs;
-}
-
 struct bad_iret_stack {
 	void *error_entry_ret;
 	struct pt_regs regs;
-- 
2.20.1

