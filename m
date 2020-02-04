Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008D8C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5C72084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgBDURB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:17:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:44172 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgBDURA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:17:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 12:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,403,1574150400"; 
   d="scan'208";a="219867019"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga007.jf.intel.com with ESMTP; 04 Feb 2020 12:16:57 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] mfd: constify properties in mfd_cell
Date:   Tue,  4 Feb 2020 22:16:51 +0200
Message-Id: <20200204201651.15778-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify 'struct property_entry *properties' in
mfd_cell and platform_device. It is always passed
around as a pointer const struct.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/mfd/core.h        | 2 +-
 include/linux/platform_device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..7e5ac3c00891 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -70,7 +70,7 @@ struct mfd_cell {
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-	struct property_entry *properties;
+	const struct property_entry *properties;
 
 	/*
 	 * Device Tree compatible string
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 276a03c24691..8e83c6ff140d 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -89,7 +89,7 @@ struct platform_device_info {
 		size_t size_data;
 		u64 dma_mask;
 
-		struct property_entry *properties;
+		const struct property_entry *properties;
 };
 extern struct platform_device *platform_device_register_full(
 		const struct platform_device_info *pdevinfo);
-- 
2.21.1

