Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30B7C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A717624955
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dO9U9DQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgEDOvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:51:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgEDOvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:51:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9GP024674;
        Mon, 4 May 2020 14:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=p0tYN8+DxLbVADW76AZKM7InJpaQ2V4ebiI+EuWm4L4=;
 b=dO9U9DQijykqredOTtBqvm++EIUo64O298gL3GNoxQBLBWJ3yZparDKY6GxulpT5DA20
 BB1pWSYic19hp2D4eh9IYSBOWCE3P/yrrkOgeLLoVfCVMHfnQtgQ+317Dnl+Prh8zApi
 P0MLn2XLo66iZifiO7r/XbyuKiF9Ks+c0URdUdrYgXjI+gdbJrF7uQpKdKFkpDQLl1PR
 ZEVECcsa6mijtB5mjDI7AkTXwtgN/faPbn+SvAbHA8Y5tXoJ7nQE4Gh7LfAzK+t9IfE2
 QxsNLju6fqS55t5Iia/GM/x43Is3Jnp7oNeH3bj7E5/DMiJZ6RGKQY6dyr9UxlzbCXbN Yg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm7bkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elcva053565;
        Mon, 4 May 2020 14:51:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r2e12u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:14 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044EpDY3022514;
        Mon, 4 May 2020 14:51:13 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:12 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-1 3/7] mm/asi: Improve TLB flushing when switching to an ASI pagetable
Date:   Mon,  4 May 2020 16:49:35 +0200
Message-Id: <20200504144939.11318-4-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504144939.11318-1-alexandre.chartre@oracle.com>
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to an ASI pagetable, the TLB doesn't need to be flushed
if it was previously used with the same PCID. So, to avoid unnecessary
TLB flushing, we track which pagetables are used with the different
ASI PCIDs. If an ASI PCID is being used with a different ASI pagetable,
or if we have a new generation of the same ASI pagetable, then the TLB
needs to be flushed. This behavior is similar to the context tracking
done when switching mm.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h | 23 +++++++++++++++++++++++
 arch/x86/mm/asi.c          | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 29b745ab393e..bcfb68e8e392 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -46,8 +46,26 @@
 
 #include <asm/asi_session.h>
 
+/*
+ * ASI_NR_DYN_ASIDS is the same as TLB_NR_DYN_ASIDS. We can't directly
+ * use TLB_NR_DYN_ASIDS because asi.h and tlbflush.h can't both include
+ * each other.
+ */
+#define ASI_TLB_NR_DYN_ASIDS	6
+
+struct asi_tlb_pgtable {
+	u64 id;
+	u64 gen;
+};
+
+struct asi_tlb_state {
+	struct asi_tlb_pgtable	tlb_pgtables[ASI_TLB_NR_DYN_ASIDS];
+};
+
 struct asi_type {
 	int			pcid_prefix;	/* PCID prefix */
+	struct asi_tlb_state	*tlb_state;	/* percpu ASI TLB state */
+	atomic64_t		last_pgtable_id; /* last id for this type */
 };
 
 /*
@@ -58,8 +76,11 @@ struct asi_type {
  * specified type.
  */
 #define DEFINE_ASI_TYPE(name, pcid_prefix)			\
+	DEFINE_PER_CPU(struct asi_tlb_state, asi_tlb_ ## name);	\
 	struct asi_type asi_type_ ## name = {			\
 		pcid_prefix,					\
+		&asi_tlb_ ## name,				\
+		ATOMIC64_INIT(1),				\
 	};							\
 	EXPORT_SYMBOL(asi_type_ ## name)
 
@@ -76,6 +97,8 @@ static inline struct asi *asi_create_ ## name(void)	\
 struct asi {
 	struct asi_type		*type;		/* ASI type */
 	pgd_t			*pagetable;	/* ASI pagetable */
+	u64			pgtable_id;	/* ASI pagetable ID */
+	atomic64_t		pgtable_gen;	/* ASI pagetable generation */
 	unsigned long		base_cr3;	/* base ASI CR3 */
 };
 
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 9fbc92122ce2..cf0d122a3c72 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -25,6 +25,8 @@ struct asi *asi_create(struct asi_type *type)
 		return NULL;
 
 	asi->type = type;
+	asi->pgtable_id = atomic64_inc_return(&type->last_pgtable_id);
+	atomic64_set(&asi->pgtable_gen, 0);
 
 	return asi;
 }
@@ -61,6 +63,33 @@ void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
 }
 EXPORT_SYMBOL(asi_set_pagetable);
 
+/*
+ * Update ASI TLB flush information for the specified ASI CR3 value.
+ * Return an updated ASI CR3 value which specified if TLB needs to
+ * be flushed or not.
+ */
+static unsigned long asi_update_flush(struct asi *asi, unsigned long asi_cr3)
+{
+	struct asi_tlb_pgtable *tlb_pgtable;
+	struct asi_tlb_state *tlb_state;
+	s64 pgtable_gen;
+	u16 pcid;
+
+	pcid = asi_cr3 & ASI_KERNEL_PCID_MASK;
+	tlb_state = get_cpu_ptr(asi->type->tlb_state);
+	tlb_pgtable = &tlb_state->tlb_pgtables[pcid - 1];
+	pgtable_gen = atomic64_read(&asi->pgtable_gen);
+	if (tlb_pgtable->id == asi->pgtable_id &&
+	    tlb_pgtable->gen == pgtable_gen) {
+		asi_cr3 |= X86_CR3_PCID_NOFLUSH;
+	} else {
+		tlb_pgtable->id = asi->pgtable_id;
+		tlb_pgtable->gen = pgtable_gen;
+	}
+
+	return asi_cr3;
+}
+
 static void asi_switch_to_asi_cr3(struct asi *asi)
 {
 	unsigned long original_cr3, asi_cr3;
@@ -72,10 +101,11 @@ static void asi_switch_to_asi_cr3(struct asi *asi)
 	original_cr3 = __get_current_cr3_fast();
 
 	/* build the ASI cr3 value */
-	asi_cr3 = asi->base_cr3;
 	if (boot_cpu_has(X86_FEATURE_PCID)) {
 		pcid = original_cr3 & ASI_KERNEL_PCID_MASK;
-		asi_cr3 |= pcid;
+		asi_cr3 = asi_update_flush(asi, asi->base_cr3 | pcid);
+	} else {
+		asi_cr3 = asi->base_cr3;
 	}
 
 	/* get the ASI session ready for entering ASI */
-- 
2.18.2

