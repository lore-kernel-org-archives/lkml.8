Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DDC55194
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E01D206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 02:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgD0CKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 22:10:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726084AbgD0CKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 22:10:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03R23X9k032308
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:10:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30mhbgu670-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 22:10:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Mon, 27 Apr 2020 03:09:52 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Apr 2020 03:09:49 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03R2AeUN63307924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 02:10:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 170CEA4066;
        Mon, 27 Apr 2020 02:10:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9036AA4054;
        Mon, 27 Apr 2020 02:10:38 +0000 (GMT)
Received: from ltc-wspoon6.aus.stglabs.ibm.com (unknown [9.40.193.95])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Apr 2020 02:10:38 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc:     npiggin@gmail.com, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        mpe@ellerman.id.au, oohall@gmail.com, mikey@neuling.org,
        psampat@linux.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC 2/3] powernv/cpuidle : Interface for an idle-stop dependency structure
Date:   Sun, 26 Apr 2020 21:10:26 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
References: <20200427021027.114582-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20042702-4275-0000-0000-000003C69EDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042702-4276-0000-0000-000038DC2F54
Message-Id: <20200427021027.114582-2-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-26_11:2020-04-24,2020-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the idea of having a dependency structure for
idle-stop. The structure encapsulates the following:
1. Bitmask for version of idle-stop
2. Bitmask for propterties like ENABLE/DISABLE
3. Function pointer which helps handle how the stop must be invoked

This patch lays a foundation for other idle-stop versions to be added
and handled cleanly based on their specified requirments.
Currently it handles the existing "idle-stop" version by setting the
discovery bits and the function pointer.

Earlier this patch was posted as part of this series :
https://lkml.org/lkml/2020/3/4/589

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

 v1->v2: This patch is newly added in this series.

 arch/powerpc/include/asm/processor.h  | 17 +++++++++++++++++
 arch/powerpc/kernel/dt_cpu_ftrs.c     |  5 +++++
 arch/powerpc/platforms/powernv/idle.c | 18 ++++++++++++++----
 drivers/cpuidle/cpuidle-powernv.c     |  3 ++-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index eedcbfb9a6ff..66fa20476d0e 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -429,6 +429,23 @@ extern void power4_idle_nap(void);
 extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
+#define STOP_ENABLE		0x00000001
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
index 182b4047c1ef..db1a525e090d 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -292,6 +292,8 @@ static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 	lpcr |=  LPCR_PECE1;
 	lpcr |=  LPCR_PECE2;
 	mtspr(SPRN_LPCR, lpcr);
+	stop_dep.cpuidle_prop |= STOP_ENABLE;
+	stop_dep.stop_version = STOP_VERSION_P9;
 
 	return 1;
 }
@@ -657,6 +659,9 @@ static void __init cpufeatures_setup_start(u32 isa)
 	}
 }
 
+stop_deps_t stop_dep = {NULL, 0x0, 0x0};
+EXPORT_SYMBOL(stop_dep);
+
 static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
 {
 	const struct dt_cpu_feature_match *m;
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1841027b25c5..538f0842ac3f 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -842,7 +842,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 
 #ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 #else
 	/*
@@ -858,7 +858,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, false);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
@@ -886,7 +886,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
 	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
 
 	__ppc64_runlatch_off();
-	srr1 = power9_idle_stop(psscr, true);
+	srr1 = stop_dep.idle_stop(psscr, true);
 	__ppc64_runlatch_on();
 
 	fini_irq_for_idle_irqsoff();
@@ -1390,8 +1390,18 @@ static int __init pnv_init_idle_states(void)
 	nr_pnv_idle_states = 0;
 	supported_cpuidle_states = 0;
 
-	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+	if (cpuidle_disable != IDLE_NO_OVERRIDE ||
+	    !(stop_dep.cpuidle_prop & STOP_ENABLE))
 		goto out;
+
+	/* Check for supported version in kernel */
+	if (stop_dep.stop_version & STOP_VERSION_P9) {
+		stop_dep.idle_stop = power9_idle_stop;
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

