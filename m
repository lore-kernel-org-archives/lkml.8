Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D7C3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235524677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCCAZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:25:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726752AbgCCAZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:25:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0230L7m7050651
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 19:25:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yfn16n2a2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 19:25:15 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Tue, 3 Mar 2020 00:25:14 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 00:25:10 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0230P8n339846118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 00:25:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 843A84204C;
        Tue,  3 Mar 2020 00:25:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0AEA4203F;
        Tue,  3 Mar 2020 00:25:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.0.1])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Mar 2020 00:25:07 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     linux-next@vger.kernel.org, akpm@linux-foundation.org,
        jack@suse.cz, kirill@shutemov.name
Cc:     borntraeger@de.ibm.com, david@redhat.com, aarcange@redhat.com,
        linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au,
        jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 1/2] mm/gup: fixup for 9947ea2c1e608e32 "mm/gup: track FOLL_PIN pages"
Date:   Tue,  3 Mar 2020 01:25:05 +0100
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200303002506.173957-1-imbrenda@linux.ibm.com>
References: <20200303002506.173957-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030300-0016-0000-0000-000002EC772E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030300-0017-0000-0000-0000334FBC05
Message-Id: <20200303002506.173957-2-imbrenda@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case pin fails, we need to unpin, a simple put_page will not be enough

fixup for commit 9947ea2c1e608e32 ("mm/gup: track FOLL_PIN pages")

it can be simply squashed in

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 mm/gup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f589299b0d4a..81a95fbe9901 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -116,6 +116,28 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
 	return NULL;
 }
 
+static void put_compound_head(struct page *page, int refs, unsigned int flags)
+{
+	if (flags & FOLL_PIN) {
+		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
+				    refs);
+
+		if (hpage_pincount_available(page))
+			hpage_pincount_sub(page, refs);
+		else
+			refs *= GUP_PIN_COUNTING_BIAS;
+	}
+
+	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
+	/*
+	 * Calling put_page() for each ref is unnecessarily slow. Only the last
+	 * ref needs a put_page().
+	 */
+	if (refs > 1)
+		page_ref_sub(page, refs - 1);
+	put_page(page);
+}
+
 /**
  * try_grab_page() - elevate a page's refcount by a flag-dependent amount
  *
@@ -2134,7 +2156,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 			goto pte_unmap;
 
 		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
-			put_page(head);
+			put_compound_head(head, 1, flags);
 			goto pte_unmap;
 		}
 
@@ -2267,28 +2289,6 @@ static int record_subpages(struct page *page, unsigned long addr,
 	return nr;
 }
 
-static void put_compound_head(struct page *page, int refs, unsigned int flags)
-{
-	if (flags & FOLL_PIN) {
-		mod_node_page_state(page_pgdat(page), NR_FOLL_PIN_RELEASED,
-				    refs);
-
-		if (hpage_pincount_available(page))
-			hpage_pincount_sub(page, refs);
-		else
-			refs *= GUP_PIN_COUNTING_BIAS;
-	}
-
-	VM_BUG_ON_PAGE(page_ref_count(page) < refs, page);
-	/*
-	 * Calling put_page() for each ref is unnecessarily slow. Only the last
-	 * ref needs a put_page().
-	 */
-	if (refs > 1)
-		page_ref_sub(page, refs - 1);
-	put_page(page);
-}
-
 #ifdef CONFIG_ARCH_HAS_HUGEPD
 static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
 				      unsigned long sz)
-- 
2.24.1

