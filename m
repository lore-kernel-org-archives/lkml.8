Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ACC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371BA2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgAQXXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:23:02 -0500
Received: from mga02.intel.com ([134.134.136.20]:65054 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbgAQXXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:23:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:23:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="373800922"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2020 15:23:00 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        aneesh.kumar@linux.ibm.com, kirill@shutemov.name,
        yang.shi@linux.alibaba.com, richardw.yang@linux.intel.com,
        thellstrom@vmware.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/5] mm/mremap.c: cleanup move_page_tables() a little
Date:   Sat, 18 Jan 2020 07:22:49 +0800
Message-Id: <20200117232254.2792-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move_page_tables() tries to move page table by PMD or PTE.

The root reason is if it tries to move PMD, both old and new range should
be PMD aligned. But current code calculate old range and new range
separately.  This leads to some redundant check and calculation.

This cleanup tries to consolidate the range check in one place to reduce
some extra range handling.

Wei Yang (5):
  mm/mremap: format the check in move_normal_pmd() same as
    move_huge_pmd()
  mm/mremap: it is sure to have enough space when extent meets
    requirement
  mm/mremap: use pmd_addr_end to calculate next in move_page_tables()
  mm/mremap: calculate extent in one place
  mm/mremap: start addresses are properly aligned

 include/linux/huge_mm.h |  2 +-
 mm/huge_memory.c        |  8 +-------
 mm/mremap.c             | 24 +++++++-----------------
 3 files changed, 9 insertions(+), 25 deletions(-)

-- 
2.17.1

