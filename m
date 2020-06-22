Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4908420706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFVIVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:21:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:17498 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgFVIVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:21:13 -0400
IronPort-SDR: Z0ub+nEzRa1sJl/QzVKmJLdWLnXyF1ML/qJPGqiggccsGrtSySAI+HJ5AIUGm5RUHCuASSXe/i
 JUwi89sIjsvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="205175379"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="205175379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 01:21:12 -0700
IronPort-SDR: lgXUlVcfPPhCCYk4XrI6ebEkoEcFaxWXyendV0kAb4z4WPfx1WJA40Z4OUGsSg8IRUUdL1JudK
 gtHrl/iuAfgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="310853612"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jun 2020 01:21:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01692130; Mon, 22 Jun 2020 11:21:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] software node: Use software_node_unregister() when unregistering group of nodes
Date:   Mon, 22 Jun 2020 11:21:08 +0300
Message-Id: <20200622082108.25577-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit
  46d26819a505 ("software node: implement software_node_unregister()")
has been applied a new helper appears that may be utilised in other places.
For time being there is one such place, i.e. in
software_node_unregister_node_group() which will benefit of the clean up.

Use software_node_unregister() when unregistering group of nodes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/swnode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index e5eb27375416..010828fc785b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -761,17 +761,13 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  */
 void software_node_unregister_node_group(const struct software_node **node_group)
 {
-	struct swnode *swnode;
 	unsigned int i;
 
 	if (!node_group)
 		return;
 
-	for (i = 0; node_group[i]; i++) {
-		swnode = software_node_to_swnode(node_group[i]);
-		if (swnode)
-			fwnode_remove_software_node(&swnode->fwnode);
-	}
+	for (i = 0; node_group[i]; i++)
+		software_node_unregister(node_group[i]);
 }
 EXPORT_SYMBOL_GPL(software_node_unregister_node_group);
 
-- 
2.27.0

