Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE63C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FCE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgHYIRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:17:35 -0400
Received: from sym2.noone.org ([178.63.92.236]:33724 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgHYIRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:17:35 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BbML43wlbzvjc1; Tue, 25 Aug 2020 10:17:32 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ftrace: let ftrace_enable_sysctl take a kernel pointer buffer
Date:   Tue, 25 Aug 2020 10:17:32 +0200
Message-Id: <20200825081732.12061-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
changed ctl_table.proc_handler to take a kernel pointer. Adjust the
signature of ftrace_enable_sysctl to match ctl_table.proc_handler which
fixes the following sparse warning:

kernel/trace/ftrace.c:7544:43: warning: incorrect type in argument 3 (different address spaces)
kernel/trace/ftrace.c:7544:43:    expected void *
kernel/trace/ftrace.c:7544:43:    got void [noderef] __user *buffer

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 include/linux/ftrace.h | 3 +--
 kernel/trace/ftrace.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ce2c06f72e86..e5c2d5cc6e6a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -85,8 +85,7 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 extern int ftrace_enabled;
 extern int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
-		     void __user *buffer, size_t *lenp,
-		     loff_t *ppos);
+		     void *buffer, size_t *lenp, loff_t *ppos);
 
 struct ftrace_ops;
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 275441254bb5..e9fa580f3083 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7531,8 +7531,7 @@ static bool is_permanent_ops_registered(void)
 
 int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
-		     void __user *buffer, size_t *lenp,
-		     loff_t *ppos)
+		     void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret = -ENODEV;
 
-- 
2.27.0

