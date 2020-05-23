Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05536C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4362053B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbgEWRJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:09:10 -0400
Received: from foss.arm.com ([217.140.110.172]:52938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387977AbgEWRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:09:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C5CD6E;
        Sat, 23 May 2020 10:09:08 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24F553F305;
        Sat, 23 May 2020 10:09:07 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/8] soc: realview: Switch to use DEVICE_ATTR_RO()
Date:   Sat, 23 May 2020 18:08:52 +0100
Message-Id: <20200523170859.50003-2-sudeep.holla@arm.com>
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
 drivers/soc/versatile/soc-realview.c | 40 +++++++++++-----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index 9471353dd8c3..cb3bcb7dd824 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -39,45 +39,37 @@ static const char *realview_arch_str(u32 id)
 	}
 }
 
-static ssize_t realview_get_manf(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+manufacturer_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%02x\n", realview_coreid >> 24);
 }
 
-static struct device_attribute realview_manf_attr =
-	__ATTR(manufacturer,  S_IRUGO, realview_get_manf,  NULL);
+static DEVICE_ATTR_RO(manufacturer);
 
-static ssize_t realview_get_board(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+board_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "HBI-%03x\n", ((realview_coreid >> 16) & 0xfff));
 }
 
-static struct device_attribute realview_board_attr =
-	__ATTR(board,  S_IRUGO, realview_get_board,  NULL);
+static DEVICE_ATTR_RO(board);
 
-static ssize_t realview_get_arch(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
+static ssize_t
+fpga_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%s\n", realview_arch_str(realview_coreid));
 }
 
-static struct device_attribute realview_arch_attr =
-	__ATTR(fpga,  S_IRUGO, realview_get_arch,  NULL);
+static DEVICE_ATTR_RO(fpga);
 
-static ssize_t realview_get_build(struct device *dev,
-			       struct device_attribute *attr,
-			       char *buf)
+static ssize_t
+build_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "%02x\n", (realview_coreid & 0xFF));
 }
 
-static struct device_attribute realview_build_attr =
-	__ATTR(build,  S_IRUGO, realview_get_build,  NULL);
+static DEVICE_ATTR_RO(build);
 
 static int realview_soc_probe(struct platform_device *pdev)
 {
@@ -112,10 +104,10 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
-	device_create_file(soc_device_to_device(soc_dev), &realview_manf_attr);
-	device_create_file(soc_device_to_device(soc_dev), &realview_board_attr);
-	device_create_file(soc_device_to_device(soc_dev), &realview_arch_attr);
-	device_create_file(soc_device_to_device(soc_dev), &realview_build_attr);
+	device_create_file(soc_device_to_device(soc_dev), &dev_attr_manufacturer);
+	device_create_file(soc_device_to_device(soc_dev), &dev_attr_board);
+	device_create_file(soc_device_to_device(soc_dev), &dev_attr_fpga);
+	device_create_file(soc_device_to_device(soc_dev), &dev_attr_build);
 
 	dev_info(&pdev->dev, "RealView Syscon Core ID: 0x%08x, HBI-%03x\n",
 		 realview_coreid,
-- 
2.17.1

