Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B313C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2243120882
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgDVM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:28:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgDVM2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:28:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F6431B;
        Wed, 22 Apr 2020 05:28:35 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FA3D3F6CF;
        Wed, 22 Apr 2020 05:28:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        James Morse <james.morse@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_sdei: Drop check for /firmware/ node and always register driver
Date:   Wed, 22 Apr 2020 13:28:23 +0100
Message-Id: <20200422122823.1390-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As with most of the drivers, let us register this driver unconditionally
by dropping the checks for presence of firmware nodes(DT) or entries(ACPI).

Further, as mentioned in the commit acafce48b07b ("firmware: arm_sdei:
Fix DT platform device creation"), the core takes care of creation of
platform device when the appropriate device node is found and probe
is called accordingly.

Let us check only for the presence of ACPI firmware entry before creating
the platform device and flag warning if we fail.

Cc: James Morse <james.morse@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_sdei.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 334c8be0c11f..5afd7409e6fa 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -1079,26 +1079,9 @@ static struct platform_driver sdei_driver = {
 	.probe		= sdei_probe,
 };
 
-static bool __init sdei_present_dt(void)
-{
-	struct device_node *np, *fw_np;
-
-	fw_np = of_find_node_by_name(NULL, "firmware");
-	if (!fw_np)
-		return false;
-
-	np = of_find_matching_node(fw_np, sdei_of_match);
-	if (!np)
-		return false;
-	of_node_put(np);
-
-	return true;
-}
-
 static bool __init sdei_present_acpi(void)
 {
 	acpi_status status;
-	struct platform_device *pdev;
 	struct acpi_table_header *sdei_table_header;
 
 	if (acpi_disabled)
@@ -1113,20 +1096,24 @@ static bool __init sdei_present_acpi(void)
 	if (ACPI_FAILURE(status))
 		return false;
 
-	pdev = platform_device_register_simple(sdei_driver.driver.name, 0, NULL,
-					       0);
-	if (IS_ERR(pdev))
-		return false;
-
 	return true;
 }
 
 static int __init sdei_init(void)
 {
-	if (sdei_present_dt() || sdei_present_acpi())
-		platform_driver_register(&sdei_driver);
+	int ret = platform_driver_register(&sdei_driver);
 
-	return 0;
+	if (!ret && sdei_present_acpi()) {
+		struct platform_device *pdev;
+
+		pdev = platform_device_register_simple(sdei_driver.driver.name,
+						       0, NULL, 0);
+		if (IS_ERR(pdev))
+			pr_info("Failed to register ACPI:SDEI platform device %ld\n",
+				PTR_ERR(pdev));
+	}
+
+	return ret;
 }
 
 /*
-- 
2.17.1

