Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BDB20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="KChSgt78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgGAVVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:21:35 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:57417 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGAVVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:21:35 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C912122EDB;
        Wed,  1 Jul 2020 23:21:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593638492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FGEoESzqhbGl5sqazUSLjvfDz9FuASX78Vb4MriptvE=;
        b=KChSgt78CKad7hUC7OaPaa1Dk0VP0qe78AWKnYwZRcTyR/NuL5ZB3U4CYa6Yhjw4kp0RO6
        jthq7fDrc5tujgfStoE5/UJX7vdP1v2GT//HWuaLdwVgZy9Dw+idF0eV08LRZeXFdo35kk
        Wv+eQtXxwxOmSem29GKPxBIINc11siQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        arnd@arndb.de, bgolaszewski@baylibre.com,
        Michael Walle <michael@walle.cc>
Subject: [RFC PATCH] mfd: add simple regmap based I2C driver
Date:   Wed,  1 Jul 2020 23:21:00 +0200
Message-Id: <20200701212100.6020-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are I2C devices which contain several different functions but
doesn't require any special access functions. For these kind of drivers
an I2C regmap should be enough.

Create an I2C driver which creates an I2C regmap and enumerates its
children. If a device wants to use this as its MFD core driver, it has
to add an individual compatible string. It may provide its own regmap
configuration and a .pre_probe hook. The latter allows simple checks
and abort probing, for example a version check.

Subdevices can use dev_get_regmap() on the parent to get their regmap
instance.

Signed-off-by: Michael Walle <michael@walle.cc>
---

I don't think the syscon-i2c is the way to go:

   "TBC, while fine for a driver to bind on 'simple-mfd', a
    DT compatible with that alone is not fine." [1]

   "Yes, this is why specific compatible strings are
    required." [1]

   "No. I'd like to just kill off syscon and simple-mfd really. Those are
	just hints meaning a specific compatible is still needed, but I see
	them all the time alone (or combined like above). 'syscon' just serves
	to create a regmap. This could be accomplished just with a list of
	compatibles to register a regmap for. That might be a longish list, but
	wanting a regmap is really a kernel implementation detail and
	decision." [2]

So I don't get it why we would now add another syscon type. Instead, here
is a new try to generalize the idea to just have a simple driver which just
have a bunch of compatible strings for supported devices (and thus can be
added quirks to it without changing the DT) and just creates a regmap. A
simple device can just add itself to the list of compatible strings. If
quirks are needed later, they can either be added right to simple-mfd-i2c.c
or split off to an own file, but time will tell.

Right now, there is just a .pre_probe() hook which can be used to cancel
the probing of the device or print some useful info to the kernel log. Yes,
this is for "my" version check. And TBH I don't see a problem with adding
that to this generic driver.

[1] https://lore.kernel.org/linux-devicetree/CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com/
[2] https://lore.kernel.org/linux-devicetree/20200609165401.GB1019634@bogus/

 drivers/mfd/Kconfig          |  9 ++++++
 drivers/mfd/Makefile         |  1 +
 drivers/mfd/simple-mfd-i2c.c | 57 ++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 drivers/mfd/simple-mfd-i2c.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 7e72ed3441f1..96055c7e5c55 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
 	  To compile this driver as a module, choose M here: the
 	  module will be called si476x-core.
 
+config MFD_SIMPLE_MFD_I2C
+	tristate "Simple regmap based I2C devices"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  This is a consolidated driver for all MFD devices which are
+	  basically just a regmap bus driver.
+
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7e26e7f98ac2..fa3a621a5a21 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,4 +265,5 @@ obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
 
+obj-$(CONFIG_MFD_SIMPLE_MFD_I2C)	+= simple-mfd-i2c.o
 obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
new file mode 100644
index 000000000000..60708e95f1a0
--- /dev/null
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+
+struct simple_mfd_i2c_config {
+	int (*pre_probe)(struct i2c_client *i2c, struct regmap *regmap);
+	const struct regmap_config *regmap_config;
+};
+
+static const struct regmap_config simple_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int simple_mfd_i2c_probe(struct i2c_client *i2c)
+{
+	const struct regmap_config *regmap_config = &simple_regmap_config;
+	const struct simple_mfd_i2c_config *config;
+	struct regmap *regmap;
+	int ret;
+
+	config = device_get_match_data(&i2c->dev);
+
+	if (config && config->regmap_config)
+		regmap_config = config->regmap_config;
+
+	regmap = devm_regmap_init_i2c(i2c, regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (config && config->pre_probe) {
+		ret = config->pre_probe(i2c, regmap);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_platform_populate(&i2c->dev);
+}
+
+static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{}
+};
+
+static struct i2c_driver simple_mfd_i2c_driver = {
+	.probe_new = simple_mfd_i2c_probe,
+	.driver = {
+		.name = "simple-mfd-i2c",
+		.of_match_table = simple_mfd_i2c_of_match,
+	},
+};
+builtin_i2c_driver(simple_mfd_i2c_driver);
-- 
2.20.1

