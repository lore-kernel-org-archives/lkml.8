Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E9C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8662074F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgDZN04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:26:56 -0400
Received: from mail.secom.com.pl ([213.216.87.26]:49068 "EHLO
        mail.secom.com.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDZN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:26:56 -0400
Received: from localhost.localdomain
        ([37.109.33.236])
        by mail.secom.com.pl; Sun, 26 Apr 2020 15:26:42 +0200
From:   =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>
Cc:     =?UTF-8?q?Rafa=C5=82=20Hibner?= <rafal.hibner@secom.com.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fs: Allow splicing from character device
Date:   Sun, 26 Apr 2020 15:17:30 +0200
Message-Id: <20200426131730.8438-1-rafal.hibner@secom.com.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splicing from character devices should be enabled. It allows for
efficient (ZEROCOPY) bulk data tranfers from device.
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index 4735defc46..306d11c5ea 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -920,7 +920,7 @@ ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
 	 * piped splicing for that!
 	 */
 	i_mode = file_inode(in)->i_mode;
-	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode)))
+	if (unlikely(!S_ISREG(i_mode) && !S_ISBLK(i_mode) && !S_ISCHR(i_mode)))
 		return -EINVAL;
 
 	/*
-- 
2.24.1

