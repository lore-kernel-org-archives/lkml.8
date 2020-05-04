Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D83FC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5424220721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOX7z1yW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgEDPA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51186 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729313AbgEDPAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:54 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbG6116513;
        Mon, 4 May 2020 15:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=5ClwOk8hAM6M0zm7zYo3+G30LLjRZv1vfMafgBD0Iqw=;
 b=iOX7z1yWED8rz7gVbvpEo6SnpLCCF4ZeouDB99xr1IgkZ3XlsF/eK/xXi7ZGZ85VDgXS
 Sqvb1zzwJ+AKfjw42W+CeC616p7RVZvaA5RrEeX/l714yca5ICzhTIu6vhbZJF+yN9J+
 rI4f3jqfKMCEZI2It1GBEPvkhminSBDaSVCuNJ0E89LbKVMd1VksNlNs7AxD08xXYNlC
 ugx6ChcQMdfgDuOMfXwWzs1aqmLmfRt+k5SxBhBUJQLx36BFNDibfSJa3VCzRGbnCHGO
 4e57hhQGSWWWlA0oPBfFExmmUtEFuWxUfKzV2+Arxz4yJk4Z0Obpy+AQ6QBjW3NBa6M3 HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09qyfvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElLHX033714;
        Mon, 4 May 2020 15:00:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30sjnaw42d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:28 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044F0RUp001695;
        Mon, 4 May 2020 15:00:27 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:26 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 13/13] mm/asi: Function to init decorated page-table with ASI core mappings
Date:   Mon,  4 May 2020 16:58:10 +0200
Message-Id: <20200504145810.11882-14-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=67 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=58 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core mappings are the minimal mappings we need to be able to
enter isolation and handle an isolation abort or exit. This
includes the kernel code, the GDT and the percpu ASI sessions.
We also need a stack so we map the current stack when entering
isolation and unmap it on exit/abort.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h |  2 ++
 arch/x86/mm/asi.c          | 57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index ac0594d4f549..eafed750e07f 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -45,6 +45,7 @@
 #include <linux/export.h>
 
 #include <asm/asi_session.h>
+#include <asm/dpt.h>
 
 /*
  * ASI_NR_DYN_ASIDS is the same as TLB_NR_DYN_ASIDS. We can't directly
@@ -150,6 +151,7 @@ extern void asi_destroy(struct asi *asi);
 extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
 extern int asi_enter(struct asi *asi);
 extern void asi_exit(struct asi *asi);
+extern int asi_init_dpt(struct dpt *dpt);
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 DECLARE_ASI_TYPE(user);
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index b63a0a883293..8b670ed13729 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -162,6 +162,63 @@ void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
 }
 EXPORT_SYMBOL(asi_set_pagetable);
 
+/*
+ * asi_init_dpt - Initialize a decorated page-table with the minimum
+ * mappings for using an ASI. Note that this function doesn't map any
+ * stack. If the stack of the task entering an ASI is not mapped then
+ * this will trigger a double-fault as soon as the task tries to access
+ * its stack.
+ */
+int asi_init_dpt(struct dpt *dpt)
+{
+	int err;
+
+	/*
+	 * Map the kernel.
+	 *
+	 * XXX We should check if we can map only kernel text, i.e. map with
+	 * size = _etext - _text
+	 */
+	err = dpt_map(dpt, (void *)__START_KERNEL_map, KERNEL_IMAGE_SIZE);
+	if (err)
+		return err;
+
+	/*
+	 * Map the cpu_entry_area because we need the GDT to be mapped.
+	 * Not sure we need anything else from cpu_entry_area.
+	 */
+	err = dpt_map_range(dpt, (void *)CPU_ENTRY_AREA_PER_CPU, P4D_SIZE,
+			    PGT_LEVEL_P4D);
+	if (err)
+		return err;
+
+	/*
+	 * Map fixed_percpu_data to get the stack canary.
+	 */
+	if (IS_ENABLED(CONFIG_STACKPROTECTOR)) {
+		err = DPT_MAP_CPUVAR(dpt, fixed_percpu_data);
+		if (err)
+			return err;
+	}
+
+	/* Map current_task, we need it for __schedule() */
+	err = DPT_MAP_CPUVAR(dpt, current_task);
+	if (err)
+		return err;
+
+	/*
+	 * Map the percpu ASI tlbstate. This also maps the asi_session
+	 * which is used by interrupt handlers to figure out if we have
+	 * entered isolation and switch back to the kernel address space.
+	 */
+	err = DPT_MAP_CPUVAR(dpt, cpu_tlbstate);
+	if (err)
+		return err;
+
+	return 0;
+}
+EXPORT_SYMBOL(asi_init_dpt);
+
 /*
  * Update ASI TLB flush information for the specified ASI CR3 value.
  * Return an updated ASI CR3 value which specified if TLB needs to
-- 
2.18.2

