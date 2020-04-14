Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD10C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D320A20768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440227AbgDNPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:10:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440279AbgDNPId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:08:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EF6S1Y035084
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:08:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ba1htq8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:08:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Tue, 14 Apr 2020 16:07:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 16:07:54 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EF8RTu28377202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 15:08:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F20184C044;
        Tue, 14 Apr 2020 15:08:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1594C046;
        Tue, 14 Apr 2020 15:08:26 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.30.155])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 15:08:26 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH RESEND 1/2] mm/mmap.c: add more sanity checks to get_unmapped_area()
Date:   Tue, 14 Apr 2020 17:08:22 +0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1586876678.git.agordeev@linux.ibm.com>
References: <cover.1586876678.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20041415-4275-0000-0000-000003BFC2F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041415-4276-0000-0000-000038D53658
Message-Id: <88d4e091d2905e49f6bed4fd7d98cbab1e9f0fec.1586876678.git.agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_06:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=542 suspectscore=1 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic get_unmapped_area() function does sanity checks
of address and length of the area to be mapped. Yet, it
lacks checking against mmap_min_addr and mmap_end limits.

At the same time the default implementation of functions
arch_get_unmapped_area[_topdown]() and some architecture
callbacks do mmap_min_addr and mmap_end checks on its own.

Put additional checks into the generic code and do not let
architecture callbacks to get away with a possible area
outside of the allowed limits.

That could also relieve arch_get_unmapped_area[_topdown]()
callbacks of own address and length sanity checks.

CC: linux-mm@kvack.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0681bd5..5b22d47 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2208,12 +2208,13 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long);
 
+	const unsigned long mmap_end = arch_get_mmap_end(addr);
 	unsigned long error = arch_mmap_check(addr, len, flags);
 	if (error)
 		return error;
 
 	/* Careful about overflows.. */
-	if (len > TASK_SIZE)
+	if (len > mmap_end - mmap_min_addr)
 		return -ENOMEM;
 
 	get_area = current->mm->get_unmapped_area;
@@ -2234,7 +2235,7 @@ unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
-	if (addr > TASK_SIZE - len)
+	if ((addr < mmap_min_addr) || (addr > mmap_end - len))
 		return -ENOMEM;
 	if (offset_in_page(addr))
 		return -EINVAL;
-- 
1.8.3.1

