Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF57C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483DF2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgDMMw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:52:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:52670 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgDMMw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:52:26 -0400
IronPort-SDR: Jw5lZlABpWM74rSQrb/DSdR5A4+YDTg/lh7dVZaj+LaAsx9MKkiRqxxSMzcOzWohmBBM3tUl23
 Jw/C1ARtO8MQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 05:52:24 -0700
IronPort-SDR: uX4ABe3J8BFw6CE0XOBP3vQpTRfwCI32Qtsy2kGMt35MgULzu1PHKCGCxZoIBH1G+5mttR3MGv
 gWMt1s4i+C7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="245132797"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2020 05:52:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id DE69A1A5; Mon, 13 Apr 2020 15:52:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3, RESEND 3/8] khugepaged: Drain all LRU caches before scanning pages
Date:   Mon, 13 Apr 2020 15:52:15 +0300
Message-Id: <20200413125220.663-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
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
---
 mm/khugepaged.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5968ec5ddd6b..ee66c140c2d6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2059,6 +2059,8 @@ static void khugepaged_do_scan(void)
 
 	barrier(); /* write khugepaged_pages_to_scan to local stack */
 
+	lru_add_drain_all();
+
 	while (progress < pages) {
 		if (!khugepaged_prealloc_page(&hpage, &wait))
 			break;
-- 
2.26.0

