Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95992C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CC322522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAUIk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:40:59 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43851 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbgAUIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:40:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ToHVJLk_1579596056;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHVJLk_1579596056)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:40:56 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Waiman Long <longman@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/iperm: remove unused pointers
Date:   Tue, 21 Jan 2020 16:40:54 +0800
Message-Id: <1579596054-254032-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one use the prev/next pointers in its function after commit 22fe5b0439dd
("x86/ioperm: Move TSS bitmap update to exit to user work"). So better to
remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Borislav Petkov <bp@alien8.de> 
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: x86@kernel.org 
Cc: Andy Lutomirski <luto@kernel.org> 
Cc: Rik van Riel <riel@surriel.com> 
Cc: Dave Hansen <dave.hansen@intel.com> 
Cc: Waiman Long <longman@redhat.com> 
Cc: Marcelo Tosatti <mtosatti@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 arch/x86/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 61e93a318983..839b5244e3b7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
 
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
-	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;
 
-	prev = &prev_p->thread;
-	next = &next_p->thread;
-
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
 
-- 
1.8.3.1

