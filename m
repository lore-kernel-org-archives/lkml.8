Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EBFC43446
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CDA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfDxQmOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgGVJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731680AbgGVJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uaZOR7KXaGa092uT6zCD4t6hx23vbPweqPLGG3hy9U8=;
        b=SfDxQmOtT33mopxcPNIRS0Jk1SqdDTZQ3QHXP5CX2Vb0Gdx43ocbo1AxXZMoY+HDZ8UW2H
        hwpzIyi5bzfoWEukBwz1pnsbh+DWJ0BLS2gNHKnnoeT174Vb6wzioh/Y9o3cfMr3OkKk58
        33yhda8XdkeDI2/GUaJowBywmhl7JbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-PqtGEzxtN8i8xNs5IYVoSw-1; Wed, 22 Jul 2020 05:46:30 -0400
X-MC-Unique: PqtGEzxtN8i8xNs5IYVoSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7935918C63C5;
        Wed, 22 Jul 2020 09:46:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6C965D9CA;
        Wed, 22 Jul 2020 09:46:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 9/9] s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive sections
Date:   Wed, 22 Jul 2020 11:45:58 +0200
Message-Id: <20200722094558.9828-10-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid memset(PAGE_UNUSED) when adding consecutive sections,
whereby the vmemmap of a single section does not span full PMDs.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index df361bbacda1b..70ebfc7958a68 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -74,7 +74,22 @@ static void vmem_pte_free(unsigned long *table)
 
 #define PAGE_UNUSED 0xFD
 
-static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+/*
+ * The unused vmemmap range, which was not yet memset(PAGE_UNUSED) ranges
+ * from unused_pmd_start to next PMD_SIZE boundary.
+ */
+static unsigned long unused_pmd_start;
+
+static void vmemmap_flush_unused_pmd(void)
+{
+	if (!unused_pmd_start)
+		return;
+	memset(__va(unused_pmd_start), PAGE_UNUSED,
+	       ALIGN(unused_pmd_start, PMD_SIZE) - unused_pmd_start);
+	unused_pmd_start = 0;
+}
+
+static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 {
 	/*
 	 * As we expect to add in the same granularity as we remove, it's
@@ -85,18 +100,41 @@ static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
 	memset(__va(start), 0, sizeof(struct page));
 }
 
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * We only optimize if the new used range directly follows the
+	 * previously unused range (esp., when populating consecutive sections).
+	 */
+	if (unused_pmd_start == start) {
+		unused_pmd_start = end;
+		if (likely(IS_ALIGNED(unused_pmd_start, PMD_SIZE)))
+			unused_pmd_start = 0;
+		return;
+	}
+	vmemmap_flush_unused_pmd();
+	__vmemmap_use_sub_pmd(start, end);
+}
+
 static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
+	vmemmap_flush_unused_pmd();
+
 	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
-	vmemmap_use_sub_pmd(start, end);
+	__vmemmap_use_sub_pmd(start, end);
 
 	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
 	if (!IS_ALIGNED(start, PMD_SIZE))
 		memset(page, PAGE_UNUSED, start - __pa(page));
+	/*
+	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
+	 * consecutive sections. Remember for the last added PMD the last
+	 * unused range in the populated PMD.
+	 */
 	if (!IS_ALIGNED(end, PMD_SIZE))
-		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+		unused_pmd_start = end;
 }
 
 /* Returns true if the PMD is completely unused and can be freed. */
@@ -104,6 +142,7 @@ static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
 {
 	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
 
+	vmemmap_flush_unused_pmd();
 	memset(__va(start), PAGE_UNUSED, end - start);
 	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
 }
-- 
2.26.2

