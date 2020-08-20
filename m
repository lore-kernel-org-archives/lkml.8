Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E7021775
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597924655;
	bh=cOt4CRmaLjXzgRgBPBXt59IgiOXy8Y3w7CEiPYGBdfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a8ZQKIfg9cTlFYdYprUj0oej3RbCn82kgiKIQ5QFn2hzwmY/BdW8QJHVW5YmuBCPj
	 dYBRC2a4djhon3c0OGUlTBWedQrfo5KBs1TQpUPOgFXv3mqX6pT8ylT8ln5EUn5jVA
	 5/LTip3WVu2eZBUUgQcK0HPV1X1KQHUe2SqN0gE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgHTL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgHTKAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:00:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86F420738;
        Thu, 20 Aug 2020 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917653;
        bh=cOt4CRmaLjXzgRgBPBXt59IgiOXy8Y3w7CEiPYGBdfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t+sylJ8EuZGJIoG/ZjVzVqJxQtsEahfbW0HlsPsVkeEaJlEGLwSzVbYuxY5+aln44
         qL4r3/fCEL69PoydJnN4qG9bQWE1csoSzL9VPisVlGGeZDa/VQnsmOz5KlyZjoiMpb
         KRQcx/tiqSe20FlBrI9DiuGcBeQqpOn0/d3HSfS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@osdl.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 109/212] console: newport_con: fix an issue about leak related system resources
Date:   Thu, 20 Aug 2020 11:21:22 +0200
Message-Id: <20200820091607.851822412@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dejin Zheng <zhengdejin5@gmail.com>

[ Upstream commit fd4b8243877250c05bb24af7fea5567110c9720b ]

A call of the function do_take_over_console() can fail here.
The corresponding system resources were not released then.
Thus add a call of iounmap() and release_mem_region()
together with the check of a failure predicate. and also
add release_mem_region() on device removal.

Fixes: e86bb8acc0fdc ("[PATCH] VT binding: Make newport_con support binding")
Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200423164251.3349-1-zhengdejin5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/console/newport_con.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index e3b9521e4ec3e..33bddf3f30406 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -31,6 +31,8 @@
 #include <linux/linux_logo.h>
 #include <linux/font.h>
 
+#define NEWPORT_LEN	0x10000
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 /* borrowed from fbcon.c */
@@ -42,6 +44,7 @@
 static unsigned char *font_data[MAX_NR_CONSOLES];
 
 static struct newport_regs *npregs;
+static unsigned long newport_addr;
 
 static int logo_active;
 static int topscan;
@@ -701,7 +704,6 @@ const struct consw newport_con = {
 static int newport_probe(struct gio_device *dev,
 			 const struct gio_device_id *id)
 {
-	unsigned long newport_addr;
 	int err;
 
 	if (!dev->resource.start)
@@ -711,7 +713,7 @@ static int newport_probe(struct gio_device *dev,
 		return -EBUSY; /* we only support one Newport as console */
 
 	newport_addr = dev->resource.start + 0xF0000;
-	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
+	if (!request_mem_region(newport_addr, NEWPORT_LEN, "Newport"))
 		return -ENODEV;
 
 	npregs = (struct newport_regs *)/* ioremap cannot fail */
@@ -719,6 +721,11 @@ static int newport_probe(struct gio_device *dev,
 	console_lock();
 	err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
 	console_unlock();
+
+	if (err) {
+		iounmap((void *)npregs);
+		release_mem_region(newport_addr, NEWPORT_LEN);
+	}
 	return err;
 }
 
@@ -726,6 +733,7 @@ static void newport_remove(struct gio_device *dev)
 {
 	give_up_console(&newport_con);
 	iounmap((void *)npregs);
+	release_mem_region(newport_addr, NEWPORT_LEN);
 }
 
 static struct gio_device_id newport_ids[] = {
-- 
2.25.1



