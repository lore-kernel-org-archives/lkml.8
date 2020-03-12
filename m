Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8C206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0kKRPt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCLMon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:44:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgCLMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584017079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NDC/aDJLXgt4BSQCv1kgy9uzztvACIYJCoAY3Dz157U=;
        b=g0kKRPt5OclIlH12SVAWuDFaUqctOWEs7pCwA9nwqbYTPwt1f3xkKSVjrlvS5yJr6u+pVj
        /xGECBL8usL4z9l5Wm69D1L4jd7SWXI8xSpa8piFa7RH6RgKnFxIWrPDvRQN7++APWa+vj
        0Px3mcm01MIq8TD8/57ANAtyOvCBq+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-N2kBufpfPLuoAUuVKNAdGw-1; Thu, 12 Mar 2020 08:44:37 -0400
X-MC-Unique: N2kBufpfPLuoAUuVKNAdGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 686EB8018B2;
        Thu, 12 Mar 2020 12:44:36 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 975768FBEF;
        Thu, 12 Mar 2020 12:44:33 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, bhe@redhat.com
Subject: [PATCH v4 4/5] mm/sparse.c: add note about only VMEMMAP supporting sub-section hotplug
Date:   Thu, 12 Mar 2020 20:44:13 +0800
Message-Id: <20200312124414.439-5-bhe@redhat.com>
In-Reply-To: <20200312124414.439-1-bhe@redhat.com>
References: <20200312124414.439-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And tell check_pfn_span() gating the porper alignment and size of
hot added memory region.

And also move the code comments from inside section_deactivate()
to being above it. The code comments are reasonable for the whole
function, and the moving makes code cleaner.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/sparse.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 117fe4554c38..f02a524e17d1 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -771,6 +771,22 @@ static bool is_subsection_map_empty(struct mem_section *ms)
 }
 #endif
 
+/*
+ * To deactivate a memory region, there are 3 cases to handle across
+ * two configurations (SPARSEMEM_VMEMMAP={y,n}):
+ *
+ * 1. deactivation of a partial hot-added section (only possible in
+ *    the SPARSEMEM_VMEMMAP=y case).
+ *      a) section was present at memory init.
+ *      b) section was hot-added post memory init.
+ * 2. deactivation of a complete hot-added section.
+ * 3. deactivation of a complete section from memory init.
+ *
+ * For 1, when subsection_map does not empty we will not be freeing the
+ * usage map, but still need to free the vmemmap range.
+ *
+ * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
+ */
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
 {
@@ -781,23 +797,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 
 	if (clear_subsection_map(pfn, nr_pages))
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
 	empty = is_subsection_map_empty(ms);
 	if (empty) {
 		unsigned long section_nr = pfn_to_section_nr(pfn);
@@ -905,6 +905,10 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
  *
  * This is only intended for hotplug.
  *
+ * Note that only VMEMMAP supports sub-section aligned hotplug,
+ * the proper alignment and size are gated by check_pfn_span().
+ *
+ *
  * Return:
  * * 0		- On success.
  * * -EEXIST	- Section has been present.
-- 
2.17.2

