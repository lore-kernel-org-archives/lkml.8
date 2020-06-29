Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121BCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF8420663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZA/9y5fL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgF2Swg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:52:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgF2Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TIqIXN105777;
        Mon, 29 Jun 2020 18:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=PXr5z4xVxGeYYRpr4zEXjcUv9wnEGSb27BZRmqn2Gno=;
 b=ZA/9y5fLJQNGGFuk2+vWQiwRQMU05GMy94wbpN/cm17Xesb20tmlvtpvq7f5mPM+TQZD
 H1vpiyfwEfIZPjZ7QgcLhQZPkqSp/tXPT/iRo2UuEGaQ+IISCQkL0Hi8poEToACpwehC
 9RwYqAIYrsfrSCFpmqPei9VyfsmG9vNspKjB11tJuUjeROGx/1716FA+cjzh4CeX+QqG
 fB4eybeQ5OTJQ0/B2GK859djpyl50LrVOoXJLL4yUKF9YHoCYQ8Hf/oI/8K3DMon4zqS
 iNmOmQnMOlCoobfz5xHQbJ3KKCP33x/j1/Pw2L6WQicBnA2zeqADPyaP0IY8HxONPAFE Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31xx1dn18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 18:52:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05TIgd43023540;
        Mon, 29 Jun 2020 18:50:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31xg113aey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 18:50:17 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05TIoFEf019806;
        Mon, 29 Jun 2020 18:50:15 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 18:50:15 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@kernel.org
Subject: [PATCH] hugetlb: fix pages per hugetlb calculation
Date:   Mon, 29 Jun 2020 11:50:03 -0700
Message-Id: <20200629185003.97202-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006290118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine hpage_nr_pages() was incorrectly used to calculate the
number of base pages in a hugetlb page.  hpage_nr_pages is designed
to be called for THP pages and will return HPAGE_PMD_NR for hugetlb
pages of any size.

Due to the context in which hpage_nr_pages was called, it is unlikely
to produce a user visible error.  The routine with the incorrect call
is only exercised in the case of hugetlb memory error or migration.
In addition, this would need to be on an architecture which supports
huge page sizes less than PMD_SIZE.  And, the vma containing the huge
page would also need to smaller than PMD_SIZE.

Fixes: c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
Cc: stable@kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..fab4485b9e52 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1593,7 +1593,7 @@ static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
 
 	/* Use first found vma */
 	pgoff_start = page_to_pgoff(hpage);
-	pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
+	pgoff_end = pgoff_start + pages_per_huge_page(page_hstate(hpage)) - 1;
 	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
 					pgoff_start, pgoff_end) {
 		struct vm_area_struct *vma = avc->vma;
-- 
2.25.4

