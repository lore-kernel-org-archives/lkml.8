Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB47BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF1220829
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bbIr5Mr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgFLEFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgFLEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:05:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C83C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so3225712plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n95gky3M8BGKrJ+IO/bBRqgu9c7XhvrCAgQUGFel/pM=;
        b=bbIr5Mr6Ew/cZVOdBVqfYXN8Yfl+nj+re+oAXDuctv8zad9EgUk8+n8O+oLv590Ljb
         ZiaC8NrgmwwSMi52Js3PUuMYsT4ohrpUfHycec2YZIpb7b/ji/A1T+C808lA3+r8brDY
         jmvu+TOiOrMcKkKP05XuImWgOUPvwU61gUL/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n95gky3M8BGKrJ+IO/bBRqgu9c7XhvrCAgQUGFel/pM=;
        b=WMxQFyt84GDo/DBNsV3peubyz+WiBaucxMasW8/SG3t/h4Y3+nKXdkjHbrdWqLQthy
         bZI2fizO/M8vbV3srRiSBrVdJFCWuRcybQ8UAen0zx4TXtz/LoNKLMTItd8xa/OS5RfF
         QMfMt1mfgFr+qJZSoE0rY7MkMjgkClUudBga9u2dI/H/sOtlGkoPCncJbTz4KypP/I2O
         LmFcx6NNOFyoCvtOxm122KdI9ECM3M/NxgsMLymXqUOyUl5W6LWqKGbhy3+zymBsFp3j
         qXbEUhrz74HMJqbJ9fLrmkOa76y2vzDucWrFo3mssVz9z+BSQskQpHiEoIngGWm7Aa9W
         sFqA==
X-Gm-Message-State: AOAM53037/BTVYIw1kIQ8FoPkU1tumEa6XZ93opHw0QhOxOXMM+arDBN
        W3F9t3zQOKoFzoLUFNfm1lsrxQ==
X-Google-Smtp-Source: ABdhPJw/SNrHDZmQ4eABu2aYM/zvSG5uqCX6ZKZPzkekm1Y6wMKgCGfIHzzVb/GY9hVFhGFD+5nFRw==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr5668056plb.330.1591934747979;
        Thu, 11 Jun 2020 21:05:47 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id u7sm4686983pfu.162.2020.06.11.21.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 21:05:47 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 3/3] regulator: Add driver for cros-ec-regulator
Date:   Fri, 12 Jun 2020 12:05:20 +0800
Message-Id: <20200612040526.192878-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612040526.192878-1-pihsun@chromium.org>
References: <20200612040526.192878-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for cros-ec-regulator, representing a voltage regulator that
is connected and controlled by ChromeOS EC, and is controlled by kernel
with EC host commands.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes from v5:
* Move introduction of new host command to a separate patch.
* Use devm_regulator_register.
* sizeof -> ARRAY_SIZE.
* Small whitespace change.

Changes from v4:
* Change compatible name from regulator-cros-ec to cros-ec-regulator.

Changes from v3:
* Remove check around CONFIG_OF.
* Add new host commands to cros_ec_trace.
* Use devm_kstrdup for duping regulator name.
* Change license header and add MODULE_AUTHOR.
* Address review comments.

Changes from v2:
* Add 'depends on OF' to Kconfig.
* Add Kconfig description about compiling as module.

Changes from v1:
* Change compatible string to google,regulator-cros-ec.
* Use reg property in device tree.
* Address comments on code styles.

This patch contains function cros_ec_cmd that is copied from the series:
https://lore.kernel.org/patchwork/project/lkml/list/?series=428457.

I can't find the first patch in that v2 series, so the function is
modified from v1 of that series according to reviewers comment:
https://lore.kernel.org/patchwork/patch/1188110/

I copied the function instead of depending on that series since I feel
the function is small enough, and the series has stalled for some time.
---
 drivers/regulator/Kconfig             |  10 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/cros-ec-regulator.c | 257 ++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 drivers/regulator/cros-ec-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8f677f5d79b4..c398e90e0e73 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -238,6 +238,16 @@ config REGULATOR_CPCAP
 	  Say y here for CPCAP regulator found on some Motorola phones
 	  and tablets such as Droid 4.
 
+config REGULATOR_CROS_EC
+	tristate "ChromeOS EC regulators"
+	depends on CROS_EC && OF
+	help
+	  This driver supports voltage regulators that is connected to ChromeOS
+	  EC and controlled through EC host commands.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called cros-ec-regulator.
+
 config REGULATOR_DA903X
 	tristate "Dialog Semiconductor DA9030/DA9034 regulators"
 	depends on PMIC_DA903X
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f163371071..46592c160d22 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) += userspace-consumer.o
 obj-$(CONFIG_REGULATOR_88PG86X) += 88pg86x.o
 obj-$(CONFIG_REGULATOR_88PM800) += 88pm800-regulator.o
 obj-$(CONFIG_REGULATOR_88PM8607) += 88pm8607.o
+obj-$(CONFIG_REGULATOR_CROS_EC) += cros-ec-regulator.o
 obj-$(CONFIG_REGULATOR_CPCAP) += cpcap-regulator.o
 obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
 obj-$(CONFIG_REGULATOR_AB3100) += ab3100.o
diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
new file mode 100644
index 000000000000..35f97246bc48
--- /dev/null
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright 2020 Google LLC.
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/slab.h>
+
+struct cros_ec_regulator_data {
+	struct regulator_desc desc;
+	struct regulator_dev *dev;
+	struct cros_ec_device *ec_dev;
+
+	u32 index;
+
+	u16 *voltages_mV;
+	u16 num_voltages;
+};
+
+static int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
+		       void *outdata, u32 outsize, void *indata, u32 insize)
+{
+	struct cros_ec_command *msg;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = version;
+	msg->command = command;
+	msg->outsize = outsize;
+	msg->insize = insize;
+
+	if (outdata && outsize > 0)
+		memcpy(msg->data, outdata, outsize);
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0)
+		goto cleanup;
+
+	if (insize)
+		memcpy(indata, msg->data, insize);
+
+cleanup:
+	kfree(msg);
+	return ret;
+}
+
+static int cros_ec_regulator_enable(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_enable cmd = {
+		.index = data->index,
+		.enable = 1,
+	};
+
+	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
+			  sizeof(cmd), NULL, 0);
+}
+
+static int cros_ec_regulator_disable(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_enable cmd = {
+		.index = data->index,
+		.enable = 0,
+	};
+
+	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_ENABLE, &cmd,
+			  sizeof(cmd), NULL, 0);
+}
+
+static int cros_ec_regulator_is_enabled(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_is_enabled cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_is_enabled resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_IS_ENABLED, &cmd,
+			  sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+	return resp.enabled;
+}
+
+static int cros_ec_regulator_list_voltage(struct regulator_dev *dev,
+					  unsigned int selector)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+
+	if (selector >= data->num_voltages)
+		return -EINVAL;
+
+	return data->voltages_mV[selector] * 1000;
+}
+
+static int cros_ec_regulator_get_voltage(struct regulator_dev *dev)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	struct ec_params_regulator_get_voltage cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_get_voltage resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_VOLTAGE, &cmd,
+			  sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+	return resp.voltage_mv * 1000;
+}
+
+static int cros_ec_regulator_set_voltage(struct regulator_dev *dev, int min_uV,
+					 int max_uV, unsigned int *selector)
+{
+	struct cros_ec_regulator_data *data = rdev_get_drvdata(dev);
+	int min_mV = DIV_ROUND_UP(min_uV, 1000);
+	int max_mV = max_uV / 1000;
+	struct ec_params_regulator_set_voltage cmd = {
+		.index = data->index,
+		.min_mv = min_mV,
+		.max_mv = max_mV,
+	};
+
+	/*
+	 * This can happen when the given range [min_uV, max_uV] doesn't
+	 * contain any voltage that can be represented exactly in mV.
+	 */
+	if (min_mV > max_mV)
+		return -EINVAL;
+
+	return cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_SET_VOLTAGE, &cmd,
+			   sizeof(cmd), NULL, 0);
+}
+
+static struct regulator_ops cros_ec_regulator_voltage_ops = {
+	.enable = cros_ec_regulator_enable,
+	.disable = cros_ec_regulator_disable,
+	.is_enabled = cros_ec_regulator_is_enabled,
+	.list_voltage = cros_ec_regulator_list_voltage,
+	.get_voltage = cros_ec_regulator_get_voltage,
+	.set_voltage = cros_ec_regulator_set_voltage,
+};
+
+static int cros_ec_regulator_init_info(struct device *dev,
+				       struct cros_ec_regulator_data *data)
+{
+	struct ec_params_regulator_get_info cmd = {
+		.index = data->index,
+	};
+	struct ec_response_regulator_get_info resp;
+	int ret;
+
+	ret = cros_ec_cmd(data->ec_dev, 0, EC_CMD_REGULATOR_GET_INFO, &cmd,
+			   sizeof(cmd), &resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	data->num_voltages =
+		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
+	data->voltages_mV =
+		devm_kmemdup(dev, resp.voltages_mv,
+			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+	data->desc.n_voltages = data->num_voltages;
+
+	/* Make sure the returned name is always a valid string */
+	resp.name[ARRAY_SIZE(resp.name) - 1] = '\0';
+	data->desc.name = devm_kstrdup(dev, resp.name, GFP_KERNEL);
+	if (!data->desc.name)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int cros_ec_regulator_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct cros_ec_regulator_data *drvdata;
+	struct regulator_init_data *init_data;
+	struct regulator_config cfg = {};
+	struct regulator_desc *desc;
+	int ret;
+
+	drvdata = devm_kzalloc(
+		&pdev->dev, sizeof(struct cros_ec_regulator_data), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->ec_dev = dev_get_drvdata(dev->parent);
+	desc = &drvdata->desc;
+
+	init_data = of_get_regulator_init_data(dev, np, desc);
+	if (!init_data)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "reg", &drvdata->index);
+	if (ret < 0)
+		return ret;
+
+	desc->owner = THIS_MODULE;
+	desc->type = REGULATOR_VOLTAGE;
+	desc->ops = &cros_ec_regulator_voltage_ops;
+
+	ret = cros_ec_regulator_init_info(dev, drvdata);
+	if (ret < 0)
+		return ret;
+
+	cfg.dev = &pdev->dev;
+	cfg.init_data = init_data;
+	cfg.driver_data = drvdata;
+	cfg.of_node = np;
+
+	drvdata->dev = devm_regulator_register(dev, &drvdata->desc, &cfg);
+	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
+		goto free_name;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
+
+free_name:
+	kfree(desc->name);
+	return ret;
+}
+
+static const struct of_device_id regulator_cros_ec_of_match[] = {
+	{ .compatible = "google,cros-ec-regulator", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, regulator_cros_ec_of_match);
+
+static struct platform_driver cros_ec_regulator_driver = {
+	.probe		= cros_ec_regulator_probe,
+	.driver		= {
+		.name		= "cros-ec-regulator",
+		.of_match_table = regulator_cros_ec_of_match,
+	},
+};
+
+module_platform_driver(cros_ec_regulator_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ChromeOS EC controlled regulator");
+MODULE_AUTHOR("Pi-Hsun Shih <pihsun@chromium.org>");
-- 
2.27.0.290.gba653c62da-goog

