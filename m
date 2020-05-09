Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305C6C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B3A21473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEIXqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728408AbgEIXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9899C05BD0F;
        Sat,  9 May 2020 16:46:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRg-RX; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>
Subject: [PATCH 08/20] cm4000_cs.c cmm_ioctl(): get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:45 +0100
Message-Id: <20200509234557.1124086-8-viro@ZenIV.linux.org.uk>
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

copy_to_user()/copy_from_user() for everything

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/pcmcia/cm4000_cs.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/char/pcmcia/cm4000_cs.c b/drivers/char/pcmcia/cm4000_cs.c
index 4edb4174a1e2..89681f07bc78 100644
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1404,7 +1404,6 @@ static long cmm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	unsigned int iobase = dev->p_dev->resource[0]->start;
 	struct inode *inode = file_inode(filp);
 	struct pcmcia_device *link;
-	int size;
 	int rc;
 	void __user *argp = (void __user *)arg;
 #ifdef CM4000_DEBUG
@@ -1441,19 +1440,6 @@ static long cmm_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		DEBUGP(4, dev, "iocnr mismatch\n");
 		goto out;
 	}
-	size = _IOC_SIZE(cmd);
-	rc = -EFAULT;
-	DEBUGP(4, dev, "iocdir=%.4x iocr=%.4x iocw=%.4x iocsize=%d cmd=%.4x\n",
-	      _IOC_DIR(cmd), _IOC_READ, _IOC_WRITE, size, cmd);
-
-	if (_IOC_DIR(cmd) & _IOC_READ) {
-		if (!access_ok(argp, size))
-			goto out;
-	}
-	if (_IOC_DIR(cmd) & _IOC_WRITE) {
-		if (!access_ok(argp, size))
-			goto out;
-	}
 	rc = 0;
 
 	switch (cmd) {
-- 
2.11.0

