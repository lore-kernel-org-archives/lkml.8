Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D240C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569622CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHGIkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgHGIkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:40:32 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C638C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 01:40:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3D2AD321; Fri,  7 Aug 2020 10:40:27 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, hpa@zytor.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason@zx2c4.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, joro@8bytes.org
Subject: [PATCH] x86/mm/64: Do not dereference non-present PGD entries
Date:   Fri,  7 Aug 2020 10:40:13 +0200
Message-Id: <20200807084013.7090-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The code for preallocate_vmalloc_pages() was written under the
assumption that the p4d_offset() and pud_offset() functions will perform
present checks before dereferencing the parent entries.

This assumption is wrong an leads to a bug in the code which causes the
physical address found in the PGD be used as a page-table page, even if
the PGD is not present.

So the code flow currently is:

	pgd = pgd_offset_k(addr);
	p4d = p4d_offset(pgd, addr);
	if (p4d_none(*p4d))
		p4d = p4d_alloc(&init_mm, pgd, addr);

This lacks a check for pgd_none() at least, the correct flow would be:

	pgd = pgd_offset_k(addr);
	if (pgd_none(*pgd))
		p4d = p4d_alloc(&init_mm, pgd, addr);
	else
		p4d = p4d_offset(pgd, addr);

But this is the same flow that the p4d_alloc() and the pud_alloc()
functions use internally, so there is no need to duplicate them.

Remove the p?d_none() checks from the function and just call into
p4d_alloc() and pud_alloc() to correctly pre-allocate the PGD entries.

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Fixes: 6eb82f994026 ("x86/mm: Pre-allocate P4D/PUD pages for vmalloc area")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init_64.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3f4e29a78f2b..449e071240e1 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1253,28 +1253,23 @@ static void __init preallocate_vmalloc_pages(void)
 		p4d_t *p4d;
 		pud_t *pud;
 
-		p4d = p4d_offset(pgd, addr);
-		if (p4d_none(*p4d)) {
-			/* Can only happen with 5-level paging */
-			p4d = p4d_alloc(&init_mm, pgd, addr);
-			if (!p4d) {
-				lvl = "p4d";
-				goto failed;
-			}
-		}
+		lvl = "p4d";
+		p4d = p4d_alloc(&init_mm, pgd, addr);
+		if (!p4d)
+			goto failed;
 
+		/*
+		 * With 5-level paging the P4D level is not folded. So the PGDs
+		 * are now populated and there is no need to walk down to the
+		 * PUD level.
+		 */
 		if (pgtable_l5_enabled())
 			continue;
 
-		pud = pud_offset(p4d, addr);
-		if (pud_none(*pud)) {
-			/* Ends up here only with 4-level paging */
-			pud = pud_alloc(&init_mm, p4d, addr);
-			if (!pud) {
-				lvl = "pud";
-				goto failed;
-			}
-		}
+		lvl = "pud";
+		pud = pud_alloc(&init_mm, p4d, addr);
+		if (!pud)
+			goto failed;
 	}
 
 	return;
-- 
2.26.2

