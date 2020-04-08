Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C94C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B651206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgDHQJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:09:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:19689 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbgDHQJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:32 -0400
IronPort-SDR: kFDoxaIZ/2f9Q+PxtExE0FCYZl4lLy7ipTaNPreSfkgAcdLVwj96SsqeuxFNfMR8NgsSzpTgAw
 mx1l1Hchh9kA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 09:09:31 -0700
IronPort-SDR: 0xnsWG9+GamSf+vIJR9WAIvUHXFcraF1Xi4ECGr6HdYkbWcLRNeJ6bNwWjBWNBpi0mGiga0wGG
 FVzwli885rWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="275491714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2020 09:09:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A02B87C6; Wed,  8 Apr 2020 19:09:25 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/6] platform/x86: intel_cht_int33fe: Switch to use acpi_dev_hid_uid_match()
Date:   Wed,  8 Apr 2020 19:09:05 +0300
Message-Id: <20200408160905.12101-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe_typec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe_typec.c b/drivers/platform/x86/intel_cht_int33fe_typec.c
index 904e75d39953..e89defb33067 100644
--- a/drivers/platform/x86/intel_cht_int33fe_typec.c
+++ b/drivers/platform/x86/intel_cht_int33fe_typec.c
@@ -40,16 +40,13 @@ static int cht_int33fe_check_for_max17047(struct device *dev, void *data)
 {
 	struct i2c_client **max17047 = data;
 	struct acpi_device *adev;
-	const char *hid;
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
 		return 0;
 
-	hid = acpi_device_hid(adev);
-
 	/* The MAX17047 ACPI node doesn't have an UID, so we don't check that */
-	if (strcmp(hid, "MAX17047"))
+	if (!acpi_dev_hid_uid_match(adev, "MAX17047", NULL))
 		return 0;
 
 	*max17047 = to_i2c_client(dev);
-- 
2.25.1

