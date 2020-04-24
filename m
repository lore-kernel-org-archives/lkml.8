Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9EEC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0779220774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RkeTuMr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgDXRf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728877AbgDXRfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:35:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33974C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so4845684pjo.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33hdVZdIvdo3r9ulzCeqVPA1lq6sxl5V/50+KNNX3vA=;
        b=RkeTuMr6pQxS9kGQ1szZoB7f5ty7zYGnPdIZBCe2ITN1R7VrKR6yI0p9MOpKHYnxo3
         0Brs7q3clGo3BgEVWdBjge9STeM5CRm7P2uyr8Mzr8kWWDVlBmgfl6BCE7UoOLb1896D
         biUAhpRWUo7UjVhyGr6DCwQpy2UUSC3zc+iP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33hdVZdIvdo3r9ulzCeqVPA1lq6sxl5V/50+KNNX3vA=;
        b=pH6XI+/sNDy8CSXihPCJsBSUC8sytVPWOZktN6NE9rX/qFch4/hdbQiOdomFD56Lg4
         bQngbmH1pegs0Rr8384/9rj8P+xqQs7qr5HkbSI24ibDGzB9zjkOmLvbsILRuuLfjLkO
         GvGO222sAqEn3IvUXjoj6mWgrzj57RZ0yqtgs6Fv/nx8q1opvAjyHaKB1Kr3fEBYwOOx
         QqPxBLUrBRdOR+4fH30sOaS9ngduaX1WITo1rDyOnt+cXS9I3l5wkoB9TprbDy3Ni1nH
         NGUb6TN/PtGTZdbrcEgSZMNNdbvPsVyqMVxCAkYJHI8auaOmP6cNzzkdFpvc6p0Yo8+q
         nhFg==
X-Gm-Message-State: AGi0PubhWrysxthf3U9p8oQY6poMFL6J4sdSWn8J9myd28nH8G9p7q9R
        8WXLu9SE0lNM3KGZ2mqrZgA28nnnqWrCXA==
X-Google-Smtp-Source: APiQypLJyUYhCmBaJxgPQFab/PXXMhS2ejilK7aTPfMJlbmAfwvBlF1nccjDo6PyB52i/djxAENRDg==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr10219965plf.115.1587749747510;
        Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id t188sm5360641pgc.3.2020.04.24.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:35:46 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH 4/4] power_supply: Add power supply type property to uevent env
Date:   Fri, 24 Apr 2020 11:35:33 -0600
Message-Id: <20200424173533.48572-5-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200424173533.48572-1-mathewk@chromium.org>
References: <20200424173533.48572-1-mathewk@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add POWER_SUPPLY_TYPE to the uevent env for power supply. Type is a
property of all power supplies and there is a sysfs entry for it but it
is not included in the properties array of the power supply so
explicitly add it to the udev env.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/power/supply/power_supply_sysfs.c | 61 ++++++++++++++---------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index fbb05466b9a5..c7087cd7ffe3 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -448,6 +448,37 @@ void power_supply_destroy_attrs(void)
 	}
 }
 
+static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
+			   enum power_supply_property prop, char *prop_buf)
+{
+	int ret = 0;
+	struct power_supply_attr *pwr_attr;
+	struct device_attribute *dev_attr;
+	char *line;
+
+	pwr_attr = &power_supply_attrs[prop];
+	dev_attr = &pwr_attr->dev_attr;
+
+	ret = power_supply_show_property(dev, dev_attr, prop_buf);
+	if (ret == -ENODEV || ret == -ENODATA) {
+		/*
+		 * When a battery is absent, we expect -ENODEV. Don't abort;
+		 * send the uevent with at least the the PRESENT=0 property
+		 */
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	line = strchr(prop_buf, '\n');
+	if (line)
+		*line = 0;
+
+	return add_uevent_var(env, "POWER_SUPPLY_%s=%s",
+			      pwr_attr->upper_name, prop_buf);
+}
+
 int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct power_supply *psy = dev_get_drvdata(dev);
@@ -467,31 +498,13 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (!prop_buf)
 		return -ENOMEM;
 
-	for (j = 0; j < psy->desc->num_properties; j++) {
-		struct power_supply_attr *pwr_attr;
-		struct device_attribute *dev_attr;
-		char *line;
-
-		pwr_attr = &power_supply_attrs[psy->desc->properties[j]];
-		dev_attr = &pwr_attr->dev_attr;
-
-		ret = power_supply_show_property(dev, dev_attr, prop_buf);
-		if (ret == -ENODEV || ret == -ENODATA) {
-			/* When a battery is absent, we expect -ENODEV. Don't abort;
-			   send the uevent with at least the the PRESENT=0 property */
-			ret = 0;
-			continue;
-		}
-
-		if (ret < 0)
-			goto out;
-
-		line = strchr(prop_buf, '\n');
-		if (line)
-			*line = 0;
+	ret = add_prop_uevent(dev, env, POWER_SUPPLY_PROP_TYPE, prop_buf);
+	if (ret)
+		goto out;
 
-		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s",
-				     pwr_attr->upper_name, prop_buf);
+	for (j = 0; j < psy->desc->num_properties; j++) {
+		ret = add_prop_uevent(dev, env, psy->desc->properties[j],
+				      prop_buf);
 		if (ret)
 			goto out;
 	}
-- 
2.26.2.303.gf8c07b1a785-goog

