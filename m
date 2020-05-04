Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E7C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22C521973
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gO7Vc2hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEDPAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50496 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbM9116466;
        Mon, 4 May 2020 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2TQALusUHTHT/8DPoOvtUCzsont8/NCzCLNnkMe9NN0=;
 b=gO7Vc2hgHxk88IgVrU2lqBvLzA+jn2bmMAufd4rine3T8INi4HeZhmkXoLx6pjLIrNSg
 3rvg91zvnxZy9muQSvT0WujXuqivwBody/WOJAOSEreyAgEE7mYiK+CTKW7yvdHkNA+S
 r1rsemIlYLILCFDssrLQwAqmEvfcsLmP2B0fOiBMpIShK/bygslzyAGJvZ5xxfLfJ27U
 LUWAH2Lro5M5hZ18UjR7iXKNI7QQsqxfPBmmEEcXu+eFNMJTUuiujA2KMeUH2KyhdvVn
 U5XQwdcvMDo+rES/bx6XLZzppc3Dx8YxnL6ParysXVKxF97LXuD3EniDwlmZGQMJU99a iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qyfr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVaC105750;
        Mon, 4 May 2020 14:59:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw0g03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:51 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044Exng3027530;
        Mon, 4 May 2020 14:59:49 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:48 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 04/13] mm/dpt: Add decorated page-table entry allocation functions
Date:   Mon,  4 May 2020 16:58:01 +0200
Message-Id: <20200504145810.11882-5-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions to allocate p4d/pud/pmd/pte pages for an decorated
page-table and keep track of them.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/mm/dpt.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 44aad99bc3dc..a2f54ba00255 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -4,6 +4,7 @@
  *
  */
 
+#include <linux/mm.h>
 #include <linux/slab.h>
 
 #include <asm/dpt.h>
@@ -148,6 +149,115 @@ static p4d_t *dpt_p4d_offset(struct dpt *dpt,
 	return p4d;
 }
 
+/*
+ * dpt_pXX_alloc() functions are equivalent to kernel pXX_alloc() functions
+ * but, in addition, they keep track of new pages allocated for the specified
+ * decorated page-table.
+ */
+
+static pte_t *dpt_pte_alloc(struct dpt *dpt, pmd_t *pmd, unsigned long addr)
+{
+	struct page *page;
+	pte_t *pte;
+	int err;
+
+	if (pmd_none(*pmd)) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		pte = (pte_t *)page_address(page);
+		err = dpt_add_backend_page(dpt, pte, PGT_LEVEL_PTE);
+		if (err) {
+			free_page((unsigned long)pte);
+			return ERR_PTR(err);
+		}
+		set_pmd_safe(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
+		pte = pte_offset_map(pmd, addr);
+	} else {
+		pte = dpt_pte_offset(dpt, pmd,  addr);
+	}
+
+	return pte;
+}
+
+static pmd_t *dpt_pmd_alloc(struct dpt *dpt, pud_t *pud, unsigned long addr)
+{
+	struct page *page;
+	pmd_t *pmd;
+	int err;
+
+	if (pud_none(*pud)) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		pmd = (pmd_t *)page_address(page);
+		err = dpt_add_backend_page(dpt, pmd, PGT_LEVEL_PMD);
+		if (err) {
+			free_page((unsigned long)pmd);
+			return ERR_PTR(err);
+		}
+		set_pud_safe(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		pmd = pmd_offset(pud, addr);
+	} else {
+		pmd = dpt_pmd_offset(dpt, pud, addr);
+	}
+
+	return pmd;
+}
+
+static pud_t *dpt_pud_alloc(struct dpt *dpt, p4d_t *p4d, unsigned long addr)
+{
+	struct page *page;
+	pud_t *pud;
+	int err;
+
+	if (p4d_none(*p4d)) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		pud = (pud_t *)page_address(page);
+		err = dpt_add_backend_page(dpt, pud, PGT_LEVEL_PUD);
+		if (err) {
+			free_page((unsigned long)pud);
+			return ERR_PTR(err);
+		}
+		set_p4d_safe(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
+		pud = pud_offset(p4d, addr);
+	} else {
+		pud = dpt_pud_offset(dpt, p4d, addr);
+	}
+
+	return pud;
+}
+
+static p4d_t *dpt_p4d_alloc(struct dpt *dpt, pgd_t *pgd, unsigned long addr)
+{
+	struct page *page;
+	p4d_t *p4d;
+	int err;
+
+	if (!pgtable_l5_enabled())
+		return (p4d_t *)pgd;
+
+	if (pgd_none(*pgd)) {
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			return ERR_PTR(-ENOMEM);
+		p4d = (p4d_t *)page_address(page);
+		err = dpt_add_backend_page(dpt, p4d, PGT_LEVEL_P4D);
+		if (err) {
+			free_page((unsigned long)p4d);
+			return ERR_PTR(err);
+		}
+		set_pgd_safe(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
+		p4d = p4d_offset(pgd, addr);
+	} else {
+		p4d = dpt_p4d_offset(dpt, pgd, addr);
+	}
+
+	return p4d;
+}
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

