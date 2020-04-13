Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CBEC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC9FA20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgDMMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:52:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:52670 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgDMMwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:52:25 -0400
IronPort-SDR: Ua7wDtM//lN6TyRDR2rF/yhYfguyL6GK/xC5LT/8hIMcn1oyT+lF7qCrmuubLJGQ8OiNHydDdi
 +9bq3puhydoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 05:52:24 -0700
IronPort-SDR: Lq4QaAwH4EgBZArwqec40Z/ctUZa6H/5OVIGS2gLNbJjK0L9MVK6hLmKn85d06sxaVRG8lBWDx
 WqqWdRnF58Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="245132796"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2020 05:52:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B8E9EDE; Mon, 13 Apr 2020 15:52:21 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3, RESEND 0/8] thp/khugepaged improvements and CoW semantics
Date:   Mon, 13 Apr 2020 15:52:12 +0300
Message-Id: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
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
 mm/huge_memory.c                           | 249 +-----
 mm/khugepaged.c                            | 218 +++--
 tools/testing/selftests/vm/Makefile        |   1 +
 tools/testing/selftests/vm/khugepaged.c    | 982 +++++++++++++++++++++
 6 files changed, 1174 insertions(+), 286 deletions(-)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

-- 
2.26.0

