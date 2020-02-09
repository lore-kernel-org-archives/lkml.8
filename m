Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815FAC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206E20733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqratGxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgBIKs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:48:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53831 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBIKsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=avDH489Kezk0JZkoC0zLQWdCP4dLpS7AfZ6UHFu6JUE=;
        b=SqratGxpX2husjUsJtOrPcaMAmX3pVrYpfv60bBKFYSI6U4XlE+fRxqM0jl5eKKS2AcNWJ
        U/iuezfVpWSSWea+iFfeEj98g7COLbdY0ypds5rFoUoSCG0OjQQBCEPAaANf+Q52PWMYGZ
        TatThlNJsTAXFClIKZ0iOXvtSec89p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-Y1RO4sIjPpW_7FwABGULVA-1; Sun, 09 Feb 2020 05:48:50 -0500
X-MC-Unique: Y1RO4sIjPpW_7FwABGULVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3618913E5;
        Sun,  9 Feb 2020 10:48:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A8E410013A7;
        Sun,  9 Feb 2020 10:48:46 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 5/7] mm/sparse.c: update code comment about section activate/deactivate
Date:   Sun,  9 Feb 2020 18:48:24 +0800
Message-Id: <20200209104826.3385-6-bhe@redhat.com>
In-Reply-To: <20200209104826.3385-1-bhe@redhat.com>
References: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's helpful to note that sub-section is only supported in
SPARSEMEM_VMEMMAP case, but not in SPARSEMEM|!VMEMMAP case. Add
sentences into the code comment above sparse_add_section.

And move the code comments inside section_deactivate() to be above
it, this makes code cleaner.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 36e6565ec67e..a7e78bfe0dce 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -809,6 +809,23 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+/*
+ * To deactivate a memory region, there are 3 cases across two
+ * two configurations (SPARSEMEM_VMEMMAP={y,n}):
+ *
+ * 1/ deactivation of a partial hot-added section (only possible
+ * in the SPARSEMEM_VMEMMAP=y case).
+ *    a/ section was present at memory init
+ *    b/ section was hot-added post memory init
+ * 2/ deactivation of a complete hot-added section
+ * 3/ deactivation of a complete section from memory init
+ *
+ * For 1/, when subsection_map does not empty we will not be
+ * freeing the usage map, but still need to free the vmemmap
+ * range.
+ *
+ * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
+ */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
@@ -821,23 +838,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	rc = clear_subsection_map(pfn, nr_pages);
 	if(IS_ERR_VALUE((unsigned long)rc))
 		return;
-	/*
-	 * There are 3 cases to handle across two configurations
-	 * (SPARSEMEM_VMEMMAP={y,n}):
-	 *
-	 * 1/ deactivation of a partial hot-added section (only possible
-	 * in the SPARSEMEM_VMEMMAP=y case).
-	 *    a/ section was present at memory init
-	 *    b/ section was hot-added post memory init
-	 * 2/ deactivation of a complete hot-added section
-	 * 3/ deactivation of a complete section from memory init
-	 *
-	 * For 1/, when subsection_map does not empty we will not be
-	 * freeing the usage map, but still need to free the vmemmap
-	 * range.
-	 *
-	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
-	 */
+
 	if (!rc) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
 
@@ -913,6 +914,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  *
  * This is only intended for hotplug.
  *
+ * Note that the added memory region is either section aligned, or
+ * sub-section aligned. The sub-section aligned region can only be
+ * hot added in SPARSEMEM_VMEMMAP case, please refer to ZONE_DEVICE
+ * part of memory-model.rst for more details.
+ *
  * Return:
  * * 0		- On success.
  * * -EEXIST	- Section has been present.
-- 
2.17.2

