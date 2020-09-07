Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D2AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDFF2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="BF+Q5yzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgIGSzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:55:36 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45880 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729431AbgIGSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:06 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IpxfU013304;
        Mon, 7 Sep 2020 18:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=ta0sRAikgKXqJfDwERCbWSmIDqgpG3X4PTZC1iNcKQ0=;
 b=BF+Q5yzHzcHuW9Ihq6Z9TPHd7bf3wsvIYL3UUVrUiH30jO3KTjPjiVfiQ4jLUrA+b7NP
 kFXWo5k1AnAWpvV0yYoiVkePqUhhNa1oQa83L3MHnq0Fes9r5dVl8gVTRWcs9cce9fBG
 r/Tdb9ADLhLbMThoYim2Yk4xERxD5PNpaFeMB7mRAx3VWklkDMF7vVFvDHhv8hs3nlAj
 QXKSmXjAK2Zk7oo51H8IEw0F6/elsHQx8UMnXFN6901o05oDtgjBUKiuIyRCYwWKyrcG
 y+V41YA+aEcFV7gf3hf+v5IBn+vtzd89PJRTAEO9FoYNwfnnmp8zIZjPPAf9Tod+JXFS Yw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cm1x4r5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:34 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 0435656;
        Mon,  7 Sep 2020 18:54:33 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 980D730060F14; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185431.537894945@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:42 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 12/12] x86/platform/uv: Update for UV5 NMI MMR changes
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UV NMI MMR addresses and fields moved between UV4 and UV5
necessitating a rewrite of the UV NMI handler.  Adjust references
to accommodate those changes.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h |   13 -------
 arch/x86/platform/uv/uv_nmi.c    |   65 +++++++++++++++++++++++++++++++++------
 2 files changed, 55 insertions(+), 23 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv_hub.h
+++ linux/arch/x86/include/asm/uv/uv_hub.h
@@ -735,19 +735,6 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_NMI_MMR_SHIFT	63
 #define UVH_NMI_MMR_TYPE	"SCRATCH5"
 
-/* Newer SMM NMI handler, not present in all systems */
-#define UVH_NMI_MMRX		UVH_EVENT_OCCURRED0
-#define UVH_NMI_MMRX_CLEAR	UVH_EVENT_OCCURRED0_ALIAS
-#define UVH_NMI_MMRX_SHIFT	UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT
-#define UVH_NMI_MMRX_TYPE	"EXTIO_INT0"
-
-/* Non-zero indicates newer SMM NMI handler present */
-#define UVH_NMI_MMRX_SUPPORTED	UVH_EXTIO_INT0_BROADCAST
-
-/* Indicates to BIOS that we want to use the newer SMM NMI handler */
-#define UVH_NMI_MMRX_REQ	UVH_BIOS_KERNEL_MMR_ALIAS_2
-#define UVH_NMI_MMRX_REQ_SHIFT	62
-
 struct uv_hub_nmi_s {
 	raw_spinlock_t	nmi_lock;
 	atomic_t	in_nmi;		/* flag this node in UV NMI IRQ */
--- linux.orig/arch/x86/platform/uv/uv_nmi.c
+++ linux/arch/x86/platform/uv/uv_nmi.c
@@ -2,8 +2,9 @@
 /*
  * SGI NMI support routines
  *
- *  Copyright (c) 2009-2013 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Mike Travis
+ * Copyright (C) 2018-2020 Hewlett Packard Enterprise Development LP
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Mike Travis
  */
 
 #include <linux/cpu.h>
@@ -54,6 +55,20 @@ static struct uv_hub_nmi_s **uv_hub_nmi_
 
 DEFINE_PER_CPU(struct uv_cpu_nmi_s, uv_cpu_nmi);
 
+/* Newer SMM NMI handler, not present in all systems */
+static unsigned long uvh_nmi_mmrx;		/* UVH_EVENT_OCCURRED0/1 */
+static unsigned long uvh_nmi_mmrx_clear;	/* UVH_EVENT_OCCURRED0/1_ALIAS */
+static int uvh_nmi_mmrx_shift;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
+static int uvh_nmi_mmrx_mask;			/* UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
+static char *uvh_nmi_mmrx_type;			/* "EXTIO_INT0" */
+
+/* Non-zero indicates newer SMM NMI handler present */
+static unsigned long uvh_nmi_mmrx_supported;	/* UVH_EXTIO_INT0_BROADCAST */
+
+/* Indicates to BIOS that we want to use the newer SMM NMI handler */
+static unsigned long uvh_nmi_mmrx_req;		/* UVH_BIOS_KERNEL_MMR_ALIAS_2 */
+static int uvh_nmi_mmrx_req_shift;		/* 62 */
+
 /* UV hubless values */
 #define NMI_CONTROL_PORT	0x70
 #define NMI_DUMMY_PORT		0x71
@@ -227,13 +242,43 @@ static inline bool uv_nmi_action_is(cons
 /* Setup which NMI support is present in system */
 static void uv_nmi_setup_mmrs(void)
 {
-	if (uv_read_local_mmr(UVH_NMI_MMRX_SUPPORTED)) {
-		uv_write_local_mmr(UVH_NMI_MMRX_REQ,
-					1UL << UVH_NMI_MMRX_REQ_SHIFT);
-		nmi_mmr = UVH_NMI_MMRX;
-		nmi_mmr_clear = UVH_NMI_MMRX_CLEAR;
-		nmi_mmr_pending = 1UL << UVH_NMI_MMRX_SHIFT;
-		pr_info("UV: SMI NMI support: %s\n", UVH_NMI_MMRX_TYPE);
+	/* First determine arch specific MMRs to handshake with BIOS */
+	if (UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED0;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED0_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED0_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED0_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD0-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else if (UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK) {
+		uvh_nmi_mmrx = UVH_EVENT_OCCURRED1;
+		uvh_nmi_mmrx_clear = UVH_EVENT_OCCURRED1_ALIAS;
+		uvh_nmi_mmrx_shift = UVH_EVENT_OCCURRED1_EXTIO_INT0_SHFT;
+		uvh_nmi_mmrx_mask = UVH_EVENT_OCCURRED1_EXTIO_INT0_MASK;
+		uvh_nmi_mmrx_type = "OCRD1-EXTIO_INT0";
+
+		uvh_nmi_mmrx_supported = UVH_EXTIO_INT0_BROADCAST;
+		uvh_nmi_mmrx_req = UVH_BIOS_KERNEL_MMR_ALIAS_2;
+		uvh_nmi_mmrx_req_shift = 62;
+
+	} else {
+		pr_err("UV:%s:cannot find EVENT_OCCURRED*_EXTIO_INT0\n",
+			__func__);
+		return;
+	}
+
+	/* Then find out if new NMI is supported */
+	if (likely(uv_read_local_mmr(uvh_nmi_mmrx_supported))) {
+		uv_write_local_mmr(uvh_nmi_mmrx_req,
+					1UL << uvh_nmi_mmrx_req_shift);
+		nmi_mmr = uvh_nmi_mmrx;
+		nmi_mmr_clear = uvh_nmi_mmrx_clear;
+		nmi_mmr_pending = 1UL << uvh_nmi_mmrx_shift;
+		pr_info("UV: SMI NMI support: %s\n", uvh_nmi_mmrx_type);
 	} else {
 		nmi_mmr = UVH_NMI_MMR;
 		nmi_mmr_clear = UVH_NMI_MMR_CLEAR;
@@ -1049,5 +1094,5 @@ void __init uv_nmi_setup_hubless(void)
 	/* Ensure NMI enabled in Processor Interface Reg: */
 	uv_reassert_nmi();
 	uv_register_nmi_notifier();
-	pr_info("UV: Hubless NMI enabled\n");
+	pr_info("UV: PCH NMI enabled\n");
 }

