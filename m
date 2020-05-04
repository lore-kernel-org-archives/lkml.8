Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D2206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFcw6hwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEDPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:01:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgEDPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:01:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbMF116466;
        Mon, 4 May 2020 15:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=uOEDtCE2eXREwp6VCLNufdVVxnWRr/1oL3nfszUxecU=;
 b=aFcw6hwQWBLe+EOVzoXsQrpKcsrLqOmJquMpCEwhVJUYEP30D5313pso+GeXEV0oMuzW
 dnqfSWgce2f4NBzUZ7P2K0hTB98uhXHu95SBNZSkmtxxK3O44DbOCkqMGzZJRZNxLaaW
 PpLbbHRRj9aNvCryMJgQ05quBQzNsTIjgPW0W/CiAepd5axRLlnSM8HTQrfXvbS0ICCl
 ktce+PsNiZg+74GBgkzV7xEoxPFfcCI8uj+v7dorYKwUb7LNIG3sNdUbeSg8b9PBNMI1
 SlXwUqRb2slMxIPXEkaDoaU73Ls9rPVtwZhVTczhqz348w3eYe+f0s+pWlfh6Vu0h8Ia Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09qyfug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EmVQJ105634;
        Mon, 4 May 2020 15:00:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjw0hv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:16 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F0EQJ027649;
        Mon, 4 May 2020 15:00:14 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:13 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 10/13] mm/dpt: Function to copy page-table entries for percpu buffer
Date:   Mon,  4 May 2020 16:58:07 +0200
Message-Id: <20200504145810.11882-11-alexandre.chartre@oracle.com>
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

Provide functions to copy page-table entries from the kernel page-table
to a decorated page-table for a percpu buffer. A percpu buffer have a
different VA range for each cpu and all them have to be copied.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h |  6 ++++++
 arch/x86/mm/dpt.c          | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index 01727ef0577e..fd8c1b84ffe2 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -78,4 +78,10 @@ static inline int dpt_map_module(struct dpt *dpt, char *module_name)
 	(dpt_map(dpt, THIS_MODULE->core_layout.base,	\
 		 THIS_MODULE->core_layout.size))
 
+extern int dpt_map_percpu(struct dpt *dpt, void *percpu_ptr, size_t size);
+extern void dpt_unmap_percpu(struct dpt *dpt, void *percpu_ptr);
+
+#define	DPT_MAP_CPUVAR(dpt, cpuvar)			\
+	dpt_map_percpu(dpt, &cpuvar, sizeof(cpuvar))
+
 #endif
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index c495c9b59b3e..adc59f9ed876 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -771,6 +771,44 @@ void dpt_unmap(struct dpt *dpt, void *ptr)
 }
 EXPORT_SYMBOL(dpt_unmap);
 
+void dpt_unmap_percpu(struct dpt *dpt, void *percpu_ptr)
+{
+	void *ptr;
+	int cpu;
+
+	pr_debug("DPT %p: UNMAP PERCPU %px\n", dpt, percpu_ptr);
+	for_each_possible_cpu(cpu) {
+		ptr = per_cpu_ptr(percpu_ptr, cpu);
+		pr_debug("DPT %p: UNMAP PERCPU%d %px\n", dpt, cpu, ptr);
+		dpt_unmap(dpt, ptr);
+	}
+}
+EXPORT_SYMBOL(dpt_unmap_percpu);
+
+int dpt_map_percpu(struct dpt *dpt, void *percpu_ptr, size_t size)
+{
+	int cpu, err;
+	void *ptr;
+
+	pr_debug("DPT %p: MAP PERCPU %px\n", dpt, percpu_ptr);
+	for_each_possible_cpu(cpu) {
+		ptr = per_cpu_ptr(percpu_ptr, cpu);
+		pr_debug("DPT %p: MAP PERCPU%d %px\n", dpt, cpu, ptr);
+		err = dpt_map(dpt, ptr, size);
+		if (err) {
+			/*
+			 * Need to unmap any percpu mapping which has
+			 * succeeded before the failure.
+			 */
+			dpt_unmap_percpu(dpt, percpu_ptr);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dpt_map_percpu);
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

