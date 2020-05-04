Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C436BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A173D20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kovaqTW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgEDPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgEDPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elb0V116465;
        Mon, 4 May 2020 14:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=sEQgjOdo4evI2vW/F7vLXsA4dt9pdUoHUZxHqkXr9QA=;
 b=kovaqTW9aibWjjOMYJyd5NFACyd7FB91PiCgvJWE159s4VLHkgk8SO2v0OxgU+W2LuYx
 1crYD2Cy3Z+BDMesBUvZN4pir+op/dLUD78XgAlF7bc6fSjypaWY2GkqUuRP5CATgm/R
 lhEYlPvfgi5OIuZ3OiNMJgOqqwzbtXtR8wf4a1XKJApZK6Gvhl8cdqX0ITQzzPPoYaTG
 XWAqnccys3S3GzN5Plit7Fampc6/mwxd86NtLnJyZeYz49iC4pn0yoZfO8PfTAfdpayK
 UjfPWQiZs51ZKRYCc23YjN+4wj6DyheCs8UZ8dwUO4AhzMD6Hc49aq+41WVb+dizfi6u rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qyfrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVHV105667;
        Mon, 4 May 2020 14:59:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjw0g7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:54 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044ExrQj001259;
        Mon, 4 May 2020 14:59:53 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:52 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 05/13] mm/dpt: Add decorated page-table entry set functions
Date:   Mon,  4 May 2020 16:58:02 +0200
Message-Id: <20200504145810.11882-6-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
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

Add wrappers around the page table entry (pgd/p4d/pud/pmd) set
functions which check that an existing entry is not being
overwritten.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/mm/dpt.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index a2f54ba00255..7a1b4cd53b03 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -258,6 +258,132 @@ static p4d_t *dpt_p4d_alloc(struct dpt *dpt, pgd_t *pgd, unsigned long addr)
 	return p4d;
 }
 
+/*
+ * dpt_set_pXX() functions are equivalent to kernel set_pXX() functions
+ * but, in addition, they ensure that they are not overwriting an already
+ * existing reference in the decorated page table. Otherwise an error is
+ * returned.
+ */
+
+static int dpt_set_pte(struct dpt *dpt, pte_t *pte, pte_t pte_value)
+{
+#ifdef DEBUG
+	/*
+	 * The pte pointer should come from dpt_pte_alloc() or dpt_pte_offset()
+	 * both of which check if the pointer is in the decorated page table.
+	 * So this is a paranoid check to ensure the pointer is really in the
+	 * decorated page table.
+	 */
+	if (!dpt_valid_offset(dpt, pte)) {
+		pr_err("DPT %p: PTE %px not found\n", dpt, pte);
+		return -EINVAL;
+	}
+#endif
+	set_pte(pte, pte_value);
+
+	return 0;
+}
+
+static int dpt_set_pmd(struct dpt *dpt, pmd_t *pmd, pmd_t pmd_value)
+{
+#ifdef DEBUG
+	/*
+	 * The pmd pointer should come from dpt_pmd_alloc() or dpt_pmd_offset()
+	 * both of which check if the pointer is in the decorated page table.
+	 * So this is a paranoid check to ensure the pointer is really in the
+	 * decorated page table.
+	 */
+	if (!dpt_valid_offset(dpt, pmd)) {
+		pr_err("DPT %p: PMD %px not found\n", dpt, pmd);
+		return -EINVAL;
+	}
+#endif
+	if (pmd_val(*pmd) == pmd_val(pmd_value))
+		return 0;
+
+	if (!pmd_none(*pmd)) {
+		pr_err("DPT %p: PMD %px overwriting %lx with %lx\n",
+		       dpt, pmd, pmd_val(*pmd), pmd_val(pmd_value));
+		return -EBUSY;
+	}
+
+	set_pmd(pmd, pmd_value);
+
+	return 0;
+}
+
+static int dpt_set_pud(struct dpt *dpt, pud_t *pud, pud_t pud_value)
+{
+#ifdef DEBUG
+	/*
+	 * The pud pointer should come from dpt_pud_alloc() or dpt_pud_offset()
+	 * both of which check if the pointer is in the decorated page table.
+	 * So this is a paranoid check to ensure the pointer is really in the
+	 * decorated page table.
+	 */
+	if (!dpt_valid_offset(dpt, pud)) {
+		pr_err("DPT %p: PUD %px not found\n", dpt, pud);
+		return -EINVAL;
+	}
+#endif
+	if (pud_val(*pud) == pud_val(pud_value))
+		return 0;
+
+	if (!pud_none(*pud)) {
+		pr_err("DPT %p: PUD %px overwriting %lx with %lx\n",
+		       dpt, pud, pud_val(*pud), pud_val(pud_value));
+		return -EBUSY;
+	}
+
+	set_pud(pud, pud_value);
+
+	return 0;
+}
+
+static int dpt_set_p4d(struct dpt *dpt, p4d_t *p4d, p4d_t p4d_value)
+{
+#ifdef DEBUG
+	/*
+	 * The p4d pointer should come from dpt_p4d_alloc() or dpt_p4d_offset()
+	 * both of which check if the pointer is in the decorated page table.
+	 * So this is a paranoid check to ensure the pointer is really in the
+	 * decorated page table.
+	 */
+	if (!dpt_valid_offset(dpt, p4d)) {
+		pr_err("DPT %p: P4D %px not found\n", dpt, p4d);
+		return -EINVAL;
+	}
+#endif
+	if (p4d_val(*p4d) == p4d_val(p4d_value))
+		return 0;
+
+	if (!p4d_none(*p4d)) {
+		pr_err("DPT %p: P4D %px overwriting %lx with %lx\n",
+		       dpt, p4d, p4d_val(*p4d), p4d_val(p4d_value));
+		return -EBUSY;
+	}
+
+	set_p4d(p4d, p4d_value);
+
+	return 0;
+}
+
+static int dpt_set_pgd(struct dpt *dpt, pgd_t *pgd, pgd_t pgd_value)
+{
+	if (pgd_val(*pgd) == pgd_val(pgd_value))
+		return 0;
+
+	if (!pgd_none(*pgd)) {
+		pr_err("DPT %p: PGD %px overwriting %lx with %lx\n",
+		       dpt, pgd, pgd_val(*pgd), pgd_val(pgd_value));
+		return -EBUSY;
+	}
+
+	set_pgd(pgd, pgd_value);
+
+	return 0;
+}
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

