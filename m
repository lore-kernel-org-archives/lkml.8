Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D8FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C542076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440315AbgDNPKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:10:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437183AbgDNPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:10:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03EF4JUZ063825
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:10:11 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30dc3rfhx1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:10:11 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <agordeev@linux.ibm.com>;
        Tue, 14 Apr 2020 16:10:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 16:10:01 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03EFA4Pi32243872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 15:10:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCCBA42052;
        Tue, 14 Apr 2020 15:10:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 748BA4204C;
        Tue, 14 Apr 2020 15:10:04 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.30.155])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 15:10:04 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org
Subject: [PATCH] mm/gup: dereference page table entry using helper
Date:   Tue, 14 Apr 2020 17:10:01 +0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 20041415-0028-0000-0000-000003F8251A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041415-0029-0000-0000-000024BDD32C
Message-Id: <1586877001-19138-1-git-send-email-agordeev@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_06:2020-04-14,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 clxscore=1015 spamscore=0 mlxlogscore=873 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=1 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0005d20 ("mm/gup: Move page table entry dereference
into helper function") wrapped access to page table entries
larger than sizeof(long) into a race-aware accessor. One of
the two dereferences in gup_fast path was however overlooked.

CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
CC: linux-mm@kvack.org
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index d53f7dd..eceb98b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2208,7 +2208,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (!head)
 			goto pte_unmap;
 
-		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
+		if (unlikely(pte_val(pte) != pte_val(gup_get_pte(ptep)))) {
 			put_compound_head(head, 1, flags);
 			goto pte_unmap;
 		}
-- 
1.8.3.1

