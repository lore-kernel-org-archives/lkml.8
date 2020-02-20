Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B4C11D41
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E69224670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4mSVyN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgBTEeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:34:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48943 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727476AbgBTEeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582173239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9GUV7ZJmC2qQXzHNAmZVY0tFi2CtcIn1WjDc/UVGLOM=;
        b=Z4mSVyN8FZwomC0LHBRs9c2yHXR8tzwHW8qFcPUHJ64BjhZEcXTS120ZjeqF7wT80WN9zy
        VD63hL2l6M317k9AKu9R2gB6e/T6OmdrGmJJRxfntUDen/5MANJbE6kttvtW4WzAUe5kSu
        /HoT6V1oaKUNCM3tiyMGaQpAvgqFfXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-spB0LoAhN9eMFmFDFL6hzA-1; Wed, 19 Feb 2020 23:33:57 -0500
X-MC-Unique: spB0LoAhN9eMFmFDFL6hzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CFBF801E5C;
        Thu, 20 Feb 2020 04:33:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 234A95DA60;
        Thu, 20 Feb 2020 04:33:51 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, bhe@redhat.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: [PATCH v2 5/7] mm/sparse.c: add code comment about sub-section hotplug
Date:   Thu, 20 Feb 2020 12:33:14 +0800
Message-Id: <20200220043316.19668-6-bhe@redhat.com>
In-Reply-To: <20200220043316.19668-1-bhe@redhat.com>
References: <20200220043316.19668-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's helpful to note that sub-section is only supported in
SPARSEMEM_VMEMMAP case, but not in SPARSEMEM|!VMEMMAP case. Add
sentences into the code comment above sparse_add_section.

And also move the code comments from inside section_deactivate()
to be above it. The code comments are reasonable to the whole
function, and the moving makes code cleaner.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/sparse.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 66c497d6a229..14bff0b44e7c 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -778,6 +778,22 @@ static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 }
 #endif
 
+/*
+ * To deactivate a memory region, there are 3 cases to handle across
+ * two configurations (SPARSEMEM_VMEMMAP={y,n}):
+ *
+ * 1. deactivation of a partial hot-added section (only possible in
+ *    the SPARSEMEM_VMEMMAP=y case).
+ *      a) section was present at memory init
+ *      b) section was hot-added post memory init
+ * 2. deactivation of a complete hot-added section.
+ * 3. deactivation of a complete section from memory init.
+ *
+ * For case 1, when subsection_map does not empty we will not be freeing
+ * the usage map, but still need to free the vmemmap range.
+ *
+ * For case 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified.
+ */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
@@ -790,23 +806,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
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
 
@@ -926,6 +926,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  *
  * This is only intended for hotplug.
  *
+ * Note that the added memory region is either section aligned, or
+ * sub-section aligned. The subsection hotplug is only supported in
+ * VMEMMAP case, please refer to ZONE_DEVICE part of memory-model.rst
+ * for more details.
+ *
  * Return:
  * * 0		- On success.
  * * -EEXIST	- Section has been present.
-- 
2.17.2

