Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E8CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76102311C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TTaUsFka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHOVsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:48:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726135AbgHOVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:48:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07FKVt8K183318;
        Sat, 15 Aug 2020 16:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nq/Qbh6g/GV+dwSR5atT+MIapKj5ifxEpKJJbzLcppg=;
 b=TTaUsFka0m+l9yCqajC6P02ynlwgwBNE0csV+uGoQcnE1l4mMDDE0bfC7zfar00YfKRP
 trS/YaFY8yMWqafniM74lRpTZxeudyO7wVe0rspeWur7fqFzTEdMMDsEFoTlMvEVkYlR
 4s+1PQBKhxV8PVeA6jTpqBH4oFvJmVxDSerfZxnfF8jfeJddSyfyoiROMLbqfKTc2F7j
 JoijZFaX9ZlDr8HNog1BK9bFYzL4o6zFwuVf7eHrTRSeuaN9U9c1tzIgFSM5ti456yRe
 qjAWaZWKn4C5a+N/Y+xIHG3l4m6k4LPom+y4xjWTLNOgzkBRscQpPTPRC0iuEr3e47oe tA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32xc75b2np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Aug 2020 16:45:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07FKiQuV006230;
        Sat, 15 Aug 2020 20:45:58 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01dal.us.ibm.com with ESMTP id 32x7b8e62w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Aug 2020 20:45:58 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07FKjvqa43516236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Aug 2020 20:45:57 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F23AABE056;
        Sat, 15 Aug 2020 20:45:56 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E781BE04F;
        Sat, 15 Aug 2020 20:45:54 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.211.150.234])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 15 Aug 2020 20:45:53 +0000 (GMT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     iommu@lists.linux-foundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [PATCH] swiotlb: Allow allocating buffer anywhere in memory
Date:   Sat, 15 Aug 2020 17:45:36 -0300
Message-Id: <20200815204536.663801-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-15_15:2020-08-14,2020-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=1 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008150159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

POWER secure guests (i.e., guests which use the Protection Execution
Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
they don't need the SWIOTLB memory to be in low addresses since the
hypervisor doesn't have any addressing limitation.

This solves a SWIOTLB initialization problem we are seeing in secure guests
with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
memory, which leaves no space for SWIOTLB in low addresses.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/mm/mem.c   |  7 ++++++-
 include/linux/swiotlb.h |  8 +++++++-
 kernel/dma/swiotlb.c    | 10 +++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

Normally I would split changes like this into one patch touching generic
code and another for the arch-specific part, but in this case I thought it
would be unneeded complexity. I can split though if people prefer it that
way.

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c2c11eb8dcfc..13f2e3aff8b5 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -50,6 +50,7 @@
 #include <asm/swiotlb.h>
 #include <asm/rtas.h>
 #include <asm/kasan.h>
+#include <asm/svm.h>
 
 #include <mm/mmu_decl.h>
 
@@ -290,7 +291,11 @@ void __init mem_init(void)
 	 * back to to-down.
 	 */
 	memblock_set_bottom_up(true);
-	swiotlb_init(0);
+	/*
+	 * SVM guests can use the SWIOTLB wherever it is in memory,
+	 * even if not DMA-able.
+	 */
+	swiotlb_init_anywhere(0, is_secure_guest());
 #endif
 
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 046bb94bd4d6..433f3dbb35b5 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -29,7 +29,13 @@ enum swiotlb_force {
  */
 #define IO_TLB_SHIFT 11
 
-extern void swiotlb_init(int verbose);
+void __init swiotlb_init_anywhere(int verbose, bool allocate_anywhere);
+
+static inline void swiotlb_init(int verbose)
+{
+	swiotlb_init_anywhere(verbose, false);
+}
+
 int swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose);
 extern unsigned long swiotlb_nr_tbl(void);
 unsigned long swiotlb_size_or_default(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c19379fabd20..27070aa59e34 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -244,7 +244,7 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
  * structures for the software IO TLB used to implement the DMA API.
  */
 void  __init
-swiotlb_init(int verbose)
+swiotlb_init_anywhere(int verbose, bool allocate_anywhere)
 {
 	size_t default_size = IO_TLB_DEFAULT_SIZE;
 	unsigned char *vstart;
@@ -257,8 +257,12 @@ swiotlb_init(int verbose)
 
 	bytes = io_tlb_nslabs << IO_TLB_SHIFT;
 
-	/* Get IO TLB memory from the low pages */
-	vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
+	if (allocate_anywhere)
+		vstart = memblock_alloc(PAGE_ALIGN(bytes), PAGE_SIZE);
+	else
+		/* Get IO TLB memory from the low pages */
+		vstart = memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
+
 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
 		return;
 
