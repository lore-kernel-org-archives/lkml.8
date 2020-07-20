Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F9C43461
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7D3207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281489;
	bh=qwv1oXhk8at2vNn/hHKYLEGA/5GQhzw6wtG6R2MdQ4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVMJIY8McVBZr+gQ/6hhoDnqP7UJpiOlBxEj/zTcXPv2eV+FvU+CzrNpKYvBBoMkc
	 nl+ogeOSjg5GW1eEIBJfTkVpOqv92zs5oZCZgWgv8+WgEytfM3XiDcnW6QeAZMnH2c
	 +gpKPQh3C1TQuW4np021uQFbsYJKmGeagODRZj30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgGTVos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgGTVhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F115E22CB2;
        Mon, 20 Jul 2020 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281066;
        bh=qwv1oXhk8at2vNn/hHKYLEGA/5GQhzw6wtG6R2MdQ4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Luh522dPoA3Cu/ieQ3SJDSK4dHVDT1EsoeI7Ka6xa79wblibthAnEYm7Y8Mfr1W1g
         AbZbscXQLS+eICeiHwQRugdvcbsxvsJSuq6sRo8BGAY89yWx6Mr2Meu+Wc7B+jtr88
         /qkKllUnTqziirhkrJ40lD9I0G/dopZZ9GFaKLs4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chu Lin <linchuyuan@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 25/40] hwmon: (adm1275) Make sure we are reading enough data for different chips
Date:   Mon, 20 Jul 2020 17:37:00 -0400
Message-Id: <20200720213715.406997-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chu Lin <linchuyuan@google.com>

[ Upstream commit 6d1d41c075a1a54ba03370e268171fec20e06563 ]

Issue:
When PEC is enabled, binding adm1272 to the adm1275 would
fail due to PEC error. See below:
adm1275: probe of xxxx failed with error -74

Diagnosis:
Per the datasheet of adm1272, adm1278, adm1293 and amd1294,
PMON_CONFIG (0xd4) is 16bits wide. On the other hand,
PMON_CONFIG (0xd4) for adm1275 is 8bits wide. The driver should not
assume everything is 8bits wide and read only 8bits from it.

Solution:
If it is adm1272, adm1278, adm1293 and adm1294, use i2c_read_word.
Else, use i2c_read_byte

Testing:
Binding adm1272 to the driver.
The change is only tested on adm1272.

Signed-off-by: Chu Lin <linchuyuan@google.com>
Link: https://lore.kernel.org/r/20200709040612.3977094-1-linchuyuan@google.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/adm1275.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index e25f541227dae..19317575d1c6a 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -465,6 +465,7 @@ MODULE_DEVICE_TABLE(i2c, adm1275_id);
 static int adm1275_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	s32 (*config_read_fn)(const struct i2c_client *client, u8 reg);
 	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
 	int config, device_config;
 	int ret;
@@ -510,11 +511,16 @@ static int adm1275_probe(struct i2c_client *client,
 			   "Device mismatch: Configured %s, detected %s\n",
 			   id->name, mid->name);
 
-	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+	if (mid->driver_data == adm1272 || mid->driver_data == adm1278 ||
+	    mid->driver_data == adm1293 || mid->driver_data == adm1294)
+		config_read_fn = i2c_smbus_read_word_data;
+	else
+		config_read_fn = i2c_smbus_read_byte_data;
+	config = config_read_fn(client, ADM1275_PMON_CONFIG);
 	if (config < 0)
 		return config;
 
-	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
+	device_config = config_read_fn(client, ADM1275_DEVICE_CONFIG);
 	if (device_config < 0)
 		return device_config;
 
-- 
2.25.1

