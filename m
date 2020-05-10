Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EB7C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF86020820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FirvAfAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgEJOQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgEJOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:16:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44377C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:16:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so15810796wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5fOLcz38jnesy0zqxU18TIccuT5+HmAVeQpuAlPeGU=;
        b=FirvAfApZqUb89QUCO9pP79Rs6+Cw3ZnsM1O76XLGm33QRmUowvf9Gc1/o2roMrV2s
         vw3eZCSNKPFYUg3CQ7fOaXqyAgwYFDoTqMuWj4HndUiTgQcD6ZARxQUXNlMyY820rq35
         LCBBNFYzoQXOA2c8+CXs6z+ifGwijWo9tKjD/Pt4ndvAd+/gy1B5JINT0WAtbNOuWtiZ
         kOTwGR45Ba9EEBIWarFnv/gQtBnLkjs+O7mMR+CjB5myd+IDlGxuTtC19jTbvTVnGFJL
         p5QSnIOpq6OzK42h+LHdK9hNxV7ecfw8xoUr46lKTgWjMAzAy68SWWAvMmZeOtWGGeS6
         mkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y5fOLcz38jnesy0zqxU18TIccuT5+HmAVeQpuAlPeGU=;
        b=LRFMuepVKUqCjOU/667LlrV9FD/Kyjll6y9I5fEnDXhdydJZ7sAOFCxtkjl9vdWMA7
         SR+Fb8U5McL6Di1t/ai5JnT5wwIpSGe41JzxruHRb6Ks9NGYCW4TSg2ylVf73hmHG8Rd
         4E9EY17E21lGU7hV9R/Gj459j/TwNZMo257qgLOR+yjjnYI330sNp+RsaUVjxB7Bx6y2
         BSGdfU5V8PKDa1paR8axp7VA9PqwrO/dt1+wDJJvMuOSdFpoOsOAX+ZbarIFhryq8RID
         Fb6UxtGId/ena3MJBY72yxKzAgD1/OdxEoBlgrY98YXIi/3QC+s8W9G4om4MXOVx/qBh
         bn9g==
X-Gm-Message-State: AGi0PuaZWAsZe8XNcMx7zgYerz1MPvmo+o1YWC/U+fg318SkrfJB/Hqq
        zji+CB1a7zPl3CMqdjz6XcA=
X-Google-Smtp-Source: APiQypLI9ytTmArHYHZxo8x/22OZBqOPo4MNWc4HZYYbaPXBk+dvnA140QntiuJEE+l1stOjb0zLqw==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr27526156wmj.21.1589120171950;
        Sun, 10 May 2020 07:16:11 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id k4sm19205281wmf.41.2020.05.10.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 07:16:11 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com, rdunlap@infradead.org
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v6 2/9] w1_therm: fix reset_select_slave during discovery
Date:   Sun, 10 May 2020 16:16:04 +0200
Message-Id: <20200510141604.172556-1-akira215corp@gmail.com>
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

 drivers/w1/slaves/w1_therm.c | 48 ++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 890cf09..5de1a67 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
+#include <linux/string.h>
 
 #include <linux/w1.h>
 
@@ -89,6 +90,24 @@ struct therm_info {
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
@@ -300,7 +319,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 	while (max_trying--) {
 		crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 
 			/* read values to only alter precision bits */
@@ -313,7 +332,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 			if (rom[8] == crc) {
 				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
 
-				if (!w1_reset_select_slave(sl)) {
+				if (!reset_select_slave(sl)) {
 					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
 					w1_write_8(dev, rom[2]);
 					w1_write_8(dev, rom[3]);
@@ -435,6 +454,21 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
 
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
@@ -462,7 +496,7 @@ static ssize_t read_therm(struct device *device,
 		info->verdict = 0;
 		info->crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 			unsigned int tm = 750;
 			unsigned long sleep_rem;
@@ -470,7 +504,7 @@ static ssize_t read_therm(struct device *device,
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 750ms strong pullup (or delay) after the convert */
@@ -500,7 +534,7 @@ static ssize_t read_therm(struct device *device,
 				}
 			}
 
-			if (!w1_reset_select_slave(sl)) {
+			if (!reset_select_slave(sl)) {
 
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				count = w1_read_block(dev, info->rom, 9);
@@ -552,7 +586,7 @@ static inline int w1_therm_eeprom(struct device *device)
 	memset(rom, 0, sizeof(rom));
 
 	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			unsigned int tm = 10;
 			unsigned long sleep_rem;
 
@@ -560,7 +594,7 @@ static inline int w1_therm_eeprom(struct device *device)
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 10ms strong pullup/delay after the copy command */
-- 
2.26.2

