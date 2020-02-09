Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A6C352A4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D302620820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENxaUZwi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBIKsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:48:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51711 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgBIKsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DsolEyvsq2X/4Ojh8CIm2FaqZo6yUXk19oty1TTx+uA=;
        b=ENxaUZwicZmkhElo4vyrI/aVIe4dZc7VWeR1hDFsDQRnfTVrB6xRxGFd7TotLr9KxWPlHw
        2E2bkDvUD7GxWK1CogReAPzIuugtsGQKQcl3ldcBrhMxqKsvQ0nrzvypU3tHeix6KmIbee
        Euoxy8I5gpv+QBbReThdChYKa96wxcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-BC8TcIIyM92RShLolccTZA-1; Sun, 09 Feb 2020 05:48:40 -0500
X-MC-Unique: BC8TcIIyM92RShLolccTZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B0013F7;
        Sun,  9 Feb 2020 10:48:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD3A310013A7;
        Sun,  9 Feb 2020 10:48:36 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 2/7] mm/sparse.c: Introduce a new function clear_subsection_map()
Date:   Sun,  9 Feb 2020 18:48:21 +0800
Message-Id: <20200209104826.3385-3-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the codes clearing subsection map of one memory region in
section_deactivate() into clear_subsection_map().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 9ad741ccbeb6..696f6b9f706e 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -726,14 +726,25 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+/**
+ * clear_subsection_map - Clear subsection map of one memory region
+ *
+ * @pfn - start pfn of the memory range
+ * @nr_pages - number of pfns to add in the region
+ *
+ * This is only intended for hotplug, and clear the related subsection
+ * map inside one section.
+ *
+ * Return:
+ * * -EINVAL	- Section already deactived.
+ * * 0		- Subsection map is emptied.
+ * * 1		- Subsection map is not empty.
+ */
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
 	struct mem_section *ms = __pfn_to_section(pfn);
-	bool section_is_early = early_section(ms);
-	struct page *memmap = NULL;
 	unsigned long *subsection_map = ms->usage
 		? &ms->usage->subsection_map[0] : NULL;
 
@@ -744,8 +755,28 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
 				"section already deactivated (%#lx + %ld)\n",
 				pfn, nr_pages))
-		return;
+		return -EINVAL;
+
+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
 
+	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
+		return 0;
+
+	return 1;
+}
+
+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap)
+{
+	struct mem_section *ms = __pfn_to_section(pfn);
+	bool section_is_early = early_section(ms);
+	struct page *memmap = NULL;
+	int rc;
+
+
+	rc = clear_subsection_map(pfn, nr_pages);
+	if(IS_ERR_VALUE((unsigned long)rc))
+		return;
 	/*
 	 * There are 3 cases to handle across two configurations
 	 * (SPARSEMEM_VMEMMAP={y,n}):
@@ -763,8 +794,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 *
 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
 	 */
-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
-	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
+	if (!rc) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
 		/*
-- 
2.17.2

