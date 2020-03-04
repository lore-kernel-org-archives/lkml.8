Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AE3C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A17D421739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388160AbgCDQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:01:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgCDQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:01:42 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024FwnZs064518
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 11:01:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj8hbs4h6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:01:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Wed, 4 Mar 2020 16:01:38 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Mar 2020 16:01:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024G1VQY6815956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Mar 2020 16:01:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60DA8AE059;
        Wed,  4 Mar 2020 16:01:31 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A662AE053;
        Wed,  4 Mar 2020 16:01:29 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.81.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Mar 2020 16:01:28 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        vaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        skiboot@lists.ozlabs.org, oohall@gmail.com, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com
Subject: [RFC 2/3] Demonstration of handling an idle-stop quirk version
Date:   Wed,  4 Mar 2020 21:31:22 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583332695.git.psampat@linux.ibm.com>
References: <cover.1583332695.git.psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030416-0012-0000-0000-0000038D291E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030416-0013-0000-0000-000021C9E53D
Message-Id: <4084fa08404fbf65942a08335318b6d800d363fc.1583332695.git.psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concept patch demonstrating an idle-stop version discovery from the
device tree, along with population its support and versioning. It also
assigns the function pointer to handle any idle-stop specific quirks.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/dt_cpu_ftrs.c     | 16 ++++++++++++++++
 arch/powerpc/platforms/powernv/idle.c |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index da59f01a5c09..277dbabafd02 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -432,6 +432,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 #define STOP_ENABLE		0x00000001
 
 #define STOP_VERSION_P9       0x1
+#define STOP_VERSION_P9_V1    0x2
 
 /*
  * Classify the dependencies of the stop states
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index db1a525e090d..63e30aa49356 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -298,6 +298,21 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 	return 1;
 }
 
+static int __init feat_enable_idle_stop_quirk(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	/* Set PECE wakeup modes for ISAv3.0B */
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECE0;
+	lpcr |=  LPCR_PECE1;
+	lpcr |=  LPCR_PECE2;
+	mtspr(SPRN_LPCR, lpcr);
+	stop_dep.cpuidle_prop |= STOP_ENABLE;
+	stop_dep.stop_version = STOP_VERSION_P9_V1;
+
+	return 1;
+}
 static int __init feat_enable_mmu_hash(struct dt_cpu_feature *f)
 {
 	u64 lpcr;
@@ -592,6 +607,7 @@ static struct dt_cpu_feature_match __initdata
 	{"idle-nap", feat_enable_idle_nap, 0},
 	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
 	{"idle-stop", feat_enable_idle_stop, 0},
+	{"idle-stop-v1", feat_enable_idle_stop_quirk, 0},
 	{"machine-check-power8", feat_enable_mce_power8, 0},
 	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
 	{"data-stream-control-register", feat_enable_dscr, CPU_FTR_DSCR},
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index c32cdc37acf4..9f5b21da2fc5 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -805,6 +805,11 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 	return srr1;
 }
 
+static unsigned long power9_idle_quirky_stop(unsigned long psscr, bool mmu_on)
+{
+	return power9_idle_stop(psscr, mmu_on);
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 static unsigned long power9_offline_stop(unsigned long psscr)
 {
@@ -1360,6 +1365,9 @@ static int __init pnv_init_idle_states(void)
 	case STOP_VERSION_P9:
 		stop_dep.idle_stop = power9_idle_stop;
 		break;
+	case STOP_VERSION_P9_V1:
+		stop_dep.idle_stop = power9_idle_quirky_stop;
+		break;
 	default:
 		stop_dep.idle_stop = NULL;
 		goto out;
-- 
2.24.1

