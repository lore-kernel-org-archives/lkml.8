Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88036C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615602074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgGPS1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:27:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:55268 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728257AbgGPS1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:27:51 -0400
IronPort-SDR: G2ooN01Zq3VTPf79Jys6AN7XDdH7CW/zD024+rC3C/SRrJWncq8S3ypiSum99m5keWT0C7eogJ
 MTSw5JH6wT0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="149454795"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="149454795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 11:27:51 -0700
IronPort-SDR: ZeF3lmPbAjYWGKZYcz7CEgBMC80GoW81Fg8YqSIKbPcHLvOKdeN/BACXNedMlhI5ceTum1GfNn
 2YaYGZWFPNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="326606341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2020 11:27:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A2CC3190; Thu, 16 Jul 2020 21:27:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v1] device property: Avoid NULL pointer dereference in device_get_next_child_node()
Date:   Thu, 16 Jul 2020 21:27:47 +0300
Message-Id: <20200716182747.54929-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have no primary fwnode or when it's a software node, we may end up
in the situation when fwnode is a NULL pointer. There is no point to look for
secondary fwnode in such case. Add a necessary check to a condition.

Fixes: 114dbb4fa7c4 ("drivers property: When no children in primary, try secondary")
Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1e6d75e65938..d58aa98fe964 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -721,7 +721,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	if (!IS_ERR_OR_NULL(fwnode->secondary))
+	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
 		next = fwnode_get_next_child_node(fwnode->secondary, child);
 
 	return next;
-- 
2.27.0

