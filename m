Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD67C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A21C20722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="j73KYCHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCZV1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24750 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCZV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:31 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QLOexU006760
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=n2ZLoVczZwXZSDy2Sw/zbfhEovYQe+QGpRr6SKE1WEk=;
 b=j73KYCHrEVh6DBE6aW2il4AGa+1HKi8qanbULlL30bN9w/AQJrBFvRv88luY+LgcwmDZ
 vPwrnBwHv448xNM8FfMU5Yb+YvxA5lN83umcLDeriPtB+WSeLuNxLxTfGmqIDiTCddGj
 uV4dcSIzUxKhY4jU2gACYROaz7uTogsaPE0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 300gjdfacu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 14:27:29 -0700
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 26 Mar 2020 14:27:28 -0700
Received: by devbig020.ftw1.facebook.com (Postfix, from userid 179119)
        id 870A658C1E71; Thu, 26 Mar 2020 14:27:26 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Aslan Bakirov <aslan@fb.com>
Smtp-Origin-Hostname: devbig020.ftw1.facebook.com
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <riel@surriel.com>, <guro@fb.com>,
        <mhocko@kernel.org>, <hannes@cmpxchg.org>,
        Aslan Bakirov <aslan@fb.com>
Smtp-Origin-Cluster: ftw1c07
Subject: [PATCH 1/2] mm: cma: NUMA node interface
Date:   Thu, 26 Mar 2020 14:27:17 -0700
Message-ID: <20200326212718.3798742-1-aslan@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_13:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 priorityscore=1501 mlxscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=1 lowpriorityscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260156
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that there is no interfaces exposed by CMA which would let me
to declare contigous memory on particular NUMA node.

This patchset adds the ability to try to allocate contiguous memory on
specific node.

Implement a new method for declaring contigous memory on particular node
and keep cma_declare_contiguous() as a wrapper.

Signed-off-by: Aslan Bakirov <aslan@fb.com>
---
 include/linux/cma.h      | 14 ++++++++++++--
 include/linux/memblock.h |  3 +++
 mm/cma.c                 | 15 ++++++++-------
 mm/memblock.c            |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/cma.h b/include/linux/cma.h
index 190184b5ff32..9512229744e0 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -24,10 +24,20 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
 extern unsigned long cma_get_size(const struct cma *cma);
 extern const char *cma_get_name(const struct cma *cma);
 
-extern int __init cma_declare_contiguous(phys_addr_t base,
+extern int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma);
+			bool fixed, const char *name, struct cma **res_cma,
+			int nid);
+static inline int __init cma_declare_contiguous(phys_addr_t base,
+			phys_addr_t size, phys_addr_t limit,
+			phys_addr_t alignment, unsigned int order_per_bit,
+			bool fixed, const char *name, struct cma **res_cma)
+			{
+				return cma_declare_contiguous_nid(base, size,
+						limit, alignment, order_per_bit,
+						fixed, name, res_cma, NUMA_NO_NODE);
+			}
 extern int cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 					unsigned int order_per_bit,
 					const char *name,
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 079d17d96410..f5878ed25e6e 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -348,6 +348,9 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
 
 phys_addr_t memblock_phys_alloc_range(phys_addr_t size, phys_addr_t align,
 				      phys_addr_t start, phys_addr_t end);
+phys_addr_t memblock_alloc_range_nid(phys_addr_t size,
+					  phys_addr_t align, phys_addr_t start,
+					  phys_addr_t end, int nid, bool exact_nid);
 phys_addr_t memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t align, int nid);
 
 static inline phys_addr_t memblock_phys_alloc(phys_addr_t size,
diff --git a/mm/cma.c b/mm/cma.c
index be55d1988c67..2300669b4253 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -220,7 +220,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 }
 
 /**
- * cma_declare_contiguous() - reserve custom contiguous area
+ * cma_declare_contiguous_nid() - reserve custom contiguous area
  * @base: Base address of the reserved area optional, use 0 for any
  * @size: Size of the reserved area (in bytes),
  * @limit: End address of the reserved memory (optional, 0 for any).
@@ -229,6 +229,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * @fixed: hint about where to place the reserved area
  * @name: The name of the area. See function cma_init_reserved_mem()
  * @res_cma: Pointer to store the created cma region.
+ * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
  * This function reserves memory from early allocator. It should be
  * called by arch specific code once the early allocator (memblock or bootmem)
@@ -238,10 +239,10 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
  * If @fixed is true, reserve contiguous area at exactly @base.  If false,
  * reserve in range from @base to @limit.
  */
-int __init cma_declare_contiguous(phys_addr_t base,
+int __init cma_declare_contiguous_nid(phys_addr_t base,
 			phys_addr_t size, phys_addr_t limit,
 			phys_addr_t alignment, unsigned int order_per_bit,
-			bool fixed, const char *name, struct cma **res_cma)
+			bool fixed, const char *name, struct cma **res_cma, int nid)
 {
 	phys_addr_t memblock_end = memblock_end_of_DRAM();
 	phys_addr_t highmem_start;
@@ -336,14 +337,14 @@ int __init cma_declare_contiguous(phys_addr_t base,
 		 * memory in case of failure.
 		 */
 		if (base < highmem_start && limit > highmem_start) {
-			addr = memblock_phys_alloc_range(size, alignment,
-							 highmem_start, limit);
+			addr = memblock_alloc_range_nid(size, alignment,
+							 highmem_start, limit, nid, false);
 			limit = highmem_start;
 		}
 
 		if (!addr) {
-			addr = memblock_phys_alloc_range(size, alignment, base,
-							 limit);
+			addr = memblock_alloc_range_nid(size, alignment, base,
+							 limit, nid, false);
 			if (!addr) {
 				ret = -ENOMEM;
 				goto err;
diff --git a/mm/memblock.c b/mm/memblock.c
index 4d06bbaded0f..c79ba6f9920c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1349,7 +1349,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * Return:
  * Physical address of allocated memory block on success, %0 on failure.
  */
-static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
+phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
 					bool exact_nid)
-- 
2.17.1

