Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9116C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE65207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2I0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:26:38 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17273 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725865AbgE2I0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:26:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Tzy5OyZ_1590740793;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tzy5OyZ_1590740793)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 May 2020 16:26:33 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH V2 4/4] x86/entry: don't copy to tmp in fixup_bad_iret
Date:   Fri, 29 May 2020 08:26:17 +0000
Message-Id: <20200529082618.1697-5-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529082618.1697-1-laijs@linux.alibaba.com>
References: <87mu5roov6.fsf@nanos.tec.linutronix.de>
 <20200529082618.1697-1-laijs@linux.alibaba.com>
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
index 9d16672865f8..1a0253a80a4c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -660,17 +660,23 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
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

