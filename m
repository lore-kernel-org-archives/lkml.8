Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3D6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D1C214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fNUWxPRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIJRLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgIJRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:09:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F82C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:09:16 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id bg5so1311413plb.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=BZ6YdwlTkATP6YcNm1nCerDB1v94oBKP5AayFPJUuNg=;
        b=fNUWxPRqJeQUZ6YDlSAgmDDsvwxVfzblFY2p1ci7EGZbYmnUUg/DsZmeO+lxF/TRii
         +Ni2x8RXrw8eiE97Q6bEG+RDk/9nQ+iTYTnYmgEYBI7Jfv3pwwE4+OtIcaqR5/g9g170
         VovVoljQhlNw9EYmYvZr7N5x8apNcubTckVzVxbtswDOXxkYJNa0E+Yy3uOthBhRfM2n
         xgOjbeMg21Cy0+KcNJ2TNQRO/FDzPTP8tkKYPeK/IcMjV62Ir1HdvXxRl26ATHtBO7Oi
         kKtoaCGjiTiDesqTcj7ToD3/MeBJRSjnSJPRWT+ZTbYmLBplDU49MXCGhq5zr/aqIxJS
         ZzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=BZ6YdwlTkATP6YcNm1nCerDB1v94oBKP5AayFPJUuNg=;
        b=GC64Lg5bu/GRKMus/gzh2Rpo4BsQHJwWCId7BiEpqz6Bs3qBj+Y6KDdPdki/gE+iMi
         gjCtqKN0khAW3/rU5QacPaKBbrLgT4Y9G8hGDEXHkHP6JNf/Eij4qHclDzFoTfyIsP8m
         AQty0XoLxQqxMOZgfuL8FkYh4krdJgNC/WeZAxm1q+RffNodMLjfV9LxZmJXS0ubKI3t
         NMFOEWqZRDToM+yKkhfJTHJLOcGZjOuR/UxsF3hIwlTat5rVzirf+kqs3TI99ecq2467
         krL9ZZouDbLWBPrner/9Szp7lkjSDLpjGkIvRHHPoqRqnvCPnoGkvtmsxLPhn5UsdSIj
         3S1Q==
X-Gm-Message-State: AOAM530V7Y8knph1YSP8upZ7K9J+3LH8Y/HXq3lpTIGsuhesXUsJ0yyN
        8FtaIOlfX8TUeaiCCeelI3PpqfM/sQclA/rU
X-Google-Smtp-Source: ABdhPJwZ01Mgx0DKAaM8vzoyP8ZZKsF7ddI+fm7+3NEsc2EjFne7JbOL+YmmPt0q+3OXeFXMg2vfeYJLO+WZTj3C
X-Received: from chu-dev.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3cfb])
 (user=linchuyuan job=sendgmr) by 2002:a17:902:6ac7:b029:d0:89f3:28d1 with
 SMTP id i7-20020a1709026ac7b02900d089f328d1mr6356139plt.13.1599757753178;
 Thu, 10 Sep 2020 10:09:13 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:09:10 +0000
Message-Id: <20200910170910.1990578-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH] hwmon: pmbus: max20730: adjust the vout reading given voltage divider
From:   Chu Lin <linchuyuan@google.com>
To:     linchuyuan@google.com, jdelvare@suse.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        qiongwang@google.com, zhongqil@google.com, jasonling@google.com,
        belgaied@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
We use voltage dividers so that the voltage presented at the voltage
sense pins is confusing. We might need to convert these readings to more
meaningful readings given the voltage divider.

Solution:
Read the voltage divider resistance from dts and convert the voltage
reading to a more meaningful reading.

Testing:
max20730 with voltage divider

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/pmbus/max20730.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index c0bb05487e0e..4b56810fa894 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -29,6 +29,7 @@ struct max20730_data {
 	struct pmbus_driver_info info;
 	struct mutex lock;	/* Used to protect against parallel writes */
 	u16 mfr_devset1;
+	u32 vout_voltage_divider[2];
 };
 
 #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
@@ -111,6 +112,12 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
 		max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
 		ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
 		break;
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (data->vout_voltage_divider[0] && data->vout_voltage_divider[1])
+			ret = DIV_ROUND_CLOSEST(ret * data->vout_voltage_divider[1],
+						data->vout_voltage_divider[0]);
+		break;
 	default:
 		ret = -ENODATA;
 		break;
@@ -329,6 +336,15 @@ static int max20730_probe(struct i2c_client *client,
 	data->id = chip_id;
 	mutex_init(&data->lock);
 	memcpy(&data->info, &max20730_info[chip_id], sizeof(data->info));
+	if (of_property_read_u32_array(client->dev.of_node, "vout-voltage-divider",
+				       data->vout_voltage_divider,
+				       ARRAY_SIZE(data->vout_voltage_divider)) != 0)
+		memset(data->vout_voltage_divider, 0, sizeof(data->vout_voltage_divider));
+	if (data->vout_voltage_divider[1] < data->vout_voltage_divider[0]) {
+		dev_err(dev,
+			"The total resistance of voltage divider is less than output resistance\n");
+		return -ENODEV;
+	}
 
 	ret = i2c_smbus_read_word_data(client, MAX20730_MFR_DEVSET1);
 	if (ret < 0)
-- 
2.28.0.526.ge36021eeef-goog

