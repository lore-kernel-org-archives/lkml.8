Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B685C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236C520767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJAabNre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgDWQm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:42:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67112C09B041;
        Thu, 23 Apr 2020 09:42:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so3219347pfx.6;
        Thu, 23 Apr 2020 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0Ejxu1wuqWuETn/IJMRXxxZQ/rRlbjvuR8vLOOTtDU=;
        b=IJAabNre2tTWjnak57Stl3OhpAV/rvj4wnWO1M3yc6RjzjaIAv2BTTo9M3W4aTmQK2
         1nkfWVe8viMZQMVqM7Ggb5rElkaK6nVmUpmsfxpeUgK85pfnIA+DfPWB+q/rqK80Chqq
         WcJwZttjVCByfGO7lkWczHDFKgIW1Bwk1huREmPw5O4MxEV0jgx/LXdiG18OFARjhrDT
         YsPHtvJKMfnHdGqF+CRSEBr+J2T3NTDSlyBxabUTTJE/+LC++HQrs1RLA8mYBOgcg4Q/
         3vZGSZ7EqishFfz+8E2CZtBRw2Xl7PtKJ7ZjEFKvpE4cZNEkdttNfVYAv19ydSCyCiDi
         iqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0Ejxu1wuqWuETn/IJMRXxxZQ/rRlbjvuR8vLOOTtDU=;
        b=Kb1rnfx5ybhu9UyHonoueKfpmSRgum/bqbKavU2zC7fhVr7teXEhF2l2CXH7Y5vYRq
         a2Vw/nvswPT/r8XYfPMPaq5M6a9YANjEqQ2yJeEC0XhqXw1dCY9nofkUypYWXwehVQHo
         oYHXvi0YaqYpOGtPfHkVEXkjPAJisTZmoICLLSu6RSoMbatq0tl2blljXvng0shARtOa
         EKbs5prAuX1gQD5FBHUZqzWERzb+7Dp1MZh59h8DD/ce233ovvbZb1KBva0aCzVlPshT
         TdvN48hb2u5cLFUJ3l3seS5ihZoas8gKG8ie0ScVhrrkBwm6XSHvuqjmXqQneRT0bxFv
         qLnQ==
X-Gm-Message-State: AGi0PuZB4Lq/F2z/lEtBV6sn5rZgD6ogrBjnxXEOGb16S3rNx3jIG8If
        oZdYCIrCYdJwzIKdtk+GHtA=
X-Google-Smtp-Source: APiQypJw9QQfdKz9HG3qn61Gqz1NLw3POTwQWawknqDpJnDaZVNpc7d2bP1j2+rbgCm0QcU3qf+5fQ==
X-Received: by 2002:a63:e607:: with SMTP id g7mr4676487pgh.303.1587660176929;
        Thu, 23 Apr 2020 09:42:56 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id p24sm3061668pff.92.2020.04.23.09.42.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 09:42:56 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        tglx@linutronix.de, akpm@osdl.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] console: newport_con: fix an issue about leak related system resources
Date:   Fri, 24 Apr 2020 00:42:51 +0800
Message-Id: <20200423164251.3349-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A call of the function do_take_over_console() can fail here.
The corresponding system resources were not released then.
Thus add a call of iounmap() and release_mem_region()
together with the check of a failure predicate. and also
add release_mem_region() on device removal.

Fixes: e86bb8acc0fdc ("[PATCH] VT binding: Make newport_con support binding")
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	- modify commit tag CC to Cc by Andy's suggestion.
	- modify Subject 'console: console:' to 'console: newport_con:'
	  by Bartlomiej's suggestion.
	- add missing release_mem_region() on error and on device removal
	  by Bartlomiej's suggestion.
	- add correct fixes commit, before this patch, add a wrong 'Fixes:
	  e84de0c6190503 ("MIPS: GIO bus support for SGI IP22/28")'
	  thanks Bartlomiej again!

v1 -> v2:
	- modify the commit comments. The commit comments have some more
	  appropriate instructions by Markus'suggestion. here is my first
	  version commit comments:

	  if do_take_over_console() return an error in the newport_probe(),
	  due to the io virtual address is not released, it will cause a
	  leak.
	 
 drivers/video/console/newport_con.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 00dddf6e08b0..2d2ee17052e8 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -32,6 +32,8 @@
 #include <linux/linux_logo.h>
 #include <linux/font.h>
 
+#define NEWPORT_LEN	0x10000
+
 #define FONT_DATA ((unsigned char *)font_vga_8x16.data)
 
 /* borrowed from fbcon.c */
@@ -43,6 +45,7 @@
 static unsigned char *font_data[MAX_NR_CONSOLES];
 
 static struct newport_regs *npregs;
+static unsigned long newport_addr;
 
 static int logo_active;
 static int topscan;
@@ -702,7 +705,6 @@ const struct consw newport_con = {
 static int newport_probe(struct gio_device *dev,
 			 const struct gio_device_id *id)
 {
-	unsigned long newport_addr;
 	int err;
 
 	if (!dev->resource.start)
@@ -712,7 +714,7 @@ static int newport_probe(struct gio_device *dev,
 		return -EBUSY; /* we only support one Newport as console */
 
 	newport_addr = dev->resource.start + 0xF0000;
-	if (!request_mem_region(newport_addr, 0x10000, "Newport"))
+	if (!request_mem_region(newport_addr, NEWPORT_LEN, "Newport"))
 		return -ENODEV;
 
 	npregs = (struct newport_regs *)/* ioremap cannot fail */
@@ -720,6 +722,11 @@ static int newport_probe(struct gio_device *dev,
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
 
@@ -727,6 +734,7 @@ static void newport_remove(struct gio_device *dev)
 {
 	give_up_console(&newport_con);
 	iounmap((void *)npregs);
+	release_mem_region(newport_addr, NEWPORT_LEN);
 }
 
 static struct gio_device_id newport_ids[] = {
-- 
2.25.0

