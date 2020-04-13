Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2717CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgDMKFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:05:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:63632 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgDMKFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:05:00 -0400
IronPort-SDR: QP2UIeRApfJdQUy26JJze3qxxFM1/jBLGZk8rRNVUme66CeRzTDCFIPkKekIdI022okenRnd7u
 wfOJrRArQASg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:04:54 -0700
IronPort-SDR: n8PBSwTUDigaajs2PeudinO86a5TZgFJJ1s8S6JJnX8rkBPQxXXZyCA+YNpQ7WJmwUXQ7sLzSU
 c9hZYXniHjeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="426640499"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2020 03:04:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9EFFF1B4; Mon, 13 Apr 2020 13:04:50 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 4/6] khugepaged: Drain LRU add pagevec after swapin
Date:   Mon, 13 Apr 2020 13:04:45 +0300
Message-Id: <20200413100447.20073-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
References: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__collapse_huge_page_isolate() may fail due to extra pin in the LRU add
pagevec. It's pretty common for swapin case: we swap in pages just to
fail due to the extra pin.

Drain LRU add pagevec on successful swapin.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ee66c140c2d6..e3e41c2768d8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -934,6 +934,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
 	}
 	vmf.pte--;
 	pte_unmap(vmf.pte);
+
+	/* Drain LRU add pagevec to remove extra pin on the swapped in pages */
+	if (swapped_in)
+		lru_add_drain();
+
 	trace_mm_collapse_huge_page_swapin(mm, swapped_in, referenced, 1);
 	return true;
 }
-- 
2.26.0

