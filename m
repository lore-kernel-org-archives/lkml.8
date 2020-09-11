Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AE622204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JxXO2bpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIKQWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:22:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2622 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbgIKP2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:28:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BDXg9X191729;
        Fri, 11 Sep 2020 09:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VCevs/yaQHazFXInnTan+oDgN62pOgD9NgM/TFWnlsU=;
 b=JxXO2bpi+aaQKD5mQomg9rDjIcfJBbMQBPCXsjTyIW6ZM4/T7OUN9gMD62k386Zx/RHH
 CLPhsmGVqzj6wuG0LfSDCMMmAJlE8naYcX0iiAKxbqS9MIXxpIRY5KMyYlFVUbYNfIZd
 xvKzqP+JEVvviyhwX2PAozUwLMhHk5on/Xz81m9Z+VxEaawNkDYOjbvY9+MKV3pxVLWm
 c1iehqsSwN6bhCPhUowgT+Bz7TX51mydzAoX4m5CgWoDec+1t1EPeXonz3vlVU7UP3Uf
 0hkoYjXKEPD99t36chveHh9MDHbtUBBjmtHkZ5yw/rZgKPZQwMxT0LsNPJwu3bluVAWJ Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g9fy22ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:48:40 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BDXh72191783;
        Fri, 11 Sep 2020 09:48:39 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33g9fy22dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 09:48:39 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BDiGpg005376;
        Fri, 11 Sep 2020 13:48:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 33f91w90bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 13:48:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BDmYPO31588724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 13:48:34 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2351CAE045;
        Fri, 11 Sep 2020 13:48:34 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DA0AE053;
        Fri, 11 Sep 2020 13:48:33 +0000 (GMT)
Received: from pomme.tlslab.ibm.com (unknown [9.145.47.39])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 13:48:33 +0000 (GMT)
From:   Laurent Dufour <ldufour@linux.ibm.com>
To:     akpm@linux-foundation.org, David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, mhocko@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mm@kvack.org, "Rafael J . Wysocki" <rafael@kernel.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm: replace memmap_context by memplug_context
Date:   Fri, 11 Sep 2020 15:48:29 +0200
Message-Id: <20200911134831.53258-2-ldufour@linux.ibm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911134831.53258-1-ldufour@linux.ibm.com>
References: <20200911134831.53258-1-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_04:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=994 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memmap_context is used to detect whether a memory operation is due to a
hot-add operation or happening at boot time.

Makes it general to the hotplug operation, renaming it at memplug_context
and move its define in the corresponding header.

There is no functional change introduced by this patch

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/ia64/mm/init.c            |  6 +++---
 include/linux/memory_hotplug.h |  9 +++++++++
 include/linux/mm.h             |  2 +-
 include/linux/mmzone.h         |  4 ----
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                | 10 +++++-----
 6 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 0b3fb4c7af29..b5054b5e77c8 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -538,7 +538,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
 	if (map_start < map_end)
 		memmap_init_zone((unsigned long)(map_end - map_start),
 				 args->nid, args->zone, page_to_pfn(map_start),
-				 MEMMAP_EARLY, NULL);
+				 MEMPLUG_EARLY, NULL);
 	return 0;
 }
 
@@ -547,8 +547,8 @@ memmap_init (unsigned long size, int nid, unsigned long zone,
 	     unsigned long start_pfn)
 {
 	if (!vmem_map) {
-		memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY,
-				NULL);
+		memmap_init_zone(size, nid, zone, start_pfn,
+				 MEMPLUG_EARLY, NULL);
 	} else {
 		struct page *start;
 		struct memmap_init_callback_data args;
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 375515803cd8..cd2bd21d3a4d 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -15,6 +15,15 @@ struct memory_block;
 struct resource;
 struct vmem_altmap;
 
+/*
+ * Memory plugin context, use to differentiate memory added at boot time and
+ * hot-plugged memory.
+ */
+enum memplug_context {
+	MEMPLUG_EARLY,
+	MEMPLUG_HOTPLUG,
+};
+
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
  * Return page for the valid pfn only if the page is online. All pfn
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1983e08f5906..4157cc1bd17f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2409,7 +2409,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
-		enum memmap_context, struct vmem_altmap *);
+		enum memplug_context, struct vmem_altmap *);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..ec254ab793b5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -824,10 +824,6 @@ bool zone_watermark_ok(struct zone *z, unsigned int order,
 		unsigned int alloc_flags);
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 		unsigned long mark, int highest_zoneidx);
-enum memmap_context {
-	MEMMAP_EARLY,
-	MEMMAP_HOTPLUG,
-};
 extern void init_currently_empty_zone(struct zone *zone, unsigned long start_pfn,
 				     unsigned long size);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e9d5ab5d3ca0..fc21625e42de 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -729,7 +729,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
 	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
-			MEMMAP_HOTPLUG, altmap);
+			 MEMPLUG_HOTPLUG, altmap);
 
 	set_zone_contiguous(zone);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..7f49fcf38b8c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5975,7 +5975,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * done. Non-atomic initialization, single-pass.
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn, enum memmap_context context,
+		unsigned long start_pfn, enum memplug_context context,
 		struct vmem_altmap *altmap)
 {
 	unsigned long pfn, end_pfn = start_pfn + size;
@@ -6007,7 +6007,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		 * There can be holes in boot-time mem_map[]s handed to this
 		 * function.  They do not exist on hotplugged memory.
 		 */
-		if (context == MEMMAP_EARLY) {
+		if (context == MEMPLUG_EARLY) {
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
 			if (defer_init(nid, pfn, end_pfn))
@@ -6016,7 +6016,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 
 		page = pfn_to_page(pfn);
 		__init_single_page(page, pfn, zone, nid);
-		if (context == MEMMAP_HOTPLUG)
+		if (context == MEMPLUG_HOTPLUG)
 			__SetPageReserved(page);
 
 		/*
@@ -6099,7 +6099,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		 * check here not to call set_pageblock_migratetype() against
 		 * pfn out of zone.
 		 *
-		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
+		 * Please note that MEMPLUG_HOTPLUG path doesn't clear memmap
 		 * because this is done early in section_activate()
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
@@ -6137,7 +6137,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
 			memmap_init_zone(size, nid, zone, start_pfn,
-					 MEMMAP_EARLY, NULL);
+					 MEMPLUG_EARLY, NULL);
 		}
 	}
 }
-- 
2.28.0

