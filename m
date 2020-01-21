Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E620678
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgAUKZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:25:47 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44825 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgAUKZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHeAkK_1579602342;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHeAkK_1579602342)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 18:25:43 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: remove unused macro
Date:   Tue, 21 Jan 2020 18:25:41 +0800
Message-Id: <1579602341-57131-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OVL_NLINK_ADD_UPPER macro is never used from it was introduced. Better
to remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu> 
Cc: linux-unionfs@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/overlayfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b045cf1826fc..7138561f955a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -627,8 +627,6 @@ static void ovl_fill_inode(struct inode *inode, umode_t mode, dev_t rdev,
  * upper inode where the nlink xattr can be stored before the copied up upper
  * entry is unlink.
  */
-#define OVL_NLINK_ADD_UPPER	(1 << 0)
-
 /*
  * On-disk format for indexed nlink:
  *
-- 
1.8.3.1

