Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4EEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BA620732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgDMKFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:05:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:35123 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgDMKE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:04:59 -0400
IronPort-SDR: ydX+iR/p+Nx/6q+8qSDLgdCCoi30FA9B2VvtLekQFS1NdXaQ1Jy0yLLhPNI+dTDbRMHZtoG6VH
 UH2mT1suQzZQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:04:53 -0700
IronPort-SDR: Je+nfy1gBfcmk8HF5V1CwbT8pCAFbQD+LTeJsKMDvyDhT0XYupO8D525qm0iwN/yhDKZnw4aZ8
 80wrKp9FK+7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="287838816"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2020 03:04:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6BCE2DE; Mon, 13 Apr 2020 13:04:50 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>
Cc:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/6] thp/khugepaged improvements and CoW semantics
Date:   Mon, 13 Apr 2020 13:04:41 +0300
Message-Id: <20200413100447.20073-1-kirill.shutemov@linux.intel.com>
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

Kirill A. Shutemov (6):
  khugepaged: Add self test
  khugepaged: Do not stop collapse if less than half PTEs are referenced
  khugepaged: Drain all LRU caches before scanning pages
  khugepaged: Drain LRU add pagevec after swapin
  khugepaged: Allow to collapse a page shared across fork
  khugepaged: Allow to collapse PTE-mapped compound pages

 mm/khugepaged.c                         | 172 +++--
 tools/testing/selftests/vm/Makefile     |   1 +
 tools/testing/selftests/vm/khugepaged.c | 899 ++++++++++++++++++++++++
 3 files changed, 1012 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/vm/khugepaged.c

-- 
2.26.0

