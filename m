Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC00C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D81D2078E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yORRV0oY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgEDPGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:06:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbgEDPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:06:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EnCJ6024811;
        Mon, 4 May 2020 15:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=3HTd6a/kkIIAOtF/XlS6dHGOCc3Mh+Pqrk2elGvT+Tk=;
 b=yORRV0oYlMSn935vfd2pC0Z1Mje0vWHKOJTjBC+EdVNPPXcRUdvCTawt3JP3GLhN3AHD
 Hhmmq3uWs8uyfU6Tl5w0IjP3dFNBiEdb473+e+A3mrZe7rLvhq3nHkafYB4tva+QiW8H
 WW6CRNuPimlGg0q6umF/F+doaFLznl0HOHh2DxJCd709f8blfHqFybRqxw1vBqw1lOzx
 ywZeB3+RCe81OTiB64xQzp4t7BuoitQODBsmBgbONYSN47tXHUjfaqtHdkz1AD/cysDx
 mlfIwhpbtZ07FuagtA4OgI/3pHMaVeV7cLUfMm+IJgRkGnZv3RzTz9/+6hc6JBUhzO+y pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm7f5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElaHf053343;
        Mon, 4 May 2020 15:04:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r2f5ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:10 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F49Ml028395;
        Mon, 4 May 2020 15:04:09 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:08 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 01/14] mm/asi: Define the test ASI type
Date:   Mon,  4 May 2020 17:02:22 +0200
Message-Id: <20200504150235.12171-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
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

Define the test ASI type which can be used for testing or experimenting
ASI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h | 2 ++
 arch/x86/mm/asi.c          | 1 +
 drivers/staging/Makefile   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
index eafed750e07f..de4f790c630b 100644
--- a/arch/x86/include/asm/asi.h
+++ b/arch/x86/include/asm/asi.h
@@ -66,6 +66,7 @@ struct asi_tlb_state {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define ASI_PCID_PREFIX_USER		0x80	/* user ASI */
 #endif
+#define ASI_PCID_PREFIX_TEST		0xff	/* test ASI */
 
 struct asi_type {
 	int			pcid_prefix;	/* PCID prefix */
@@ -156,6 +157,7 @@ extern int asi_init_dpt(struct dpt *dpt);
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 DECLARE_ASI_TYPE(user);
 #endif
+DECLARE_ASI_TYPE(test);
 
 static inline void asi_set_log_policy(struct asi *asi, int policy)
 {
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index 8b670ed13729..e0b0d70415d7 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -17,6 +17,7 @@
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 DEFINE_ASI_TYPE(user, ASI_PCID_PREFIX_USER, false);
 #endif
+DEFINE_ASI_TYPE(test, ASI_PCID_PREFIX_TEST, true);
 
 static void asi_log_fault(struct asi *asi, struct pt_regs *regs,
 			   unsigned long error_code, unsigned long address,
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 4d34198151b3..fb50e669579b 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -50,3 +50,4 @@ obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_QLGE)		+= qlge/
 obj-$(CONFIG_WFX)		+= wfx/
+obj-$(CONFIG_ADDRESS_SPACE_ISOLATION) += asi/
-- 
2.18.2

