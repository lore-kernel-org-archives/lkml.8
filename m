Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FC1206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cozJiluR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEDPDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:03:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53650 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgEDPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:03:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elbmn116463;
        Mon, 4 May 2020 15:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=Znxthj2nB/nosH+Hjc7m0rLCqlY1NvIB6ejFhn9Kd3E=;
 b=cozJiluRmq0O+l+y6gIqT1Prl0V56vFPgnUWM/9RBWpnAn3EMhRYfGrZ97Pa8nAseCif
 PtuJLdF2NDXMVxVSximHqbqY2YSjKkK9H5YmlpbBxhnjO9ZfzPH2mo2qIj9dQrx2nRqL
 tRbzgsIRubuKpk3sj0ukXWkU+bmkQwBAkv9/P8uzgAjjnT9F8uEHP+kwWHcnwdjoqhcV
 O78cxxvjUQHguahyjUzPdGHfBSRLb94EIKu+B2TDZxt8lDFae1/93Ev2q/KanGYSg2D9
 XdVtz42LC8PFmnAv0EcHN6ouC1rf3EOzInCRsvjEu1/SH3RfCbGYIrYVOiS8vINSI9vs +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30s09qygch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:02:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElaEu053343;
        Mon, 4 May 2020 15:00:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r2eu6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:00:23 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F0ImZ026075;
        Mon, 4 May 2020 15:00:18 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:00:17 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 11/13] mm/dpt: Add decorated page-table remap function
Date:   Mon,  4 May 2020 16:58:08 +0200
Message-Id: <20200504145810.11882-12-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
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

Add a function to remap an already mapped buffer with a new address in
a decorated page-table: the already mapped buffer is unmapped, and a
new mapping is added for the specified new address.

This is useful to track and remap a buffer which can be freed and
then reallocated.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h |  1 +
 arch/x86/mm/dpt.c          | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
index fd8c1b84ffe2..3234ba968d80 100644
--- a/arch/x86/include/asm/dpt.h
+++ b/arch/x86/include/asm/dpt.h
@@ -57,6 +57,7 @@ extern int dpt_map_range(struct dpt *dpt, void *ptr, size_t size,
 			 enum page_table_level level);
 extern int dpt_map(struct dpt *dpt, void *ptr, unsigned long size);
 extern void dpt_unmap(struct dpt *dpt, void *ptr);
+extern int dpt_remap(struct dpt *dpt, void **mapping, void *ptr, size_t size);
 
 static inline int dpt_map_module(struct dpt *dpt, char *module_name)
 {
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
index adc59f9ed876..9517e3081716 100644
--- a/arch/x86/mm/dpt.c
+++ b/arch/x86/mm/dpt.c
@@ -809,6 +809,31 @@ int dpt_map_percpu(struct dpt *dpt, void *percpu_ptr, size_t size)
 }
 EXPORT_SYMBOL(dpt_map_percpu);
 
+int dpt_remap(struct dpt *dpt, void **current_ptrp, void *new_ptr, size_t size)
+{
+	void *current_ptr = *current_ptrp;
+	int err;
+
+	if (current_ptr == new_ptr) {
+		/* no change, already mapped */
+		return 0;
+	}
+
+	if (current_ptr) {
+		dpt_unmap(dpt, current_ptr);
+		*current_ptrp = NULL;
+	}
+
+	err = dpt_map(dpt, new_ptr, size);
+	if (err)
+		return err;
+
+	*current_ptrp = new_ptr;
+
+	return 0;
+}
+EXPORT_SYMBOL(dpt_remap);
+
 /*
  * dpt_create - allocate a page-table and create a corresponding
  * decorated page-table. The page-table is allocated and aligned
-- 
2.18.2

