Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F48AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299B020829
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 00:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="A2D/nyka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbgIKAA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgIKAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 20:00:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D43C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 17:00:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id l8so4750939pgt.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to;
        bh=ErReYkTQ4pcFb25crZHKkq2Xdo+6ljM0acA/Ojar1k4=;
        b=A2D/nykaKg4XsLf1LURwEgxi3gDQ4KCJEJX3M1yHzqUuccfFKjiOh2KfKRiY4Qty/1
         VuYTRbhuzjYSiPxW1oB1xTQfcMexhiLSQhFYj0kIHzsgz/Yqm/QmUq0oq+k56Bhh9N3E
         QiAbrUTiKMHZ2j+LJlqdJfxM+RkUFyN1CjBhMP9XPQaqJZ1Co2F0sk33xLqMAG9umJHc
         U2oawkLcYus6C7hjmT71xL7v2irMwIv2oxKWp7rV/NwoerGlVsGEoHFJcb6Fg8F4PUDZ
         uog77T4n24Viw5a1YaMIiSMXK86D5ekKkGlY+Iim9+3ITKabWk++WCkKv8Po8n1cO9Ok
         xl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to;
        bh=ErReYkTQ4pcFb25crZHKkq2Xdo+6ljM0acA/Ojar1k4=;
        b=maNswj4EEHDFemAJ6Q/hRGOIhLUy4yP4XSwqo8YUBwMKp7hFMiMA3PZ9shL6OZzCQQ
         kbmfRubLqb8r4GmtkJXFg4/ZZyhZDqCdcLiQpD5i+f2lDhUvY9ApGPc1VHHXxKEIaWod
         QIH0gIv80rTiNuiA4mrxyDZ3DJu+Q5ul/tjS9cx8DKSh8YPC/FPNc8I075IS6yniH80H
         0hYJCB/ff6drmhHxSddLkX4dqRitl/wcamUV3SKCGoINuBN2X6+a+rRbQSf4p6ubhwXl
         NJM9zZzwNTPaav7JwcYEmAmQBzlGSRVI2WXdub6aGXkI6SKNO4USfih6rnCS2o1+Jnk4
         VW2A==
X-Gm-Message-State: AOAM531E1B3nb/yaRFL7JX/ghyQ/H1PCrssRAqOPguh1XKFPkvqng8vy
        PMObSMpG49KD3oLbf5NDRX4xKL5vnSI20Tvg
X-Google-Smtp-Source: ABdhPJyialhXkZow5lAnkiKyOvJQ7BB1I3JPFOMajlHE+hhynbjGrm2YIufuIixxIXdd13FdlJbcYnJiCcJCK2lR
X-Received: from chu-dev.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3cfb])
 (user=linchuyuan job=sendgmr) by 2002:aa7:8aca:0:b029:13e:d13d:a07d with SMTP
 id b10-20020aa78aca0000b029013ed13da07dmr7800569pfd.20.1599782453027; Thu, 10
 Sep 2020 17:00:53 -0700 (PDT)
Date:   Fri, 11 Sep 2020 00:00:50 +0000
Message-Id: <20200911000050.2301678-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2] hwmon: pmbus: max20730: adjust the vout reading given
 voltage divider
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
ChangeLog v1 -> v2
  - Don't do anything to the ret if an error is returned from
    pmbus_read_word
  - avoid overflow when doing multiplication

 drivers/hwmon/pmbus/max20730.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hwmon/pmbus/max20730.c b/drivers/hwmon/pmbus/max20730.c
index c0bb05487e0e..83affdad4060 100644
--- a/drivers/hwmon/pmbus/max20730.c
+++ b/drivers/hwmon/pmbus/max20730.c
@@ -29,6 +29,7 @@ struct max20730_data {
 	struct pmbus_driver_info info;
 	struct mutex lock;	/* Used to protect against parallel writes */
 	u16 mfr_devset1;
+	u32 vout_voltage_divider[2];
 };
 
 #define to_max20730_data(x)  container_of(x, struct max20730_data, info)
@@ -111,6 +112,14 @@ static int max20730_read_word_data(struct i2c_client *client, int page,
 		max_c = max_current[data->id][(data->mfr_devset1 >> 5) & 0x3];
 		ret = val_to_direct(max_c, PSC_CURRENT_OUT, info);
 		break;
+	case PMBUS_READ_VOUT:
+		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret > 0 && data->vout_voltage_divider[0] && data->vout_voltage_divider[1]) {
+			u64 temp = DIV_ROUND_CLOSEST_ULL((u64)ret * data->vout_voltage_divider[1],
+							 data->vout_voltage_divider[0]);
+			ret = clamp_val(temp, 0, 0xffff);
+		}
+		break;
 	default:
 		ret = -ENODATA;
 		break;
@@ -329,6 +338,15 @@ static int max20730_probe(struct i2c_client *client,
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

