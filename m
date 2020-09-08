Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9805B21897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgIHG05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:26:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:26026 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgIHG04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:26:56 -0400
IronPort-SDR: n7joOIgDU3bYUz2XQQViIFOYe0qn1MND4QIsaUaH7dA5ORRzCL60FnqAO49MdpVg9XTkTRVg5l
 kZ6hFY+GYXXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="159053562"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="159053562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 23:26:53 -0700
IronPort-SDR: 1qkboM30O8V3XqhnA0U4ZXS4EeZCQRn7yUQ4PyUWfSC8JuMVXgTkCFTalrF9DpE+5WE1yh6TRd
 RUJAm5FTQs5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="317081226"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2020 23:26:49 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     linux@roeck-us.net, jdelvare@suse.com, lee.jones@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, mdf@kernel.org
Subject: [PATCH] hwmon: intel-m10-bmc-hwmon: add hwmon support for Intel MAX 10 BMC
Date:   Tue,  8 Sep 2020 14:22:20 +0800
Message-Id: <1599546140-18804-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599546140-18804-1-git-send-email-yilun.xu@intel.com>
References: <1599546140-18804-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds hwmon functionality for Intel MAX 10 BMC chip. This BMC
chip connects to a set of sensor chips to monitor current, voltage,
thermal and power of different components on board. The BMC firmware is
responsible for sensor data sampling and recording in shared registers.
Host driver reads the sensor data from these shared registers and
exposes them to users as hwmon interfaces.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hwmon/Kconfig               |  11 +
 drivers/hwmon/Makefile              |   1 +
 drivers/hwmon/intel-m10-bmc-hwmon.c | 516 ++++++++++++++++++++++++++++++++++++
 3 files changed, 528 insertions(+)
 create mode 100644 drivers/hwmon/intel-m10-bmc-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8dc28b2..53af15c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2064,6 +2064,17 @@ config SENSORS_XGENE
 	  If you say yes here you get support for the temperature
 	  and power sensors for APM X-Gene SoC.
 
+config SENSORS_INTEL_M10_BMC_HWMON
+	tristate "Intel MAX10 BMC Hardware Monitoring"
+	depends on MFD_INTEL_M10_BMC
+	help
+	  This driver provides support for the hardware monitoring functionality
+	  on Intel MAX10 BMC chip.
+
+	  This BMC Chip is used on Intel FPGA PCIe Acceleration Cards (PAC). Its
+	  sensors monitor various telemetry data of different components on the
+	  card, e.g. board temperature, FPGA core temperature/voltage/current.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index a8f4b35..ba5a25a 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SENSORS_IIO_HWMON) += iio_hwmon.o
 obj-$(CONFIG_SENSORS_INA209)	+= ina209.o
 obj-$(CONFIG_SENSORS_INA2XX)	+= ina2xx.o
 obj-$(CONFIG_SENSORS_INA3221)	+= ina3221.o
+obj-$(CONFIG_SENSORS_INTEL_M10_BMC_HWMON) += intel-m10-bmc-hwmon.o
 obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
new file mode 100644
index 0000000..43e55e7
--- /dev/null
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -0,0 +1,516 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel MAX 10 BMC HWMON Driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+enum m10bmc_channel_type {
+	M10BMC_CHT_TEMP,
+	M10BMC_CHT_IN,
+	M10BMC_CHT_CURR,
+	M10BMC_CHT_POWER,
+	M10BMC_CHT_MAX,
+};
+
+struct m10bmc_sdata {
+	unsigned int type;
+	unsigned int reg_input;
+	unsigned int reg_max;
+	unsigned int reg_crit;
+	unsigned int reg_hyst;
+	unsigned int reg_min;
+	unsigned int multiplier;
+	const char *label;
+};
+
+static struct m10bmc_sdata n3000bmc_sensor_tbl[] = {
+	{ M10BMC_CHT_TEMP, 0x100, 0x104, 0x108, 0x10c, 0x0, 500,
+	 "Board Temperature" },
+	{ M10BMC_CHT_TEMP, 0x110, 0x114, 0x118, 0x0, 0x0, 500,
+	 "FPGA Die Temperature" },
+	{ M10BMC_CHT_TEMP, 0x11c, 0x120, 0x124, 0x0, 0x0, 500,
+	 "QSFP0 Temperature" },
+	{ M10BMC_CHT_IN, 0x128, 0x0, 0x0, 0x0, 0x0, 1,
+	 "QSFP0 Supply Voltage" },
+	{ M10BMC_CHT_TEMP, 0x12c, 0x130, 0x134, 0x0, 0x0, 500,
+	 "QSFP1 Temperature" },
+	{ M10BMC_CHT_IN, 0x138, 0x0, 0x0, 0x0, 0x0, 1,
+	 "QSFP1 Supply Voltage" },
+	{ M10BMC_CHT_IN, 0x13c, 0x0, 0x0, 0x0, 0x0, 1,
+	 "FPGA Core Voltage" },
+	{ M10BMC_CHT_CURR, 0x140, 0x0, 0x0, 0x0, 0x0, 1,
+	 "FPGA Core Current" },
+	{ M10BMC_CHT_IN, 0x144, 0x0, 0x0, 0x0, 0x0, 1,
+	 "12V Backplane Voltage" },
+	{ M10BMC_CHT_CURR, 0x148, 0x0, 0x0, 0x0, 0x0, 1,
+	 "12V Backplane Current" },
+	{ M10BMC_CHT_IN, 0x14c, 0x0, 0x0, 0x0, 0x0, 1,
+	 "1.2V Voltage" },
+	{M10BMC_CHT_IN, 0x150, 0x0, 0x0, 0x0, 0x0, 1,
+	 "12V AUX Voltage" },
+	{ M10BMC_CHT_CURR, 0x154, 0x0, 0x0, 0x0, 0x0, 1,
+	 "12V AUX Current" },
+	{ M10BMC_CHT_IN, 0x158, 0x0, 0x0, 0x0, 0x0, 1,
+	 "1.8V Voltage" },
+	{ M10BMC_CHT_IN, 0x15c, 0x0, 0x0, 0x0, 0x0, 1,
+	 "3.3V Voltage" },
+	{ M10BMC_CHT_POWER, 0x160, 0x0, 0x0, 0x0, 0x0, 1000,
+	 "Board Power" },
+	{ M10BMC_CHT_TEMP, 0x168, 0x0, 0x0, 0x0, 0x0, 500,
+	 "Retimer A Temperature" },
+	{ M10BMC_CHT_TEMP, 0x16c, 0x0, 0x0, 0x0, 0x0, 500,
+	 "Retimer A SerDes Temperature" },
+	{ M10BMC_CHT_TEMP, 0x170, 0x0, 0x0, 0x0, 0x0, 500,
+	 "Retimer B Temperature" },
+	{ M10BMC_CHT_TEMP, 0x174, 0x0, 0x0, 0x0, 0x0, 500,
+	 "Retimer B SerDes Temperature" },
+	{ M10BMC_CHT_MAX } /* sentinel */
+};
+
+struct m10bmc_ch_group {
+	int num_channels;
+	struct m10bmc_sdata **data_list;
+	u32 *config;
+	struct hwmon_channel_info info;
+};
+
+struct m10bmc_hwmon {
+	struct device *dev;
+	struct m10bmc_ch_group chgs[M10BMC_CHT_MAX];
+	/* This is a NULL terminated array required by the HWMON interface */
+	const struct hwmon_channel_info *info[M10BMC_CHT_MAX + 1];
+	struct hwmon_chip_info chip;
+	char *hw_name;
+	struct intel_m10bmc *m10bmc;
+	struct m10bmc_sdata *data_tbl;
+};
+
+static enum m10bmc_channel_type
+htype_to_ctype(enum hwmon_sensor_types htype)
+{
+	switch (htype) {
+	case hwmon_temp:
+		return M10BMC_CHT_TEMP;
+	case hwmon_in:
+		return M10BMC_CHT_IN;
+	case hwmon_curr:
+		return M10BMC_CHT_CURR;
+	case hwmon_power:
+		return M10BMC_CHT_POWER;
+	default:
+		return M10BMC_CHT_MAX;
+	}
+}
+
+static enum hwmon_sensor_types
+ctype_to_htype(enum m10bmc_channel_type ctype)
+{
+	switch (ctype) {
+	case M10BMC_CHT_TEMP:
+		return hwmon_temp;
+	case M10BMC_CHT_IN:
+		return hwmon_in;
+	case M10BMC_CHT_CURR:
+		return hwmon_curr;
+	case M10BMC_CHT_POWER:
+		return hwmon_power;
+	default:
+		return hwmon_max;
+	}
+}
+
+static umode_t
+m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+			u32 attr, int channel)
+{
+	return 0444;
+}
+
+static struct m10bmc_sdata *
+find_sensor_data(struct m10bmc_hwmon *hw, enum hwmon_sensor_types htype,
+		 int channel)
+{
+	enum m10bmc_channel_type ctype = htype_to_ctype(htype);
+	struct m10bmc_ch_group *ch_group;
+
+	if (ctype >= M10BMC_CHT_MAX)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	ch_group = &hw->chgs[ctype];
+
+	if (channel >= ch_group->num_channels)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return ch_group->data_list[channel];
+}
+
+static int do_sensor_read(struct m10bmc_hwmon *hw, struct m10bmc_sdata *data,
+			  unsigned int regoff, long *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = m10bmc_sys_read(hw->m10bmc, regoff, &regval);
+	if (ret)
+		return ret;
+
+	/*
+	 * BMC Firmware will return 0xdeadbeef if the sensor value is invalid
+	 * at that time. This usually happens on sensor channels which connect
+	 * to external pluggable modules, e.g. QSFP temperature and voltage.
+	 * When the QSFP is unplugged from cage, driver will get 0xdeadbeef
+	 * from their registers.
+	 */
+	if (regval == 0xdeadbeef)
+		return -EBUSY;
+
+	*val = regval * data->multiplier;
+
+	return 0;
+}
+
+static int m10bmc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long *val)
+{
+	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
+	unsigned int reg, reg_hyst = 0;
+	struct m10bmc_sdata *data;
+	long hyst, value;
+	int ret;
+
+	data = find_sensor_data(hw, type, channel);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_temp_max_hyst:
+			reg_hyst = data->reg_hyst;
+			fallthrough;
+		case hwmon_temp_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_temp_crit_hyst:
+			reg_hyst = data->reg_hyst;
+			fallthrough;
+		case hwmon_temp_crit:
+			reg = data->reg_crit;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_in_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_in_crit:
+			reg = data->reg_crit;
+			break;
+		case hwmon_in_min:
+			reg = data->reg_min;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			reg = data->reg_input;
+			break;
+		case hwmon_curr_max:
+			reg = data->reg_max;
+			break;
+		case hwmon_curr_crit:
+			reg = data->reg_crit;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	case hwmon_power:
+		switch (attr) {
+		case hwmon_power_input:
+			reg = data->reg_input;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = do_sensor_read(hw, data, reg, &value);
+	if (ret)
+		return ret;
+
+	if (reg_hyst) {
+		ret = do_sensor_read(hw, data, reg_hyst, &hyst);
+		if (ret)
+			return ret;
+
+		value -= hyst;
+	}
+
+	*val = value;
+
+	return ret;
+}
+
+static int m10bmc_hwmon_read_string(struct device *dev,
+				    enum hwmon_sensor_types type,
+				    u32 attr, int channel, const char **str)
+{
+	struct m10bmc_hwmon *hw = dev_get_drvdata(dev);
+	struct m10bmc_sdata *data;
+
+	data = find_sensor_data(hw, type, channel);
+	if (!data)
+		return -EOPNOTSUPP;
+
+	*str = data->label;
+
+	return 0;
+}
+
+static const struct hwmon_ops m10bmc_hwmon_ops = {
+	.is_visible = m10bmc_hwmon_is_visible,
+	.read = m10bmc_hwmon_read,
+	.read_string = m10bmc_hwmon_read_string,
+};
+
+static int m10bmc_malloc_channels(struct device *dev,
+				  struct m10bmc_ch_group *chg, int num_ch)
+{
+	chg->config = devm_kcalloc(dev, num_ch + 1,
+				   sizeof(*chg->config), GFP_KERNEL);
+	if (!chg->config)
+		return -ENOMEM;
+
+	chg->data_list = devm_kcalloc(dev, num_ch, sizeof(*chg->data_list),
+				      GFP_KERNEL);
+	if (!chg->data_list)
+		return -ENOMEM;
+
+	chg->info.config = chg->config;
+	chg->num_channels = num_ch;
+
+	return 0;
+}
+
+static void m10bmc_fill_temp_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
+				     struct m10bmc_sdata *data)
+{
+	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_TEMP];
+
+	if (data->reg_input)
+		chg->config[ch_idx] |= HWMON_T_INPUT;
+
+	if (data->reg_max) {
+		chg->config[ch_idx] |= HWMON_T_MAX;
+		if (data->reg_hyst)
+			chg->config[ch_idx] |= HWMON_T_MAX_HYST;
+	}
+
+	if (data->reg_crit) {
+		chg->config[ch_idx] |= HWMON_T_CRIT;
+		if (data->reg_hyst)
+			chg->config[ch_idx] |= HWMON_T_CRIT_HYST;
+	}
+
+	if (data->label)
+		chg->config[ch_idx] |= HWMON_T_LABEL;
+
+	chg->data_list[ch_idx] = data;
+}
+
+static void m10bmc_fill_in_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
+				   struct m10bmc_sdata *data)
+{
+	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_IN];
+
+	if (data->reg_input)
+		chg->config[ch_idx] |= HWMON_I_INPUT;
+
+	if (data->reg_max)
+		chg->config[ch_idx] |= HWMON_I_MAX;
+
+	if (data->reg_crit)
+		chg->config[ch_idx] |= HWMON_I_CRIT;
+
+	if (data->reg_min)
+		chg->config[ch_idx] |= HWMON_I_MIN;
+
+	if (data->label)
+		chg->config[ch_idx] |= HWMON_I_LABEL;
+
+	chg->data_list[ch_idx] = data;
+}
+
+static void m10bmc_fill_curr_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
+				     struct m10bmc_sdata *data)
+{
+	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_CURR];
+
+	if (data->reg_input)
+		chg->config[ch_idx] |= HWMON_C_INPUT;
+
+	if (data->reg_max)
+		chg->config[ch_idx] |= HWMON_C_MAX;
+
+	if (data->reg_crit)
+		chg->config[ch_idx] |= HWMON_C_CRIT;
+
+	if (data->label)
+		chg->config[ch_idx] |= HWMON_C_LABEL;
+
+	chg->data_list[ch_idx] = data;
+}
+
+static void m10bmc_fill_power_channel(struct m10bmc_hwmon *hwmon, int ch_idx,
+				      struct m10bmc_sdata *data)
+{
+	struct m10bmc_ch_group *chg = &hwmon->chgs[M10BMC_CHT_POWER];
+
+	if (data->reg_input)
+		chg->config[ch_idx] |= HWMON_P_INPUT;
+
+	if (data->label)
+		chg->config[ch_idx] |= HWMON_P_LABEL;
+
+	chg->data_list[ch_idx] = data;
+}
+
+static int m10bmc_hwmon_init(struct device *dev, struct intel_m10bmc *m10bmc,
+			     const char *dev_name,
+			     struct m10bmc_sdata *data_tbl)
+{
+	int num_ch[M10BMC_CHT_MAX] = { 0 }, ret, i, j;
+	struct m10bmc_sdata *data = data_tbl;
+	struct device *hwmon_dev;
+	struct m10bmc_hwmon *hw;
+
+	hw = devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	hw->dev = dev;
+	hw->m10bmc = m10bmc;
+	hw->data_tbl = data_tbl;
+
+	while (data->type != M10BMC_CHT_MAX) {
+		if (data->type > M10BMC_CHT_MAX)
+			return -EINVAL;
+
+		++num_ch[data->type];
+		++data;
+	}
+
+	for (i = 0; i < M10BMC_CHT_MAX; i++) {
+		if (!num_ch[i])
+			continue;
+
+		ret = m10bmc_malloc_channels(dev, &hw->chgs[i],
+					     num_ch[i]);
+		if (ret)
+			return ret;
+
+		hw->chgs[i].info.type = ctype_to_htype(i);
+	}
+
+	data = data_tbl;
+	memset(&num_ch, 0, sizeof(num_ch));
+	while (data->type != M10BMC_CHT_MAX) {
+		switch (data->type) {
+		case M10BMC_CHT_TEMP:
+			m10bmc_fill_temp_channel(hw, num_ch[data->type],
+						 data);
+			break;
+		case M10BMC_CHT_IN:
+			m10bmc_fill_in_channel(hw, num_ch[data->type],
+					       data);
+			break;
+		case M10BMC_CHT_CURR:
+			m10bmc_fill_curr_channel(hw, num_ch[data->type],
+						 data);
+			break;
+		case M10BMC_CHT_POWER:
+			m10bmc_fill_power_channel(hw, num_ch[data->type],
+						  data);
+			break;
+		}
+
+		++num_ch[data->type];
+		++data;
+	}
+
+	for (i = 0, j = 0; i < M10BMC_CHT_MAX; i++) {
+		if (num_ch[i])
+			hw->info[j++] = &hw->chgs[i].info;
+	}
+
+	hw->chip.info = hw->info;
+	hw->chip.ops = &m10bmc_hwmon_ops;
+
+	hw->hw_name = devm_kstrdup(dev, dev_name, GFP_KERNEL);
+	if (!hw->hw_name)
+		return -ENOMEM;
+
+	for (i = 0; hw->hw_name[i]; i++)
+		if (hwmon_is_bad_char(hw->hw_name[i]))
+			hw->hw_name[i] = '_';
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, hw->hw_name,
+							 hw, &hw->chip, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static int m10bmc_hwmon_probe(struct platform_device *pdev)
+{
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
+
+	return m10bmc_hwmon_init(&pdev->dev, m10bmc, id->name,
+				 (struct m10bmc_sdata *)id->driver_data);
+}
+
+static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
+	{
+		.name = "n3000bmc-hwmon",
+		.driver_data = (unsigned long)&n3000bmc_sensor_tbl,
+	},
+	{ }
+};
+
+static struct platform_driver intel_m10bmc_hwmon_driver = {
+	.probe = m10bmc_hwmon_probe,
+	.driver = {
+		.name = "intel-m10-bmc-hwmon",
+	},
+	.id_table = intel_m10bmc_hwmon_ids,
+};
+module_platform_driver(intel_m10bmc_hwmon_driver);
+
+MODULE_DEVICE_TABLE(platform, intel_m10bmc_hwmon_ids);
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX 10 BMC hardware monitor");
+MODULE_LICENSE("GPL");
-- 
2.7.4

