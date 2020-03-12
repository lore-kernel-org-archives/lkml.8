Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A79206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCLSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:32:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:1957 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCLSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:32:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="444038375"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 12 Mar 2020 11:32:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 26B94339; Thu, 12 Mar 2020 20:32:46 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] regulator: core: Avoid device name duplication in NORMAL_GET
Date:   Thu, 12 Mar 2020 20:32:45 +0200
Message-Id: <20200312183245.1612-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With current code:
	st-gyro-i2c i2c-PRP0001:00: i2c-PRP0001:00 supply vdd not found, using dummy regulator

which looks a bit oververbose.

Replace this with simplified format string for the above case, and drop
"deviceless" case since for all dev_*() macros used in _regulator_get()
the "(null)" will be printed anyway.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/regulator/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index d015d99cb59d..7486f6e4e613 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1849,7 +1849,6 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 {
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
-	const char *devname = dev ? dev_name(dev) : "deviceless";
 	struct device_link *link;
 	int ret;
 
@@ -1887,9 +1886,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev,
-				 "%s supply %s not found, using dummy regulator\n",
-				 devname, id);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
 			get_device(&rdev->dev);
 			break;
-- 
2.25.1

