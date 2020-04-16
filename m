Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE90AC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9468217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636500AbgDPQBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:45354 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636422AbgDPQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:00:45 -0400
IronPort-SDR: jcXLGTVjmxAyTXmYWpPDwPgGM1Xg3XC5Mc32WntXdEY7MD+X3TOP2hIAdXXRPIdMMfAHYzpQ0i
 HwzZFKFivLBw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:00:35 -0700
IronPort-SDR: NQIcM0V3MN2Fg/uMznKWIBC3Pdni5h6eJawVvQTVFnCw969sy6vJ89vFVR2vHDLDK2HEGxPdqE
 rqdqI2AvGKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="454377398"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Apr 2020 09:00:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6B6F249F; Thu, 16 Apr 2020 19:00:31 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 3/8] khugepaged: Drain all LRU caches before scanning pages
Date:   Thu, 16 Apr 2020 19:00:21 +0300
Message-Id: <20200416160026.16538-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
References: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a page in LRU add cache offsets page refcount and gives
false-negative on PageLRU(). It reduces collapse success rate.

Drain all LRU add caches before scanning. It happens relatively
rare and should not disturb the system too much.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-and-Tested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6e69dc9a9fb1..0b75b9821f44 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2078,6 +2078,8 @@ static void khugepaged_do_scan(void)
 
 	barrier(); /* write khugepaged_pages_to_scan to local stack */
 
+	lru_add_drain_all();
+
 	while (progress < pages) {
 		if (!khugepaged_prealloc_page(&hpage, &wait))
 			break;
-- 
2.26.1

