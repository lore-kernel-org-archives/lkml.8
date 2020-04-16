Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E97DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BFA2078A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 05:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406947AbgDPFjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:39:44 -0400
Received: from mail.windriver.com ([147.11.1.11]:32881 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406392AbgDPFjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 01:39:41 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 03G5cwhp009251
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 15 Apr 2020 22:38:58 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 22:38:58 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 4BC32721B41; Thu, 16
 Apr 2020 13:38:29 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jiping.ma2@windriver.com>
Subject: [PATCH] Perf: support to unwind userspace application stacks generated with thumb.
Date:   Thu, 16 Apr 2020 13:38:29 +0800
Message-ID: <20200416053829.130395-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only push sp and lr in the stack for thumb mode. it will go
through the stack find sp and lr.

Change this to the more detailed description of the patch

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 arch/arm64/kernel/perf_callchain.c | 36 +++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index bcafd7dcfe8b..97dde271c121 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -104,6 +104,30 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
 
 	return (struct compat_frame_tail __user *)compat_ptr(buftail.fp) - 1;
 }
+
+void
+user_backtrace_thumb(struct perf_callchain_entry_ctx *entry,
+		     struct pt_regs *regs)
+{
+	u32 sp;
+	u32 *sp_t;
+	/*
+	 * Only push sp, lr to stack.
+	 */
+	for (sp = regs->compat_sp; (sp < current->mm->start_stack) &&
+		(entry->nr < entry->max_stack); sp += 4) {
+		sp_t = (u32 *)(unsigned long)sp;
+		if ((*sp_t > regs->compat_sp) &&
+			(*sp_t < current->mm->start_stack)) {
+			if (*(sp_t + 1) < current->mm->end_code &&
+				*(sp_t + 1) > current->mm->start_code) {
+				perf_callchain_store(entry,  *(sp_t + 1)-1);
+				sp += 4;
+			}
+		}
+	}
+}
+
 #endif /* CONFIG_COMPAT */
 
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
@@ -132,9 +156,15 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 		tail = (struct compat_frame_tail __user *)regs->compat_fp - 1;
 
-		while ((entry->nr < entry->max_stack) &&
-			tail && !((unsigned long)tail & 0x3))
-			tail = compat_user_backtrace(tail, entry);
+		if (((unsigned long)tail > current->mm->start_stack) ||
+			((unsigned long)tail < regs->compat_sp) ||
+			regs->compat_sp == regs->compat_usr(7)) {
+			user_backtrace_thumb(entry, regs);
+		} else {
+			while ((entry->nr < entry->max_stack) &&
+				tail && !((unsigned long)tail & 0x3))
+				tail = compat_user_backtrace(tail, entry);
+		}
 #endif
 	}
 }
-- 
2.18.1

