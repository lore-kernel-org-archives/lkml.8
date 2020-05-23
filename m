Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CAAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1220738
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgEWRJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:52974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388004AbgEWRJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:09:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5652B11FB;
        Sat, 23 May 2020 10:09:11 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7266A3F305;
        Sat, 23 May 2020 10:09:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/8] soc: integrator: Use custom soc attribute group instead of device_create_file
Date:   Sat, 23 May 2020 18:08:55 +0100
Message-Id: <20200523170859.50003-5-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200523170859.50003-1-sudeep.holla@arm.com>
References: <20200523170859.50003-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c31e73121f4c ("base: soc: Handle custom soc information sysfs
entries") introduced custom soc attribute group in soc_device_attribute
structure but there are no users treewide. While trying to understand
the motivation and tried to use it, it was found lot of existing custom
attributes can moved to use it instead of device_create_file.

Though most of these never remove/cleanup the custom attribute as they
never call soc_device_unregister, using these custom attribute group
eliminate the need for any cleanup as the driver infrastructure will
take care of that.

Let us remove device_create_file and start using the custom attribute
group in soc_device_attribute.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/versatile/soc-integrator.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index 8ba98b3b4e8e..7dcf77ccd31e 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -88,6 +88,16 @@ build_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 static DEVICE_ATTR_RO(build);
 
+static struct attribute *integrator_attrs[] = {
+	&dev_attr_manufacturer.attr,
+	&dev_attr_arch.attr,
+	&dev_attr_fpga.attr,
+	&dev_attr_build.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(integrator);
+
 static int __init integrator_soc_init(void)
 {
 	static struct regmap *syscon_regmap;
@@ -119,6 +129,7 @@ static int __init integrator_soc_init(void)
 	soc_dev_attr->soc_id = "Integrator";
 	soc_dev_attr->machine = "Integrator";
 	soc_dev_attr->family = "Versatile";
+	soc_dev_attr->custom_attr_group = integrator_groups[0];
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		kfree(soc_dev_attr);
@@ -126,11 +137,6 @@ static int __init integrator_soc_init(void)
 	}
 	dev = soc_device_to_device(soc_dev);
 
-	device_create_file(dev, &dev_attr_manufacturer);
-	device_create_file(dev, &dev_attr_arch);
-	device_create_file(dev, &dev_attr_fpga);
-	device_create_file(dev, &dev_attr_build);
-
 	dev_info(dev, "Detected ARM core module:\n");
 	dev_info(dev, "    Manufacturer: %02x\n", (val >> 24));
 	dev_info(dev, "    Architecture: %s\n", integrator_arch_str(val));
-- 
2.17.1

