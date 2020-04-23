Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52770C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3023620776
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kV5doxnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgDWQCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:02:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41052 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbgDWQCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:02:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03NG2eYf101883;
        Thu, 23 Apr 2020 11:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587657760;
        bh=1NH2XB5Oms82BHTZJAEVYiodGFdHx/vjCOGPbtuG1oQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kV5doxnSZOSYTCjqfiOHuZB1VKBJBdN5LJ6T1NOSpCZJbuMjJOBYxbejffdbNHEp4
         E2GIVZPawJdSDJpxgsFvoXYYqNASnWaJC9JDmYznqSQVH4P8FyjRg+toouN+KBUHiv
         gCwIWhXZTdOfEtEtbQGp+PmehnmbL/7HCs7YR7po=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03NG2dbd062738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 11:02:40 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 11:02:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 11:02:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03NG2diq028400;
        Thu, 23 Apr 2020 11:02:39 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v20 16/17] leds: lp5523: Fix checkpatch issues in the code
Date:   Thu, 23 Apr 2020 10:55:23 -0500
Message-ID: <20200423155524.13971-17-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423155524.13971-1-dmurphy@ti.com>
References: <20200423155524.13971-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch errors and warnings for the LP5523.c device
driver.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-lp5523.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 80d364f237d0..8ce278348495 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -23,13 +23,13 @@
 
 #define LP5523_PROGRAM_LENGTH		32	/* bytes */
 /* Memory is used like this:
-   0x00 engine 1 program
-   0x10 engine 2 program
-   0x20 engine 3 program
-   0x30 engine 1 muxing info
-   0x40 engine 2 muxing info
-   0x50 engine 3 muxing info
-*/
+ * 0x00 engine 1 program
+ * 0x10 engine 2 program
+ * 0x20 engine 3 program
+ * 0x30 engine 1 muxing info
+ * 0x40 engine 2 muxing info
+ * 0x50 engine 3 muxing info
+ */
 #define LP5523_MAX_LEDS			9
 
 /* Registers */
@@ -326,7 +326,7 @@ static int lp5523_update_program_memory(struct lp55xx_chip *chip,
 					const u8 *data, size_t size)
 {
 	u8 pattern[LP5523_PROGRAM_LENGTH] = {0};
-	unsigned cmd;
+	unsigned int cmd;
 	char c[3];
 	int nrchars;
 	int ret;
@@ -468,6 +468,7 @@ static int lp5523_mux_parse(const char *buf, u16 *mux, size_t len)
 static void lp5523_mux_to_array(u16 led_mux, char *array)
 {
 	int i, pos = 0;
+
 	for (i = 0; i < LP5523_MAX_LEDS; i++)
 		pos += sprintf(array + pos, "%x", LED_ACTIVE(led_mux, i));
 
@@ -506,7 +507,7 @@ static int lp5523_load_mux(struct lp55xx_chip *chip, u16 mux, int nr)
 	if (ret)
 		return ret;
 
-	ret = lp55xx_write(chip, LP5523_REG_PROG_MEM , (u8)(mux >> 8));
+	ret = lp55xx_write(chip, LP5523_REG_PROG_MEM, (u8)(mux >> 8));
 	if (ret)
 		return ret;
 
-- 
2.25.1

