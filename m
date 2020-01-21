Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A7C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D6F22314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgAUFyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:54:36 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49308 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgAUFyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:54:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ToH3qle_1579586073;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToH3qle_1579586073)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 13:54:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace: remove unused variables
Date:   Tue, 21 Jan 2020 13:54:32 +0800
Message-Id: <1579586072-45047-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No body care 'ret' in their functions. So better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Steven Rostedt <rostedt@goodmis.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/trace/ftrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9bf1f2cd515e..3826bad33c87 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4113,7 +4113,6 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 	struct ftrace_hash **orig_hash, *new_hash;
 	LIST_HEAD(process_mods);
 	char *func;
-	int ret;
 
 	mutex_lock(&ops->func_hash->regex_lock);
 
@@ -4166,7 +4165,7 @@ static void process_mod_list(struct list_head *head, struct ftrace_ops *ops,
 
 	mutex_lock(&ftrace_lock);
 
-	ret = ftrace_hash_move_and_update_ops(ops, orig_hash,
+	ftrace_hash_move_and_update_ops(ops, orig_hash,
 					      new_hash, enable);
 	mutex_unlock(&ftrace_lock);
 
@@ -5517,7 +5516,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 	struct ftrace_hash **orig_hash;
 	struct trace_parser *parser;
 	int filter_hash;
-	int ret;
 
 	if (file->f_mode & FMODE_READ) {
 		iter = m->private;
@@ -5545,7 +5543,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 			orig_hash = &iter->ops->func_hash->notrace_hash;
 
 		mutex_lock(&ftrace_lock);
-		ret = ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
+		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
 	} else {
-- 
1.8.3.1

