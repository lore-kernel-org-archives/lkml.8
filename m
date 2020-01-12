Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE7C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FF32080D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 16:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbgALQ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:56:26 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:46344 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgALQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 11:56:18 -0500
Received: from ramsan ([84.195.182.253])
        by michel.telenet-ops.be with bizsmtp
        id pUwG2100K5USYZQ06UwGVU; Sun, 12 Jan 2020 17:56:16 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-00082y-7P; Sun, 12 Jan 2020 17:56:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iqgXA-0005Sy-6J; Sun, 12 Jan 2020 17:56:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Philip Blundell <philb@gnu.org>
Cc:     linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] dio: Remove unused dio_dev_driver()
Date:   Sun, 12 Jan 2020 17:56:13 +0100
Message-Id: <20200112165613.20960-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200112165613.20960-1-geert@linux-m68k.org>
References: <20200112165613.20960-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function was never used.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/linux/dio.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/dio.h b/include/linux/dio.h
index ca07243690edf6eb..5abd07361eb516b5 100644
--- a/include/linux/dio.h
+++ b/include/linux/dio.h
@@ -247,10 +247,6 @@ extern int dio_create_sysfs_dev_files(struct dio_dev *);
 /* New-style probing */
 extern int dio_register_driver(struct dio_driver *);
 extern void dio_unregister_driver(struct dio_driver *);
-static inline struct dio_driver *dio_dev_driver(const struct dio_dev *d)
-{
-    return d->driver;
-}
 
 #define dio_resource_start(d) ((d)->resource.start)
 #define dio_resource_end(d)   ((d)->resource.end)
-- 
2.17.1

