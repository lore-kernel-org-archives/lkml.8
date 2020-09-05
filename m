Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BAEC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1F92072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="V7QELSCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgIENGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgIENFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:05:47 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544CEC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:05:47 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so12044313ejo.9
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4NyOYnIqq8KMzZjS4q4blGeDnGTKT6A+OwRskgwANa8=;
        b=V7QELSCLgezCn3g1jebi0G/Nxy97A/0yHYsyL/nR35cz/aSFH/RjD5Ylf0Y13yZRDW
         mPQzORIdjZdoS9WSSEdLAX8R5c+mZXihvd3bGeNTbCWc4vU6llOfID52L1IaN0rjhoPB
         s9N1cB2TuPTLwtdji8Ufjg7IwW1BiRYhm3bTPbWTqNauVIrrQZ56U1TUQX0d8EwiCCk5
         LntWUr4nX6zL7tbfkxtn3P6HDl8hxSxrjsiZF+pZUn44VB2ejCZWNAB1uXGnv0XhA0Ik
         scHVnZQwxw38pCNXXhjDKmh1QXUfA5L7RBaCxz2kDmzY5j+K0CiQAiB2X49aulOw7qxY
         ZDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NyOYnIqq8KMzZjS4q4blGeDnGTKT6A+OwRskgwANa8=;
        b=J2CnNARIcinZr+z0/iW6mvShDiD0oft64LptcNhMQxQtYYpPlYv7/fRgSV1ItE3FwK
         SJ4LYv3vxV5BTnjgo5UyPIs6gof8i4yRvhR/lmcPq0MajrOTXxfXQnTy7puoXA8JABka
         Yfx03UbpWRaXB5mBh89+YbJl4CIKbthimESNyWvP9oU41HcJSlJm96ArWRJeuEKdxbX5
         pSc/vhlSqHkfzgEZpyX04tRXlFPKqB+PxdRSeyw5Hy47gcC4zahfw+oox7aE3aurIUd2
         zjRlwF8XKpdFQn6UMILPKFvunQghBXAZfIIRt+phyFIWNnYMqC0Ijjo2NMBT70hswROF
         3pyg==
X-Gm-Message-State: AOAM532LSxjADcuJK273jmULR/vk9omFwbFJl0OGZe+v9g8M66JTis3e
        ok3dv2o8eiHuBamKLrT9OgcxpHucg4WaONd+7hduw7SdXJgcjdoUraQdNYtd/bZwuhE15NqqIee
        szkws/JBtTUfjRmd0As3poNC/jm1fXqayIuFGUx/deHAE2auMrW7XiJH4salA6AsVg+qAL9alVc
        130KTPNulq9Q==
X-Google-Smtp-Source: ABdhPJw05X/9kpNEFN10V3oKBYxavgqxX5bTRc7Ps675juzBRKYI+y3lwj9Uznf852RGmoh3bAriDA==
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr12206628ejz.378.1599311145049;
        Sat, 05 Sep 2020 06:05:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:ee2:4b0d:3002:290:faff:fe54:449c])
        by smtp.gmail.com with ESMTPSA id s18sm9372655ejd.54.2020.09.05.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:05:44 -0700 (PDT)
From:   Luka Kovacic <luka.kovacic@sartura.hr>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org
Cc:     lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@bootlin.com,
        luka.perkov@sartura.hr, Luka Kovacic <luka.kovacic@sartura.hr>
Subject: [PATCH 3/7] drivers: hwmon: Add the iEi WT61P803 PUZZLE HWMON driver
Date:   Sat,  5 Sep 2020 15:03:32 +0200
Message-Id: <20200905130336.967622-4-luka.kovacic@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200905130336.967622-1-luka.kovacic@sartura.hr>
References: <20200905130336.967622-1-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the iEi WT61P803 PUZZLE HWMON driver, that handles the fan speed
control via PWM, reading fan speed and reading on-board temperature
sensors.

The driver registers a HWMON device and a simple thermal cooling device to
enable in-kernel fan management.

This driver depends on the iEi WT61P803 PUZZLE MFD driver.

Signed-off-by: Luka Kovacic <luka.kovacic@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
 drivers/hwmon/Kconfig                     |   8 +
 drivers/hwmon/Makefile                    |   1 +
 drivers/hwmon/iei-wt61p803-puzzle-hwmon.c | 613 ++++++++++++++++++++++
 3 files changed, 622 insertions(+)
 create mode 100644 drivers/hwmon/iei-wt61p803-puzzle-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8dc28b26916e..ff279df9bf40 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -722,6 +722,14 @@ config SENSORS_IBMPOWERNV
 	  This driver can also be built as a module. If so, the module
 	  will be called ibmpowernv.
 
+config SENSORS_IEI_WT61P803_PUZZLE_HWMON
+	tristate "iEi WT61P803 PUZZLE MFD HWMON Driver"
+	depends on MFD_IEI_WT61P803_PUZZLE
+	help
+	  The iEi WT61P803 PUZZLE MFD HWMON Driver handles reading fan speed
+	  and writing fan PWM values. It also supports reading on-board
+	  temperature sensors.
+
 config SENSORS_IIO_HWMON
 	tristate "Hwmon driver that uses channels specified via iio maps"
 	depends on IIO
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a8f4b35b136b..b0afb2d6896f 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
+obj-$(CONFIG_SENSORS_IEI_WT61P803_PUZZLE_HWMON) += iei-wt61p803-puzzle-hwmon.o
 obj-$(CONFIG_SENSORS_IBMAEM)	+= ibmaem.o
 obj-$(CONFIG_SENSORS_IBMPEX)	+= ibmpex.o
 obj-$(CONFIG_SENSORS_IBMPOWERNV)+= ibmpowernv.o
diff --git a/drivers/hwmon/iei-wt61p803-puzzle-hwmon.c b/drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
new file mode 100644
index 000000000000..ca26d0cc6884
--- /dev/null
+++ b/drivers/hwmon/iei-wt61p803-puzzle-hwmon.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* iEi WT61P803 PUZZLE MCU HWMON Driver
+ *
+ * Copyright (C) 2020 Sartura Ltd.
+ * Author: Luka Kovacic <luka.kovacic@sartura.hr>
+ */
+
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/iei-wt61p803-puzzle.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/math64.h>
+#include <linux/err.h>
+
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
+
+#define IEI_WT61P803_PUZZLE_HWMON_MAX_TEMP_NUM 2
+#define IEI_WT61P803_PUZZLE_HWMON_MAX_FAN_NUM 5
+#define IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_NUM 2
+#define IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_VAL 255
+
+/**
+ * struct iei_wt61p803_puzzle_thermal_cooling_device - Thermal cooling device instance
+ *
+ * @mcu_hwmon: MCU HWMON struct pointer
+ * @tcdev: Thermal cooling device pointer
+ * @name: Thermal cooling device name
+ * @pwm_channel: PWM channel (0 or 1)
+ * @cooling_levels: Thermal cooling device cooling levels
+ */
+struct iei_wt61p803_puzzle_thermal_cooling_device {
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon;
+	struct thermal_cooling_device *tcdev;
+	char name[THERMAL_NAME_LENGTH];
+	int pwm_channel;
+	u8 *cooling_levels;
+};
+
+/**
+ * struct iei_wt61p803_puzzle_hwmon - MCU HWMON Driver
+ *
+ * @mcu: MCU struct pointer
+ * @temp_lock: Mutex for temp_sensor_val
+ * @temp_sensor_val: Temperature sensor values
+ * @fan_lock: Mutex for fan_speed_val
+ * @fan_speed_val: FAN speed (RPM) values
+ * @pwm_lock: Mutex for pwm_val
+ * @pwm_val: PWM values (0-255)
+ * @thermal_cooling_dev_lock: Mutex for Thermal Framework related members
+ * @thermal_cooling_dev_present: Per-channel thermal cooling device control
+ * @cdev: Per-channel thermal cooling device private structure
+ */
+struct iei_wt61p803_puzzle_hwmon {
+	struct iei_wt61p803_puzzle *mcu;
+
+	struct mutex temp_lock;
+	int temp_sensor_val[IEI_WT61P803_PUZZLE_HWMON_MAX_TEMP_NUM];
+
+	struct mutex fan_lock;
+	int fan_speed_val[IEI_WT61P803_PUZZLE_HWMON_MAX_FAN_NUM];
+
+	struct mutex pwm_lock;
+	int pwm_val[IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_NUM];
+
+	struct mutex thermal_cooling_dev_lock;
+	bool thermal_cooling_dev_present[IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_NUM];
+	struct iei_wt61p803_puzzle_thermal_cooling_device
+		*cdev[IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_NUM];
+};
+
+/*
+ * Generic MCU access functions
+ *
+ * Description: The functions below are used as generic translation functions
+ * between the kernel and the MCU hardware. These can be used from HWMON or
+ * from the Thermal Framework.
+ */
+
+#define raw_temp_to_milidegree_celsius(x) ((int)((x - 0x80)*1000))
+static int iei_wt61p803_puzzle_read_temp_sensor
+(struct iei_wt61p803_puzzle_hwmon *mcu_hwmon, int channel, int *value)
+{
+	int ret;
+	size_t reply_size = 0;
+	unsigned char *resp_buf;
+
+	/* MCU Command: Retrieve all available NTC values */
+	unsigned char temp_sensor_ntc_cmd[4] = { '@', 'T', 'A' };
+
+	if (channel > 1 && channel < 0)
+		return -EINVAL;
+
+	resp_buf = kmalloc(IEI_WT61P803_PUZZLE_BUF_SIZE, GFP_KERNEL);
+	if (!resp_buf)
+		return -ENOMEM;
+
+	/* Write the command to the MCU */
+	ret = iei_wt61p803_puzzle_write_command(mcu_hwmon->mcu,
+			temp_sensor_ntc_cmd, sizeof(temp_sensor_ntc_cmd),
+			resp_buf, &reply_size);
+	if (!ret) {
+		/* Check the number of NTC values (should be 0x32/'2') */
+		if (resp_buf[3] == 0x32) {
+			mutex_lock(&mcu_hwmon->temp_lock);
+
+			/* Write values to the struct */
+			mcu_hwmon->temp_sensor_val[0] =
+				raw_temp_to_milidegree_celsius(resp_buf[4]);
+			mcu_hwmon->temp_sensor_val[1] =
+				raw_temp_to_milidegree_celsius(resp_buf[5]);
+
+			mutex_unlock(&mcu_hwmon->temp_lock);
+		}
+
+	}
+
+	kfree(resp_buf);
+
+	mutex_lock(&mcu_hwmon->temp_lock);
+	*value = mcu_hwmon->temp_sensor_val[channel];
+	mutex_unlock(&mcu_hwmon->temp_lock);
+
+	return ret;
+}
+
+#define raw_fan_val_to_rpm(x, y) ((int)(((x)<<8|(y))/2)*60)
+static int iei_wt61p803_puzzle_read_fan_speed
+(struct iei_wt61p803_puzzle_hwmon *mcu_hwmon, int channel, int *value)
+{
+	int ret;
+	size_t reply_size = 0;
+	unsigned char *resp_buf;
+
+	/* MCU Command: Retrieve fan speed value */
+	unsigned char fan_speed_cmd[4] = { '@', 'F', 'A' };
+
+	resp_buf = kmalloc(IEI_WT61P803_PUZZLE_BUF_SIZE, GFP_KERNEL);
+	if (!resp_buf)
+		return -ENOMEM;
+
+	switch (channel) {
+	case 0:
+		fan_speed_cmd[2] = 'A';
+		break;
+	case 1:
+		fan_speed_cmd[2] = 'B';
+		break;
+	case 2:
+		fan_speed_cmd[2] = 'C';
+		break;
+	case 3:
+		fan_speed_cmd[2] = 'D';
+		break;
+	case 4:
+		fan_speed_cmd[2] = 'E';
+		break;
+	default:
+		kfree(resp_buf);
+		return -EINVAL;
+	}
+
+	/* Write the command to the MCU */
+	ret = iei_wt61p803_puzzle_write_command(mcu_hwmon->mcu, fan_speed_cmd,
+			sizeof(fan_speed_cmd), resp_buf, &reply_size);
+	if (!ret) {
+		mutex_lock(&mcu_hwmon->fan_lock);
+
+		/* Calculate fan RPM */
+		mcu_hwmon->fan_speed_val[channel] = raw_fan_val_to_rpm(resp_buf[3],
+				resp_buf[4]);
+
+		mutex_unlock(&mcu_hwmon->fan_lock);
+	}
+
+	kfree(resp_buf);
+
+	mutex_lock(&mcu_hwmon->fan_lock);
+	*value = mcu_hwmon->fan_speed_val[channel];
+	mutex_unlock(&mcu_hwmon->fan_lock);
+
+	return 0;
+}
+
+static int iei_wt61p803_puzzle_write_pwm_channel
+(struct iei_wt61p803_puzzle_hwmon *mcu_hwmon, int channel, long pwm_set_val)
+{
+	int ret;
+	size_t reply_size = 0;
+	unsigned char *resp_buf;
+
+	/* MCU Command: Set PWM value (Default channel is 0/0x30 at index 3) */
+	unsigned char pwm_set_cmd[6] = { '@', 'F', 'W', 0x30, 0x00 };
+
+	resp_buf = kmalloc(IEI_WT61P803_PUZZLE_BUF_SIZE, GFP_KERNEL);
+	if (!resp_buf)
+		return -ENOMEM;
+
+	/* Determine the PWM channel */
+	switch (channel) {
+	case 0:
+		pwm_set_cmd[3] = 0x30;
+		break;
+	case 1:
+		pwm_set_cmd[3] = 0x31;
+		break;
+	default:
+		kfree(resp_buf);
+		return -EINVAL;
+	}
+
+	if (pwm_set_val < 0 || pwm_set_val > IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_VAL) {
+		kfree(resp_buf);
+		return -EINVAL;
+	}
+
+	/* Add the value to the command */
+	pwm_set_cmd[4] = (char)pwm_set_val;
+
+	/* Write the command to the MCU */
+	ret = iei_wt61p803_puzzle_write_command(mcu_hwmon->mcu, pwm_set_cmd,
+			sizeof(pwm_set_cmd), resp_buf, &reply_size);
+	if (!ret) {
+		/* Store the PWM value */
+		if (resp_buf[0] == '@' && resp_buf[1] == 0x30) {
+			mutex_lock(&mcu_hwmon->pwm_lock);
+			mcu_hwmon->pwm_val[channel] = (int)pwm_set_val;
+			mutex_unlock(&mcu_hwmon->pwm_lock);
+		}
+	}
+
+	kfree(resp_buf);
+	return 0;
+}
+
+static int iei_wt61p803_puzzle_read_pwm_channel
+(struct iei_wt61p803_puzzle_hwmon *mcu_hwmon, int channel, int *value)
+{
+	int ret;
+	size_t reply_size = 0;
+	unsigned char *resp_buf;
+
+	/* MCU Command: Retrieve PWM value (Default channel: 0x30 at idx 3) */
+	unsigned char pwm_get_cmd[5] = { '@', 'F', 'Z', 0x30 };
+
+	resp_buf = kmalloc(IEI_WT61P803_PUZZLE_BUF_SIZE, GFP_KERNEL);
+	if (!resp_buf)
+		return -ENOMEM;
+
+	/* Determine the PWM channel */
+	switch (channel) {
+	case 0:
+		pwm_get_cmd[3] = 0x30;
+		break;
+	case 1:
+		pwm_get_cmd[3] = 0x31;
+		break;
+	default:
+		kfree(resp_buf);
+		return -EINVAL;
+	}
+
+	/* Write the command to the MCU */
+	ret = iei_wt61p803_puzzle_write_command(mcu_hwmon->mcu, pwm_get_cmd,
+			sizeof(pwm_get_cmd), resp_buf, &reply_size);
+	if (!ret) {
+		/* Store the PWM value */
+		if (resp_buf[2] == 'Z') {
+			mutex_lock(&mcu_hwmon->pwm_lock);
+			mcu_hwmon->pwm_val[channel] = (int)resp_buf[3];
+			mutex_unlock(&mcu_hwmon->pwm_lock);
+		}
+	}
+
+	kfree(resp_buf);
+
+	mutex_lock(&mcu_hwmon->pwm_lock);
+	*value = mcu_hwmon->pwm_val[channel];
+	mutex_unlock(&mcu_hwmon->pwm_lock);
+
+	return 0;
+}
+
+/*
+ * HWMON attributes
+ *
+ * Description: The attributes below are registered with the HWMON subsystem.
+ * Fans can only be controlled, if they are not controlled by the Thermal
+ * Framework.
+ */
+
+static ssize_t temp_input_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon =
+		dev_get_drvdata(dev->parent);
+	struct sensor_device_attribute *sensor_dev_attr =
+		to_sensor_dev_attr(attr);
+	int nr = sensor_dev_attr->index;
+
+	int ret, value;
+
+	ret = iei_wt61p803_puzzle_read_temp_sensor(mcu_hwmon, nr, &value);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
+static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
+
+static ssize_t fan_input_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon =
+		dev_get_drvdata(dev->parent);
+	struct sensor_device_attribute *sensor_dev_attr =
+		to_sensor_dev_attr(attr);
+	int nr = sensor_dev_attr->index;
+
+	int ret, value;
+
+	ret = iei_wt61p803_puzzle_read_fan_speed(mcu_hwmon, nr, &value);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_input, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_input, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_input, 4);
+
+static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon =
+		dev_get_drvdata(dev->parent);
+	struct sensor_device_attribute *sensor_dev_attr =
+		to_sensor_dev_attr(attr);
+	int nr = sensor_dev_attr->index;
+
+	int ret;
+	long pwm_value;
+
+	if (mcu_hwmon->thermal_cooling_dev_present[nr]) {
+		/*
+		 * The Thermal Framework has already claimed this specific PWM
+		 * channel. Return 0, to indicate 0 bytes written.
+		 */
+
+		return 0;
+	}
+
+	/* Convert the string to a long */
+	ret = kstrtol(buf, 10, &pwm_value);
+	if (ret)
+		return ret;
+
+	ret = iei_wt61p803_puzzle_write_pwm_channel(mcu_hwmon, nr, pwm_value);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t pwm_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon =
+		dev_get_drvdata(dev->parent);
+	struct sensor_device_attribute *sensor_dev_attr =
+		to_sensor_dev_attr(attr);
+	int nr = sensor_dev_attr->index;
+
+	int ret, value;
+
+	ret = iei_wt61p803_puzzle_read_pwm_channel(mcu_hwmon, nr, &value);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
+
+static struct attribute *iei_wt61p803_puzzle_attributes_temp[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *iei_wt61p803_puzzle_attributes_fan[] = {
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan5_input.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *iei_wt61p803_puzzle_attributes_pwm[] = {
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group iei_wt61p803_puzzle_group_temp = {
+	.attrs = iei_wt61p803_puzzle_attributes_temp
+};
+
+static const struct attribute_group iei_wt61p803_puzzle_group_fan = {
+	.attrs = iei_wt61p803_puzzle_attributes_fan
+};
+
+static const struct attribute_group iei_wt61p803_puzzle_group_pwm = {
+	.attrs = iei_wt61p803_puzzle_attributes_pwm
+};
+
+static const struct attribute_group *iei_wt61p803_puzzle_attr_groups[] = {
+	&iei_wt61p803_puzzle_group_temp,
+	&iei_wt61p803_puzzle_group_fan,
+	&iei_wt61p803_puzzle_group_pwm,
+	NULL
+};
+
+/*
+ * Thermal cooling device
+ *
+ * Description: The functions below are thermal cooling device ops, registered
+ * with the Thermal Framework.
+ */
+
+static int iei_wt61p803_puzzle_get_max_state
+(struct thermal_cooling_device *tcdev, unsigned long *state)
+{
+	*state = IEI_WT61P803_PUZZLE_HWMON_MAX_PWM_VAL;
+
+	return 0;
+}
+
+static int iei_wt61p803_puzzle_get_cur_state
+(struct thermal_cooling_device *tcdev, unsigned long *state)
+{
+	struct iei_wt61p803_puzzle_thermal_cooling_device *cdev = tcdev->devdata;
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon = cdev->mcu_hwmon;
+
+	int ret, value;
+
+	if (!mcu_hwmon)
+		return -EINVAL;
+
+	ret = iei_wt61p803_puzzle_read_pwm_channel(mcu_hwmon,
+			cdev->pwm_channel, &value);
+	if (ret)
+		return ret;
+
+	*state = (unsigned long)value;
+
+	return 0;
+}
+
+static int iei_wt61p803_puzzle_set_cur_state
+(struct thermal_cooling_device *tcdev, unsigned long state)
+{
+	struct iei_wt61p803_puzzle_thermal_cooling_device *cdev = tcdev->devdata;
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon = cdev->mcu_hwmon;
+
+	if (!mcu_hwmon)
+		return -EINVAL;
+
+	return iei_wt61p803_puzzle_write_pwm_channel(mcu_hwmon,
+			cdev->pwm_channel, state);
+}
+
+static const struct thermal_cooling_device_ops iei_wt61p803_puzzle_cooling_ops = {
+	.get_max_state = iei_wt61p803_puzzle_get_max_state,
+	.get_cur_state = iei_wt61p803_puzzle_get_cur_state,
+	.set_cur_state = iei_wt61p803_puzzle_set_cur_state,
+};
+
+/*
+ * Driver setup
+ */
+
+static int iei_wt61p803_puzzle_enable_thermal_cooling_dev
+(struct device *dev, struct device_node *child, struct iei_wt61p803_puzzle_hwmon *mcu_hwmon)
+{
+	u32 pwm_channel;
+	int ret, num_levels;
+
+	struct iei_wt61p803_puzzle_thermal_cooling_device *cdev;
+
+	ret = of_property_read_u32(child, "reg", &pwm_channel);
+	if (ret)
+		return ret;
+
+	mutex_lock(&mcu_hwmon->thermal_cooling_dev_lock);
+	mcu_hwmon->thermal_cooling_dev_present[pwm_channel] = true;
+	mutex_unlock(&mcu_hwmon->thermal_cooling_dev_lock);
+
+	num_levels = of_property_count_u8_elems(child, "cooling-levels");
+	if (num_levels > 0) {
+		cdev = devm_kzalloc(dev, sizeof(*cdev), GFP_KERNEL);
+		if (!cdev)
+			return -ENOMEM;
+
+		cdev->cooling_levels = devm_kzalloc(dev, num_levels, GFP_KERNEL);
+		if (!cdev->cooling_levels)
+			return -ENOMEM;
+
+		ret = of_property_read_u8_array(child, "cooling-levels",
+				cdev->cooling_levels, num_levels);
+		if (ret) {
+			dev_err(dev, "Couldn't read property 'cooling-levels'");
+			return ret;
+		}
+
+		snprintf(cdev->name, THERMAL_NAME_LENGTH, "iei_wt61p803_puzzle_%d", pwm_channel);
+
+		cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
+				cdev->name, cdev, &iei_wt61p803_puzzle_cooling_ops);
+		if (IS_ERR(cdev->tcdev))
+			return PTR_ERR(cdev->tcdev);
+
+		cdev->mcu_hwmon = mcu_hwmon;
+		cdev->pwm_channel = pwm_channel;
+
+		mutex_lock(&mcu_hwmon->thermal_cooling_dev_lock);
+		mcu_hwmon->cdev[pwm_channel] = cdev;
+		mutex_unlock(&mcu_hwmon->thermal_cooling_dev_lock);
+	}
+	return 0;
+}
+
+static int iei_wt61p803_puzzle_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *child;
+
+	/* iEi WT61P803 PUZZLE HWMON priv struct */
+	struct iei_wt61p803_puzzle_hwmon *mcu_hwmon;
+
+	/* iEi WT61P803 PUZZLE MCU Core driver */
+	struct iei_wt61p803_puzzle *mcu = dev_get_drvdata(dev->parent);
+
+	struct device *hwmon_dev;
+
+	int ret;
+
+	mcu_hwmon = devm_kzalloc(dev, sizeof(*mcu_hwmon), GFP_KERNEL);
+	if (!mcu_hwmon)
+		return -ENOMEM;
+
+	/* Set reference to the parent 'core' MFD driver */
+	mcu_hwmon->mcu = mcu;
+
+	/* Initialize the mutex members */
+	mutex_init(&mcu_hwmon->temp_lock);
+	mutex_init(&mcu_hwmon->fan_lock);
+	mutex_init(&mcu_hwmon->pwm_lock);
+	mutex_init(&mcu_hwmon->thermal_cooling_dev_lock);
+
+	platform_set_drvdata(pdev, mcu_hwmon);
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
+					"iei_wt61p803_puzzle",
+					mcu_hwmon,
+					iei_wt61p803_puzzle_attr_groups);
+
+	/* Control fans via PWM lines via Linux Kernel */
+	if (IS_ENABLED(CONFIG_THERMAL)) {
+		for_each_child_of_node(dev->of_node, child) {
+			ret = iei_wt61p803_puzzle_enable_thermal_cooling_dev(dev, child, mcu_hwmon);
+			if (ret) {
+				dev_err(dev, "Enabling the PWM fan failed\n");
+				of_node_put(child);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id iei_wt61p803_puzzle_hwmon_id_table[] = {
+	{ .compatible = "iei,wt61p803-puzzle-hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, iei_wt61p803_puzzle_hwmon_id_table);
+
+static struct platform_driver iei_wt61p803_puzzle_hwmon_driver = {
+	.driver = {
+		.name = "iei-wt61p803-puzzle-hwmon",
+		.of_match_table = iei_wt61p803_puzzle_hwmon_id_table,
+	},
+	.probe = iei_wt61p803_puzzle_hwmon_probe,
+};
+
+module_platform_driver(iei_wt61p803_puzzle_hwmon_driver);
+
+MODULE_DESCRIPTION("iEi WT61P803 PUZZLE MCU HWMON Driver");
+MODULE_AUTHOR("Luka Kovacic <luka.kovacic@sartura.hr>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

