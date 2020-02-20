Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEA3C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B121D24670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8EJGzDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBTEd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:33:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgBTEd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582173237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=oCBv2HOJLKiIgRMHMc/3eKQp7QmzN8xhrTm/x4TQ1YA=;
        b=I8EJGzDzrw25cpC1FSLthijRa5vGK4F5a+6YwEMhKqH4p8vLUAC3Dwakf9UOgjMFd9vv72
        b5KvAW0NZH22lAknZzcMSwDym/QoD1ItC8h1AprRMY7RH32Wht+xZgwxpbDWMW9L1Dxc+x
        ohZ+E91HpNNRvxWMwY5iiqMfEgXkbrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-jGP_ygKmNh2_31R1tSC_YA-1; Wed, 19 Feb 2020 23:33:53 -0500
X-MC-Unique: jGP_ygKmNh2_31R1tSC_YA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B7A8800D53;
        Thu, 20 Feb 2020 04:33:51 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D86F5DA60;
        Thu, 20 Feb 2020 04:33:45 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, bhe@redhat.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: [PATCH v2 4/7] mm/sparse.c: only use subsection map in VMEMMAP case
Date:   Thu, 20 Feb 2020 12:33:13 +0800
Message-Id: <20200220043316.19668-5-bhe@redhat.com>
In-Reply-To: <20200220043316.19668-1-bhe@redhat.com>
References: <20200220043316.19668-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, subsection map is used when SPARSEMEM is enabled, including
VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessary
and misleading. Let's adjust code to only allow subsection map being
used in VMEMMAP case.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/mmzone.h |  2 ++
 mm/sparse.c            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 462f6873905a..fc0de3a9a51e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsigned long sec)
 #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
 
 struct mem_section_usage {
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
+#endif
 	/* See declaration of similar field in struct zone */
 	unsigned long pageblock_flags[0];
 };
diff --git a/mm/sparse.c b/mm/sparse.c
index df857ee9330c..66c497d6a229 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -209,6 +209,7 @@ static inline unsigned long first_present_section_nr(void)
 	return next_present_section_nr(-1);
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 static void subsection_mask_set(unsigned long *map, unsigned long pfn,
 		unsigned long nr_pages)
 {
@@ -243,6 +244,11 @@ void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
 		nr_pages -= pfns;
 	}
 }
+#else
+void __init subsection_map_init(unsigned long pfn, unsigned long nr_pages)
+{
+}
+#endif
 
 /* Record a memory area against a node. */
 void __init memory_present(int nid, unsigned long start, unsigned long end)
@@ -726,6 +732,7 @@ static void free_map_bootmem(struct page *memmap)
 }
 #endif /* CONFIG_SPARSEMEM_VMEMMAP */
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 /**
  * clear_subsection_map - Clear subsection map of one memory region
  *
@@ -764,6 +771,12 @@ static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
 	return 1;
 }
+#else
+static int clear_subsection_map(unsigned long pfn, unsigned long nr_pages)
+{
+	return 0;
+}
+#endif
 
 static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		struct vmem_altmap *altmap)
@@ -820,6 +833,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 		ms->section_mem_map = (unsigned long)NULL;
 }
 
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
 /**
  * fill_subsection_map - fill subsection map of a memory region
  * @pfn - start pfn of the memory range
@@ -854,6 +868,12 @@ static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
 
 	return rc;
 }
+#else
+static int fill_subsection_map(unsigned long pfn, unsigned long nr_pages)
+{
+	return 0;
+}
+#endif
 
 static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap)
-- 
2.17.2

