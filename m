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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35799C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D5F206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oT6WB9VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHJHBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgHJHAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:00:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6B6C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:00:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so4248385pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PaYSbxUwv9yN57+SOQkKrctAUvcnjUP0cxb1/WJhE0=;
        b=oT6WB9VWiwEyyuNd06z7NUUBS1FehmJmCyYO6su2+wkEdieupjHKgU/x0T4jnTzHSk
         QrT/DA1OJP6fFWMeYzICxc9egTpI5W0eTeu7CMxWWsw/F1fdbZ9IsNdz7/W6X7HL6q24
         4NafSgsLi17yCPldtgV55deAYbSuFj6Fbasok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PaYSbxUwv9yN57+SOQkKrctAUvcnjUP0cxb1/WJhE0=;
        b=W5ILai5tAito9okKSvPLHHevnJJi9Iwrs9ZXGlDJMGrCaIADDR5HbMIcyebpNpL4Zu
         rvmCXy+fT1TZd6iyQOMYw7i4gUN5pyEm0An8KN2DNFqwTbHz9fyfEARLX+s+9Nw4y+2T
         JQDZNldbx6GhguzAzH6owYVf91wDpxpVKM0Nvh0rbfCFVdNgJDvToiUEzDkdmbObDWei
         qJbpNPrwStxFL3b2zUuTlCHR50rrQcqL1WtpaW9+psuKAwxVVisMrmHLK324nhiagito
         5AznLUurDUwK+2WSY8lgvndPbLJV0yX4K27Tj+SCqCvLbBCHRIyHGQ5srdsP1j9zeciT
         IdIA==
X-Gm-Message-State: AOAM532DgyCKHOcGdrBLcmmfB60Xtidyhc5NsV1OJLoEuD04E1ZY3FiH
        UlbowAClP2RPgRLwRoujp778hw==
X-Google-Smtp-Source: ABdhPJw2i0Dvol67N+GLngD1ZyDfX7mf1ptT6RoKds5hIA498mdGWWDrDneWFcir1lcJl0+uWGyXvg==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr20608578pgu.367.1597042845922;
        Mon, 10 Aug 2020 00:00:45 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id h1sm21938651pfr.39.2020.08.10.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:00:45 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] power: supply: sbs-battery: remove unused enable_detection flags
Date:   Mon, 10 Aug 2020 15:00:41 +0800
Message-Id: <20200810070041.662662-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enable_detection flag which is always true after
the device is proved.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/power/supply/sbs-battery.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 83b9924033bd..73461321eb05 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -185,7 +185,6 @@ struct sbs_info {
 	struct power_supply		*power_supply;
 	bool				is_present;
 	struct gpio_desc		*gpio_detect;
-	bool				enable_detection;
 	bool				charger_broadcasts;
 	int				last_state;
 	int				poll_time;
@@ -876,9 +875,6 @@ static int sbs_get_property(struct power_supply *psy,
 		return -EINVAL;
 	}
 
-	if (!chip->enable_detection)
-		goto done;
-
 	if (!chip->gpio_detect &&
 		chip->is_present != (ret >= 0)) {
 		sbs_update_presence(chip, (ret >= 0));
@@ -1007,7 +1003,6 @@ static int sbs_probe(struct i2c_client *client)
 
 	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
 	chip->client = client;
-	chip->enable_detection = false;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
 	chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
@@ -1091,8 +1086,6 @@ static int sbs_probe(struct i2c_client *client)
 
 	INIT_DELAYED_WORK(&chip->work, sbs_delayed_work);
 
-	chip->enable_detection = true;
-
 	return 0;
 
 exit_psupply:
-- 
2.28.0.236.gb10cc79966-goog

