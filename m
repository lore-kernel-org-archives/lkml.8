Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B757C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF41204EA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgFIOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:05:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:57106 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgFIOFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:05:38 -0400
IronPort-SDR: P4agx8Etbv25GxfHcwGvqnOu95nQHxY1bF7mjWV8oVcgKcLNG7Kn5VDeW6kH/sET7nLauEQFqP
 WK8u4ezfMljg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 07:05:38 -0700
IronPort-SDR: CdI5D4+gZ52zQLqN69VUXlyu98fE1ky9QLWqVmoOs/Gxn8PSf0aTQqt56kWmOwFW2pg7238vna
 ov2ozhwksyzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,492,1583222400"; 
   d="scan'208";a="418415438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 09 Jun 2020 07:05:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B0866182; Tue,  9 Jun 2020 17:05:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, yury.norov@gmail.com,
        agordeev@linux.ibm.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/bitmap: Convert infinite while loop to for one
Date:   Tue,  9 Jun 2020 17:05:35 +0300
Message-Id: <20200609140535.87160-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert infinite while loop to for one in order to be more explicit
in one place what we are doing with chunks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Andrew, this can be folded to the fix

 lib/bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 10f8fa0497e3..03ef42fbe658 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -740,10 +740,10 @@ int bitmap_parse(const char *start, unsigned int buflen,
 	const char *end = strnchrnul(start, buflen, '\n') - 1;
 	int chunks = BITS_TO_U32(nmaskbits);
 	u32 *bitmap = (u32 *)maskp;
-	int chunk = 0;
 	int unset_bit;
+	int chunk;
 
-	while (1) {
+	for (chunk = 0; ; chunk++) {
 		end = bitmap_find_region_reverse(start, end);
 		if (start > end)
 			break;
@@ -758,7 +758,6 @@ int bitmap_parse(const char *start, unsigned int buflen,
 #endif
 		if (IS_ERR(end))
 			return PTR_ERR(end);
-		chunk++;
 	}
 
 	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
-- 
2.27.0.rc2

