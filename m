Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A27C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C6E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 23:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BiqhlME8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHRXm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 19:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgHRXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 19:42:26 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4D6C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:42:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w23so5655580pll.21
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 16:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yY1Ai/jNTj6Vw5Dv9pvJHsoPjxTtiZAJ3yPRfLnZnrc=;
        b=BiqhlME8QDUTtH9S02XVPgc4aXak9Kd/BXz9C+GzU5fz+YaKUzRGt4T+zTOjhbzG6F
         iHOZtKeSpy5XZtjN7Kye/cUmNGcsKrGxr0oKJ6ZR+FPZs4S4pFNz8SZcCKB1dFMnCHdQ
         LDCLxiJapOpKg4rEEzAbVBVaXnUBFKUdCA2hmdrzs9ah+Nn4pJWAEhAZVZZaCTDbpL/v
         M36UD9V9+fHghXl2jQ2HIH1A4Ae4gMpDO6jNE1L/C7eG4RNbOILHW6zDTX4oBGVObM+l
         g8ib6spUc7x39PVOc1F09DLuM5VWf+3OdkmiW2cbIA6IN2bDvwCau7AaXc1HY9xPf895
         yOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yY1Ai/jNTj6Vw5Dv9pvJHsoPjxTtiZAJ3yPRfLnZnrc=;
        b=Vx06YKgPXlx8aVz5sBUun6S9Y5FKMuffjfJhXHlY233EkASJMMg10O91yz1L3TipoR
         VlKYhSOuI/hXnWjngpP09uaN6gm7czhldk11gB5KcSec5lEVScHjW4rGxxHrRPODZW4A
         qT3g2XowqPo/73xYLYjmsPNd1E6mQMjCyvRJ4L9BL04nPrDJi9kTDbe3L8YdtvlKNDjN
         HTQ+Z7rXVtha6hqF+BU/4A8bUdUpuMiivwyBO3pGu0jfZvlTIz8fqNCmYghoLmjAtiPM
         0z+ABA0p0Jpyw5Ceh/O/lS2XdumgjGVQrWuqT8Y0SobTn6zeCGD7Ciyc1qL2p9/QzjHw
         rMJw==
X-Gm-Message-State: AOAM532SzX8EY/hEQUJLibMgJb/6lRtoXSaMH7AJwsTTtHjYioP0ft9u
        5ZWUfpf3wzW25T0GgksOHJefiEtx+jn6
X-Google-Smtp-Source: ABdhPJwthDZoNP1DxXeGiF0NGBrbyivJjDqG4TqsNlTSVgOqpPIggITb8N6ZBA3M0jfzkUY61z3YXRlQMBHT
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a17:90a:bc41:: with SMTP id
 t1mr1735763pjv.181.1597794144834; Tue, 18 Aug 2020 16:42:24 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:42:15 -0700
Message-Id: <20200818234215.2255611-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] drivers: input: Use single i2c_transfer transaction when
 using RM_CMD_BANK_SWITCH
From:   Furquan Shaikh <furquan@google.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        adurbin@google.com, Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an AMD chromebook, where the same I2C bus is shared by both Raydium
touchscreen and a trackpad device, it is observed that interleaving of
I2C messages when raydium_i2c_read_message() is called leads to the
Raydium touch IC reporting incorrect information. This is the sequence
that was observed to result in the above issue:

* I2C write to Raydium device for RM_CMD_BANK_SWITCH
* I2C write to trackpad device
* I2C read from trackpad device
* I2C write to Raydium device for setting address
* I2C read from Raydium device >>>> This provides incorrect
  information

This change updates raydium_i2c_read_message and
raydium_i2c_send_message to perform all the I2C transfers in the
function as part of a single i2c_transfer transaction. This ensures
that no transactions are initiated to any other device on the same bus
in between and hence the information obtained from the touchscreen
device is correct. Verified with the patch across multiple
reboots (>100) that the information reported by the Raydium
touchscreen device during probe is correct.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 102 ++++++++++++++++-----
 1 file changed, 80 insertions(+), 22 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index fe245439adee..11c00d341eb1 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -111,6 +111,15 @@ struct raydium_info {
 	u8 y_res;		/* units/mm */
 };
 
+/*
+ * Header to be sent for RM_CMD_BANK_SWITCH command. This is used by
+ * raydium_i2c_{read|send}_message below.
+ */
+struct __packed raydium_bank_switch_header {
+	u8 cmd;
+	__be32 be_addr;
+};
+
 /* struct raydium_data - represents state of Raydium touchscreen device */
 struct raydium_data {
 	struct i2c_client *client;
@@ -198,22 +207,44 @@ static int raydium_i2c_read(struct i2c_client *client,
 static int raydium_i2c_read_message(struct i2c_client *client,
 				    u32 addr, void *data, size_t len)
 {
-	__be32 be_addr;
-	size_t xfer_len;
-	int error;
+	int ret;
 
 	while (len) {
-		xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
-
-		be_addr = cpu_to_be32(addr);
+		u8 read_addr = addr & 0xff;
+		struct raydium_bank_switch_header header = {
+			.cmd = RM_CMD_BANK_SWITCH,
+			.be_addr = cpu_to_be32(addr),
+		};
+		size_t xfer_len = min_t(size_t, len, RM_MAX_READ_SIZE);
+		/*
+		 * Perform as a single i2c_transfer transaction to ensure that
+		 * no other I2C transactions are initiated on the bus to any
+		 * other device in between. Initiating transacations to other
+		 * devices after RM_CMD_BANK_SWITCH is sent is known to cause
+		 * read issues.
+		 */
+		struct i2c_msg xfer[] = {
+			{
+				.addr = client->addr,
+				.len = sizeof(header),
+				.buf = (u8 *)&header,
+			},
+			{
+				.addr = client->addr,
+				.len = 1,
+				.buf = &read_addr,
+			},
+			{
+				.addr = client->addr,
+				.flags = I2C_M_RD,
+				.len = xfer_len,
+				.buf = data,
+			}
+		};
 
-		error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
-					 &be_addr, sizeof(be_addr));
-		if (!error)
-			error = raydium_i2c_read(client, addr & 0xff,
-						 data, xfer_len);
-		if (error)
-			return error;
+		ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+		if (ret != ARRAY_SIZE(xfer))
+			return ret < 0 ? ret : -EIO;
 
 		len -= xfer_len;
 		data += xfer_len;
@@ -224,22 +255,49 @@ static int raydium_i2c_read_message(struct i2c_client *client,
 }
 
 static int raydium_i2c_send_message(struct i2c_client *client,
-				    u32 addr, const void *data, size_t len)
+				    u32 addr, void *data, size_t len)
 {
-	__be32 be_addr = cpu_to_be32(addr);
-	int error;
+	int tries = 0;
 
-	error = raydium_i2c_send(client, RM_CMD_BANK_SWITCH,
-				 &be_addr, sizeof(be_addr));
-	if (!error)
-		error = raydium_i2c_send(client, addr & 0xff, data, len);
+	do {
+		int ret;
+		u8 write_addr = addr & 0xff;
+		struct raydium_bank_switch_header header = {
+			.cmd = RM_CMD_BANK_SWITCH,
+			.be_addr = cpu_to_be32(addr),
+		};
+
+		struct i2c_msg xfer[] = {
+			{
+				.addr = client->addr,
+				.len = sizeof(header),
+				.buf = (u8 *)&header,
+			},
+			{
+				.addr = client->addr,
+				.len = 1,
+				.buf = &write_addr,
+			},
+			{
+				.addr = client->addr,
+				.len = len,
+				.buf = data,
+			}
+		};
 
-	return error;
+		ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+		if (likely(ret == ARRAY_SIZE(xfer)))
+			return 0;
+
+		msleep(20);
+	} while (++tries < RM_MAX_RETRIES);
+
+	return -EIO;
 }
 
 static int raydium_i2c_sw_reset(struct i2c_client *client)
 {
-	const u8 soft_rst_cmd = 0x01;
+	u8 soft_rst_cmd = 0x01;
 	int error;
 
 	error = raydium_i2c_send_message(client, RM_RESET_MSG_ADDR,
-- 
2.28.0.220.ged08abb693-goog

