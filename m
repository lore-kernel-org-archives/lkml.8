Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9458220781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tNT0E7/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgGBPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:22:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53272 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgGBPWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:22:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EuQ7V133054;
        Thu, 2 Jul 2020 15:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=bDBnEagVBGyloOOLaZ5VGU/OtU6T8N2gifh7nDCHKBA=;
 b=tNT0E7/DLeh/aLiFeQPOskGV96OvZV1IheuwtSGZ0VF22ZM4WifKpMYsCGIkJYUml7LD
 cvKgbQXU0ZCx5MkL4M8EHgapcDDxh2lvr/wqok7MFdkUXPR60mYwaUSr4B1PkoLtLJY1
 VG+pn+75NHT5t+I+EXP80N7/hNJgE6M9hAMP1qULDB3OXobyoCNMo2fczCPoClveLKtk
 c/os+quyv+gbpnN95pXE9/zFslTJeQhyfcmxx6Skd7CZUUTAPuPnW2I9IjvnUrFoqLt5
 B7olRhEqEX6XfzkUqKq7tLRYu0kLQhHhFN36Biuww0K8Pwftr6/KOygFk2g2Mw5Tmwbd 5A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1e5xcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:21:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EvsHi162796;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31xg2144f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062FLjE5021065;
        Thu, 2 Jul 2020 15:21:45 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:54 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 6/7] x86: cpu: bugs.c: reprobe bugs at runtime
Date:   Thu,  2 Jul 2020 18:18:26 +0300
Message-Id: <1593703107-8852-7-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=1 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt check_bugs to be callable at runtime after the
microcode late loading has been done.

Also update SRBDS to reset the default value for srbds_mitigation and call
update_srbds_msr on all CPUs.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/bugs.c           | 37 ++++++++++++++++++++++++++----------
 arch/x86/kernel/cpu/microcode/core.c |  2 ++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 21b9df3..c4084d7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -77,17 +77,19 @@
 
 void __ref check_bugs(void)
 {
-	identify_boot_cpu();
+	if (system_state != SYSTEM_RUNNING) {
+		identify_boot_cpu();
 
-	/*
-	 * identify_boot_cpu() initialized SMT support information, let the
-	 * core code know.
-	 */
-	cpu_smt_check_topology();
+		/*
+		 * identify_boot_cpu() initialized SMT support information,
+		 * let the core code know.
+		 */
+		cpu_smt_check_topology();
 
-	if (!IS_ENABLED(CONFIG_SMP)) {
-		pr_info("CPU: ");
-		print_cpu_info(&boot_cpu_data);
+		if (!IS_ENABLED(CONFIG_SMP)) {
+			pr_info("CPU: ");
+			print_cpu_info(&boot_cpu_data);
+		}
 	}
 
 	/*
@@ -112,6 +114,13 @@ void __ref check_bugs(void)
 	srbds_select_mitigation();
 
 	/*
+	 * If we are late loading the microcode, code below should
+	 * not be executed --- it is only needed during boot.
+	 */
+	if (system_state == SYSTEM_RUNNING)
+		return;
+
+	/*
 	 * As MDS and TAA mitigations are inter-related, print MDS
 	 * mitigation until after TAA mitigation selection is done.
 	 */
@@ -452,10 +461,17 @@ void update_srbds_msr(void)
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 }
 
+static void _update_srbds_msr(void *p)
+{
+	update_srbds_msr();
+}
+
 static void srbds_select_mitigation(void)
 {
 	u64 ia32_cap;
 
+	srbds_mitigation = SRBDS_MITIGATION_FULL;
+
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
@@ -473,7 +489,8 @@ static void srbds_select_mitigation(void)
 	else if (cpu_mitigations_off() || srbds_off)
 		srbds_mitigation = SRBDS_MITIGATION_OFF;
 
-	update_srbds_msr();
+	on_each_cpu(_update_srbds_msr, NULL, 1);
+
 	pr_info("%s\n", srbds_strings[srbds_mitigation]);
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 2cd983a..6d327a0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -31,6 +31,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 
+#include <asm/bugs.h>
 #include <asm/microcode_intel.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode_amd.h>
@@ -669,6 +670,7 @@ static ssize_t reload_store(struct device *dev,
 
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
+	check_bugs();
 	mutex_unlock(&microcode_mutex);
 
 put:
-- 
1.8.3.1

