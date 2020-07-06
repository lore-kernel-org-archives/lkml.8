Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59336C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D4820775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 22:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="neD5wSD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGFWKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 18:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgGFWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 18:10:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AFAC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 15:10:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t7so29805102ybk.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lw9OXIX2m5ZzcZqLuR/UlqrrMt9wZGKpViJE1Hwnf5Y=;
        b=neD5wSD1rz/TzNLhAamPuDWt75kNdmkHCsDg7LTLbS2xy8QR2AI4SwGmIoCa/ahd7y
         Wt05UvLiRajfPRwsZWh8ZIy0qbn08HH2b68qYb5ZZW3UaJ9lCAuItUxOIYm2+q9laR1Z
         9WwF0uwqDY/RofwVFXXDcytTp+UgyBQMdJyc0WXn0ifAmynSVBHi89o50ZUuqcsiSYJ1
         AxO9Jb9XaCKJUXPJ12j5OANMTx7UxRDWhZRFSj2Vfio494RNwqJTxRaOyVKwXOf1b6o/
         KLaGs29cgfBXFteXQjdRphKLrff9/wfKPNCUkbJYveRh959uXArcfxEOvQq1YUvagvfF
         yvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lw9OXIX2m5ZzcZqLuR/UlqrrMt9wZGKpViJE1Hwnf5Y=;
        b=Y3Vhkhe+09IZxPrGbqmUhtdrcOK+I+SHwO2JP+kS6+jNZ9AgdOW2SFXq2vVCIx5c+G
         JBi3aTBiKsKMfcMU4/URUIjijWJELpid+OLdOuaNVxHjqPxnOyV+CX+Ji3rhB6tUeaBR
         VNBv5B7ND9iy5MzqwkCPuSZbDGy+1J35k5VJhd2PnB+KsyFzkYJ8cxEqoezrKcZt/LxI
         dn4tDhFVoWZ/FX/6gbslkCNOBBM09rusqLQ7QRJhUvEwEeEWYTV+tShKw5LB14BrU3PN
         HtmHLbzEZNn9cDjwLmIS0aMcCbyX9L2sjBEszl8WzSXWWKStgTf4ciFt57iOyVH4ycXG
         nuZA==
X-Gm-Message-State: AOAM532GyVZerPLDAp5zclreGz6QbcqNHKpD6KxrGVBNqDn6efRIu5jv
        nlQGqfGyOYUjmN5NdfCWjkMgf6TxQv8VCyu3
X-Google-Smtp-Source: ABdhPJwv7RPB45eRS069omSDbH3F/Qjjx6dRMiMGKRYmwYhIagapBQsUvXGW5OGA9MT6I2lKlYJVTcAwa1M8dLbY
X-Received: by 2002:a25:5806:: with SMTP id m6mr54598822ybb.152.1594073419122;
 Mon, 06 Jul 2020 15:10:19 -0700 (PDT)
Date:   Mon,  6 Jul 2020 22:10:01 +0000
In-Reply-To: <20200706221001.1996816-1-linchuyuan@google.com>
Message-Id: <20200706221001.1996816-2-linchuyuan@google.com>
Mime-Version: 1.0
References: <20200706221001.1996816-1-linchuyuan@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v2 1/1] hwmon:max6697: Allow max6581 to create tempX_offset
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

---
 drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 64122eb38060..8c814c544116 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -57,6 +57,9 @@ static const u8 MAX6697_REG_CRIT[] = {
 #define MAX6581_REG_IDEALITY_SELECT	0x4c
 #define MAX6581_REG_OFFSET		0x4d
 #define MAX6581_REG_OFFSET_SELECT	0x4e
+#define MAX6581_OFFSET_MIN		-31750
+#define MAX6581_OFFSET_MAX		31750
+
 
 #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
 
@@ -172,6 +175,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
 	},
 };
 
+static inline int max6581_offset_to_millic(int val)
+{
+	return val & (1 << 7) ? (val | 0xffffff00) * 250 : val * 250;
+}
+
 static struct max6697_data *max6697_update_device(struct device *dev)
 {
 	struct max6697_data *data = dev_get_drvdata(dev);
@@ -317,6 +325,69 @@ static ssize_t temp_store(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t offset_store(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count)
+{
+	long temp;
+	u8 val, select;
+	int ret, index;
+	struct max6697_data *data;
+
+	index = to_sensor_dev_attr(devattr)->index;
+	data = dev_get_drvdata(dev);
+	select = i2c_smbus_read_byte_data(data->client,
+					  MAX6581_REG_OFFSET_SELECT);
+	if (select < 0)
+		return select;
+	ret = kstrtol(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+	/* disable the offset for channel */
+	if (temp == 0) {
+		ret = i2c_smbus_write_byte_data(data->client,
+						MAX6581_REG_OFFSET_SELECT,
+						select & ~(1 << (index - 1)));
+		return ret < 0 ? ret : count;
+	}
+	temp = clamp_val(temp, MAX6581_OFFSET_MIN, MAX6581_OFFSET_MAX);
+	val = DIV_ROUND_CLOSEST(temp, 250);
+	mutex_lock(&data->update_lock);
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX6581_REG_OFFSET_SELECT,
+					select | (1 << (index - 1)));
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX6581_REG_OFFSET,
+					val);
+	mutex_unlock(&data->update_lock);
+	return ret < 0 ? ret : count;
+}
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	int select, ret, index;
+	struct max6697_data *data;
+
+	index = to_sensor_dev_attr(devattr)->index;
+	data = dev_get_drvdata(dev);
+	select = i2c_smbus_read_byte_data(data->client,
+					  MAX6581_REG_OFFSET_SELECT);
+	if (select < 0)
+		return select;
+	if (select & (1 << (index - 1))) {
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MAX6581_REG_OFFSET);
+		if (ret < 0)
+			return ret;
+	} else {
+		return sprintf(buf, "%d\n", 0);
+	}
+	return sprintf(buf, "%d\n", max6581_offset_to_millic(ret));
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
@@ -375,6 +446,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
 static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
 static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
 
+/* There is no offset for local temperature so starting from temp2 */
+static SENSOR_DEVICE_ATTR_RW(temp2_offset, offset, 1);
+static SENSOR_DEVICE_ATTR_RW(temp3_offset, offset, 2);
+static SENSOR_DEVICE_ATTR_RW(temp4_offset, offset, 3);
+static SENSOR_DEVICE_ATTR_RW(temp5_offset, offset, 4);
+static SENSOR_DEVICE_ATTR_RW(temp6_offset, offset, 5);
+static SENSOR_DEVICE_ATTR_RW(temp7_offset, offset, 6);
+static SENSOR_DEVICE_ATTR_RW(temp8_offset, offset, 7);
+
 static DEVICE_ATTR(dummy, 0, NULL, NULL);
 
 static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
@@ -383,8 +463,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct max6697_data *data = dev_get_drvdata(dev);
 	const struct max6697_chip_data *chip = data->chip;
-	int channel = index / 6;	/* channel number */
-	int nr = index % 6;		/* attribute index within channel */
+	int channel = index / 8;	/* channel number */
+	int nr = index % 7;		/* attribute index within channel */
 
 	if (channel >= chip->channels)
 		return 0;
@@ -393,6 +473,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 		return 0;
 	if (nr == 5 && !(chip->have_fault & (1 << channel)))
 		return 0;
+	/* offset reg is only supported on max6581 remote channels */
+	if (nr == 6)
+		if (data->type != max6581 || channel == 0)
+			return 0;
 
 	return attr->mode;
 }
@@ -409,6 +493,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&dev_attr_dummy.attr,
+	&dev_attr_dummy.attr,
 
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
@@ -416,6 +501,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
@@ -423,6 +509,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp4_input.dev_attr.attr,
 	&sensor_dev_attr_temp4_max.dev_attr.attr,
@@ -430,6 +517,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp4_crit.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp5_input.dev_attr.attr,
 	&sensor_dev_attr_temp5_max.dev_attr.attr,
@@ -437,6 +525,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp5_crit.dev_attr.attr,
 	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp6_input.dev_attr.attr,
 	&sensor_dev_attr_temp6_max.dev_attr.attr,
@@ -444,6 +533,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp6_crit.dev_attr.attr,
 	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp6_fault.dev_attr.attr,
+	&sensor_dev_attr_temp6_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp7_input.dev_attr.attr,
 	&sensor_dev_attr_temp7_max.dev_attr.attr,
@@ -451,6 +541,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp7_crit.dev_attr.attr,
 	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp7_fault.dev_attr.attr,
+	&sensor_dev_attr_temp7_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp8_input.dev_attr.attr,
 	&sensor_dev_attr_temp8_max.dev_attr.attr,
@@ -458,6 +549,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp8_crit.dev_attr.attr,
 	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp8_fault.dev_attr.attr,
+	&sensor_dev_attr_temp8_offset.dev_attr.attr,
 	NULL
 };
 
@@ -494,8 +586,8 @@ static void max6697_get_config_of(struct device_node *node,
 	}
 	prop = of_get_property(node, "transistor-ideality", &len);
 	if (prop && len == 2 * sizeof(u32)) {
-			pdata->ideality_mask = be32_to_cpu(prop[0]);
-			pdata->ideality_value = be32_to_cpu(prop[1]);
+		pdata->ideality_mask = be32_to_cpu(prop[0]);
+		pdata->ideality_value = be32_to_cpu(prop[1]);
 	}
 }
 
-- 
2.27.0.383.g050319c2ae-goog

