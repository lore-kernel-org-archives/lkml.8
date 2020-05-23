Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78DDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8457A2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgEWRJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:09:18 -0400
Received: from foss.arm.com ([217.140.110.172]:52986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbgEWRJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:09:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB4112FC;
        Sat, 23 May 2020 10:09:12 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A4E43F305;
        Sat, 23 May 2020 10:09:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/8] soc: ux500: Switch to use DEVICE_ATTR_RO()
Date:   Sat, 23 May 2020 18:08:56 +0100
Message-Id: <20200523170859.50003-6-sudeep.holla@arm.com>
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
 drivers/soc/ux500/ux500-soc-id.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/ux500/ux500-soc-id.c b/drivers/soc/ux500/ux500-soc-id.c
index d64feeb51a40..55ceb67e066b 100644
--- a/drivers/soc/ux500/ux500-soc-id.c
+++ b/drivers/soc/ux500/ux500-soc-id.c
@@ -146,9 +146,8 @@ static const char * __init ux500_get_revision(void)
 	return kasprintf(GFP_KERNEL, "%s", "Unknown");
 }
 
-static ssize_t ux500_get_process(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
+static ssize_t
+process_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	if (dbx500_id.process == 0x00)
 		return sprintf(buf, "Standard\n");
@@ -156,6 +155,8 @@ static ssize_t ux500_get_process(struct device *dev,
 	return sprintf(buf, "%02xnm\n", dbx500_id.process);
 }
 
+static DEVICE_ATTR_RO(process);
+
 static const char *db8500_read_soc_id(struct device_node *backupram)
 {
 	void __iomem *base;
@@ -186,9 +187,6 @@ static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
 	soc_dev_attr->revision = ux500_get_revision();
 }
 
-static const struct device_attribute ux500_soc_attr =
-	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
-
 static int __init ux500_soc_device_init(void)
 {
 	struct device *parent;
@@ -218,7 +216,7 @@ static int __init ux500_soc_device_init(void)
 	}
 
 	parent = soc_device_to_device(soc_dev);
-	device_create_file(parent, &ux500_soc_attr);
+	device_create_file(parent, &dev_attr_process);
 
 	return 0;
 }
-- 
2.17.1

