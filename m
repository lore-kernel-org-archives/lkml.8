Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4DDC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4319C20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgAJDOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:14:11 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60834 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730952AbgAJDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:14:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnHqBGN_1578626049;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnHqBGN_1578626049)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jan 2020 11:14:09 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: remove unused guest_enter/exit
Date:   Fri, 10 Jan 2020 11:13:56 +0800
Message-Id: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6edaa5307f3f ("KVM: remove kvm_guest_enter/exit wrappers")
no one uses guest_enter/exit anymore.

So better to remove them to simplify code and reduced a bit of object
size.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org> 
Cc: Frederic Weisbecker <frederic@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 include/linux/context_tracking.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 64ec82851aa3..238ada39ac2e 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -153,23 +153,4 @@ static inline void guest_exit_irqoff(void)
 	current->flags &= ~PF_VCPU;
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-
-static inline void guest_enter(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_enter_irqoff();
-	local_irq_restore(flags);
-}
-
-static inline void guest_exit(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_exit_irqoff();
-	local_irq_restore(flags);
-}
-
 #endif
-- 
1.8.3.1

