Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572B6207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgGHQMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:12:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:45949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgGHQMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:12:40 -0400
IronPort-SDR: BkoI7E0U9FsmcSwErJvWktvBNDgy5DYO2S6tcTrY/DK0kSMnCQ1UfK+YcK+X8KSHnqCyEVFNcz
 flpKduB5XfpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="149347436"
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="149347436"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 09:12:40 -0700
IronPort-SDR: 7OQdnSn0i/jg5bNMTBL0fUlP0GeQFtfVhMZ8eEQEjXCww4Am2hQ+tWWri4pcE9d5QQSkP0CxlW
 3XYyxQP7KMwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="279998707"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2020 09:12:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AD0D621D; Wed,  8 Jul 2020 19:12:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] regmap: Switch to use fwnode instead of OF one
Date:   Wed,  8 Jul 2020 19:12:32 +0300
Message-Id: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make regmap firmware node type agnostic by switching it to use fwnode.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index aa4c8f5dc6e5..e93700af7e6e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -11,7 +11,7 @@
 #include <linux/export.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
@@ -631,7 +631,7 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 					 const struct regmap_bus *bus,
 					 const struct regmap_config *config)
 {
-	struct device_node *np;
+	struct fwnode_handle *fwnode = dev ? dev_fwnode(dev) : NULL;
 	enum regmap_endian endian;
 
 	/* Retrieve the endianness specification from the regmap config */
@@ -641,22 +641,17 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 	if (endian != REGMAP_ENDIAN_DEFAULT)
 		return endian;
 
-	/* If the dev and dev->of_node exist try to get endianness from DT */
-	if (dev && dev->of_node) {
-		np = dev->of_node;
-
-		/* Parse the device's DT node for an endianness specification */
-		if (of_property_read_bool(np, "big-endian"))
-			endian = REGMAP_ENDIAN_BIG;
-		else if (of_property_read_bool(np, "little-endian"))
-			endian = REGMAP_ENDIAN_LITTLE;
-		else if (of_property_read_bool(np, "native-endian"))
-			endian = REGMAP_ENDIAN_NATIVE;
-
-		/* If the endianness was specified in DT, use that */
-		if (endian != REGMAP_ENDIAN_DEFAULT)
-			return endian;
-	}
+	/* If the firmware node exist try to get endianness from it */
+	if (fwnode_property_read_bool(fwnode, "big-endian"))
+		endian = REGMAP_ENDIAN_BIG;
+	else if (fwnode_property_read_bool(fwnode, "little-endian"))
+		endian = REGMAP_ENDIAN_LITTLE;
+	else if (fwnode_property_read_bool(fwnode, "native-endian"))
+		endian = REGMAP_ENDIAN_NATIVE;
+
+	/* If the endianness was specified in fwnode, use that */
+	if (endian != REGMAP_ENDIAN_DEFAULT)
+		return endian;
 
 	/* Retrieve the endianness specification from the bus config */
 	if (bus && bus->val_format_endian_default)
-- 
2.27.0

