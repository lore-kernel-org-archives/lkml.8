Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FAAC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF94B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toFrMiQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgEKUgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKUgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:36:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:36:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so12680830wra.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MsNU84hetyfF6zdPC3wGUgOPgBm/7koQkMk3+n24ylg=;
        b=toFrMiQUW4O81dYzsRAVH6dllzHi7YW6EgcePzguVQQm7Fnlee/S7EtT7lqU4DvBu4
         D8o/A/uE5cq8uAcCw2firsd0YjdjdNswErpaEZmtNx134QrXHv3SfqDLXBkZ/QbDRBXc
         3Ql4WiUghSv3DUK2hzFxCdOVyoEfQucicdJbbcxIidp2TBG7mGQCVzEElhsd+MKJ4vR7
         KbRZJLd0csWdK7ezpL47ijMzl1lv5I3mxLAtgIDPOOcjMf7tIY3KK6efiGfREUMG5QPc
         6T/mURLWK4G3GPETWFn08StqigR3L8AAwDhY4XDUp2msoOsEGQYD8pCOkuV8CyHonPO5
         QNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MsNU84hetyfF6zdPC3wGUgOPgBm/7koQkMk3+n24ylg=;
        b=cyCkDfwEeVHbG+aP2xgtTHu+YjbkgYLevdJcEkKnBl7rgBP7/o4rwOgkKt7cIhmu9v
         AYtN+PFQmowQQGIXmN1mQNECm8xd+lwdO4bIA1Ge0l0eMSvD+ineEaHP7QjSfR1RoiT2
         vyaxrOPd6QvhNpy+Z1wkUvDlVq+iBsRUelZD26+QPKYqqffTNbSydAjqX0DrzeLVe8lN
         y2nBAM9eAir3VQx0335ujfIyvE+7aMPriLeIbn5g4t4AsqdmC3dKsUZ3f98gJ9KDlunu
         6ZRhyxsBMDwU7ryxhu6tcPntNJDA9UjmTMiy9vUKYC+9nj0D4lsoKQmYgW3eu0mX9JEN
         IAoA==
X-Gm-Message-State: AGi0PuaGupNNtFx5zifAoxNc5OUFS4iqBPq4NyTVHUsEyvqeQkQF72Bw
        Lbu8d5HImytXE9FmjcAm97g=
X-Google-Smtp-Source: APiQypIG95OMIDrOYKvIa+WiIHiiBIaDNYrOJAWNYnd449fNs1mxEVyi9kl3s14kf8FnwJM2/Kw4zw==
X-Received: by 2002:a5d:4041:: with SMTP id w1mr2483025wrp.245.1589229381188;
        Mon, 11 May 2020 13:36:21 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.googlemail.com with ESMTPSA id u9sm7464114wmb.19.2020.05.11.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:36:20 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v7 2/9] w1_therm: fix reset_select_slave during discovery
Date:   Mon, 11 May 2020 22:36:10 +0200
Message-Id: <20200511203610.409975-1-akira215corp@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix reset_select_slave issue during devices discovery by the master on
bus. The w1_reset_select_slave() from w1_io.c, which was previously used,
assume that if the slave count is 1 there is only one slave attached on
the bus. This is not always true. For example when discovering devices,
when the first device is discover by the bus master, its slave count is
1, but some other slaves may be on the bus.

In that case instead of adressing command to the attached slave the 
master throw a SKIP ROM command so that all slaves attached on the bus
will answer simultenaously causing data collision.

A dedicated reset_select_slave() function is implemented here,
it always perform an adressing to each slave using the MATCH ROM
command.

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v5:
- All patch serie in one .c file
- Correcting some comments
- adding <linux/string.h> include
Changes in v6:
- Formatting code comments according to kernel-doc requirements
Changes in v7:
- Formatting code comments and correcting comments mistakes

 drivers/w1/slaves/w1_therm.c | 48 ++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 67204b3..6a54fc4 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
+#include <linux/string.h>
 
 #include <linux/w1.h>
 
@@ -90,6 +91,24 @@ struct therm_info {
 	u8 verdict;
 };
 
+/* Hardware Functions declaration */
+
+/**
+ * reset_select_slave() - reset and select a slave
+ * @sl: the slave to select
+ *
+ * Resets the bus and select the slave by sending a ROM MATCH cmd
+ * w1_reset_select_slave() from w1_io.c could not be used here because
+ * it sent a SKIP ROM command if only one device is on the line.
+ * At the beginning of the such process, sl->master->slave_count is 1 even if
+ * more devices are on the line, causing collision on the line.
+ *
+ * Context: The w1 master lock must be held.
+ *
+ * Return: 0 if success, negative kernel error code otherwise.
+ */
+static int reset_select_slave(struct w1_slave *sl);
+
 /* Sysfs interface declaration */
 
 static ssize_t w1_slave_show(struct device *device,
@@ -301,7 +320,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 	while (max_trying--) {
 		crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 
 			/* read values to only alter precision bits */
@@ -314,7 +333,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 			if (rom[8] == crc) {
 				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
 
-				if (!w1_reset_select_slave(sl)) {
+				if (!reset_select_slave(sl)) {
 					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
 					w1_write_8(dev, rom[2]);
 					w1_write_8(dev, rom[3]);
@@ -460,6 +479,21 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
 
 /* Hardware Functions */
 
+/* Safe version of reset_select_slave - avoid using the one in w_io.c */
+static int reset_select_slave(struct w1_slave *sl)
+{
+	u8 match[9] = { W1_MATCH_ROM, };
+	u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
+
+	if (w1_reset_bus(sl->master))
+		return -ENODEV;
+
+	memcpy(&match[1], &rn, 8);
+	w1_write_block(sl->master, match, 9);
+
+	return 0;
+}
+
 static ssize_t read_therm(struct device *device,
 			  struct w1_slave *sl, struct therm_info *info)
 {
@@ -487,7 +521,7 @@ static ssize_t read_therm(struct device *device,
 		info->verdict = 0;
 		info->crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 			unsigned int tm = 750;
 			unsigned long sleep_rem;
@@ -495,7 +529,7 @@ static ssize_t read_therm(struct device *device,
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 750ms strong pullup (or delay) after the convert */
@@ -525,7 +559,7 @@ static ssize_t read_therm(struct device *device,
 				}
 			}
 
-			if (!w1_reset_select_slave(sl)) {
+			if (!reset_select_slave(sl)) {
 
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				count = w1_read_block(dev, info->rom, 9);
@@ -577,7 +611,7 @@ static inline int w1_therm_eeprom(struct device *device)
 	memset(rom, 0, sizeof(rom));
 
 	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			unsigned int tm = 10;
 			unsigned long sleep_rem;
 
@@ -585,7 +619,7 @@ static inline int w1_therm_eeprom(struct device *device)
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 10ms strong pullup/delay after the copy command */
-- 
2.26.2

