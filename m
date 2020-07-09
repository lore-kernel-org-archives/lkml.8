Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B51AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF56206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+kVGjQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGIEGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGIEGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:06:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D9C08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 21:06:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e14so1334533ybk.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 21:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1y2c3rjVWMDvkKdYX8ZNaWmxEBIIQ3QnKUzqSw9YCtw=;
        b=v+kVGjQtYzAabSAO2hVKtBYznz8uI02EUUuXTacWLcGXnVXhea9CwSYIsZtGhtthah
         h/+cSWroxJWyTyGcFs465H2HD9/sIjqtZFwUH03rkplMnoTi1vTfMBerm5WA517N4Qfg
         EJeH/U3ffEFGZCS3iICsNNefitXPX3j3iy9S1ip8ujMtHfAGmuiBmxovYam+sjIF1B04
         HFwkf3qBzbRKekmUJ68IpQMvcUg611xkelANY1Fltk4u7wAbpBNEOcXalgIV1Rw0lSIW
         vv3tnHZ1ZDyPuikQ9k9xf1EK/mhOQPeSrLKQUH4q36ZNQ5u8zfRk8t3yIJ5iaBPNn4qH
         92gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1y2c3rjVWMDvkKdYX8ZNaWmxEBIIQ3QnKUzqSw9YCtw=;
        b=s1KykfTnGsyntfYmH71s0TbHy3+fmMBpDNpm5jNXy28MlxqrbeJ0yHjd43kDnh4I94
         heLKE5bNraek7oHqYAyucG7Ae8Zb74G3PlXxuB0uEQU4agx1XOLnolXJHRFt7z9JyCWO
         b4h/+wvwIFtSiUXBRgajrq/76FCT94oLR/tOzbHXk2Ad7r5In5AlWtTom5D1V9PKjxMx
         MsI+B1j5aoiqMOwbt7zYKzqxdikvUAK5OVOybF8THei9yRFHKo7BlfdoPn3n7LE8Bd3+
         qF8nBWU1PMGyMLtVAHgG1dLXarI0f3cenJOz8uLihOhQdevCzcCug6goSbcEZA+aKeaL
         KoWQ==
X-Gm-Message-State: AOAM533sQgGcTCLIJp/C4MrLo5i3Xzchjg+2Arhgrntrz8o96Por4OHu
        t9wbgRWqFN6PsWhRqjisZTetiwNobrzD2Rg4
X-Google-Smtp-Source: ABdhPJysVuabU1/EIYkuOguPqwUhvSghCQ6RiPLy3m040sjW13pEIAe6T9sUlWstOcS5Rovj8NjC7SwRQ2He9Hk+
X-Received: by 2002:a25:4143:: with SMTP id o64mr17348936yba.226.1594267580232;
 Wed, 08 Jul 2020 21:06:20 -0700 (PDT)
Date:   Thu,  9 Jul 2020 04:06:12 +0000
Message-Id: <20200709040612.3977094-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v2] hwmon: adm1275: Make sure we are reading enough data for
 different chips
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linchuyuan@google.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

ChangeLog v1 -> v2
  - Rename config_read_fn_ptr to config_read_fn
  - Move config_read_fn to the first line as it is the longest
    variable declaration
  - Include adm1293 and adm1294
  - Remove the inline comment as I think the purpose is obvious


 drivers/hwmon/pmbus/adm1275.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index e25f541227da..19317575d1c6 100644
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
2.27.0.383.g050319c2ae-goog

