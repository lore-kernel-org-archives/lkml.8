Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA67C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8A721924
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506816AbgDPQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:01:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:40294 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636404AbgDPQAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:00:42 -0400
IronPort-SDR: g/XFrmyn5GwHB/99h6aH5bxxV06mE5I3+7kN0X3X60a0RMe8qOgHfCHxQCcC+NYMrlEewS1Kg6
 yAscooNY1Yxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 09:00:37 -0700
IronPort-SDR: pDMNkWvYNHv1ubiGEOcKw/KAQTj5tzHAVB/4Q19JN+AEY6d4sLqBsaG9vLrsgh1d22eY0Z521B
 sV9XGTvo7wyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="455314877"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2020 09:00:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3FAC717F; Thu, 16 Apr 2020 19:00:31 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 0/8] thp/khugepaged improvements and CoW semantics
Date:   Thu, 16 Apr 2020 19:00:18 +0300
Message-Id: <20200416160026.16538-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds khugepaged selftest (anon-THP only for now), expands
cases khugepaged can handle and switches anon-THP copy-on-write handling
to 4k.

Please review and consider applying.

v4:
 - Rebase to v5.7-rc1;
 - Minor adjustments based on feedback: comments/messages/whitespace
 - Apply Reviewed/Acked/Tested-by;
v3:
 - Fix handling compound pages in swap cache;
 - Rework swaped vs. referenced check;
 - Fix refcounting for compound pages;
 - Drop Reviewed-by/Acked-by as patchset changed non-trivially;
 - Typos;
v2:
 - Fix race in compound page handling;
 - Add one more test-case for compound page case;
 - Rework LRU add cache draining;
 - Typos;

Kirill A. Shutemov (8):
  khugepaged: Add self test
  khugepaged: Do not stop collapse if less than half PTEs are referenced
  khugepaged: Drain all LRU caches before scanning pages
  khugepaged: Drain LRU add pagevec after swapin
  khugepaged: Allow to collapse a page shared across fork
  khugepaged: Allow to collapse PTE-mapped compound pages
  thp: Change CoW semantics for anon-THP
  khugepaged: Introduce 'max_ptes_shared' tunable

 Documentation/admin-guide/mm/transhuge.rst |   7 +
 include/trace/events/huge_memory.h         |   3 +-
 mm/huge_memory.c                           | 250 +-----
 mm/khugepaged.c                            | 220 +++--
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/khugepaged.c    | 982 +++++++++++++++++++++
 6 files changed, 1175 insertions(+), 288 deletions(-)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

-- 
2.26.1

