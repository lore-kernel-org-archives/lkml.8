Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C82C20772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jL63M1Jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgHKG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgHKG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:59:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729AFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:59:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so7093643pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFIXitVkGGB3OquEg0UyFCUv4pL9LxO2pe6bYqKtso=;
        b=jL63M1JnD3F1yArg7W8QNSlW8MlF3QrcrBCZ9t//W4XmKBRTEHGcw7GhYfX0EUuc+G
         DepzEo+TBYU7rr9vPQi8p5Nw1TbMB936DZsSp0xT82QBcQ+18zNeWpL5I/x51ZkA6+0B
         lw/3UMHs8ECfpoXdOidsP2GnLr6ZjvVxmi0w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJFIXitVkGGB3OquEg0UyFCUv4pL9LxO2pe6bYqKtso=;
        b=sOTHxrHyqgudHAlatL2l77TuTv39xJrmfqDwKfWjRm2i8jmsaxJGfdA8qvLZp4dAN7
         YrZA/LBVwsWY8SbVisOpTGHtBmpTFQvZHtivRuuejYGnCeX/7+nXQtHQ2VICbG23aCdb
         OiipLKfTqYytQpO0eBKZ76HpJEZhg8Oy7QdxzkXHutHh5f66pNAl8aJfOfQtJv8P1UZP
         34fDXmASoG7nz8e5i/TMPjGKubomSX6aakjzPjXvmUa8+jwVjwhgR4rocCSVcMXg7IjD
         B8xQ3N9IylJe8YFcNkPntyRAH06uObydBuPQOOamv7B5xAuAX/545/1WxJG5wGsB8XZc
         KimA==
X-Gm-Message-State: AOAM532qDNHsF699vYWaTRiIGgDLv3DJmD2U1nc5zy8Mw6yWlz8ETRxB
        jpkc3HmVtiEViz4VfiEyl/2S0rZt9Fw=
X-Google-Smtp-Source: ABdhPJwt7VZ9y0TDCOyGtiXGInmj8RP3FEOipZFy9pMwd7HbGwe6zkcbWrDe3CwzHsUOOuEao9qkyw==
X-Received: by 2002:a62:ee06:: with SMTP id e6mr4734809pfi.313.1597129145927;
        Mon, 10 Aug 2020 23:59:05 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id b15sm20487599pgk.14.2020.08.10.23.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:59:05 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v2 2/2] power: supply: sbs-battery: don't assume every i2c errors as battery disconnect
Date:   Tue, 11 Aug 2020 14:59:02 +0800
Message-Id: <20200811065902.2100551-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sbs-battery considers all smbus errors as diconnection events
when battery-detect pin isn't supplied, and restored to present state back
on any successful transaction were made.

This can leads to unlimited state changes between present and !present
when one unsupported command was requested and other following commands
were successful, e.g. udev rules tries to read multiple properties.

This patch checks battery presence by reading known good command to
check battery existence.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
v2: fix return value checking of sbs_get_battery_presence_and_health()
---
 drivers/power/supply/sbs-battery.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6acb4ea25d2a..db964a470ebc 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!chip->enable_detection)
 		goto done;
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, val.intval);
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1067,11 +1074,12 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		union power_supply_propval val;
+		sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (!val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
+			rc = -ENODEV;
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.236.gb10cc79966-goog

