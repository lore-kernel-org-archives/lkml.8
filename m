Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D19C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297F621473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEIXr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728575AbgEIXqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:00 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B62CC061A0C;
        Sat,  9 May 2020 16:46:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRG-B0; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/20] btrfs_ioctl_send(): don't bother with access_ok()
Date:   Sun, 10 May 2020 00:45:40 +0100
Message-Id: <20200509234557.1124086-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we do copy_from_user() on that range anyway

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/send.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c5f41bd86765..6a92ecf9eaa2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7065,13 +7065,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		goto out;
 	}
 
-	if (!access_ok(arg->clone_sources,
-			sizeof(*arg->clone_sources) *
-			arg->clone_sources_count)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
 	if (arg->flags & ~BTRFS_SEND_FLAG_MASK) {
 		ret = -EINVAL;
 		goto out;
-- 
2.11.0

