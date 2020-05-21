Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A32075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgEUAhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgEUAh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:37:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74644C061A0F;
        Wed, 20 May 2020 17:37:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jbZDA-00CgfF-Kl; Thu, 21 May 2020 00:37:24 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 17/19] atm: switch do_atm_iobuf() to direct use of atm_getnames()
Date:   Thu, 21 May 2020 01:37:19 +0100
Message-Id: <20200521003721.3023783-17-viro@ZenIV.linux.org.uk>
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

