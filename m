Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52563C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA720771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 05:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VIw7Xr8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMFLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 01:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:11:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE755C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:11:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e4so2222332pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FMYYj1/Xxcp82PCrmKsgs8Np1phiw6fLYPJNOolOwNw=;
        b=VIw7Xr8WMGYfKDagFaz/elAgH5+hg3d4Xw4OMofLulJoJXk+XI3fJDTUCg5G1JDqFc
         584/+i3l3qLKhNDGedNvT6DalAyoNpMMywO2oyM9vOkJepnUc39TDnpNM7OjLDoZ8qGC
         f/jp5y3w6FbEK9z6CVYTjdKsADzOwil/6vHMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FMYYj1/Xxcp82PCrmKsgs8Np1phiw6fLYPJNOolOwNw=;
        b=Dm0lDhXyeS9aZM6+RN2Y6u0SVqMXKKXRtSybND6YuQYMQLtLJkBS2eaNVkxHrXbK+D
         ADWt6DObIhekjVNTC6oWa34LvQ0Jt5qy/tkDNJIwyWeNVJjhb9DknnPDsD7PAV3dIf9O
         JIPQb5rV4bpQ/H+8AfXgH45/obCbBs3nvFsR+I6sLWw088CK92AzBVg8ANYnuBcXLSof
         3gneY4OYpo7HucOj2ptRWKotmAGCRFlMd9GFWg4InKgx/vggaAMK24KyEYOSFNmrt8Z+
         a9uYl5fq6i4joSC//XhrljhfcR7Ekfiao3B5DCAio+T5BGg+VIhvrreJri+N13t9OjyQ
         lWfQ==
X-Gm-Message-State: AOAM531Yf7i2qKMc4np2hCWsHi+mkIYoMHKbLEOJKYY/YAIB1ArBdt2U
        i+SOqdu8iOi7rPt3gEyS6qGlUA==
X-Google-Smtp-Source: ABdhPJwoD2Tp7w1MZmvV9527An+ypHDs/mT8Qr0CKML1UcNCZyBFrtkn4SXAXZqMGyV04NGtBdkMmg==
X-Received: by 2002:a17:90a:740e:: with SMTP id a14mr3233903pjg.165.1597295474397;
        Wed, 12 Aug 2020 22:11:14 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id fh14sm3720153pjb.38.2020.08.12.22.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 22:11:14 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH v3 2/2] power: supply: sbs-battery: don't assume i2c errors as battery disconnect
Date:   Thu, 13 Aug 2020 13:10:08 +0800
Message-Id: <20200813051008.3461515-3-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
In-Reply-To: <20200813051008.3461515-1-ikjn@chromium.org>
References: <0200811065307.2094930-1-ikjn@chromium.org>
 <20200813051008.3461515-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current sbs-battery considers all smbus errors as disconnection events
when battery-detect pin isn't supplied, and restored to present state back
when any successful transaction is made.

This can lead to unlimited state changes between present and !present
when one unsupported command was requested and other following commands
were successful, e.g. udev rules tries to read multiple properties.

This patch checks battery presence by reading known good command to
check battery existence.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6acb4ea25d2a..2e32fde04628 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -878,10 +878,17 @@ static int sbs_get_property(struct power_supply *psy,
 	if (!chip->enable_detection)
 		goto done;
 
-	if (!chip->gpio_detect &&
-		chip->is_present != (ret >= 0)) {
-		sbs_update_presence(chip, (ret >= 0));
-		power_supply_changed(chip->power_supply);
+	if (!chip->gpio_detect && chip->is_present != (ret >= 0)) {
+		bool old_present = chip->is_present;
+		union power_supply_propval val;
+
+		ret = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+
+		sbs_update_presence(chip, !ret && val.intval);
+
+		if (old_present != chip->is_present)
+			power_supply_changed(chip->power_supply);
 	}
 
 done:
@@ -1067,11 +1074,13 @@ static int sbs_probe(struct i2c_client *client)
 	 * to the battery.
 	 */
 	if (!(force_load || chip->gpio_detect)) {
-		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
+		union power_supply_propval val;
 
-		if (rc < 0) {
-			dev_err(&client->dev, "%s: Failed to get device status\n",
-				__func__);
+		rc = sbs_get_battery_presence_and_health(
+				client, POWER_SUPPLY_PROP_PRESENT, &val);
+		if (rc < 0 || !val.intval) {
+			dev_err(&client->dev, "Failed to get present status\n");
+			rc = -ENODEV;
 			goto exit_psupply;
 		}
 	}
-- 
2.28.0.236.gb10cc79966-goog

