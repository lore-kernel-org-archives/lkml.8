Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3ADFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7BE20720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgHaDLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:11:10 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40449 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgHaDLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7JHBz7_1598843466;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7JHBz7_1598843466)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:06 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/6] ftrace: define seq_file only for FMODE_READ
Date:   Mon, 31 Aug 2020 11:10:59 +0800
Message-Id: <20200831031104.23322-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the operation is to get ftrace_iterator, which is embedded
in file or seq_file for FMODE_WRITE/FMODE_READ respectively. Since we
don't have a seq_file for FMODE_WRITE case, it is meaningless to cast
file->private_data to seq_file.

Let's move the definition when there is a valid seq_file.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index edc233122598..12cb535769bc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5558,7 +5558,6 @@ static void __init set_ftrace_early_filters(void)
 
 int ftrace_regex_release(struct inode *inode, struct file *file)
 {
-	struct seq_file *m = (struct seq_file *)file->private_data;
 	struct ftrace_iterator *iter;
 	struct ftrace_hash **orig_hash;
 	struct trace_parser *parser;
@@ -5566,6 +5565,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 	int ret;
 
 	if (file->f_mode & FMODE_READ) {
+		struct seq_file *m = file->private_data;
 		iter = m->private;
 		seq_release(inode, file);
 	} else
-- 
2.20.1 (Apple Git-117)

