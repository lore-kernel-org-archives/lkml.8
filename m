Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9002C4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8265624670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kI/RCy3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgBZQXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:12 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgBZQXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFweM6096229;
        Wed, 26 Feb 2020 16:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=fpvkJLOYCuo2Awnt/kSyoENKIknG8iv9ujHYW4iFwwE=;
 b=kI/RCy3BqWaorddlbVpBUTP1gjsKVQBS6O8+swsxuWcpZaMPyzpwj66ZFZ3KP5GBEjUF
 ruQaHz6XHmzabDVE7QgL29sswJE874LFI8XqyxpIzPVph430f43Yl2DYATWzalu9GmpO
 oqNLIwL994sPAQBlLZ8hIFYX20jyfJFbYNA3I2Qc40aD2vD0FZyOHWNYu+JjCuGQYhgk
 a1rnNmm9YmfYvFhXa7cebpqmv5wgkgegrL5pQOC9rk4jXHgynojJoLijddPyfRltC2Zl
 NFZQ0SNCJ5ybKN9zXR2VNlFhuQ380zBQBOrUVuktyFf9zaeib3X+L86gpjGqSuCqsmxj 6A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ydct34r2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGM6h5023034;
        Wed, 26 Feb 2020 16:22:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ydj4hvv23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGMJlm000664;
        Wed, 26 Feb 2020 16:22:19 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:18 -0800
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
Subject: [RFC PATCH v3 3/7] mm/asi: Improve TLB flushing when switching to an ASI pagetable
Date:   Wed, 26 Feb 2020 17:21:56 +0100
Message-Id: <1582734120-26757-4-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
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
 arch/x86/include/asm/asi.h |   23 +++++++++++++++++++++++
 arch/x86/mm/asi.c          |   34 ++++++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index 29b745a..bcfb68e 100644
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
 
@@ -76,6 +97,8 @@ struct asi_type {
 struct asi {
 	struct asi_type		*type;		/* ASI type */
 	pgd_t			*pagetable;	/* ASI pagetable */
+	u64			pgtable_id;	/* ASI pagetable ID */
+	atomic64_t		pgtable_gen;	/* ASI pagetable generation */
 	unsigned long		base_cr3;	/* base ASI CR3 */
 };
 
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 9fbc921..cf0d122 100644
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
1.7.1

