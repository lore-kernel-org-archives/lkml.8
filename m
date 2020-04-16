Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48704C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FADE217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636434AbgDPQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:00:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:3424 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636277AbgDPQAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:00:35 -0400
IronPort-SDR: 2J/wh0wIYCWhf1Z3/MN9OyYEsauFVWT+IGGEObuZbs4Gk8S0kQAEJ0qJIPKnLMbW34khj0HzaH
 r/yDaUYdHP/g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:00:34 -0700
IronPort-SDR: yJ088btDTNzvL2Vk+437eBGYkoQC6+Yjz9Cn9GhybEUCWIdcrHcHY50kSJYiYLPX0Jz26guHFd
 pOsjAGTMZEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="278039807"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2020 09:00:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 72AAF190; Thu, 16 Apr 2020 19:00:31 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 4/8] khugepaged: Drain LRU add pagevec after swapin
Date:   Thu, 16 Apr 2020 19:00:22 +0300
Message-Id: <20200416160026.16538-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
References: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
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
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-and-Tested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/khugepaged.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0b75b9821f44..adc686f13447 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -931,6 +931,11 @@ static bool __collapse_huge_page_swapin(struct mm_struct *mm,
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
2.26.1

