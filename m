Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B436C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F2B2187F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbgALQ4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:56:18 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:41812 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733115AbgALQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:56:17 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id pUwG2100B5USYZQ01UwGBU; Sun, 12 Jan 2020 17:56:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-00082t-5S; Sun, 12 Jan 2020 17:56:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-0005Ss-4I; Sun, 12 Jan 2020 17:56:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Philip Blundell <philb@gnu.org>
Cc:     linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] dio: Make dio_match_device() static
Date:   Sun, 12 Jan 2020 17:56:11 +0100
Message-Id: <20200112165613.20960-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112165613.20960-1-geert@linux-m68k.org>
References: <20200112165613.20960-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike its PCI counterpart, dio_match_device() was never used outside
the DIO bus code.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/dio/dio-driver.c | 3 +--
 include/linux/dio.h      | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dio/dio-driver.c b/drivers/dio/dio-driver.c
index a7b174ef4c85f9c4..daf87e214a7794c2 100644
--- a/drivers/dio/dio-driver.c
+++ b/drivers/dio/dio-driver.c
@@ -25,7 +25,7 @@
  *  dio_device_id structure or %NULL if there is no match.
  */
 
-const struct dio_device_id *
+static const struct dio_device_id *
 dio_match_device(const struct dio_device_id *ids,
 		   const struct dio_dev *d)
 {
@@ -137,7 +137,6 @@ static int __init dio_driver_init(void)
 
 postcore_initcall(dio_driver_init);
 
-EXPORT_SYMBOL(dio_match_device);
 EXPORT_SYMBOL(dio_register_driver);
 EXPORT_SYMBOL(dio_unregister_driver);
 EXPORT_SYMBOL(dio_bus_type);
diff --git a/include/linux/dio.h b/include/linux/dio.h
index 1470d1d943b477ab..ca07243690edf6eb 100644
--- a/include/linux/dio.h
+++ b/include/linux/dio.h
@@ -247,7 +247,6 @@ extern int dio_create_sysfs_dev_files(struct dio_dev *);
 /* New-style probing */
 extern int dio_register_driver(struct dio_driver *);
 extern void dio_unregister_driver(struct dio_driver *);
-extern const struct dio_device_id *dio_match_device(const struct dio_device_id *ids, const struct dio_dev *z);
 static inline struct dio_driver *dio_dev_driver(const struct dio_dev *d)
 {
     return d->driver;
-- 
2.17.1

