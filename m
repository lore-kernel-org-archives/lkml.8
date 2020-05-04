Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652DC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755AE206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NYaPu6pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgEDPAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbDo116519;
        Mon, 4 May 2020 14:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=ItAga/RAZZLJV2kYsxGyvAeBJnzaxmTXCE/C0Q2axKc=;
 b=NYaPu6pUwjVJ3gCuMmIeR4QjgnjJAa1EfrSnTxbil4a2AIEQnfp5a3IaEV4En82n/9yJ
 QKzIqppk1aCLias8xSIi3Hdf/5k6pH4iWeimowFwt0UtX25QaaQT/EMTM4/wBSVJBQpG
 T9+L70neL+NhewAs4vErWbCyeqzWqQniZWEeXy6rwJY8oXFgLs/cOg6ku6dPIzv21I4+
 jNK2CnZJe5oI6nUgtW4FUZLA87Eu0ZlmOvrmHOsPv1TFt6KsiiqkCnrMiiSmaXbQhVWz
 clS6E1vVtFMO4hetYxBiUvXFOP/1e1ptoJxt8B8uUaARL0+MuP9uvDF86QPWIgaD3GwU zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09qyfqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EkelF094657;
        Mon, 4 May 2020 14:59:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdqq654-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:46 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044Exi5M022173;
        Mon, 4 May 2020 14:59:44 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:44 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 03/13] mm/dpt: Add decorated page-table entry offset functions
Date:   Mon,  4 May 2020 16:58:00 +0200
Message-Id: <20200504145810.11882-4-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wrappers around the p4d/pud/pmd/pte offset kernel functions which
ensure that page-table pointers are in the specified decorated page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/mm/dpt.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index 6df2d4fde8ec..44aad99bc3dc 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -82,6 +82,72 @@ static bool dpt_valid_offset(struct dpt *dpt, void *offset)
 	return valid;
 }
 
+/*
+ * dpt_pXX_offset() functions are equivalent to kernel pXX_offset()
+ * functions but, in addition, they ensure that page table pointers
+ * are in the specified decorated page table. Otherwise an error is
+ * returned.
+ */
+
+static pte_t *dpt_pte_offset(struct dpt *dpt,
+			     pmd_t *pmd, unsigned long addr)
+{
+	pte_t *pte;
+
+	pte = pte_offset_map(pmd, addr);
+	if (!dpt_valid_offset(dpt, pte)) {
+		pr_err("DPT %p: PTE %px not found\n", dpt, pte);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pte;
+}
+
+static pmd_t *dpt_pmd_offset(struct dpt *dpt,
+			     pud_t *pud, unsigned long addr)
+{
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	if (!dpt_valid_offset(dpt, pmd)) {
+		pr_err("DPT %p: PMD %px not found\n", dpt, pmd);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pmd;
+}
+
+static pud_t *dpt_pud_offset(struct dpt *dpt,
+			     p4d_t *p4d, unsigned long addr)
+{
+	pud_t *pud;
+
+	pud = pud_offset(p4d, addr);
+	if (!dpt_valid_offset(dpt, pud)) {
+		pr_err("DPT %p: PUD %px not found\n", dpt, pud);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return pud;
+}
+
+static p4d_t *dpt_p4d_offset(struct dpt *dpt,
+			     pgd_t *pgd, unsigned long addr)
+{
+	p4d_t *p4d;
+
+	p4d = p4d_offset(pgd, addr);
+	/*
+	 * p4d is the same has pgd if we don't have a 5-level page table.
+	 */
+	if ((p4d != (p4d_t *)pgd) && !dpt_valid_offset(dpt, p4d)) {
+		pr_err("DPT %p: P4D %px not found\n", dpt, p4d);
+		return ERR_PTR(-EINVAL);
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

