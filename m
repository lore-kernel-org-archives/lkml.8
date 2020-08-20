Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0ADD2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921883;
	bh=KjAxcYHOufY/4EXARebzDTcyfHyjGan4vKGLiw3dTww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KN3tGyOr8vTJQEiNf5B8ffwTDhbYIMNEG1vKZIi3yfjAhkys4FamHCfbFfQx3ifJ/
	 bYwDVkiqTdCYGRGiV172AR+SuSpEW1urDNxOlC25F9uRMFJkSr5kKQ89Tns6O1+eYb
	 +gjepiTDKhudZDQvZKKmMPaaHzyVxCDNDxkn8raE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgHTLLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730847AbgHTKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:09:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDBC20738;
        Thu, 20 Aug 2020 10:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918191;
        bh=KjAxcYHOufY/4EXARebzDTcyfHyjGan4vKGLiw3dTww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/9ostoPxOJOvNc/KTnddF5dTiT3CSCkH6NCBR+thhOLI9shs74Y//WXkoqF0F+fB
         KYws31R2jljPcl2vrQw9iOcg9TMTIYHWBTdKVVmEJ6yBFNLzpdj0zBaL8RsXAsH/4m
         m+dNjcferKYRQOyhJTusb8s5Ax0gEhhBfkdZ/YZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@osdl.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 083/228] console: newport_con: fix an issue about leak related system resources
Date:   Thu, 20 Aug 2020 11:20:58 +0200
Message-Id: <20200820091611.759974556@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
index 42d02a206059b..d3b0850391e0d 100644
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



