Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC656C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66C9207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 15:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgHDPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:03:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729516AbgHDPBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 11:01:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074Eb8Pd007355;
        Tue, 4 Aug 2020 11:01:34 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32q7kgmyaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 11:01:33 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074Euvtc003591;
        Tue, 4 Aug 2020 15:01:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32mynha3fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 15:01:31 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074F1Sl760948736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 15:01:29 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1A31AE051;
        Tue,  4 Aug 2020 15:01:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C83CFAE061;
        Tue,  4 Aug 2020 15:01:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Aug 2020 15:01:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 852ADE1BB4; Tue,  4 Aug 2020 17:01:28 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 1/3] vdso: allow to add architecture-specific vdso data
Date:   Tue,  4 Aug 2020 17:01:22 +0200
Message-Id: <20200804150124.41692-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200804150124.41692-1-svens@linux.ibm.com>
References: <20200804150124.41692-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040106
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
---
 arch/Kconfig            | 3 +++
 include/vdso/datapage.h | 9 +++++++++
 2 files changed, 12 insertions(+)

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
index 7955c56d6b3c..a11e89e2f547 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,12 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+#include <asm/vdso/data.h>
+#else
+struct arch_vdso_data {};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -64,6 +70,7 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
+ * @arch_data:		architecture specific data
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -97,6 +104,8 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
+
+	struct arch_vdso_data	arch_data;
 };
 
 /*
-- 
2.17.1

