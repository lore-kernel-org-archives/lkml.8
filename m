Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C895920734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KpnqMHq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHJHCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:02:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g19so4302554plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZ2qWIvH6uYgIORKPoTfrdoIgrgh2dDxOhXUmAE4Cf8=;
        b=KpnqMHq7NBNilrVqaRbw3aKNsVXzWCb5INK7cp772AVWrsz4eH2oMHnii03HUKebDF
         sKwmAcBjk7W6fuU6t8JkjjFD4fW5OVsJA0Xkjnvk/fFKQuVuOaKBrsDpzhC5PL11XSji
         nZRnV82G0uWGtneq1UepSdXDlm+v5tMeDGt3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pZ2qWIvH6uYgIORKPoTfrdoIgrgh2dDxOhXUmAE4Cf8=;
        b=nvsoKmm8dnHyLA47ze5ZIniv+vNbaj1wwnY4ZmKVmi6SBoQfo45D/jddOzM/n5ySX4
         tLuO+qpuphjGoAt+mb+loAEpLmpMUZwHQr7rYl5rnEGngmYTiqPPWkl/vrv4yDmV02kb
         byK2+clQOPsiz/vAEwlK5FiCTkQ0G+xZfrWxYZAuN1LUVUTw+eCPDjKdAZVKQJYy2Yjq
         i/ubUI1gUGeLg2AufvW+iSRJQ4terRnD+atJPBB4T49jo2IcLd6w6sIGxexEo+E3uzJl
         1Q+2pS9SxbY8PKHw7fro9Pt/gfOKhn631mI+OoTykFmauvvdutdjUkdQRDa0KYGWf1de
         soJQ==
X-Gm-Message-State: AOAM5337qL6Tvjb5DnvTNrR6mNWGEH8OZr4JBVizqLjQ+O7dIHFTy3j2
        AasJhmBD0u8ioXWcAwOFfm3J/w==
X-Google-Smtp-Source: ABdhPJwq29g5B+z9vOnN/8SxV/4lwZhNZJ3DXjSvTK3I8zP9tzjif4SPCX6yHfMVVm+9lAwuebTscg==
X-Received: by 2002:a17:90a:ca87:: with SMTP id y7mr24937606pjt.102.1597042924000;
        Mon, 10 Aug 2020 00:02:04 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id w7sm20620571pfi.164.2020.08.10.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:02:03 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] power: supply: sbs-battery: don't assume i2c errors as battery disconnect
Date:   Mon, 10 Aug 2020 15:01:59 +0800
Message-Id: <20200810070159.662863-1-ikjn@chromium.org>
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

This patch checks battery presence by reading well-known register to
check battery existence.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 73461321eb05..483f814385a3 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -875,10 +875,17 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >=0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		ret = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, !ret && !!(val.intval));
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1063,11 +1070,11 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
-
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		union power_supply_propval val;
+		rc = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (rc < 0 || !val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.236.gb10cc79966-goog

