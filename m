Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D37DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FC520786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHZKpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:45:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:61567 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHZKpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:45:02 -0400
IronPort-SDR: y6OILM9SfWEZQPyhFfdwMYSeqvYyHumZLtJ6bo+wgGnXchXII0Rr44PwCqC9hEVHkL1PHg0Y4N
 ejo6PJuLVpkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="143931319"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="143931319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 03:45:02 -0700
IronPort-SDR: GtlAWxchxD7gAbR+1HW3OAcLgKEfphqrT8SYlku9jUeHltx6H3qcywJnsiqhYebyChppN5R8dw
 P3YHVCMp5yVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="403027212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Aug 2020 03:45:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1E5EE352; Wed, 26 Aug 2020 13:45:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] driver core: Annotate dev_err_probe() with __must_check
Date:   Wed, 26 Aug 2020 13:44:59 +0300
Message-Id: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have got already new users of this API which interpret it differently
and miss the opportunity to optimize their code.

In order to avoid similar cases in the future, annotate dev_err_probe()
with __must_check.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ca18da4768e3..f9d2e5703bbf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -978,7 +978,7 @@ void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
 extern __printf(3, 4)
-int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
+int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
-- 
2.28.0

