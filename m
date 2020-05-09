Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD378C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFF521473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgEIXqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728783AbgEIXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BC4C05BD0B;
        Sat,  9 May 2020 16:46:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAO-004iSE-4A; Sat, 09 May 2020 23:46:00 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 15/20] drm_read(): get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:52 +0100
Message-Id: <20200509234557.1124086-15-viro@ZenIV.linux.org.uk>
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

address is passed only to copy_to_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/drm_file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index eb009d3ab48f..6a1f6c802415 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -569,9 +569,6 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
 	struct drm_device *dev = file_priv->minor->dev;
 	ssize_t ret;
 
-	if (!access_ok(buffer, count))
-		return -EFAULT;
-
 	ret = mutex_lock_interruptible(&file_priv->event_read_lock);
 	if (ret)
 		return ret;
-- 
2.11.0

