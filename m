Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E41C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33144208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgEAVG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:06:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:14691 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:06:57 -0400
IronPort-SDR: WEsCdQx7bsWBcp//WeC8GyeyHVdDdmj2SUffVUQxkmi1BHugrqNz2GsyW0G6juDhfZbv1LV1kK
 SzP+lxI30oXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 14:06:56 -0700
IronPort-SDR: fLz4oPOZC60fv9eFRf6XoS+qjHY6BgQN9a7XdIo1PDtpEPeDxgJAPiz1VJsNXCDCRhxZAcnxfs
 PJXezy1GJ5+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="433425589"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 01 May 2020 14:06:56 -0700
Subject: [RFC][PATCH 1/2] mm/migrate: remove extra page_count() check
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, npiggin@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 01 May 2020 14:05:18 -0700
References: <20200501210516.DFAFF456@viggo.jf.intel.com>
In-Reply-To: <20200501210516.DFAFF456@viggo.jf.intel.com>
Message-Id: <20200501210518.DA161B7E@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

This is not a bug fix.  It was found by inspection, but I believe
that it is confusing as it stands.

First, page_ref_freeze() is implemented internally with:

	atomic_cmpxchg(&page->_refcount, expected, 0) == expected

The "cmp" part of cmpxchg is making sure that _refcount==expected
which means that there's an implicit check here, equivalent to:

	page_count(page) == expected_count

This appears to have originated in "e286781: mm: speculative page
references", which is pretty ancient.  This check is also somewhat
dangerous to have here because it might lead someone to think that
page_ref_freeze() *doesn't* do its own page_count() checking.

Remove the unnecessary check.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---

 b/mm/migrate.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN mm/migrate.c~remove_extra_page_count_check mm/migrate.c
--- a/mm/migrate.c~remove_extra_page_count_check	2020-05-01 14:00:42.331525924 -0700
+++ b/mm/migrate.c	2020-05-01 14:00:42.336525924 -0700
@@ -425,11 +425,12 @@ int migrate_page_move_mapping(struct add
 	newzone = page_zone(newpage);
 
 	xas_lock_irq(&xas);
-	if (page_count(page) != expected_count || xas_load(&xas) != page) {
+	if (xas_load(&xas) != page) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
 
+	/* Freezing will fail if page_count()!=expected_count */
 	if (!page_ref_freeze(page, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
_
