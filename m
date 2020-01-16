Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EDC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4F7206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAPDcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:32:45 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45353 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgAPDcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:32:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TnrNwaZ_1579145561;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnrNwaZ_1579145561)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jan 2020 11:32:42 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: remove unused guest_enter
Date:   Thu, 16 Jan 2020 11:32:39 +0800
Message-Id: <1579145559-168038-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 61bd0f66ff92 ("KVM: PPC: Book3S HV: Fix guest time accounting
with VIRT_CPU_ACCOUNTING_GEN"), no one use this function anymore, So better
to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/context_tracking.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 64ec82851aa3..8150f5ac176c 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -154,15 +154,6 @@ static inline void guest_exit_irqoff(void)
 }
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
 
-static inline void guest_enter(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	guest_enter_irqoff();
-	local_irq_restore(flags);
-}
-
 static inline void guest_exit(void)
 {
 	unsigned long flags;
-- 
1.8.3.1

