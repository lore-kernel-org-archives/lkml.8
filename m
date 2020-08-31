Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBDFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0DB20738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgHaDLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:11:22 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:37561 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgHaDLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:11:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U7JJRN7_1598843469;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U7JJRN7_1598843469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Aug 2020 11:11:09 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 6/6] ftrace: ftrace_global_list is renamed to ftrace_ops_list
Date:   Mon, 31 Aug 2020 11:11:04 +0800
Message-Id: <20200831031104.23322-7-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment to comply with the code.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 include/linux/ftrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 23c4d6526998..8e1fd97343c6 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -218,11 +218,11 @@ extern struct ftrace_ops __rcu *ftrace_ops_list;
 extern struct ftrace_ops ftrace_list_end;
 
 /*
- * Traverse the ftrace_global_list, invoking all entries.  The reason that we
+ * Traverse the ftrace_ops_list, invoking all entries.  The reason that we
  * can use rcu_dereference_raw_check() is that elements removed from this list
  * are simply leaked, so there is no need to interact with a grace-period
  * mechanism.  The rcu_dereference_raw_check() calls are needed to handle
- * concurrent insertions into the ftrace_global_list.
+ * concurrent insertions into the ftrace_ops_list.
  *
  * Silly Alpha and silly pointer-speculation compiler optimizations!
  */
-- 
2.20.1 (Apple Git-117)

