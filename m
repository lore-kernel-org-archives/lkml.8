Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C209C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5383F2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437011AbgDNPJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:09:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440280AbgDNPIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:08:34 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EF49XE052373
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:08:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30b6sg8av6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:08:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Tue, 14 Apr 2020 16:07:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 16:07:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EF8RnQ54132906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 15:08:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BADC4C040;
        Tue, 14 Apr 2020 15:08:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 149244C046;
        Tue, 14 Apr 2020 15:08:27 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.30.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 15:08:26 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH RESEND 2/2] mm/mmap.c: deny fixed mappings outside of allowed limits
Date:   Tue, 14 Apr 2020 17:08:23 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1586876678.git.agordeev@linux.ibm.com>
References: <cover.1586876678.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041415-0016-0000-0000-0000030470C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041415-0017-0000-0000-0000336868F9
Message-Id: <b00a3b7d5f4761b8ac789393164f25e1abc48d8d.1586876678.git.agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_07:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=550 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004140123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to request a fixed mapping address below
mmap_min_addr and succeed. This update adds early checks
of mmap_min_addr and mmap_end boundaries and fixes the
above issue.

CC: linux-mm@kvack.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/mmap.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5b22d47..9a16e25 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -62,6 +62,14 @@
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
@@ -1369,6 +1377,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long pgoff, unsigned long *populate,
 			struct list_head *uf)
 {
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
 
@@ -1391,8 +1400,12 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -2089,14 +2102,6 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	return addr;
 }
 
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
1.8.3.1

