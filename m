Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311ADC33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F8214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbgALQty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:49:54 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:48194 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgALQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:49:53 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id pUpr210025USYZQ01Uprw6; Sun, 12 Jan 2020 17:49:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0007yD-TY; Sun, 12 Jan 2020 17:49:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgQw-0005Gg-Sa; Sun, 12 Jan 2020 17:49:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] zorro: Make zorro_match_device() static
Date:   Sun, 12 Jan 2020 17:49:45 +0100
Message-Id: <20200112164949.20196-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
References: <20200112164949.20196-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike its PCI counterpart, zorro_match_device() was never used outside
the Zorro bus code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/zorro/zorro-driver.c | 3 +--
 include/linux/zorro.h        | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index fa23b7366b98ccbe..84ac94aecb7966b8 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -28,7 +28,7 @@
      *  zorro_device_id structure or %NULL if there is no match.
      */
 
-const struct zorro_device_id *
+static const struct zorro_device_id *
 zorro_match_device(const struct zorro_device_id *ids,
 		   const struct zorro_dev *z)
 {
@@ -39,7 +39,6 @@ zorro_match_device(const struct zorro_device_id *ids,
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(zorro_match_device);
 
 
 static int zorro_device_probe(struct device *dev)
diff --git a/include/linux/zorro.h b/include/linux/zorro.h
index 63fbba0740c2c2bf..cb72515b0ac17040 100644
--- a/include/linux/zorro.h
+++ b/include/linux/zorro.h
@@ -70,7 +70,6 @@ struct zorro_driver {
 /* New-style probing */
 extern int zorro_register_driver(struct zorro_driver *);
 extern void zorro_unregister_driver(struct zorro_driver *);
-extern const struct zorro_device_id *zorro_match_device(const struct zorro_device_id *ids, const struct zorro_dev *z);
 static inline struct zorro_driver *zorro_dev_driver(const struct zorro_dev *z)
 {
     return z->driver;
-- 
2.17.1

