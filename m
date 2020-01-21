Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CDAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455122253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgAUKZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:25:40 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34852 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgAUKZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:39 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ToHeAiX_1579602336;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHeAiX_1579602336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 18:25:36 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/quota: remove unused macro
Date:   Tue, 21 Jan 2020 18:25:34 +0800
Message-Id: <1579602334-57039-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__QUOTA_V2_PARANOIA  macro is never used. better to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jan Kara <jack@suse.com> 
Cc: linux-kernel@vger.kernel.org 
---
 fs/quota/quota_v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index 53429c29c784..58fc2a7c7fd1 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -22,8 +22,6 @@
 MODULE_DESCRIPTION("Quota format v2 support");
 MODULE_LICENSE("GPL");
 
-#define __QUOTA_V2_PARANOIA
-
 static void v2r0_mem2diskdqb(void *dp, struct dquot *dquot);
 static void v2r0_disk2memdqb(struct dquot *dquot, void *dp);
 static int v2r0_is_id(void *dp, struct dquot *dquot);
-- 
1.8.3.1

