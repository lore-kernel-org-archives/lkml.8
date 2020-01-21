Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29056C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0661324653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUItW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:49:22 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:44421 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728680AbgAUItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:49:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHVLyx_1579596558;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHVLyx_1579596558)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:49:18 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/gfs2: remove unused macro lbitskip etc
Date:   Tue, 21 Jan 2020 16:49:17 +0800
Message-Id: <1579596557-257872-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 223b2b889f37 ("GFS2: Fix alignment issue and tidy
gfs2_bitfit"), these 3 macros aren't used anymore. remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Bob Peterson <rpeterso@redhat.com> 
Cc: Andreas Gruenbacher <agruenba@redhat.com> 
Cc: cluster-devel@redhat.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/gfs2/rgrp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 2466bb44a23c..e7bf91ec231c 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -36,16 +36,6 @@
 #define BFITNOENT ((u32)~0)
 #define NO_BLOCK ((u64)~0)
 
-#if BITS_PER_LONG == 32
-#define LBITMASK   (0x55555555UL)
-#define LBITSKIP55 (0x55555555UL)
-#define LBITSKIP00 (0x00000000UL)
-#else
-#define LBITMASK   (0x5555555555555555UL)
-#define LBITSKIP55 (0x5555555555555555UL)
-#define LBITSKIP00 (0x0000000000000000UL)
-#endif
-
 /*
  * These routines are used by the resource group routines (rgrp.c)
  * to keep track of block allocation.  Each block is represented by two
-- 
1.8.3.1

