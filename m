Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BC12073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0LdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:33:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59560 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727666AbgC0LdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:33:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RB4dKL107909;
        Fri, 27 Mar 2020 07:32:58 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr9kcyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 07:32:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02RBUgcc005451;
        Fri, 27 Mar 2020 11:32:53 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 2ywaw2x8q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 11:32:52 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RBWpYw13435396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 11:32:51 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 837B1BE058;
        Fri, 27 Mar 2020 11:32:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B44FEBE053;
        Fri, 27 Mar 2020 11:32:50 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.72.108])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 11:32:50 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 7548D2E3B08; Fri, 27 Mar 2020 17:02:45 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v4 4/6] powerpc/sysfs: Show idle_purr and idle_spurr for every CPU
Date:   Fri, 27 Mar 2020 17:02:38 +0530
Message-Id: <1585308760-28792-5-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_03:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxlogscore=987 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On Pseries LPARs, to calculate utilization, we need to know the
[S]PURR ticks when the CPUs were busy or idle.

The total PURR and SPURR ticks are already exposed via the per-cpu
sysfs files "purr" and "spurr". This patch adds support for exposing
the idle PURR and SPURR ticks via new per-cpu sysfs files named
"idle_purr" and "idle_spurr".

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/sysfs.c | 82 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 479c706..571b325 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -19,6 +19,7 @@
 #include <asm/smp.h>
 #include <asm/pmc.h>
 #include <asm/firmware.h>
+#include <asm/idle.h>
 #include <asm/svm.h>
 
 #include "cacheinfo.h"
@@ -760,6 +761,74 @@ static void create_svm_file(void)
 }
 #endif /* CONFIG_PPC_SVM */
 
+#ifdef CONFIG_PPC_PSERIES
+static void read_idle_purr(void *val)
+{
+	u64 *ret = val;
+
+	*ret = read_this_idle_purr();
+}
+
+static ssize_t idle_purr_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	u64 val;
+
+	smp_call_function_single(cpu->dev.id, read_idle_purr, &val, 1);
+	return sprintf(buf, "%llx\n", val);
+}
+static DEVICE_ATTR(idle_purr, 0400, idle_purr_show, NULL);
+
+static void create_idle_purr_file(struct device *s)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		device_create_file(s, &dev_attr_idle_purr);
+}
+
+static void remove_idle_purr_file(struct device *s)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		device_remove_file(s, &dev_attr_idle_purr);
+}
+
+static void read_idle_spurr(void *val)
+{
+	u64 *ret = val;
+
+	*ret = read_this_idle_spurr();
+}
+
+static ssize_t idle_spurr_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct cpu *cpu = container_of(dev, struct cpu, dev);
+	u64 val;
+
+	smp_call_function_single(cpu->dev.id, read_idle_spurr, &val, 1);
+	return sprintf(buf, "%llx\n", val);
+}
+static DEVICE_ATTR(idle_spurr, 0400, idle_spurr_show, NULL);
+
+static void create_idle_spurr_file(struct device *s)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		device_create_file(s, &dev_attr_idle_spurr);
+}
+
+static void remove_idle_spurr_file(struct device *s)
+{
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		device_remove_file(s, &dev_attr_idle_spurr);
+}
+
+#else /* CONFIG_PPC_PSERIES */
+#define create_idle_purr_file(s)
+#define remove_idle_purr_file(s)
+#define create_idle_spurr_file(s)
+#define remove_idle_spurr_file(s)
+#endif /* CONFIG_PPC_PSERIES */
+
 static int register_cpu_online(unsigned int cpu)
 {
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -823,10 +892,13 @@ static int register_cpu_online(unsigned int cpu)
 		if (!firmware_has_feature(FW_FEATURE_LPAR))
 			add_write_permission_dev_attr(&dev_attr_purr);
 		device_create_file(s, &dev_attr_purr);
+		create_idle_purr_file(s);
 	}
 
-	if (cpu_has_feature(CPU_FTR_SPURR))
+	if (cpu_has_feature(CPU_FTR_SPURR)) {
 		device_create_file(s, &dev_attr_spurr);
+		create_idle_spurr_file(s);
+	}
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		device_create_file(s, &dev_attr_dscr);
@@ -910,11 +982,15 @@ static int unregister_cpu_online(unsigned int cpu)
 		device_remove_file(s, &dev_attr_mmcra);
 #endif /* CONFIG_PMU_SYSFS */
 
-	if (cpu_has_feature(CPU_FTR_PURR))
+	if (cpu_has_feature(CPU_FTR_PURR)) {
 		device_remove_file(s, &dev_attr_purr);
+		remove_idle_purr_file(s);
+	}
 
-	if (cpu_has_feature(CPU_FTR_SPURR))
+	if (cpu_has_feature(CPU_FTR_SPURR)) {
 		device_remove_file(s, &dev_attr_spurr);
+		remove_idle_spurr_file(s);
+	}
 
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		device_remove_file(s, &dev_attr_dscr);
-- 
1.9.4

