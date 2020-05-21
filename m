Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7206AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585332075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgEUAhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEUAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:37:28 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7500C08C5C5;
        Wed, 20 May 2020 17:37:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbZDA-00CgfM-Qc; Thu, 21 May 2020 00:37:25 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 18/19] atm: lift copyin from atm_dev_ioctl()
Date:   Thu, 21 May 2020 01:37:20 +0100
Message-Id: <20200521003721.3023783-18-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200521003721.3023783-1-viro@ZenIV.linux.org.uk>
References: <20200521003657.GE23230@ZenIV.linux.org.uk>
 <20200521003721.3023783-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/atm/ioctl.c     | 25 ++++++++++++++++++++++++-
 net/atm/resources.c | 35 +++++------------------------------
 net/atm/resources.h |  4 ++--
 3 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index fdd0e3434523..52f2c77e656f 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -182,7 +182,30 @@ static int do_vcc_ioctl(struct socket *sock, unsigned int cmd,
 		}
 		error = atm_getnames(buf, len);
 	} else {
-		error = atm_dev_ioctl(cmd, argp, compat);
+		int number;
+
+		if (IS_ENABLED(CONFIG_COMPAT) && compat) {
+#ifdef CONFIG_COMPAT
+			struct compat_atmif_sioc __user *csioc = argp;
+			compat_uptr_t carg;
+
+			len = &csioc->length;
+			if (get_user(carg, &csioc->arg))
+				return -EFAULT;
+			buf = compat_ptr(carg);
+			if (get_user(number, &csioc->number))
+				return -EFAULT;
+#endif
+		} else {
+			struct atmif_sioc __user *sioc = argp;
+
+			len = &sioc->length;
+			if (get_user(buf, &sioc->arg))
+				return -EFAULT;
+			if (get_user(number, &sioc->number))
+				return -EFAULT;
+		}
+		error = atm_dev_ioctl(cmd, buf, len, number, compat);
 	}
 
 done:
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 5507cc608969..94bdc6527ee8 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -227,39 +227,14 @@ int atm_getnames(void __user *buf, int __user *iobuf_len)
 	return error;
 }
 
-int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
+int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
+		  int number, int compat)
 {
-	void __user *buf;
-	int error, len, number, size = 0;
+	int error, len, size = 0;
 	struct atm_dev *dev;
-	int __user *sioc_len;
 
-	if (IS_ENABLED(CONFIG_COMPAT) && compat) {
-#ifdef CONFIG_COMPAT
-		struct compat_atmif_sioc __user *csioc = arg;
-		compat_uptr_t carg;
-
-		sioc_len = &csioc->length;
-		if (get_user(carg, &csioc->arg))
-			return -EFAULT;
-		buf = compat_ptr(carg);
-
-		if (get_user(len, &csioc->length))
-			return -EFAULT;
-		if (get_user(number, &csioc->number))
-			return -EFAULT;
-#endif
-	} else {
-		struct atmif_sioc __user *sioc = arg;
-
-		sioc_len = &sioc->length;
-		if (get_user(buf, &sioc->arg))
-			return -EFAULT;
-		if (get_user(len, &sioc->length))
-			return -EFAULT;
-		if (get_user(number, &sioc->number))
-			return -EFAULT;
-	}
+	if (get_user(len, sioc_len))
+		return -EFAULT;
 
 	dev = try_then_request_module(atm_dev_lookup(number), "atm-device-%d",
 				      number);
diff --git a/net/atm/resources.h b/net/atm/resources.h
index 5e2c68d37d63..4a0839e92ff3 100644
--- a/net/atm/resources.h
+++ b/net/atm/resources.h
@@ -15,8 +15,8 @@ extern struct list_head atm_devs;
 extern struct mutex atm_dev_mutex;
 
 int atm_getnames(void __user *buf, int __user *iobuf_len);
-int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat);
-
+int atm_dev_ioctl(unsigned int cmd, void __user *buf, int __user *sioc_len,
+		  int number, int compat);
 
 #ifdef CONFIG_PROC_FS
 
-- 
2.11.0

