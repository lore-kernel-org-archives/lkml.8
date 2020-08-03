Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A21C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F1820678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgHCF5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:57:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727889AbgHCF5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:57:09 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0735WrEX068218;
        Mon, 3 Aug 2020 01:56:55 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32pap7tt2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 01:56:54 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0735omWa026674;
        Mon, 3 Aug 2020 05:56:52 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 32n01893t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 05:56:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0735unTs31392074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 05:56:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C057952051;
        Mon,  3 Aug 2020 05:56:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id B7EA852052;
        Mon,  3 Aug 2020 05:56:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 79AC6E03D7; Mon,  3 Aug 2020 07:56:49 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/2] vdso: allow to add architecture-specific vdso data
Date:   Mon,  3 Aug 2020 07:56:44 +0200
Message-Id: <20200803055645.79042-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200803055645.79042-1-svens@linux.ibm.com>
References: <20200803055645.79042-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the possibility to add architecture specific vDSO
data to struct vdso_data. This is useful if the arch specific
user space VDSO code needs additional data during execution.
If CONFIG_ARCH_HAS_VDSO_DATA is defined, the generic code will
include asm/vdso/data.h which should contain 'struct arch_vdso_data'.
This structure will be embedded in the generic vDSO data.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/Kconfig            | 3 +++
 include/vdso/datapage.h | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..e1017ce979e2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -979,6 +979,9 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config ARCH_HAS_VDSO_DATA
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7955c56d6b3c..74e730238ce6 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,10 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+#include <asm/vdso/data.h>
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -97,6 +101,9 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+	struct arch_vdso_data arch;
+#endif
 };
 
 /*
-- 
2.17.1

