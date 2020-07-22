Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CDBC43457
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC6220787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2I0mqgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgGVJqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25828 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731867AbgGVJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2Pt8YbOgtZ7xNRMelyfuowofOPYBJ1LTpQOaKuUjMk=;
        b=e2I0mqgODo401hDAUcjmpLwTBGfd8NFn9hastEWmWcvzfIvTBhtXRX9USDWM6yzi47c+D7
        wneR7WvYNhqMXCquvU8/5zEfU0iNuBa+XJiK6N6ua9jxjHXw1DuvWt2GhqKs/fdDa9EJ/r
        He6haT2eNeXPMYVsbi0YCQ38lghuNVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-yRXh0_a8OFKxIAsdpKFoeg-1; Wed, 22 Jul 2020 05:46:28 -0400
X-MC-Unique: yRXh0_a8OFKxIAsdpKFoeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 720FB800688;
        Wed, 22 Jul 2020 09:46:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7637B5D9CA;
        Wed, 22 Jul 2020 09:46:23 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 8/9] s390/vmemmap: remember unused sub-pmd ranges
Date:   Wed, 22 Jul 2020 11:45:57 +0200
Message-Id: <20200722094558.9828-9-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a memmap size of 56 bytes or 72 bytes per page, the memmap for a
256 MB section won't span full PMDs. As we populate single sections and
depopulate single sections, the depopulation step would not be able to
free all vmemmap pmds anymore.

Do it similarly to x86, marking the unused memmap ranges in a special way
(pad it with 0xFD).

This allows us to add/remove sections, cleaning up all allocated
vmemmap pages even if the memmap size is not multiple of 16 bytes per page.

A 56 byte memmap can, for example, be created with !CONFIG_MEMCG and
!CONFIG_SLUB.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index e82a63de19db2..df361bbacda1b 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -72,6 +72,42 @@ static void vmem_pte_free(unsigned long *table)
 	page_table_free(&init_mm, table);
 }
 
+#define PAGE_UNUSED 0xFD
+
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * As we expect to add in the same granularity as we remove, it's
+	 * sufficient to mark only some piece used to block the memmap page from
+	 * getting removed (just in case the memmap never gets initialized,
+	 * e.g., because the memory block never gets onlined).
+	 */
+	memset(__va(start), 0, sizeof(struct page));
+}
+
+static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
+	vmemmap_use_sub_pmd(start, end);
+
+	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+		memset(page, PAGE_UNUSED, start - __pa(page));
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+}
+
+/* Returns true if the PMD is completely unused and can be freed. */
+static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	memset(__va(start), PAGE_UNUSED, end - start);
+	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
+}
+
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, bool add, bool direct)
@@ -157,6 +193,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 								get_order(PMD_SIZE));
 					pmd_clear(pmd);
 					pages++;
+				} else if (!direct &&
+					   vmemmap_unuse_sub_pmd(addr, next)) {
+					vmem_free_pages(pmd_deref(*pmd),
+							get_order(PMD_SIZE));
+					pmd_clear(pmd);
 				}
 				continue;
 			}
@@ -182,6 +223,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 							       NUMA_NO_NODE);
 				if (new_page) {
 					pmd_val(*pmd) = __pa(new_page) | prot;
+					if (!IS_ALIGNED(addr, PMD_SIZE) ||
+					    !IS_ALIGNED(next, PMD_SIZE)) {
+						vmemmap_use_new_sub_pmd(addr,
+									next);
+					}
 					continue;
 				}
 			}
@@ -189,8 +235,11 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 			if (!pte)
 				goto out;
 			pmd_populate(&init_mm, pmd, pte);
-		} else if (pmd_large(*pmd))
+		} else if (pmd_large(*pmd)) {
+			if (!direct)
+				vmemmap_use_sub_pmd(addr, next);
 			continue;
+		}
 
 		ret = modify_pte_table(pmd, addr, next, add, direct);
 		if (ret)
-- 
2.26.2

