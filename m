Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A722084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=domanski-co.20150623.gappssmtp.com header.i=@domanski-co.20150623.gappssmtp.com header.b="J4dfikkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgGDArv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDAru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:47:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3132CC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 17:47:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so36034481ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 17:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=domanski-co.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vs1k8R+QxPoBfvYjlX3BrpdDaB1fKsGp6W2GdBM50yA=;
        b=J4dfikkqm90RVa+WaWPe+cuouPI9p45LeQdlU3gToiFUsWhXM9RkoeRFAFXRRmKtYf
         o7fUeEcKEPPrByXvvj+cTkAYH6a3VsYwHA9CAtz3tdcbn5eB2mxTk20ZMik+IQDwaLn0
         AIG70FiakFzvvGSzUBc0AW0ZG/5yLuDle0DZu9JSlRz9oMFwWqthBIP75jMFXt/zY/E6
         oLy4z9DtZJCrzwLQn/MYTReH7w9kr+3chr8zDe0s2PyRWsUBIpJA4HGrf4WlmLOymCXO
         O9tnDACwjvOwJMIxdJUC/EgZr2qB0oX9Ekm+YUVnhf5L7EELmHVrzFMv2CPFDyHGn/8j
         PWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vs1k8R+QxPoBfvYjlX3BrpdDaB1fKsGp6W2GdBM50yA=;
        b=gS2pEchsScZ18USTmssE0VVT+O/vefsmxuTmd4nCwdyhrjAZYv6uJaJhUx6QpYMu77
         TRUXrMaNr8rbKzm3hLgh39DTaMDvZKOtqN8fOyKR0+e2pRtXTtbniA4excRMyHM5YnwS
         /VikWHLRhb9u2146Cd86l4PuDKAb6+uGJENQ6eVLJGt/Eri7OeXX38wCjQbrtTxy2LNC
         T70mLzmiYUCSSdWN1mAIyoIIM9hL4lv4dBCq4t8fM5/Unfpc4uBw85ALocCHRKvmn1Dn
         4n7GTZg99Z5lmKaHuq4ZUwH/lIM6L2fKHTGU7A36PDQLoiRW4JtDDLdLX6texE8LJ00P
         wrCg==
X-Gm-Message-State: AOAM5311wAmopxn6qzYytTXvShAxFfGjOJMLBS+AfMpgXqSCr/J1tRFs
        7X5V0MST92vlMl+wYtQCxWnnBbnV/tB1cuEY
X-Google-Smtp-Source: ABdhPJxXSOwXdHqsoVJkpAVLG4vinOi5GieMe0f/VfWP+JYEKFKtRN+ZSjvHbPFP3nTVLyHnAhmwww==
X-Received: by 2002:a17:906:d116:: with SMTP id b22mr11026546ejz.250.1593823668367;
        Fri, 03 Jul 2020 17:47:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:4540:6b00:6900:489f:a320:1bb1:801e])
        by smtp.gmail.com with ESMTPSA id u17sm10321650eje.74.2020.07.03.17.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 17:47:47 -0700 (PDT)
From:   =?UTF-8?q?Kamil=20Doma=C5=84ski?= <kamil@domanski.co>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>,
        =?UTF-8?q?Kamil=20Doma=C5=84ski?= <kamil@domanski.co>
Subject: [PATCH v3] HID: logitech-hidpp: add support for Logitech G533 headset
Date:   Sat,  4 Jul 2020 02:47:45 +0200
Message-Id: <20200704004745.383271-1-kamil@domanski.co>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
  v2:
  - changed charging status parsing to account for invalid states
  v3:
  - rebased against Linux v5.7
  - changed variable naming in hidpp20_adc_map_status_voltage
    to camel case
  - corrected comment styling in hidpp_battery_get_property
  - dropped usage of test_bit macro in hidpp20_adc_map_status_voltage
    to avoid using `long` type
  - added bit flag definitions in hidpp20_adc_map_status_voltage

Signed-off-by: Kamil Domański <kamil@domanski.co>
---
 drivers/hid/hid-logitech-hidpp.c | 197 ++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 094f4f1b6555..2e2842aec05b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -29,6 +29,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
+MODULE_AUTHOR("Kamil Domański <kamil@domanski.co>");
 MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 
 static bool disable_raw_mode;
@@ -92,6 +93,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
 #define HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS	BIT(3)
 #define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
+#define HIDPP_CAPABILITY_ADC_MEASUREMENT	BIT(5)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -141,6 +143,7 @@ struct hidpp_battery {
 	u8 feature_index;
 	u8 solar_feature_index;
 	u8 voltage_feature_index;
+	u8 adc_measurement_feature_index;
 	struct power_supply_desc desc;
 	struct power_supply *ps;
 	char name[64];
@@ -215,6 +218,7 @@ struct hidpp_device {
 #define HIDPP_ERROR_INVALID_PARAM_VALUE		0x0b
 #define HIDPP_ERROR_WRONG_PIN_CODE		0x0c
 /* HID++ 2.0 error codes */
+#define HIDPP20_ERROR_DISCONNECTED	0x05
 #define HIDPP20_ERROR				0xff
 
 static void hidpp_connect_event(struct hidpp_device *hidpp_dev);
@@ -1378,6 +1382,179 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x1F20: Analog-digital converter measurement                               */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_ADC_MEASUREMENT 0x1F20
+
+#define CMD_ADC_MEASUREMENT_GET_VOLTAGE 0x01
+
+#define FLAG_ADC_MAP_STATUS_CONNECTED         0x01
+#define FLAG_ADC_MAP_STATUS_CHARGING          0x02
+#define FLAG_ADC_MAP_STATUS_CHARGING_COMPLETE 0x04
+#define FLAG_ADC_MAP_STATUS_CHARGING_FAULT    0x08
+
+/**
+ * hidpp20_adc_map_status_voltage() - convert HID++ code to power supply status
+ * @hidpp: HID++ device struct.
+ * @data: ADC report data.
+ * @voltage: Pointer to variable where the ADC voltage shall be written.
+ *
+ * This function decodes the ADC voltage and charge status
+ * of the device's battery.
+ *
+ * Return: Returns the power supply charge status code.
+ */
+static int hidpp20_adc_map_status_voltage(struct hidpp_device *hidpp,
+						u8 data[3], int *voltage)
+{
+	u8 flags = data[2];
+	*voltage = get_unaligned_be16(data);
+
+	if (!(flags & FLAG_ADC_MAP_STATUS_CONNECTED))
+		return POWER_SUPPLY_STATUS_UNKNOWN;
+
+	if (flags & FLAG_ADC_MAP_STATUS_CHARGING) {
+		if (flags & FLAG_ADC_MAP_STATUS_CHARGING_FAULT)
+			return POWER_SUPPLY_STATUS_NOT_CHARGING;
+
+		if (flags & FLAG_ADC_MAP_STATUS_CHARGING_COMPLETE)
+			return POWER_SUPPLY_STATUS_FULL;
+
+		return POWER_SUPPLY_STATUS_CHARGING;
+	}
+
+	return POWER_SUPPLY_STATUS_DISCHARGING;
+}
+
+/**
+ * hidpp20_get_adc_measurement() - retrieve ADC mesurement feature info
+ * @hidpp: HID++ device struct.
+ * @feature_index: The device's feature index for ADC measurement.
+ * @status: Pointer to variable where the charge status shall be written.
+ * @voltage: Pointer to variable where the ADC voltage shall be written.
+ *
+ * This function retrieves the ADC voltage and charge status
+ * of the device's battery.
+ *
+ * Return: Returns 0 on success.
+ */
+static int hidpp20_get_adc_measurement(struct hidpp_device *hidpp,
+						 u8 feature_index,
+						 int *status, int *voltage)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_ADC_MEASUREMENT_GET_VOLTAGE,
+					  NULL, 0, &response);
+
+	/* The dongle cannot reach a device. */
+	if (ret == HIDPP20_ERROR_DISCONNECTED) {
+		*status = POWER_SUPPLY_STATUS_UNKNOWN;
+		*voltage = 0;
+		return 0;
+	}
+
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	*status = hidpp20_adc_map_status_voltage(hidpp, params, voltage);
+
+	return 0;
+}
+
+/**
+ * hidpp20_query_adc_measurement_info() - retrieve ADC mesurement feature info
+ * @hidpp: HID++ device struct.
+ *
+ * This function queries the device for the feature index
+ * of the analog-to-digital converter measurement feature.
+ *
+ * Subsequently it retrieves the measurement result.
+ *
+ * Return: Returns 0 on success.
+ */
+static int hidpp20_query_adc_measurement_info(struct hidpp_device *hidpp)
+{
+	u8 feature_type;
+	int ret;
+	int status, voltage;
+
+	/* If the current index is unspecified (0xFF)
+	 * then fetch it using the root feature. */
+	if (hidpp->battery.adc_measurement_feature_index == 0xff) {
+		ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_ADC_MEASUREMENT,
+					     &hidpp->battery.adc_measurement_feature_index,
+					     &feature_type);
+		if (ret)
+			return ret;
+
+		hidpp->capabilities |= HIDPP_CAPABILITY_ADC_MEASUREMENT;
+	}
+
+	ret = hidpp20_get_adc_measurement(hidpp,
+						  hidpp->battery.adc_measurement_feature_index,
+						  &status, &voltage);
+
+	if (ret)
+		return ret;
+
+	hidpp->battery.status = status;
+	hidpp->battery.voltage = voltage;
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_CHARGING ||
+							status == POWER_SUPPLY_STATUS_FULL;
+
+	return 0;
+}
+
+/**
+ * hidpp20_adc_measurement_event() - handle incoming ADC measurement event
+ * @hidpp: HID++ device struct.
+ * @data: Pointer to the incoming report data.
+ * @size: Size of the incoming report data.
+ *
+ * This function processes an incoming update in the device's battery
+ * ADC voltage and charge status. If there is a change in either,
+ * a power supply update is passed on to the kernel.
+ *
+ * Return: Returns 0 on success.
+ */
+static int hidpp20_adc_measurement_event(struct hidpp_device *hidpp,
+					    u8 *data, int size)
+{
+	struct hidpp_report *report = (struct hidpp_report *)data;
+	int status, voltage;
+
+	/* Ignore the report if it is not an ADC report. */
+	if (report->fap.feature_index != hidpp->battery.adc_measurement_feature_index ||
+		report->fap.funcindex_clientid != EVENT_BATTERY_VOLTAGE_STATUS_BROADCAST)
+		return 0;
+
+	status = hidpp20_adc_map_status_voltage(hidpp,
+		report->fap.params, &voltage);
+
+	hidpp->battery.online = status == POWER_SUPPLY_STATUS_CHARGING ||
+							status == POWER_SUPPLY_STATUS_FULL;
+
+	/* Update the PS only if charging state or voltage changed. */
+	if (voltage != hidpp->battery.voltage || status != hidpp->battery.status) {
+		hidpp->battery.voltage = voltage;
+		hidpp->battery.status = status;
+		if (hidpp->battery.ps)
+			power_supply_changed(hidpp->battery.ps);
+	}
+	return 0;
+}
+
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
@@ -1426,6 +1603,13 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 			val->strval = hidpp->hid_dev->uniq;
 			break;
 		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			/*
+			 * ADC feature doesn't automatically report the voltage
+			 * so we poll it explicitly when the property is read.
+			 */
+			if (hidpp->capabilities & HIDPP_CAPABILITY_ADC_MEASUREMENT)
+				hidpp20_query_adc_measurement_info(hidpp);
+
 			/* hardware reports voltage in in mV. sysfs expects uV */
 			val->intval = hidpp->battery.voltage * 1000;
 			break;
@@ -3291,6 +3475,9 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		ret = hidpp20_battery_voltage_event(hidpp, data, size);
 		if (ret != 0)
 			return ret;
+		ret = hidpp20_adc_measurement_event(hidpp, data, size);
+		if (ret != 0)
+			return ret;
 	}
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP10_BATTERY) {
@@ -3413,6 +3600,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	hidpp->battery.feature_index = 0xff;
 	hidpp->battery.solar_feature_index = 0xff;
 	hidpp->battery.voltage_feature_index = 0xff;
+	hidpp->battery.adc_measurement_feature_index = 0xff;
 
 	if (hidpp->protocol_major >= 2) {
 		if (hidpp->quirks & HIDPP_QUIRK_CLASS_K750)
@@ -3421,6 +3609,8 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 			ret = hidpp20_query_battery_voltage_info(hidpp);
 			if (ret)
 				ret = hidpp20_query_battery_info(hidpp);
+			if (ret)
+				ret = hidpp20_query_adc_measurement_info(hidpp);
 		}
 
 		if (ret)
@@ -3456,7 +3646,8 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 				POWER_SUPPLY_PROP_CAPACITY_LEVEL;
 
-	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE ||
+		hidpp->capabilities & HIDPP_CAPABILITY_ADC_MEASUREMENT)
 		battery_props[num_battery_props++] =
 			POWER_SUPPLY_PROP_VOLTAGE_NOW;
 
@@ -3625,6 +3816,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	} else if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
 		if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
 			hidpp20_query_battery_voltage_info(hidpp);
+		else if (hidpp->capabilities & HIDPP_CAPABILITY_ADC_MEASUREMENT)
+			hidpp20_query_adc_measurement_info(hidpp);
 		else
 			hidpp20_query_battery_info(hidpp);
 	}
@@ -3994,6 +4187,8 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ /* Logitech G403 Wireless Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
+	{ /* Logitech G533 Wireless Headset over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0A66) },
 	{ /* Logitech G703 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
 	{ /* Logitech G703 Hero Gaming Mouse over USB */
-- 
2.27.0

