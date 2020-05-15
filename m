Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E7020787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgEOMrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:47:31 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51733 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgEOMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:47:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TycgwXZ_1589546835;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TycgwXZ_1589546835)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 May 2020 20:47:15 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michel Lespinasse <walken@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <David.Woodhouse@intel.com>,
        Rik van Riel <riel@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] rbtree_latch: don't need to check seq when it found a node
Date:   Fri, 15 May 2020 12:47:07 +0000
Message-Id: <20200515124710.16439-2-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515124710.16439-1-laijs@linux.alibaba.com>
References: <20200515124710.16439-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

latch_tree_find() should be protected by caller via RCU or so.
When it find a node in an attempt, the node must be a valid one.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Michel Lespinasse <walken@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 include/linux/rbtree_latch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index b012bd95eabf..09a3c05d1c5b 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -208,7 +208,7 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	do {
 		seq = raw_read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (read_seqcount_retry(&root->seq, seq));
+	} while (!node && read_seqcount_retry(&root->seq, seq));
 
 	return node;
 }
-- 
2.20.1

