Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD91C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A73208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEAVHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:07:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:41968 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:06:59 -0400
IronPort-SDR: MX5d6yeunNxsVI22BgDOvlnp4Slhvr8XNbPOIDfNgLJsLsOTocBnL102tXO2rV6hK4CVsb2cxW
 bzb9lgKQEE0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 14:06:59 -0700
IronPort-SDR: ndrAxZLEU5/DjQqA4yIL2o6b5+ROOEw6B1BXjG7cT6PX4yclHY8sdrTh2h5rSxX9mxT64XJeEI
 pGW4vEMquB+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,341,1583222400"; 
   d="scan'208";a="405849459"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 01 May 2020 14:06:59 -0700
Subject: [RFC][PATCH 2/2] mm/migrate: annotate possible unnecessary xas_load()
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, npiggin@gmail.com,
        akpm@linux-foundation.org, willy@infradead.org,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 01 May 2020 14:05:20 -0700
References: <20200501210516.DFAFF456@viggo.jf.intel.com>
In-Reply-To: <20200501210516.DFAFF456@viggo.jf.intel.com>
Message-Id: <20200501210520.6B29706C@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The xas_load() in question also originated in "e286781: mm:
speculative page references" as a radix_tree_deref_slot(), the
only one in the tree at the time.

I'm thoroughly confused why it is needed, though.  A page's
slot in the page cache should be stabilized by lock_page()
being held.

So, first of all, add a VM_BUG_ON_ONCE() to make it totally
clear that the page is locked.

But, even if the page was truncated, we normally check:

	page_mapping(page) != mapping

to check for truncation.  This would seem to imply that we
are looking for some kind of state change that can happen
to the xarray slot for a page, but without changing
page->mapping.

I'm at a loss for that that might be.  Stick a WARN_ON_ONCE()
in there to see if we ever actually hit this.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---

 b/mm/migrate.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN mm/migrate.c~remove_extra_xas_load_check mm/migrate.c
--- a/mm/migrate.c~remove_extra_xas_load_check	2020-05-01 14:00:43.377525921 -0700
+++ b/mm/migrate.c	2020-05-01 14:00:43.381525921 -0700
@@ -407,6 +407,8 @@ int migrate_page_move_mapping(struct add
 	int dirty;
 	int expected_count = expected_page_refs(mapping, page) + extra_count;
 
+	VM_WARN_ONCE(!PageLocked(page));
+
 	if (!mapping) {
 		/* Anonymous page without mapping */
 		if (page_count(page) != expected_count)
@@ -425,7 +427,13 @@ int migrate_page_move_mapping(struct add
 	newzone = page_zone(newpage);
 
 	xas_lock_irq(&xas);
+	/*
+	 * 'mapping' was established under the page lock, which
+	 * prevents the xarray slot for 'page' from being changed.
+	 * Thus, xas_load() failure here is unexpected.
+	 */
 	if (xas_load(&xas) != page) {
+		WARN_ON_ONCE(1);
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
_
