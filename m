Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA86C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E320739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgGFEuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 00:50:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64682 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726001AbgGFEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 00:50:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0664ksa6127077;
        Mon, 6 Jul 2020 00:50:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 322kx8pvhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 00:50:41 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0664nOmR132508;
        Mon, 6 Jul 2020 00:50:41 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 322kx8pvh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 00:50:40 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0664oKG9010293;
        Mon, 6 Jul 2020 04:50:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 322hd81vqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 04:50:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0664oahX55705628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Jul 2020 04:50:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 116EDA405C;
        Mon,  6 Jul 2020 04:50:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 847AAA405F;
        Mon,  6 Jul 2020 04:50:34 +0000 (GMT)
Received: from bostonp9.aus.stglabs.ibm.com (unknown [9.3.23.179])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  6 Jul 2020 04:50:34 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc:     npiggin@gmail.com, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        mpe@ellerman.id.au, oohall@gmail.com, mikey@neuling.org,
        psampat@linux.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC v2 2/2] powerpc/powernv : Introduce capability for firmware-enabled-stop
Date:   Sun,  5 Jul 2020 23:50:01 -0500
Message-Id: <20200706045001.77039-2-huntbag@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706045001.77039-1-huntbag@linux.vnet.ibm.com>
References: <20200706045001.77039-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_02:2020-07-02,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 cotscore=-2147483648 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability for firmware to handle the stop
states instead. A bit is set based on the discovery of the feature
and correspondingly also the responsibility to handle the stop states.

If Kernel does not know about stop version, it can fallback to opal for
idle stop support if firmware-stop-supported property is present.

Earlier part of this patch was posted in this series :
https://lkml.org/lkml/2020/3/4/589

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
v1->v2 : Combined patch 2 and 3 from previous iteration and rebased it.

 arch/powerpc/include/asm/processor.h  | 18 ++++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c     | 13 +++++++++++++
 arch/powerpc/platforms/powernv/idle.c | 20 ++++++++++++++++----
 drivers/cpuidle/cpuidle-powernv.c     |  3 ++-
 4 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index bfa336fbcfeb..b8de7146387c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -428,6 +428,24 @@ extern void power4_idle_nap(void);
 extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
+#define STOP_ENABLE		0x00000001
+#define FIRMWARE_STOP_ENABLE	0x00000010
+
+#define STOP_VERSION_P9       0x1
+
+/*
+ * Classify the dependencies of the stop states
+ * @idle_stop: function handler to handle the quirk stop version
+ * @cpuidle_prop: Signify support for stop states through kernel and/or firmware
+ * @stop_version: Classify quirk versions for stop states
+ */
+typedef struct {
+	unsigned long (*idle_stop)(unsigned long psscr, bool mmu_on);
+	uint8_t cpuidle_prop;
+	uint8_t stop_version;
+} stop_deps_t;
+extern stop_deps_t stop_dep;
+
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 
 extern void power7_idle_type(unsigned long type);
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 36bc0d5c4f3a..737686fae3c7 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -291,6 +291,15 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 	lpcr |=  LPCR_PECE1;
 	lpcr |=  LPCR_PECE2;
 	mtspr(SPRN_LPCR, lpcr);
+	stop_dep.cpuidle_prop |= STOP_ENABLE;
+	stop_dep.stop_version = STOP_VERSION_P9;
+
+	return 1;
+}
+
+static int __init feat_enable_firmware_stop(struct dt_cpu_feature *f)
+{
+	stop_dep.cpuidle_prop |= FIRMWARE_STOP_ENABLE;
 
 	return 1;
 }
@@ -589,6 +598,7 @@ static struct dt_cpu_feature_match __initdata
 	{"idle-nap", feat_enable_idle_nap, 0},
 	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
 	{"idle-stop", feat_enable_idle_stop, 0},
+	{"firmware-stop-supported", feat_enable_firmware_stop, 0},
 	{"machine-check-power8", feat_enable_mce_power8, 0},
 	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
 	{"data-stream-control-register", feat_enable_dscr, CPU_FTR_DSCR},
@@ -656,6 +666,9 @@ static void __init cpufeatures_setup_start(u32 isa)
 	}
 }
 
+stop_deps_t stop_dep = {NULL, 0x0, 0x0};
+EXPORT_SYMBOL(stop_dep);
+
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 {
 	const struct dt_cpu_feature_match *m;
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 3afd4293f729..3602950f6c08 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -824,7 +824,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 
 #ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 #else
 	/*
@@ -840,7 +840,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, false);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
@@ -868,7 +868,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -1365,8 +1365,20 @@ static int __init pnv_init_idle_states(void)
 	nr_pnv_idle_states = 0;
 	supported_cpuidle_states = 0;
 
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
+	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
 		goto out;
+
+	/* Check for supported version in kernel or fallback to opal*/
+	if (stop_dep.stop_version & STOP_VERSION_P9) {
+		stop_dep.idle_stop = power9_idle_stop;
+	} else if (stop_dep.cpuidle_prop & FIRMWARE_STOP_ENABLE) {
+		stop_dep.idle_stop = power9_firmware_idle_stop;
+	} else {
+		stop_dep.idle_stop = NULL;
+		goto out;
+	}
+
 	rc = pnv_parse_cpuidle_dt();
 	if (rc)
 		return rc;
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1b299e801f74..7430a8edf5c9 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -371,7 +371,8 @@ static int powernv_add_idle_states(void)
  */
 static int powernv_idle_probe(void)
 {
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
+	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_OPAL)) {
-- 
2.17.1

