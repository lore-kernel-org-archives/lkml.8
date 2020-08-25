Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ED2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6241D20737
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHYE5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:41 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:59258 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728901AbgHYE52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id D3A1D1E0A;
        Tue, 25 Aug 2020 04:57:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: guide76_470c28d27059
X-Filterd-Recvd-Size: 3447
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:25 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     reiserfs-devel@vger.kernel.org
Subject: [PATCH 24/29] reiserfs: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:21 -0700
Message-Id: <29b5ea94496d64e7a73af216b01f26d9ff7ac1fe.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/reiserfs/fix_node.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fs/reiserfs/fix_node.c b/fs/reiserfs/fix_node.c
index fefe87e1c099..aea63e67a42b 100644
--- a/fs/reiserfs/fix_node.c
+++ b/fs/reiserfs/fix_node.c
@@ -235,8 +235,10 @@ static void check_left(struct tree_balance *tb, int h, int cur_free)
 	d_size = 0, ih_size = IH_SIZE;
 
 	/* first item may be merge with last item in left neighbor */
-	if (vi->vi_type & VI_TYPE_LEFT_MERGEABLE)
-		d_size = -((int)IH_SIZE), ih_size = 0;
+	if (vi->vi_type & VI_TYPE_LEFT_MERGEABLE) {
+		d_size = -((int)IH_SIZE);
+		ih_size = 0;
+	}
 
 	tb->lnum[0] = 0;
 	for (i = 0; i < vn->vn_nr_item;
@@ -321,8 +323,10 @@ static void check_right(struct tree_balance *tb, int h, int cur_free)
 	d_size = 0, ih_size = IH_SIZE;
 
 	/* last item may be merge with first item in right neighbor */
-	if (vi->vi_type & VI_TYPE_RIGHT_MERGEABLE)
-		d_size = -(int)IH_SIZE, ih_size = 0;
+	if (vi->vi_type & VI_TYPE_RIGHT_MERGEABLE) {
+		d_size = -(int)IH_SIZE;
+		ih_size = 0;
+	}
 
 	tb->rnum[0] = 0;
 	for (i = vn->vn_nr_item - 1; i >= 0;
@@ -1534,8 +1538,10 @@ static int ip_check_balance(struct tree_balance *tb, int h)
 			nver1 = get_num_ver(vn->vn_mode, tb, h,
 					    0, -1, 0, -1,
 					    snum012 + NOTHING_SHIFT_FLOW, FLOW);
-			if (nver > nver1)
-				nset = NOTHING_SHIFT_FLOW, nver = nver1;
+			if (nver > nver1) {
+				nset = NOTHING_SHIFT_FLOW;
+				nver = nver1;
+			}
 		}
 
 		/*
@@ -1559,8 +1565,10 @@ static int ip_check_balance(struct tree_balance *tb, int h)
 					     ((tb->lbytes != -1) ? 1 : 0),
 					     tb->lbytes, 0, -1,
 					     snum012 + LEFT_SHIFT_FLOW, FLOW);
-			if (lnver > lnver1)
-				lset = LEFT_SHIFT_FLOW, lnver = lnver1;
+			if (lnver > lnver1) {
+				lset = LEFT_SHIFT_FLOW;
+				lnver = lnver1;
+			}
 		}
 
 		/*
@@ -1590,8 +1598,10 @@ static int ip_check_balance(struct tree_balance *tb, int h)
 					     tb->rbytes,
 					     snum012 + RIGHT_SHIFT_FLOW, FLOW);
 
-			if (rnver > rnver1)
-				rset = RIGHT_SHIFT_FLOW, rnver = rnver1;
+			if (rnver > rnver1) {
+				rset = RIGHT_SHIFT_FLOW;
+				rnver = rnver1;
+			}
 		}
 
 		/*
@@ -1622,8 +1632,10 @@ static int ip_check_balance(struct tree_balance *tb, int h)
 					       ((tb->rbytes != -1) ? 1 : 0)),
 					      tb->rbytes,
 					      snum012 + LR_SHIFT_FLOW, FLOW);
-			if (lrnver > lrnver1)
-				lrset = LR_SHIFT_FLOW, lrnver = lrnver1;
+			if (lrnver > lrnver1) {
+				lrset = LR_SHIFT_FLOW;
+				lrnver = lrnver1;
+			}
 		}
 
 		/*
-- 
2.26.0

