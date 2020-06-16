Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE596C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A743620810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgFPHKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:10:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgFPHKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:10:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C89E5D6E242227FF4D68;
        Tue, 16 Jun 2020 15:10:43 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 16 Jun 2020
 15:10:33 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, <yi.zhang@huawei.com>, <liu.song11@zte.com.cn>
Subject: [PATCH RFC 4/5] ubifs: ubifs_dump_sleb: Remove unused function
Date:   Tue, 16 Jun 2020 15:11:45 +0800
Message-ID: <20200616071146.2607061-5-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200616071146.2607061-1-chengzhihao1@huawei.com>
References: <20200616071146.2607061-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ubifs_dump_sleb() is defined but unused, it can be removed.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/debug.c | 16 ----------------
 fs/ubifs/debug.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index 24a6e6fb5e9a..2d07615369f9 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -828,22 +828,6 @@ void ubifs_dump_lpt_info(struct ubifs_info *c)
 	spin_unlock(&dbg_lock);
 }
 
-void ubifs_dump_sleb(const struct ubifs_info *c,
-		     const struct ubifs_scan_leb *sleb, int offs)
-{
-	struct ubifs_scan_node *snod;
-
-	pr_err("(pid %d) start dumping scanned data from LEB %d:%d\n",
-	       current->pid, sleb->lnum, offs);
-
-	list_for_each_entry(snod, &sleb->nodes, list) {
-		cond_resched();
-		pr_err("Dumping node at LEB %d:%d len %d\n",
-		       sleb->lnum, snod->offs, snod->len);
-		ubifs_dump_node(c, snod->node);
-	}
-}
-
 void ubifs_dump_leb(const struct ubifs_info *c, int lnum)
 {
 	struct ubifs_scan_leb *sleb;
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index 42610fa5f3a7..ed966108da80 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -252,8 +252,6 @@ void ubifs_dump_lprop(const struct ubifs_info *c,
 void ubifs_dump_lprops(struct ubifs_info *c);
 void ubifs_dump_lpt_info(struct ubifs_info *c);
 void ubifs_dump_leb(const struct ubifs_info *c, int lnum);
-void ubifs_dump_sleb(const struct ubifs_info *c,
-		     const struct ubifs_scan_leb *sleb, int offs);
 void ubifs_dump_znode(const struct ubifs_info *c,
 		      const struct ubifs_znode *znode);
 void ubifs_dump_heap(struct ubifs_info *c, struct ubifs_lpt_heap *heap,
-- 
2.25.4

