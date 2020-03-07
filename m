Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ECC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD03520675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxvpdhYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCGIm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:42:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41320 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726300AbgCGImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583570574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=PkrIlsbzacNBuG97+eQewuYn5QQ3ji1rZFJWaZvAU5s=;
        b=AxvpdhYCAP6G4LOwzyN2O0cJPP67VjF0dxzrN+WWFUbrtbPaUWbs45TArvqQwJDKVAllye
        kvv8Je9Pbk7INnFUVLQJ83v462KPfG/5o9ZY4z0U6ICjq2eLywf4QLfNFI8WVvazRZeHon
        eiXNSrYVYkgWOqmWbtOtVe75M8xyD+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-6TjR-4feM5azlnrTFnYryA-1; Sat, 07 Mar 2020 03:42:50 -0500
X-MC-Unique: 6TjR-4feM5azlnrTFnYryA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F06E800D50;
        Sat,  7 Mar 2020 08:42:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7799B5D9CA;
        Sat,  7 Mar 2020 08:42:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com,
        bhe@redhat.com
Subject: [PATCH v3 3/7] mm/sparse.c: introduce a new function clear_subsection_map()
Date:   Sat,  7 Mar 2020 16:42:25 +0800
Message-Id: <20200307084229.28251-4-bhe@redhat.com>
In-Reply-To: <20200307084229.28251-1-bhe@redhat.com>
References: <20200307084229.28251-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code which clear subsection map of one memory region from
section_deactivate() into clear_subsection_map().

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index e37c0abcdc89..d9dcd58d5c1d 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -726,15 +726,11 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
-static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
-		struct vmem_altmap *altmap)
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 {
 	DECLARE_BITMAP(map, SUBSECTIONS_PER_SECTION) = { 0 };
 	DECLARE_BITMAP(tmp, SUBSECTIONS_PER_SECTION) = { 0 };
 	struct mem_section *ms = __pfn_to_section(pfn);
-	bool section_is_early = early_section(ms);
-	struct page *memmap = NULL;
-	bool empty = false;
 	unsigned long *subsection_map = ms->usage
 		? &ms->usage->subsection_map[0] : NULL;
 
@@ -745,8 +741,31 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	if (WARN(!subsection_map || !bitmap_equal(tmp, map, SUBSECTIONS_PER_SECTION),
 				"section already deactivated (%#lx + %ld)\n",
 				pfn, nr_pages))
+		return -EINVAL;
+
+	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
+
+	return 0;
+}
+
+static bool is_subsection_map_empty(struct mem_section *ms)
+{
+	return bitmap_empty(&ms->usage->subsection_map[0],
+			    SUBSECTIONS_PER_SECTION);
+}
+
+static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap)
+{
+	struct mem_section *ms = __pfn_to_section(pfn);
+	bool section_is_early = early_section(ms);
+	struct page *memmap = NULL;
+	bool empty = false;
+
+	if (clear_subsection_map(pfn, nr_pages))
 		return;
 
+	empty = is_subsection_map_empty(ms);
 	/*
 	 * There are 3 cases to handle across two configurations
 	 * (SPARSEMEM_VMEMMAP={y,n}):
@@ -764,8 +783,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 *
 	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
 	 */
-	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
-	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
-- 
2.17.2

