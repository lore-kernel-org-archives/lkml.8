Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2940C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AD020735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgCWN3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:29:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbgCWN3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:29:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NDChUs053251
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:38 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf0ms232-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:38 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Mon, 23 Mar 2020 13:29:35 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Mar 2020 13:29:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02NDTX8458851470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:29:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A39A84204C;
        Mon, 23 Mar 2020 13:29:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5994842047;
        Mon, 23 Mar 2020 13:29:33 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.39.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Mar 2020 13:29:33 +0000 (GMT)
From:   agordeev@linux.ibm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/2] mm/mmap.c: do not allow mappings outside of allowed limits
Date:   Mon, 23 Mar 2020 14:29:29 +0100
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1584958099.git.agordeev@linux.ibm.com>
References: <cover.1584958099.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032313-0012-0000-0000-000003963A1B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032313-0013-0000-0000-000021D32A7F
Message-Id: <d6da1319114a331095052638f0ffa3ccb0be58f1.1584958099.git.agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_04:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=445 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

It is possible to request a fixed mapping address below
mmap_min_addr and succeed. This update adds early checks
of mmap_min_addr and mmap_end boundaries and fixes the
above issue.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/mmap.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a0fcb5ca0e06..bd673a01b1d0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -59,6 +59,14 @@
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
 
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)	(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr, base) (base)
+#endif
+
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
 const int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
@@ -1366,6 +1374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long pgoff, unsigned long *populate,
 			struct list_head *uf)
 {
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
@@ -1388,8 +1397,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (flags & MAP_FIXED_NOREPLACE)
 		flags |= MAP_FIXED;
 
-	if (!(flags & MAP_FIXED))
+	if (flags & MAP_FIXED) {
+		if ((addr < mmap_min_addr) || (addr > mmap_end))
+			return -ENOMEM;
+	} else {
 		addr = round_hint_to_min(addr);
+	}
 
 	/* Careful about overflows.. */
 	len = PAGE_ALIGN(len);
@@ -2050,15 +2063,6 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	return gap_end;
 }
 
-
-#ifndef arch_get_mmap_end
-#define arch_get_mmap_end(addr)	(TASK_SIZE)
-#endif
-
-#ifndef arch_get_mmap_base
-#define arch_get_mmap_base(addr, base) (base)
-#endif
-
 /* Get an address range which is currently unmapped.
  * For shmat() with addr=0.
  *
-- 
2.23.0

