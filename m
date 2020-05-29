Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23894C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED2F42075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438163AbgE2Afp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgE2AfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565A5C08C5CA;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFRI-R0; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 07/10] comedi: lift copy_from_user() into callers of __comedi_get_user_cmd()
Date:   Fri, 29 May 2020 01:35:10 +0100
Message-Id: <20200529003512.4110852-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index d80a416e70b2..e85a143057a1 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1649,17 +1649,11 @@ static int do_insn_ioctl(struct comedi_device *dev,
 }
 
 static int __comedi_get_user_cmd(struct comedi_device *dev,
-				 struct comedi_cmd __user *arg,
 				 struct comedi_cmd *cmd)
 {
 	struct comedi_subdevice *s;
 
 	lockdep_assert_held(&dev->mutex);
-	if (copy_from_user(cmd, arg, sizeof(*cmd))) {
-		dev_dbg(dev->class_dev, "bad cmd address\n");
-		return -EFAULT;
-	}
-
 	if (cmd->subdev >= dev->n_subdevices) {
 		dev_dbg(dev->class_dev, "%d no such subdevice\n", cmd->subdev);
 		return -ENODEV;
@@ -1757,8 +1751,13 @@ static int do_cmd_ioctl(struct comedi_device *dev,
 
 	lockdep_assert_held(&dev->mutex);
 
+	if (copy_from_user(&cmd, arg, sizeof(cmd))) {
+		dev_dbg(dev->class_dev, "bad cmd address\n");
+		return -EFAULT;
+	}
+
 	/* get the user's cmd and do some simple validation */
-	ret = __comedi_get_user_cmd(dev, arg, &cmd);
+	ret = __comedi_get_user_cmd(dev, &cmd);
 	if (ret)
 		return ret;
 
@@ -1866,8 +1865,13 @@ static int do_cmdtest_ioctl(struct comedi_device *dev,
 
 	lockdep_assert_held(&dev->mutex);
 
+	if (copy_from_user(&cmd, arg, sizeof(cmd))) {
+		dev_dbg(dev->class_dev, "bad cmd address\n");
+		return -EFAULT;
+	}
+
 	/* get the user's cmd and do some simple validation */
-	ret = __comedi_get_user_cmd(dev, arg, &cmd);
+	ret = __comedi_get_user_cmd(dev, &cmd);
 	if (ret)
 		return ret;
 
-- 
2.11.0

