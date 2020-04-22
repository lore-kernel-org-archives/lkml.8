Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C9FC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59C82075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551180;
	bh=SkYy+KuoP2SP8ufyYCYQvRtjgVmVX+j4n9Gx1vxC/lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wzon3OJYqFNwAkji1da9D40AKtPMKK9oF8czWEbutfdhRREJnQHiMcJQa20sd4sq2
	 +yFHJ1FLY7ggzOFX6IT1+l2osWcSJPzqr6WlS9EPU7j+wpseO8usLCOPVFPGCEVDwY
	 mDovaPyDdWyvJLRU8eA1Cnpei/xR4/BljBSL983M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgDVK0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730696AbgDVK0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E4E2075A;
        Wed, 22 Apr 2020 10:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551175;
        bh=SkYy+KuoP2SP8ufyYCYQvRtjgVmVX+j4n9Gx1vxC/lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyNw6HsEeSrAfj13qoAnFJSq+cLg4cB4jX247tuIVSOfHjs9JTzlZ5xwnv4K8EnrO
         krR8fDMyS+WSk95qHTG6j6EWMytqYCAmCwMhP9VIC8vW1JwFL0fLwbQeHuqWxGimt9
         ueV3iHgwZXBGdyMCCIwmJViki99hE8skAFlmA1aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 114/166] ACPI: Update Tiger Lake ACPI device IDs
Date:   Wed, 22 Apr 2020 11:57:21 +0200
Message-Id: <20200422095100.939845685@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gayatri Kammela <gayatri.kammela@intel.com>

[ Upstream commit b62c770fee699a137359e1f1da9bf14a7f348567 ]

Tiger Lake's new unique ACPI device IDs for DPTF and fan drivers are not
valid as the IDs are missing 'C'. Fix the IDs by updating them.

After the update, the new IDs should now look like
INT1047 --> INTC1047
INT1040 --> INTC1040
INT1043 --> INTC1043
INT1044 --> INTC1044

Fixes: 55cfe6a5c582 ("ACPI: DPTF: Add Tiger Lake ACPI device IDs")
Fixes: c248dfe7e0ca ("ACPI: fan: Add Tiger Lake ACPI device ID")
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/device_pm.c            | 2 +-
 drivers/acpi/dptf/dptf_power.c      | 2 +-
 drivers/acpi/dptf/int340x_thermal.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index b64c62bfcea56..b2263ec67b432 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1321,8 +1321,8 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	 */
 	static const struct acpi_device_id special_pm_ids[] = {
 		{"PNP0C0B", }, /* Generic ACPI fan */
-		{"INT1044", }, /* Fan for Tiger Lake generation */
 		{"INT3404", }, /* Fan */
+		{"INTC1044", }, /* Fan for Tiger Lake generation */
 		{}
 	};
 	struct acpi_device *adev = ACPI_COMPANION(dev);
diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 387f27ef3368b..e4e8b75d39f09 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -97,8 +97,8 @@ static int dptf_power_remove(struct platform_device *pdev)
 }
 
 static const struct acpi_device_id int3407_device_ids[] = {
-	{"INT1047", 0},
 	{"INT3407", 0},
+	{"INTC1047", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int340x_thermal.c
index 1ec7b6900662c..bc71a6a603345 100644
--- a/drivers/acpi/dptf/int340x_thermal.c
+++ b/drivers/acpi/dptf/int340x_thermal.c
@@ -13,10 +13,6 @@
 
 #define INT3401_DEVICE 0X01
 static const struct acpi_device_id int340x_thermal_device_ids[] = {
-	{"INT1040"},
-	{"INT1043"},
-	{"INT1044"},
-	{"INT1047"},
 	{"INT3400"},
 	{"INT3401", INT3401_DEVICE},
 	{"INT3402"},
@@ -28,6 +24,10 @@ static const struct acpi_device_id int340x_thermal_device_ids[] = {
 	{"INT3409"},
 	{"INT340A"},
 	{"INT340B"},
+	{"INTC1040"},
+	{"INTC1043"},
+	{"INTC1044"},
+	{"INTC1047"},
 	{""},
 };
 
-- 
2.20.1



