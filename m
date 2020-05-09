Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22590C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAABB2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7JfqEJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEIX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgEIX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:59:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E38CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:59:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id m24so4349153wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y87lF67Vi4z0wZ1VFRumqjwRk4aeUOBZyCR9R7Gv3fc=;
        b=I7JfqEJniySLY0u6mSFeMCFto8i3kLxdaOK0ba/VVqfusfQDb2cakXVNrxS/0lBofQ
         Oqt7lFiRNXVcf6r9wgNXjOgAV/i0QWTmQ0GGhxvNpFRhFLV2VAzYZeZVhKYosBI9yALU
         9DmXpCdiGgbfDkddtdckfQe82MqEnMHLN94Sqbk3UI7Qkp0TYTUss+5KVcEHKUUSQ/sQ
         kCRyRxOngFnt9xgWl0VJICZvFDJcpxeHipv3RpZ7qSLG0cuqJWWbIbll80AOGjjOMQtu
         PRB2zhSO9rjHzt+DHdIKMzWHIfY72Wp8I1zhEoZjWY+eb0aMCeex8Lp4JTTbS9OsiYGX
         PQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y87lF67Vi4z0wZ1VFRumqjwRk4aeUOBZyCR9R7Gv3fc=;
        b=AMqDEtWSQ1YlTFBIHfBNfcDD3+McxPhHmIq9dGpsEchDLMOZsWLl8116ir1zZSzxo0
         SLfpeaXLYNrDZwZ4sihfHEfa14RSQS4flaq3rE9Ty+2bHfKcwbvr0wo+fLoyGelKms2D
         Hp1Sur0OL3lRL0GlHfC8brVVuG/kaNAJnLgsAX74Nq7sZbIXCw57pITx7S5pPnid8MfN
         nGWoF8V5EfmGKxq3fDEch/G+48ZS7GnQD0wlM6u7FEZOp3kSykv43FrRGpbCEGV+6RGR
         sMicgvM5YfklH7nisWpxl2HpBT6wS2JeptTBu82cdnifrZbOuYm8lk9yQ4ssPaZtwJaW
         IXmQ==
X-Gm-Message-State: AGi0Pub/saLI6haqdcH3Fqmgbv/iwyiW+90uoPbkUkNj1r9c/oNJhik8
        7CjL26rsrx0AFGqHvzUBIEw=
X-Google-Smtp-Source: APiQypJJCaJgWq7vMYOnamaqbQcq5emq9Oms7W3i+1dWm8+M241BVrF1sPDFoKXpHljzLHRoBW2fVA==
X-Received: by 2002:a05:600c:201:: with SMTP id 1mr7484204wmi.155.1589068740214;
        Sat, 09 May 2020 16:59:00 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:48ff:3af:e1d8:fd19])
        by smtp.googlemail.com with ESMTPSA id g25sm19362662wmh.24.2020.05.09.16.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:58:59 -0700 (PDT)
From:   Akira Shimahara <akira215corp@gmail.com>
To:     greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org,
        Akira Shimahara <akira215corp@gmail.com>
Subject: [PATCH v5 2/9] w1_therm: fix reset_select_slave during discovery
Date:   Sun, 10 May 2020 01:58:50 +0200
Message-Id: <20200509235850.423252-1-akira215corp@gmail.com>
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

 drivers/w1/slaves/w1_therm.c | 45 ++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index f7147b2..4dd139b 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
+#include <linux/string.h>
 
 #include <linux/w1.h>
 
@@ -92,6 +93,21 @@ struct therm_info {
 	u8 verdict;
 };
 
+/*---------------------Hardware Functions declaration-----------------------*/
+
+/**
+ * reset_select_slave() - reset and select a slave
+ * \brief Resets the bus and select the slave by sending a ROM MATCH cmd
+ * w1_reset_select_slave() from w1_io.c could not be used here because
+ * it sent a SKIP ROM command if only one device is on the line.
+ * At the beginning of the such process, sl->master->slave_count is 1 even if
+ * more devices are on the line, causing collision on the line.
+ * The w1 master lock must be held.
+ * \param sl the slave to select
+ * \return 0 if success, negative kernel error code otherwise
+ */
+static int reset_select_slave(struct w1_slave *sl);
+
 /*-----------------------Interface sysfs declaration------------------------*/
 
 /** \brief A callback function to output the temperature Old way
@@ -305,7 +321,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 	while (max_trying--) {
 		crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 
 			/* read values to only alter precision bits */
@@ -318,7 +334,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
 			if (rom[8] == crc) {
 				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
 
-				if (!w1_reset_select_slave(sl)) {
+				if (!reset_select_slave(sl)) {
 					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
 					w1_write_8(dev, rom[2]);
 					w1_write_8(dev, rom[3]);
@@ -440,6 +456,21 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
 
 /*---------------------------Hardware Functions-----------------------------*/
 
+/* Safe version of reser_select_slave - avoid using the one in w_io.c */
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
@@ -467,7 +498,7 @@ static ssize_t read_therm(struct device *device,
 		info->verdict = 0;
 		info->crc = 0;
 
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			int count = 0;
 			unsigned int tm = 750;
 			unsigned long sleep_rem;
@@ -475,7 +506,7 @@ static ssize_t read_therm(struct device *device,
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 750ms strong pullup (or delay) after the convert */
@@ -505,7 +536,7 @@ static ssize_t read_therm(struct device *device,
 				}
 			}
 
-			if (!w1_reset_select_slave(sl)) {
+			if (!reset_select_slave(sl)) {
 
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				count = w1_read_block(dev, info->rom, 9);
@@ -557,7 +588,7 @@ static inline int w1_therm_eeprom(struct device *device)
 	memset(rom, 0, sizeof(rom));
 
 	while (max_trying--) {
-		if (!w1_reset_select_slave(sl)) {
+		if (!reset_select_slave(sl)) {
 			unsigned int tm = 10;
 			unsigned long sleep_rem;
 
@@ -565,7 +596,7 @@ static inline int w1_therm_eeprom(struct device *device)
 			w1_write_8(dev, W1_READ_PSUPPLY);
 			external_power = w1_read_8(dev);
 
-			if (w1_reset_select_slave(sl))
+			if (reset_select_slave(sl))
 				continue;
 
 			/* 10ms strong pullup/delay after the copy command */
-- 
2.26.2

