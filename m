Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B11EC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC1C20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="lDw4bzhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBCPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:43:18 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:44120 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgBCPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:43:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 70BB03F386;
        Mon,  3 Feb 2020 16:43:15 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=lDw4bzhC;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nV0aPQ4GvCBo; Mon,  3 Feb 2020 16:43:14 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id C0FCD3F374;
        Mon,  3 Feb 2020 16:43:13 +0100 (CET)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 202013600E5;
        Mon,  3 Feb 2020 16:43:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1580744593; bh=XlNdoAIJhpLSyjWqttR1EHRGL0pqRlRHRNorOyAJqJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=lDw4bzhCl2B//23TdxB/WCEoTB7BQ0+kdara1T10lvEvnwRZRyjBZKtocQrzdtSB6
         a4uJ9XBMY4T1+rNKOTOqk+H2glaGG7hKVqcn1eksu0CtrOkrd5aKO/dZ3KfdL2RcwP
         P3Noxm3r0uayKt/Pvb0keFvZZWgeCIXbYVPynHyk=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] mm/mapping_dirty_helpers: Update huge page-table entry callbacks
Date:   Mon,  3 Feb 2020 16:43:05 +0100
Message-Id: <20200203154305.15045-1-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

Following the update of pagewalk code
commit a07984d48146 ("mm: pagewalk: add p4d_entry() and pgd_entry()")
we can modify the mapping_dirty_helpers' huge page-table entry callbacks
to avoid splitting when a huge pud or -pmd is encountered.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
v2: Added R-B from Steven.
---
 mm/mapping_dirty_helpers.c | 42 ++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index 71070dda9643..2c7d03675903 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -111,26 +111,60 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
 	return 0;
 }
 
-/* wp_clean_pmd_entry - The pagewalk pmd callback. */
+/*
+ * wp_clean_pmd_entry - The pagewalk pmd callback.
+ *
+ * Dirty-tracking should take place on the PTE level, so
+ * WARN() if encountering a dirty huge pmd.
+ * Furthermore, never split huge pmds, since that currently
+ * causes dirty info loss. The pagefault handler should do
+ * that if needed.
+ */
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	/* Dirty-tracking should be handled on the pte level */
 	pmd_t pmdval = pmd_read_atomic(pmd);
 
+	if (!pmd_trans_unstable(&pmdval))
+		return 0;
+
+	if (pmd_none(pmdval)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	/* Huge pmd, present or migrated */
+	walk->action = ACTION_CONTINUE;
 	if (pmd_trans_huge(pmdval) || pmd_devmap(pmdval))
 		WARN_ON(pmd_write(pmdval) || pmd_dirty(pmdval));
 
 	return 0;
 }
 
-/* wp_clean_pud_entry - The pagewalk pud callback. */
+/*
+ * wp_clean_pud_entry - The pagewalk pud callback.
+ *
+ * Dirty-tracking should take place on the PTE level, so
+ * WARN() if encountering a dirty huge puds.
+ * Furthermore, never split huge puds, since that currently
+ * causes dirty info loss. The pagefault handler should do
+ * that if needed.
+ */
 static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	/* Dirty-tracking should be handled on the pte level */
 	pud_t pudval = READ_ONCE(*pud);
 
+	if (!pud_trans_unstable(&pudval))
+		return 0;
+
+	if (pud_none(pudval)) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	/* Huge pud */
+	walk->action = ACTION_CONTINUE;
 	if (pud_trans_huge(pudval) || pud_devmap(pudval))
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
 
-- 
2.21.1

