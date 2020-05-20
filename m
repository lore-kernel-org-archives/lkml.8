Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D61207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETKaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:30:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:29393 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgETKaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:30:08 -0400
IronPort-SDR: KZrtG0XJyT31nGFDfahxvuh59l0rpThbG5bCovmsEnjqWB770L+C2/r9UqUIXOl+R8hUIBYwpH
 Ak9nORPpzSVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:30:04 -0700
IronPort-SDR: zB7UAGtXmOqSB9pbiZQ0fato3STNm567WdPr8rk3xAUSFpchwt6s7EhzXDd12+c3TElKTOhqQJ
 f21PqY+1ez3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="253636154"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 20 May 2020 03:30:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0E66994; Wed, 20 May 2020 13:30:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] drivers property: When no children in primary, try secondary
Date:   Wed, 20 May 2020 13:29:59 +0300
Message-Id: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software firmware nodes can provide a child node to its parent.
Since software node can be secondary, we need a mechanism to access
the children. The idea is to list children of the primary node first
and when they are finished, continue with secondary node if available.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 5f35c0ccf5e0..1e6d75e65938 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -708,14 +708,23 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 						 struct fwnode_handle *child)
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
-	struct fwnode_handle *fwnode = NULL;
+	struct fwnode_handle *fwnode = NULL, *next;
 
 	if (dev->of_node)
 		fwnode = &dev->of_node->fwnode;
 	else if (adev)
 		fwnode = acpi_fwnode_handle(adev);
 
-	return fwnode_get_next_child_node(fwnode, child);
+	/* Try to find a child in primary fwnode */
+	next = fwnode_get_next_child_node(fwnode, child);
+	if (next)
+		return next;
+
+	/* When no more children in primary, continue with secondary */
+	if (!IS_ERR_OR_NULL(fwnode->secondary))
+		next = fwnode_get_next_child_node(fwnode->secondary, child);
+
+	return next;
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
-- 
2.26.2

