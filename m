Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99034C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666FA207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzP/52G8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGBBnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgGBBn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:43:29 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85D8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 18:43:29 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a25so7658749pfl.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 18:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SCqQGailrCYA7+IFNQkGdPcyTCT2gfWNKAHkDA9B1GY=;
        b=hzP/52G8y/U5SEdRnajEwhCVo+IzJNdL7M7B8RPX28Uyin02LnNTbtuD+Aw5XtyzWK
         5nEIfIhJg6HNRCXZ/FADkRrgwvLGm2lOt1R3L0K9zcedZbffA2Bysl88uHclF3WX3OeG
         4pNIg5xNSkEuX9ro8KTQxHgkqxheICXdsu32ePHrOIrg+Yfec7Phjqx+AvQBd/vng6Vf
         JZGtPihMHYfu4tGn3wXHzCElVxB8w0lJ7R1j75uAQJ/Yp5GrYWipGVxLiixYBhxoS31O
         nAS75psD+5EvYbsVZ8m3ewcerRGRv0dVMPe7oYalc85C85uPPJOHFsCo5/39toqXFhtX
         d9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SCqQGailrCYA7+IFNQkGdPcyTCT2gfWNKAHkDA9B1GY=;
        b=nx+XKUKBXvxIoEVJoFdTgltGko1aTAdZVIq0Qp7finPgNI4w3nyQAsuZDARS6BhKku
         kU27uVHckZVOFx3LB+RH4vXnldXek63AtIopS8jcw2umreeRixW2Z7Z29r/4/PqV6dbk
         IBeGMdg5mGr0Mvy10e4jrfVH3k/dZ1Bn6cL59JUxSwMsvztMmtg1Bf6KLPOZ64EiYqmq
         tygfwN3eiUFn5XzbBAUuC7kXPBjNwTmTFyVtsdbX4efgmVUUWG7xXPSpGFUhnRvXC9mS
         A4h1AEHWNUq9zUkyWE9MFRGYQ+Rzhdm02Xdd2VNL7mLQUlXWCnp1TC257SzhJjlYmNQg
         LfZA==
X-Gm-Message-State: AOAM530XiXjfdoqX+d9+74c1sFrnLXgTSY0YaV0T9j6MQYlZ0I479DCm
        pveNMPI7kZxehXYaywbC7ZlXqyh6B32ZwYl2
X-Google-Smtp-Source: ABdhPJzhZwG94LQ7S2+ClOsEqlp0XJknP6+1ih2Pa0MuDmV7aHu0txehv0/LSu/sHmSlQJDwz/N8dgohlStubMLF
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr24117264plo.161.1593654209035;
 Wed, 01 Jul 2020 18:43:29 -0700 (PDT)
Date:   Thu,  2 Jul 2020 01:42:23 +0000
In-Reply-To: <20200630174350.2842555-1-linchuyuan@google.com>
Message-Id: <20200702014223.4096977-1-linchuyuan@google.com>
Mime-Version: 1.0
References: <20200630174350.2842555-1-linchuyuan@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] hwmon:max6697: Allow max6581 to create tempX_offset attributes
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net, jdelvare@suse.com, linchuyuan@google.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jasonling@google.com, belgaied@google.com, zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per max6581, reg 4d and reg 4e is used for temperature read offset.
This patch will let the user specify the temperature read offset for
max6581. This patch is tested on max6581 and only applies to max6581.

Testing:
echo 16250 > temp2_offset
cat temp2_offset
16250

echo 17500 > temp3_offset
cat temp3_offset
17500
cat temp4_offset
0
cat temp2_offset
17500

echo 0 > temp2_offset
cat temp2_offset
0
cat temp3_offset
17500

echo -0 > temp2_offset
cat temp2_offset
0

echo -100000 > temp2_offset
-sh: echo: write error: Invalid argument

cat temp2_input
37000

echo 10000 > temp2_offset
cat temp2_input
47125

echo -2000 > temp2_offset
cat temp2_input
34875

echo -0 > temp2_offset
cat temp2_input
37000

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 drivers/hwmon/max6697.c | 129 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 743752a2467a..b11fcb594807 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -41,6 +41,14 @@ static const u8 MAX6697_REG_CRIT[] = {
 #define MAX6697_MAP_BITS(reg)	((((reg) & 0x7e) >> 1) | \
 				 (((reg) & 0x01) << 6) | ((reg) & 0x80))
 
+#define MAX6581_OFFSET_TO_MILLIC(reg)	(16000 * (((reg) & (1<<6)) >> 6) + \
+					 8000 * (((reg) & (1<<5)) >> 5) + \
+					 4000 * (((reg) & (1<<4)) >> 4) + \
+					 2000 * (((reg) & (1<<3)) >> 3) + \
+					 1000 * (((reg) & (1<<2)) >> 2) + \
+					 500 * (((reg) & (1<<1)) >> 1) + \
+					 250 * ((reg) & 1))
+
 #define MAX6697_REG_STAT(n)		(0x44 + (n))
 
 #define MAX6697_REG_CONFIG		0x41
@@ -56,6 +64,9 @@ static const u8 MAX6697_REG_CRIT[] = {
 #define MAX6581_REG_IDEALITY_SELECT	0x4c
 #define MAX6581_REG_OFFSET		0x4d
 #define MAX6581_REG_OFFSET_SELECT	0x4e
+#define MAX6581_OFFSET_MIN		-31750
+#define MAX6581_OFFSET_MAX		-MAX6581_OFFSET_MIN
+
 
 #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
 
@@ -316,6 +327,94 @@ static ssize_t temp_store(struct device *dev,
 	return ret < 0 ? ret : count;
 }
 
+static ssize_t offset_store(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count)
+{
+	long temp;
+	u8 val, select;
+	int i, temp_frac, temp_int, ret, index;
+	bool sign;
+	struct max6697_data *data;
+
+	index = to_sensor_dev_attr(devattr)->index;
+	data = dev_get_drvdata(dev);
+	select = i2c_smbus_read_byte_data(data->client,
+					  MAX6581_REG_OFFSET_SELECT);
+	if (select < 0)
+		return -ENODATA;
+	ret = kstrtol(buf, 10, &temp);
+	if (ret < 0)
+		return ret;
+	if (temp > MAX6581_OFFSET_MAX || temp < MAX6581_OFFSET_MIN)
+		return -EINVAL;
+
+	/* disable the offset for channel */
+	if (temp == 0) {
+		ret = i2c_smbus_write_byte_data(data->client,
+						MAX6581_REG_OFFSET_SELECT,
+						select & ~(1<<(index-1)));
+		return ret < 0 ? ret : count;
+	}
+	sign = temp < 0 ? false : true;
+	temp = abs(temp);
+	temp_int = temp / 1000;
+	temp_frac = temp % 1000;
+	for (i = 4; i >= 0 && temp_int > 0; --i) {
+		if (temp_int >= 1<<i) {
+			temp_int -= 1<<i;
+			val |= 1 << (i+2);
+		}
+	}
+	/* special handle the fraction */
+	if (temp_frac % 250 != 0)
+		return -EINVAL;
+	if (temp_frac == 750)
+		val |= 0x3;
+	else if (temp_frac == 500)
+		val |= 0x2;
+	else if (temp_frac)
+		val |= 0x1;
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX6581_REG_OFFSET_SELECT,
+					select | 1<<(index-1));
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(data->client,
+					MAX6581_REG_OFFSET,
+					sign?val:(~val + 1));
+	return ret < 0 ? ret : count;
+}
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *devattr,
+			   char *buf)
+{
+	int select, ret, index, temp;
+	struct max6697_data *data;
+
+	index = to_sensor_dev_attr(devattr)->index;
+	data = dev_get_drvdata(dev);
+	select = i2c_smbus_read_byte_data(data->client,
+				       MAX6581_REG_OFFSET_SELECT);
+	if (select < 0)
+		return -ENODATA;
+	if (select & (1<<(index-1))) {
+		ret = i2c_smbus_read_byte_data(data->client,
+					       MAX6581_REG_OFFSET);
+		if (ret < 0)
+			return -ENODATA;
+	} else {
+		return sprintf(buf, "%d\n", 0);
+	}
+	if (1<<7 & ret) {
+		ret = ~ret + 1;
+		temp = -MAX6581_OFFSET_TO_MILLIC(ret);
+	} else {
+		temp = MAX6581_OFFSET_TO_MILLIC(ret);
+	}
+	return sprintf(buf, "%d\n", temp);
+}
+
 static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_max, temp, 0, MAX6697_TEMP_MAX);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_crit, temp, 0, MAX6697_TEMP_CRIT);
@@ -374,6 +473,16 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
 static SENSOR_DEVICE_ATTR_RO(temp7_fault, alarm, 6);
 static SENSOR_DEVICE_ATTR_RO(temp8_fault, alarm, 7);
 
+/* There is no offset for local temperature so starting from temp2 */
+static SENSOR_DEVICE_ATTR_RW(temp1_offset, offset, 0);
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
@@ -382,8 +491,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct max6697_data *data = dev_get_drvdata(dev);
 	const struct max6697_chip_data *chip = data->chip;
-	int channel = index / 6;	/* channel number */
-	int nr = index % 6;		/* attribute index within channel */
+	int channel = index / 8;	/* channel number */
+	int nr = index % 7;		/* attribute index within channel */
 
 	if (channel >= chip->channels)
 		return 0;
@@ -392,6 +501,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 		return 0;
 	if (nr == 5 && !(chip->have_fault & (1 << channel)))
 		return 0;
+	/* offset reg is only supported on max6581 remote channels */
+	if (nr == 6)
+		if (data->type != max6581 || channel == 0)
+			return 0;
 
 	return attr->mode;
 }
@@ -408,6 +521,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&dev_attr_dummy.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
@@ -415,6 +529,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
@@ -422,6 +537,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp4_input.dev_attr.attr,
 	&sensor_dev_attr_temp4_max.dev_attr.attr,
@@ -429,6 +545,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp4_crit.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp5_input.dev_attr.attr,
 	&sensor_dev_attr_temp5_max.dev_attr.attr,
@@ -436,6 +553,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp5_crit.dev_attr.attr,
 	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp6_input.dev_attr.attr,
 	&sensor_dev_attr_temp6_max.dev_attr.attr,
@@ -443,6 +561,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp6_crit.dev_attr.attr,
 	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp6_fault.dev_attr.attr,
+	&sensor_dev_attr_temp6_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp7_input.dev_attr.attr,
 	&sensor_dev_attr_temp7_max.dev_attr.attr,
@@ -450,6 +569,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp7_crit.dev_attr.attr,
 	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp7_fault.dev_attr.attr,
+	&sensor_dev_attr_temp7_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp8_input.dev_attr.attr,
 	&sensor_dev_attr_temp8_max.dev_attr.attr,
@@ -457,6 +577,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp8_crit.dev_attr.attr,
 	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp8_fault.dev_attr.attr,
+	&sensor_dev_attr_temp8_offset.dev_attr.attr,
 	NULL
 };
 
@@ -493,8 +614,8 @@ static void max6697_get_config_of(struct device_node *node,
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
2.27.0.212.ge8ba1cc988-goog

