Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C024C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F9C206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sizd9TUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgBTQ0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:26:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:26:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGMTon010612
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : date : subject : message-id :
 to; s=corp-2020-01-29; bh=vvRf79KpiA4uLI7Ir8UW6SkyHG7uUASiVZgzd+/BqCY=;
 b=Sizd9TUL3AwnCUE3zEWHCLj12FBCr0k3B39YsLi4PpVSjHviCFlzkVL4Ka7AG/oZNNTA
 HyV/cIcFkITTdGPml0Md99bvbMoLjAIqjpEeZhMe/vKHilvyYf7uDN0zxFVaDkh2Yvoc
 jM7vPHhbZbFyEUa29OnqIFwwslyp3ghB2f1Bfzm1E6Eh+XKQgIzPrCQodvfy7zseF7gM
 osok4WTVAHezNFZJuMc2mFu9hE1DMqCiZLNsK+zncB8gXFkNuSxiFuOhZ5R9PBtaeckB
 8A9JMGp8WTFNArspMQZTjRGGxtDl5II/K+UkW2YzL8TN1vBTJAVyAqTQMo7KGGoAP/0s 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y8ud1avjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:26:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KGHwTs058261
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:26:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud4696k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:26:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KGQewM014776
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:26:40 GMT
Received: from [10.39.225.221] (/10.39.225.221)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 08:26:39 -0800
From:   John Donnelly <john.p.donnelly@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date:   Thu, 20 Feb 2020 10:26:37 -0600
Subject: [PATCH] iommu: Force iommu shutdown on panic.
Message-Id: <573BDCBC-3C4F-4A41-91D8-60BD7C44C43E@oracle.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=3 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=3 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This eliminates intermitten kdump hangs reported on AMD/x86 servers=20
with iommu enabled (iommu=3Don) regardless if iommu features are
used or not, on 5.4 kernels.  When kdump fails to initialize and run, no =
vmcore
(crash dumps) are captured.

Derived from the upsteam commit: iommu/vt-d: Turn off translations at =
shutdown.


Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Jack Vogel <jack.vogel@oracle.com>
---
 arch/x86/include/asm/x86_init.h | 2 +-
 arch/x86/kernel/amd_gart_64.c   | 2 +-
 arch/x86/kernel/reboot.c        | 2 +-
 arch/x86/kernel/x86_init.c      | 2 +-
 drivers/iommu/amd_iommu_init.c  | 8 ++++----
 drivers/iommu/intel-iommu.c     | 9 ++++++---
 include/linux/dmar.h            | 4 ++--
 kernel/panic.c                  | 7 +++++++
 8 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h =
b/arch/x86/include/asm/x86_init.h
index 96d9cd208610..06233f57b7c9 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -270,7 +270,7 @@ struct x86_platform_ops {
 	unsigned long (*calibrate_tsc)(void);
 	void (*get_wallclock)(struct timespec64 *ts);
 	int (*set_wallclock)(const struct timespec64 *ts);
-	void (*iommu_shutdown)(void);
+	void (*iommu_shutdown)(int panic);
 	bool (*is_untracked_pat_range)(u64 start, u64 end);
 	void (*nmi_init)(void);
 	unsigned char (*get_nmi_reason)(void);
diff --git a/arch/x86/kernel/amd_gart_64.c =
b/arch/x86/kernel/amd_gart_64.c
index 4e5f50236048..2f805cc073ad 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -681,7 +681,7 @@ static const struct dma_map_ops gart_dma_ops =3D {
 	.get_required_mask		=3D =
dma_direct_get_required_mask,
 };
=20
-static void gart_iommu_shutdown(void)
+static void gart_iommu_shutdown(int panic)
 {
 	struct pci_dev *dev;
 	int i;
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0cc7c0b106bb..fd3c88a4f2e7 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -708,7 +708,7 @@ void native_machine_shutdown(void)
 #endif
=20
 #ifdef CONFIG_X86_64
-	x86_platform.iommu_shutdown();
+	x86_platform.iommu_shutdown(0);
 #endif
 }
=20
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 85f1a90c55cd..e63719710097 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -28,7 +28,7 @@
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
 static int __init iommu_init_noop(void) { return 0; }
-static void iommu_shutdown_noop(void) { }
+static void iommu_shutdown_noop(int panic) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
 static __init int set_rtc_noop(const struct timespec64 *now) { return =
-EINVAL; }
diff --git a/drivers/iommu/amd_iommu_init.c =
b/drivers/iommu/amd_iommu_init.c
index 2759a8d57b7f..a1afc2e2a68c 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2361,7 +2361,7 @@ static void enable_iommus(void)
 	enable_iommus_v2();
 }
=20
-static void disable_iommus(void)
+static void disable_iommus(int panic)
 {
 	struct amd_iommu *iommu;
=20
@@ -2395,7 +2395,7 @@ static void amd_iommu_resume(void)
 static int amd_iommu_suspend(void)
 {
 	/* disable IOMMUs to go out of the way for BIOS */
-	disable_iommus();
+	disable_iommus(0);
=20
 	return 0;
 }
@@ -2612,7 +2612,7 @@ static int __init early_amd_iommu_init(void)
=20
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
-		disable_iommus();
+		disable_iommus(0);
=20
 	if (amd_iommu_irq_remap)
 		amd_iommu_irq_remap =3D check_ioapic_information();
@@ -2762,7 +2762,7 @@ static int __init state_next(void)
 	if (ret) {
 		free_dma_resources();
 		if (!irq_remapping_enabled) {
-			disable_iommus();
+			disable_iommus(0);
 			free_iommu_resources();
 		} else {
 			struct amd_iommu *iommu;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 9dc37672bf89..8bc95f4e7d3e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4903,7 +4903,7 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
=20
-void intel_iommu_shutdown(void)
+void intel_iommu_shutdown(int panic)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu =3D NULL;
@@ -4911,7 +4911,8 @@ void intel_iommu_shutdown(void)
 	if (no_iommu || dmar_disabled)
 		return;
=20
-	down_write(&dmar_global_lock);
+	if (!panic)
+		down_write(&dmar_global_lock);
=20
 	/* Disable PMRs explicitly here. */
 	for_each_iommu(iommu, drhd)
@@ -4920,7 +4921,9 @@ void intel_iommu_shutdown(void)
 	/* Make sure the IOMMUs are switched off */
 	intel_disable_iommus();
=20
-	up_write(&dmar_global_lock);
+	if (!panic)
+		up_write(&dmar_global_lock);
+=09
 }
=20
 static inline struct intel_iommu *dev_to_intel_iommu(struct device =
*dev)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f64ca27dc210..c4f24bc41169 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -129,7 +129,7 @@ static inline int dmar_res_noop(struct =
acpi_dmar_header *hdr, void *arg)
 #ifdef CONFIG_INTEL_IOMMU
 extern int iommu_detected, no_iommu;
 extern int intel_iommu_init(void);
-extern void intel_iommu_shutdown(void);
+extern void intel_iommu_shutdown(int panic);
 extern int dmar_parse_one_rmrr(struct acpi_dmar_header *header, void =
*arg);
 extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void =
*arg);
 extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void =
*arg);
@@ -138,7 +138,7 @@ extern int dmar_iommu_hotplug(struct dmar_drhd_unit =
*dmaru, bool insert);
 extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info =
*info);
 #else /* !CONFIG_INTEL_IOMMU: */
 static inline int intel_iommu_init(void) { return -ENODEV; }
-static inline void intel_iommu_shutdown(void) { }
+static inline void intel_iommu_shutdown(int panic) { }
=20
 #define	dmar_parse_one_rmrr		dmar_res_noop
 #define	dmar_parse_one_atsr		dmar_res_noop
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..ee81462d5b1f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -32,6 +32,7 @@
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
 #include <asm/sections.h>
+#include <linux/dmar.h>
=20
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -213,6 +214,12 @@ void panic(const char *fmt, ...)
 		buf[len - 1] =3D '\0';
=20
 	pr_emerg("Kernel panic - not syncing: %s\n", buf);
+
+#ifdef CONFIG_X86
+	pr_emerg("Shutting down iommu.\n");
+	x86_platform.iommu_shutdown(1);=20
+#endif
+
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 	/*
 	 * Avoid nested stack-dumping if a panic occurs during oops =
processing
--=20
2.20.1

