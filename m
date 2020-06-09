Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10631C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62B3206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mCASZcRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgFITWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgFITWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:22:43 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681DC03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 12:22:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d8so5241226plo.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AREZFen+390F/g/lLqSOI2E3OTadaJweieFHsKjOGEo=;
        b=mCASZcRtsW2E9COdZCGGeuE6fxEOLG8kDxoXySFgqYfZkelvoZBw41VZgZ7yG7T2UY
         3NumPgt5kZ5QkhfHFo9v9bI06oehP5L1msin12ey1vmNVyZbK5eAv0BaRAsETVGqaKP4
         04KW+40DI4sYL6yy17H4KQCE7TtXDHFiyQIT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AREZFen+390F/g/lLqSOI2E3OTadaJweieFHsKjOGEo=;
        b=nm2d/JCvSsN0n/m1dU59HdylkOPFQ9rOFf7rSVtGmUHPTeeq+LVggA41vA7/BNSSfV
         WfnIUWyF/zRzTHMYpHtxteRD4VwqLMlJaM9sMp1CpKgBDFEnAWXwRf1KKkl0rfz1rVhX
         rtacxAAkQt8m/nSX+WTc2qvHs20CT0mktQ8N4KRjC/uxvZr5fEofsh2laQtVDZtJYGTp
         /4k/2ae1J9CQBe2crYQgetSWtNNJB3z1EhGwgmLzdIl5SAoQxPzBh6VoEthPAbvp16D9
         6iMjXFfdjjTkhC2Nka61N1TsKwuaNE9CGP6j0USl9TFX2be0nFXDBqTwCpvNPiwnnNSZ
         ktDQ==
X-Gm-Message-State: AOAM532wP+nJff9GK4m3zIL8XWrmV0ivt/OjLBKZ/Zf2tCFF9ZcrjP25
        wBwBZjJpK50nPZPtP2trptFCDg==
X-Google-Smtp-Source: ABdhPJxhnDO1wuNjXw7lcXWylEoFV7scLH3smcZwtgL94V+KtbXIMxQSgff/lO9E9m2xpoHwCpb+yA==
X-Received: by 2002:a17:902:bc86:: with SMTP id bb6mr4501337plb.243.1591730562043;
        Tue, 09 Jun 2020 12:22:42 -0700 (PDT)
Received: from twawrzynczak.bld.corp.google.com ([161.97.245.194])
        by smtp.gmail.com with ESMTPSA id p12sm10883174pfq.69.2020.06.09.12.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:22:41 -0700 (PDT)
From:   Tim Wawrzynczak <twawrzynczak@chromium.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tim Wawrzynczak <twawrzynczak@chromium.org>
Subject: [PATCH 1/2] power: supply: Add new power supply prop for date of manufacture
Date:   Tue,  9 Jun 2020 13:22:36 -0600
Message-Id: <20200609192237.32571-1-twawrzynczak@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Smart Battery Specification v1.1 defines Manufacture Date as one of
its availabe registers. This patch adds this as a property so that
power_supply drivers can support the property and report it in syfs.

Signed-off-by: Tim Wawrzynczak <twawrzynczak@chromium.org>
Change-Id: I90bf8c67b0cd531f2155404424a98302a1c931d6
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 include/linux/power_supply.h              | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b9..ac6d9992a8675 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -171,7 +171,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 		ret = sprintf(buf, "%s\n",
 			      power_supply_scope_text[value.intval]);
 		break;
-	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_SERIAL_NUMBER:
+	case POWER_SUPPLY_PROP_MODEL_NAME ... POWER_SUPPLY_PROP_MANUFACTURE_DATE:
 		ret = sprintf(buf, "%s\n", value.strval);
 		break;
 	default:
@@ -310,6 +310,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
 	POWER_SUPPLY_ATTR(serial_number),
+	POWER_SUPPLY_ATTR(manufacture_date),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 28413f737e7d0..67839bb0a46b6 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -162,6 +162,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_MANUFACTURE_DATE,
 };
 
 enum power_supply_type {
-- 
2.26.2

