Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E2D20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHSSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:46:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:45245 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgHSSqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:46:37 -0400
IronPort-SDR: 1Pt1KSvK1MDVVu7g8k+5NHse/g/Mo/ImBXKLdsgfPR3r287hcxv7bvi/RnJqxrAaBDZhLIMzaC
 kHHjqsRFIygw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="173228504"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="173228504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:46:37 -0700
IronPort-SDR: ShbvnrbxkE77kMqrMHLfmvz1a61Ot9qOqUVuu8SjJXc/kO7gOj5EmtpWY4P69YfL8zlUhy6kmV
 IYRMI4Mp7Apg==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="472339351"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 11:46:36 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/highmem: Clean up endif comments
Date:   Wed, 19 Aug 2020 11:46:35 -0700
Message-Id: <20200819184635.112579-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The #endif at the end of the file matches up with the '#if
defined(HASHED_PAGE_VIRTUAL)' on line 374.  Not the CONFIG_HIGHMEM #if
earlier.

Fix comments on both of the #endif's to indicate the correct end of
blocks for each.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/highmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 64d8dea47dd1..1352a27951e3 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -369,7 +369,7 @@ void kunmap_high(struct page *page)
 }
 
 EXPORT_SYMBOL(kunmap_high);
-#endif
+#endif	/* CONFIG_HIGHMEM */
 
 #if defined(HASHED_PAGE_VIRTUAL)
 
@@ -481,4 +481,4 @@ void __init page_address_init(void)
 	}
 }
 
-#endif	/* defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL) */
+#endif	/* defined(HASHED_PAGE_VIRTUAL) */
-- 
2.25.1

