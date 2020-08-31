Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A8B20720
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHaDLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:11:24 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44415 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbgHaDLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7IrXzq_1598843467;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7IrXzq_1598843467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:08 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 3/6] ftrace: simplify the dyn_ftrace->flags macro
Date:   Mon, 31 Aug 2020 11:11:01 +0800
Message-Id: <20200831031104.23322-4-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the three macro are defined to be used for ftrace_rec_count(). This
can be achieved by (flags & FTRACE_REF_MAX) directly.

Since no other places would use those macros, remove them for clarity.

Also it fixes a typo in the comment.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/ftrace.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 3e3fe779a8c2..23c4d6526998 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -433,7 +433,7 @@ bool is_ftrace_trampoline(unsigned long addr);
  *  DIRECT   - there is a direct function to call
  *
  * When a new ftrace_ops is registered and wants a function to save
- * pt_regs, the rec->flag REGS is set. When the function has been
+ * pt_regs, the rec->flags REGS is set. When the function has been
  * set up to save regs, the REG_EN flag is set. Once a function
  * starts saving regs it will do so until all ftrace_ops are removed
  * from tracing that function.
@@ -451,12 +451,9 @@ enum {
 };
 
 #define FTRACE_REF_MAX_SHIFT	23
-#define FTRACE_FL_BITS		9
-#define FTRACE_FL_MASKED_BITS	((1UL << FTRACE_FL_BITS) - 1)
-#define FTRACE_FL_MASK		(FTRACE_FL_MASKED_BITS << FTRACE_REF_MAX_SHIFT)
 #define FTRACE_REF_MAX		((1UL << FTRACE_REF_MAX_SHIFT) - 1)
 
-#define ftrace_rec_count(rec)	((rec)->flags & ~FTRACE_FL_MASK)
+#define ftrace_rec_count(rec)	((rec)->flags & FTRACE_REF_MAX)
 
 struct dyn_ftrace {
 	unsigned long		ip; /* address of mcount call-site */
-- 
2.20.1 (Apple Git-117)

