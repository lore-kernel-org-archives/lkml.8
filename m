Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938EC47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AEC21775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgEIXrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728752AbgEIXqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584CC05BD09;
        Sat,  9 May 2020 16:46:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRc-O3; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/20] nvram: drop useless access_ok()
Date:   Sun, 10 May 2020 00:45:44 +0100
Message-Id: <20200509234557.1124086-7-viro@ZenIV.linux.org.uk>
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

we are using copy_to_user()/memdup_user() anyway

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/nvram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 4667844eee69..8206412d25ba 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -232,8 +232,6 @@ static ssize_t nvram_misc_read(struct file *file, char __user *buf,
 	ssize_t ret;
 
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	if (*ppos >= nvram_size)
 		return 0;
 
@@ -264,8 +262,6 @@ static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 	char *tmp;
 	ssize_t ret;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	if (*ppos >= nvram_size)
 		return 0;
 
-- 
2.11.0

