Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C809C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DA8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Ai2vmMkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIJRKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgIJRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:08:25 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC82C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:08:25 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o14so4657330qtq.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=BZ6YdwlTkATP6YcNm1nCerDB1v94oBKP5AayFPJUuNg=;
        b=Ai2vmMkDkdZ6vRWJ0lhs98xNTLunr8RFYDvleWom+E/NgDXjIOGxYdIbHucuJziRuD
         WQE5erR0AlX8OvVIaY9JSqtcY6ddr5jk/BG7S5PgV4hBp5yeKSIDKT0J9nPW3tQKDGdy
         H4/csGumgf+Ez3Ljm7rsmwPRlvpQP+wM/+INkoVJvNMiLF+z4Vhsnsm8hcGnNyHk6MUG
         vg9A0q0P9dbr46dkU0Iu3fPQoSosoDokIM+2SQL4D23DM7lv3uwivM34d7/vHubKGzGL
         vT39UfQbLX5diR645KJR/SDLnp+VLfpjLN9oXiHe1elMf6sSYIZGHHdy/C8ESoljftjJ
         QhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=BZ6YdwlTkATP6YcNm1nCerDB1v94oBKP5AayFPJUuNg=;
        b=DSN1PMzvQw/LfDSSIDFrQV5ORjsuQZBCD20DvDoarUyJc6b/c1DN45GIU19vF7Fsw1
         bTHWK3Md5XeKMtTbjFKSVoyG8VU1NWsmX2sJPhJgbahLbEN4P+uInJuB+UXJnYmqXW6C
         rqNkDPurx8KiTvq3PI1DJZSGvuGmngjk8GcEqsF3R/R7/0N+NYP98mJm2nl6fg7a2A4C
         E/M/+OXB1K2Czh86j2gNKOsrnDeOa57Cl4js2Di7bBHBRegvYnnuBWA8OdffqDgRKuiZ
         2ahsXJsRSaJq//P1Wyqe/pb0HKZGsHmJL7BOS0Y9qILzdmrHQBLQz5jn4hWUpqd7Kqrb
         b+Aw==
X-Gm-Message-State: AOAM531CjUuWdJ1okNIG7mu6W5wJxqvFUYK+4fJosTq8xgXJpmYZKaAT
        GLX12pvW0pgMxiIeoqduHqx9iyh88O4RFAKT
X-Google-Smtp-Source: ABdhPJx+7OOyKHKXz87Yhbi4VvnetfXmdc6s4b1LWLln9dKwcSBoRl9SCrIo0G9osX3kRPdS3m47zSNu3rjcRW/b
X-Received: from chu-dev.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3cfb])
 (user=linchuyuan job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr9086510qvu.12.1599757704282; Thu, 10 Sep 2020 10:08:24 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:08:21 +0000
Message-Id: <20200910170821.1988467-1-linchuyuan@google.com>
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

