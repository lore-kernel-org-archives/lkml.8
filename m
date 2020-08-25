Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D26C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEED2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgHYI64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgHYI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:58:55 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C74C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:58:55 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BbNFm343lzvjc1; Tue, 25 Aug 2020 10:58:52 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] stackleak: let stack_erasing_sysctl take a kernel pointer buffer
Date:   Tue, 25 Aug 2020 10:58:52 +0200
Message-Id: <20200825085852.17815-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
signature of stack_erasing_sysctl to match ctl_table.proc_handler which
fixes the following sparse warning:

kernel/stackleak.c:31:50: warning: incorrect type in argument 3 (different address spaces)
kernel/stackleak.c:31:50:    expected void *
kernel/stackleak.c:31:50:    got void [noderef] __user *buffer

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/stackleak.h | 2 +-
 kernel/stackleak.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index 3d5c3271a9a8..a59db2f08e76 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -25,7 +25,7 @@ static inline void stackleak_task_init(struct task_struct *t)
 
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos);
+			void *buffer, size_t *lenp, loff_t *ppos);
 #endif
 
 #else /* !CONFIG_GCC_PLUGIN_STACKLEAK */
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index a8fc9ae1d03d..ce161a8e8d97 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -20,7 +20,7 @@
 static DEFINE_STATIC_KEY_FALSE(stack_erasing_bypass);
 
 int stack_erasing_sysctl(struct ctl_table *table, int write,
-			void __user *buffer, size_t *lenp, loff_t *ppos)
+			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
-- 
2.27.0

