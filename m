Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C49C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27BD21D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCIOLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:11:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:42087 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgCIOLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:11:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 07:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="234022108"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 07:11:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1566DBD; Mon,  9 Mar 2020 16:11:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] driver core: Read atomic counter once in driver_probe_done()
Date:   Mon,  9 Mar 2020 16:11:10 +0200
Message-Id: <20200309141111.40576-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
References: <20200309141111.40576-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between printing the debug message and actual check atomic counter can be
altered. For better debugging experience read atomic counter value only once.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 43720beb5300..efd0e4c16ba5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -669,9 +669,10 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
  */
 int driver_probe_done(void)
 {
-	pr_debug("%s: probe_count = %d\n", __func__,
-		 atomic_read(&probe_count));
-	if (atomic_read(&probe_count))
+	int local_probe_count = atomic_read(&probe_count);
+
+	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
+	if (local_probe_count)
 		return -EBUSY;
 	return 0;
 }
-- 
2.25.1

