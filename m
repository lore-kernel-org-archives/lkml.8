Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23168C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7B32073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 07:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbgE0Hbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 03:31:37 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:47024 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387444AbgE0Hbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 03:31:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TznFcjn_1590564682;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TznFcjn_1590564682)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 May 2020 15:31:22 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5/5] x86/entry: don't copy to tmp in fixup_bad_iret
Date:   Wed, 27 May 2020 07:31:07 +0000
Message-Id: <20200527073107.2127-6-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200527073107.2127-1-laijs@linux.alibaba.com>
References: <20200527073107.2127-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is safe to do memcpy() in fixup_bad_iret() now.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/traps.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 8291f84933ff..6fe72c771745 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -657,17 +657,23 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 * (rather than just below the IRET frame) and we want to
 	 * pretend that the exception came from the IRET target.
 	 */
-	struct bad_iret_stack tmp, *new_stack =
+	struct bad_iret_stack *new_stack =
 		(struct bad_iret_stack *)__this_cpu_read(cpu_current_top_of_stack) - 1;
 
-	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	/*
+	 * Both the IRET frame and the saved pt_regs must be on the
+	 * entry stacks since iret to user is only issued on the
+	 * entry stacks. So they don't overlap with kernel stack and
+	 * memcpy() is safe to copy them.
+	 */
+	BUG_ON(((unsigned long)s - (unsigned long)new_stack) < PAGE_SIZE ||
+	       ((unsigned long)new_stack - (unsigned long)s) < PAGE_SIZE);
 
-	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	/* Copy the IRET target to the new stack. */
+	memcpy(&new_stack->regs.ip, (void *)s->regs.sp, 5*8);
 
-	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	/* Copy the remainder of the stack from the current stack. */
+	memcpy(new_stack, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
-- 
2.20.1

