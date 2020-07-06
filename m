Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32953C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E48820702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LN9P2bMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgGFRyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:54:37 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C25CC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 10:54:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j9so26827698pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W0KT7MUBp4ULzA/lrz9MNjkq65gb+iqSXVPHPYHRdns=;
        b=LN9P2bMipuAjtve6DM+6REHBKjQce98SrGd/0YHWKaOWQfnz8cdLEKTSIyJuG6nrKh
         Kaq3M6nxCOAoAWbR2uJG+bgFctKsIwe+p/b0Eu/H3mjcg+6nemWh4CR2BHA+cIQqHvRV
         4DA4rUU5s+s1lAGsCVVpi5FYh1kMJgKR1rBAX2y/zLJfhUjQQPXar2FZBK0hdjKghxac
         wGugPVv72bFzlzVvRagYTA/xeKqna1XP3jTKJaxuhBI/P6aBb6SQwAeeSihvoanXRmKE
         jFruNJFa0ebEimxHqgLfHPhP/Dhdg0LUvT5dMkO+/juPFN/3uRn/EYGOjkvNqPLkW7kp
         39ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W0KT7MUBp4ULzA/lrz9MNjkq65gb+iqSXVPHPYHRdns=;
        b=n0+xuHFsR7Rzadld6/w7BVfBcHLB27lLkA85Wt/6x0Slf5YAluZ6e65W9vKsY3d4ce
         jbZz3k6sVMtl+RrUv9ruIgydQkM+jgpH8yfI6RlT1JLH9XxcleGx4ul15OIMWb5SA5mS
         lKLFBVHSyF/RZkVwG/aBpC2BXtL3XlDd1FLh/Vi6RyjNCakLJF4LndS9b9mGPtLbJ53u
         FKS+GsHO0ZmM/3XdNCn9JOrnWiUlqPXGIW1UHjzuvWVpqFF7EUnD7rDxDGfdS3Smqliu
         4OKxwkbO8GxCeUj3tI650QqrViVGMAJL07T7zu1ymcxbfhL037EGG5+JJwYmiFgofPLz
         Ao5Q==
X-Gm-Message-State: AOAM532slsWqZ0Xj1NhC4D2ENZOcKNLJOihbR7bpuAO4E/etctWeaP43
        h/yBFUnazmEWXjKLFZLvKfKS4X/H6vFO3uKG
X-Google-Smtp-Source: ABdhPJx5xIqXhKVVf4e6pEmntrife0SA3xqyLciFIZhRHxFkyT2tuYJjgnqRhIDVTpQc0tMvrOwXRxqs95QEUj92
X-Received: by 2002:aa7:8298:: with SMTP id s24mr47519552pfm.21.1594058076399;
 Mon, 06 Jul 2020 10:54:36 -0700 (PDT)
Date:   Mon,  6 Jul 2020 17:54:33 +0000
In-Reply-To: <20200703010611.GA100794@roeck-us.net>
Message-Id: <20200706175433.1948648-1-linchuyuan@google.com>
Mime-Version: 1.0
References: <20200703010611.GA100794@roeck-us.net>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] hwmon:max6697: Allow max6581 to create tempX_offset
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
cat temp2_input
4875

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
 drivers/hwmon/max6697.c | 100 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index da43f7ae3de1..4b71b3716f22 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -65,6 +65,9 @@ static const u8 MAX6697_REG_CRIT[] = {
 #define MAX6581_REG_IDEALITY_SELECT	0x4c
 #define MAX6581_REG_OFFSET		0x4d
 #define MAX6581_REG_OFFSET_SELECT	0x4e
+#define MAX6581_OFFSET_MIN		-31750
+#define MAX6581_OFFSET_MAX		31750
+
 
 #define MAX6697_CONV_TIME		156	/* ms per channel, worst case */
 
@@ -180,6 +183,11 @@ static const struct max6697_chip_data max6697_chip_data[] = {
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
@@ -325,6 +333,69 @@ static ssize_t temp_store(struct device *dev,
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
@@ -383,6 +454,15 @@ static SENSOR_DEVICE_ATTR_RO(temp6_fault, alarm, 5);
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
@@ -391,8 +471,8 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct max6697_data *data = dev_get_drvdata(dev);
 	const struct max6697_chip_data *chip = data->chip;
-	int channel = index / 6;	/* channel number */
-	int nr = index % 6;		/* attribute index within channel */
+	int channel = index / 8;	/* channel number */
+	int nr = index % 7;		/* attribute index within channel */
 
 	if (channel >= chip->channels)
 		return 0;
@@ -401,6 +481,10 @@ static umode_t max6697_is_visible(struct kobject *kobj, struct attribute *attr,
 		return 0;
 	if (nr == 5 && !(chip->have_fault & (1 << channel)))
 		return 0;
+	/* offset reg is only supported on max6581 remote channels */
+	if (nr == 6)
+		if (data->type != max6581 || channel == 0)
+			return 0;
 
 	return attr->mode;
 }
@@ -417,6 +501,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
 	&dev_attr_dummy.attr,
+	&dev_attr_dummy.attr,
 
 	&sensor_dev_attr_temp2_input.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
@@ -424,6 +509,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp2_crit.dev_attr.attr,
 	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp2_fault.dev_attr.attr,
+	&sensor_dev_attr_temp2_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp3_input.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
@@ -431,6 +517,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp3_crit.dev_attr.attr,
 	&sensor_dev_attr_temp3_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp3_fault.dev_attr.attr,
+	&sensor_dev_attr_temp3_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp4_input.dev_attr.attr,
 	&sensor_dev_attr_temp4_max.dev_attr.attr,
@@ -438,6 +525,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp4_crit.dev_attr.attr,
 	&sensor_dev_attr_temp4_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp4_fault.dev_attr.attr,
+	&sensor_dev_attr_temp4_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp5_input.dev_attr.attr,
 	&sensor_dev_attr_temp5_max.dev_attr.attr,
@@ -445,6 +533,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp5_crit.dev_attr.attr,
 	&sensor_dev_attr_temp5_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp5_fault.dev_attr.attr,
+	&sensor_dev_attr_temp5_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp6_input.dev_attr.attr,
 	&sensor_dev_attr_temp6_max.dev_attr.attr,
@@ -452,6 +541,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp6_crit.dev_attr.attr,
 	&sensor_dev_attr_temp6_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp6_fault.dev_attr.attr,
+	&sensor_dev_attr_temp6_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp7_input.dev_attr.attr,
 	&sensor_dev_attr_temp7_max.dev_attr.attr,
@@ -459,6 +549,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp7_crit.dev_attr.attr,
 	&sensor_dev_attr_temp7_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp7_fault.dev_attr.attr,
+	&sensor_dev_attr_temp7_offset.dev_attr.attr,
 
 	&sensor_dev_attr_temp8_input.dev_attr.attr,
 	&sensor_dev_attr_temp8_max.dev_attr.attr,
@@ -466,6 +557,7 @@ static struct attribute *max6697_attributes[] = {
 	&sensor_dev_attr_temp8_crit.dev_attr.attr,
 	&sensor_dev_attr_temp8_crit_alarm.dev_attr.attr,
 	&sensor_dev_attr_temp8_fault.dev_attr.attr,
+	&sensor_dev_attr_temp8_offset.dev_attr.attr,
 	NULL
 };
 
@@ -502,8 +594,8 @@ static void max6697_get_config_of(struct device_node *node,
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

