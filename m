Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00826C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D214724653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAUItS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:49:18 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59567 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728680AbgAUItR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHVLxs_1579596554;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHVLxs_1579596554)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:15 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/gfs2: remove IS_DINODE
Date:   Tue, 21 Jan 2020 16:49:12 +0800
Message-Id: <1579596552-257820-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 1579343a73e3 ("GFS2: Remove dirent_first() function"), this
macro isn't used any more. so remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Bob Peterson <rpeterso@redhat.com> 
Cc: Andreas Gruenbacher <agruenba@redhat.com> 
Cc: cluster-devel@redhat.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/gfs2/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index eb9c0578978f..636a8d0f3dab 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -74,7 +74,6 @@
 #include "util.h"
 
 #define IS_LEAF     1 /* Hashed (leaf) directory */
-#define IS_DINODE   2 /* Linear (stuffed dinode block) directory */
 
 #define MAX_RA_BLOCKS 32 /* max read-ahead blocks */
 
-- 
1.8.3.1

