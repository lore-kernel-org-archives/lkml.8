Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01AAC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842142082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEKEqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728366AbgEKEp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:45:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049BC05BD0A;
        Sun, 10 May 2020 21:45:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY0KC-005jJH-Qy; Mon, 11 May 2020 04:45:56 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/19] atm: switch do_atm_iobuf() to direct use of atm_getnames()
Date:   Mon, 11 May 2020 05:45:51 +0100
Message-Id: <20200511044553.1365660-17-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200511044553.1365660-1-viro@ZenIV.linux.org.uk>
References: <20200511044328.GP23230@ZenIV.linux.org.uk>
 <20200511044553.1365660-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and sod the compat_alloc_user_space() with its complications

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/atm/ioctl.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/net/atm/ioctl.c b/net/atm/ioctl.c
index e239cebf48da..fdd0e3434523 100644
--- a/net/atm/ioctl.c
+++ b/net/atm/ioctl.c
@@ -251,32 +251,13 @@ static struct {
 static int do_atm_iobuf(struct socket *sock, unsigned int cmd,
 			unsigned long arg)
 {
-	struct atm_iobuf __user *iobuf;
-	struct compat_atm_iobuf __user *iobuf32;
+	struct compat_atm_iobuf __user *iobuf32 = compat_ptr(arg);
 	u32 data;
-	void __user *datap;
-	int len, err;
-
-	iobuf = compat_alloc_user_space(sizeof(*iobuf));
-	iobuf32 = compat_ptr(arg);
 
-	if (get_user(len, &iobuf32->length) ||
-	    get_user(data, &iobuf32->buffer))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(len, &iobuf->length) ||
-	    put_user(datap, &iobuf->buffer))
+	if (get_user(data, &iobuf32->buffer))
 		return -EFAULT;
 
-	err = do_vcc_ioctl(sock, cmd, (unsigned long) iobuf, 0);
-
-	if (!err) {
-		if (copy_in_user(&iobuf32->length, &iobuf->length,
-				 sizeof(int)))
-			err = -EFAULT;
-	}
-
-	return err;
+	return atm_getnames(&iobuf32->length, compat_ptr(data));
 }
 
 static int do_atmif_sioc(struct socket *sock, unsigned int cmd,
-- 
2.11.0

