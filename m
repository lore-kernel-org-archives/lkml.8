Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADE2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D162053B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgEWRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:09:17 -0400
Received: from foss.arm.com ([217.140.110.172]:52966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387997AbgEWRJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:09:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E72B113E;
        Sat, 23 May 2020 10:09:10 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58B863F305;
        Sat, 23 May 2020 10:09:09 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/8] soc: integrator: Switch to use DEVICE_ATTR_RO()
Date:   Sat, 23 May 2020 18:08:54 +0100
Message-Id: <20200523170859.50003-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200523170859.50003-1-sudeep.holla@arm.com>
References: <20200523170859.50003-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move device attributes to DEVICE_ATTR_RO() as that would make things
a lot more "obvious" what is happening over the existing __ATTR usage.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/soc/versatile/soc-integrator.c | 40 +++++++++++---------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/versatile/soc-integrator.c b/drivers/soc/versatile/soc-integrator.c
index ae13fa2aa582..8ba98b3b4e8e 100644
--- a/drivers/soc/versatile/soc-integrator.c
+++ b/drivers/soc/versatile/soc-integrator.c
@@ -56,45 +56,37 @@ static const char *integrator_fpga_str(u32 id)
 	}
 }
 
-static ssize_t integrator_get_manf(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+manufacturer_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%02x\n", integrator_coreid >> 24);
 }
 
-static struct device_attribute integrator_manf_attr =
-	__ATTR(manufacturer,  S_IRUGO, integrator_get_manf,  NULL);
+static DEVICE_ATTR_RO(manufacturer);
 
-static ssize_t integrator_get_arch(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+arch_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", integrator_arch_str(integrator_coreid));
 }
 
-static struct device_attribute integrator_arch_attr =
-	__ATTR(arch,  S_IRUGO, integrator_get_arch,  NULL);
+static DEVICE_ATTR_RO(arch);
 
-static ssize_t integrator_get_fpga(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+fpga_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", integrator_fpga_str(integrator_coreid));
 }
 
-static struct device_attribute integrator_fpga_attr =
-	__ATTR(fpga,  S_IRUGO, integrator_get_fpga,  NULL);
+static DEVICE_ATTR_RO(fpga);
 
-static ssize_t integrator_get_build(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t
+build_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%02x\n", (integrator_coreid >> 4) & 0xFF);
 }
 
-static struct device_attribute integrator_build_attr =
-	__ATTR(build,  S_IRUGO, integrator_get_build,  NULL);
+static DEVICE_ATTR_RO(build);
 
 static int __init integrator_soc_init(void)
 {
@@ -134,10 +126,10 @@ static int __init integrator_soc_init(void)
 	}
 	dev = soc_device_to_device(soc_dev);
 
-	device_create_file(dev, &integrator_manf_attr);
-	device_create_file(dev, &integrator_arch_attr);
-	device_create_file(dev, &integrator_fpga_attr);
-	device_create_file(dev, &integrator_build_attr);
+	device_create_file(dev, &dev_attr_manufacturer);
+	device_create_file(dev, &dev_attr_arch);
+	device_create_file(dev, &dev_attr_fpga);
+	device_create_file(dev, &dev_attr_build);
 
 	dev_info(dev, "Detected ARM core module:\n");
 	dev_info(dev, "    Manufacturer: %02x\n", (val >> 24));
-- 
2.17.1

