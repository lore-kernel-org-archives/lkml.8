Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2D2C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF73B2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgCWN3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:29:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728355AbgCWN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:29:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ND33gM169159
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yxvxx44gm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:29:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Mon, 23 Mar 2020 13:29:36 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Mar 2020 13:29:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02NDTX5858851466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:29:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43A4542042;
        Mon, 23 Mar 2020 13:29:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0151A4204D;
        Mon, 23 Mar 2020 13:29:32 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.39.189])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Mar 2020 13:29:32 +0000 (GMT)
From:   agordeev@linux.ibm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/2] mm/mmap.c: add more sanity checks to get_unmapped_area()
Date:   Mon, 23 Mar 2020 14:29:28 +0100
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1584958099.git.agordeev@linux.ibm.com>
References: <cover.1584958099.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032313-0020-0000-0000-000003B987B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032313-0021-0000-0000-000022120305
Message-Id: <d14f2cff3c891ef2c4b0337d737c6f04beacb124.1584958099.git.agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_04:2020-03-21,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=537 phishscore=0
 suspectscore=1 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

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

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d681a20eb4ea..a0fcb5ca0e06 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2168,12 +2168,13 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
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
@@ -2194,7 +2195,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
-	if (addr > TASK_SIZE - len)
+	if ((addr < mmap_min_addr) || (addr > mmap_end - len))
 		return -ENOMEM;
 	if (offset_in_page(addr))
 		return -EINVAL;
-- 
2.23.0

