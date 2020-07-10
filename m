Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0022C2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MYNbUmQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGJAo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgGJAo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:44:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBDC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 17:44:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i203so5036573yba.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=t9i52B1pRW7NNwQem2xtfhHz6MEicsdkhoSgH5EUEqk=;
        b=MYNbUmQAXNqG4ukLS28pTAIVaO2vxHhB9bnpmh9rZrc1N5YX4Lq8dRgGFCrN0ufd09
         piKx95RRMn2xddJjPUsGj/I0esIuVF3VWtnunx3aA5YXBqnS+Ej33vL4rHnkGvk0sAfD
         eaxSIw341JGOx/0diPeyckGAJx2E8P7oqQN58n0pDeuTml8MspBhdSwJQBmh37Dx1sG0
         5UZqPA0csot1jpFpBFolSNsocwlfqHi3aSEppDR6iTFctqW3Nb/BwqlUqVpq1BeSugtI
         bgihtvM852llZCE4toFDe5mFwXN6IGJVtVhlvoazPMtXQrgQwdSrbAz3GFVLrnPPlXV/
         J1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=t9i52B1pRW7NNwQem2xtfhHz6MEicsdkhoSgH5EUEqk=;
        b=Rz2hycl0rvuxZnBY+EbNb6wJDX66XZQRcv+qcYPIiR6+baItblhkpg2lEMWL0myj/B
         +G1X3X/lOEIiyWnL6hI3mZnHgUA3Qs7DhJK0zB99FGYa8dUlJuzg6y7t9PA1wUz4PPWM
         dHSYJ3y6HxPoI7yBMBbC6TbUuxgFOwm+1iv/Fse20ugk0bOet0qER03ucy5e/0FUiO4l
         O7+QSXa8EjmSoLwzeQ3qtli13wU/FSUVkK3gVpK01RG1kdWf57XKcVm8URkQ2es+rYad
         CbARbp3hUT2Y0P0pOUUHrjHfZfLZLoi46OqizTBQdUUH6oDHfToURS4bVquUum/KStMQ
         bQPw==
X-Gm-Message-State: AOAM531tSJ1dlGpb0K8LAIXP9axBJPQd65cezuPpj8EGl9+nkZvn3xiy
        Z+4jVMB6ttIv+md1HtLrCOf8qzR9Q5f+59OB
X-Google-Smtp-Source: ABdhPJx3cXh4hzy135F82CgEDevTpjt3qDsmiQcYtuxGbFeAaepZZSPY/LdQE0FqgKXxYz3NZikYmocTfGCRD8Lh
X-Received: by 2002:a25:b28d:: with SMTP id k13mr18719127ybj.162.1594341865353;
 Thu, 09 Jul 2020 17:44:25 -0700 (PDT)
Date:   Fri, 10 Jul 2020 00:44:22 +0000
Message-Id: <20200710004422.298090-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] hwmon: adm1272: Enable temperature sampling for adm1272 adm1278
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

Problem:
	adm1272 and adm1278 supports temperature sampling. The
current way of enabling it requires the user manually unbind the device
from the driver, flip the temperature sampling control bit and then bind
the device back to the driver. It would be nice if we can control this in a
better way by reading the dt.

Solution:
	Introducing device tree binding adm1272-adm1278-temp1-en. If the
flag is set, flip the temp1_en control bit on probing.

Testing:
1). iotools smbus_write16 35 0x10 0xd4 0x0037 // disable the temp1_en
2). recompile the dt to have  adm1272-adm1278-temp1-en set
3). Probe the driver and make sure tempX shows up in hwmon

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/adm1275.c | 36 +++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 19317575d1c6..293308875162 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -475,6 +475,7 @@ static int adm1275_probe(struct i2c_client *client,
 	const struct coefficients *coefficients;
 	int vindex = -1, voindex = -1, cindex = -1, pindex = -1;
 	int tindex = -1;
+	bool temp1_en;
 	u32 shunt;
 
 	if (!i2c_check_functionality(client->adapter,
@@ -536,6 +537,9 @@ static int adm1275_probe(struct i2c_client *client,
 	if (shunt == 0)
 		return -EINVAL;
 
+	temp1_en = of_property_read_bool(client->dev.of_node, "adm1272-adm1278-temp1-en") &&
+		(mid->driver_data == adm1272 || mid->driver_data == adm1278);
+
 	data->id = mid->driver_data;
 
 	info = &data->info;
@@ -614,16 +618,18 @@ static int adm1275_probe(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+		ret = config;
+		/* Enable temp if it is instructed by dt (it is disabled by default) */
+		if (temp1_en && !(config & ADM1278_TEMP1_EN))
+			config |= ADM1278_TEMP1_EN;
 		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
+		if (!(config & ADM1278_VOUT_EN))
 			config |= ADM1278_VOUT_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
+		if (ret != config) {
+			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
 			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
+				dev_err(&client->dev, "Failed to enable config control bits");
+				return ret;
 			}
 		}
 
@@ -685,16 +691,18 @@ static int adm1275_probe(struct i2c_client *client,
 		info->func[0] |= PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT |
 			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
 
+		ret = config;
+		/* Enable temp if it is instructed by dt (it is disabled by default) */
+		if (temp1_en && !(config & ADM1278_TEMP1_EN))
+			config |= ADM1278_TEMP1_EN;
 		/* Enable VOUT if not enabled (it is disabled by default) */
-		if (!(config & ADM1278_VOUT_EN)) {
+		if (!(config & ADM1278_VOUT_EN))
 			config |= ADM1278_VOUT_EN;
-			ret = i2c_smbus_write_byte_data(client,
-							ADM1275_PMON_CONFIG,
-							config);
+		if (ret != config) {
+			ret = i2c_smbus_write_word_data(client, ADM1275_PMON_CONFIG, config);
 			if (ret < 0) {
-				dev_err(&client->dev,
-					"Failed to enable VOUT monitoring\n");
-				return -ENODEV;
+				dev_err(&client->dev, "Failed to enable config control bits");
+				return ret;
 			}
 		}
 
-- 
2.27.0.383.g050319c2ae-goog

