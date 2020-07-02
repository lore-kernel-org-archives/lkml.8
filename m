Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36991C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04421208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aW1KSTIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgGBPX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:23:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46388 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbgGBPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062FMXc1004060;
        Thu, 2 Jul 2020 15:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=plEcjH4/pGPGRyfYdsLYzLVT5ymotiodyrZ8qXUrINM=;
 b=aW1KSTIhEet7W+djvC54DWVXOMWchbNpur3x0SAsVtv7RNC9StwDYL0mO5yDLSSTNo/P
 OLEH2c8PNU9eY//Ciift7R6MgjBxO+lGcMip044btU43oQCixUL7fu5Xu5fdlGtWWi4F
 45cuPIiGoxgupSSWi7fg2CY853rJH/aZEfgS1hoX2ognNH1dgfaLBNdJwT5lSckSY9ub
 eUS90gcFuwDQUIL2Wu/k6x7iY95L2HVBFk84kCnJHoKnJCvPEvMle1n1API98cXlBt+W
 UuaKYyM8GzaSFBMfqkoZiaS/q/nZcVksxRpcHA+aQA5184r90b7LcGW0wfuWneguO3GL 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31wxrnh2wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:23:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062Evrjv162732;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31xg2144f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 062FLjaa022711;
        Thu, 2 Jul 2020 15:21:45 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:54 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 5/7] x86: microcode: late loading feature and bug evaluation
Date:   Thu,  2 Jul 2020 18:18:25 +0300
Message-Id: <1593703107-8852-6-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While doing microcode late loading, need to probe again all the
CPU features after the microcode has been loaded. Before probing
the CPU features and bug, need to clear the current bug bits. The
new function, cpu_clear_bug_bits, will clear all the bug bits and
then set them.

The logic is as follows:

- for boot cpu call cpu_clear_bug_bits, get_cpu_cap and then
cpu_set_bug_bits

- meanwhile all the other cores are waiting because they need
information from boot cpu about the forced caps

- in the last step every cpu is calling cpu_clear_bug_bits and
the bug bits will be set by get_cpu_cap through the apply_forced_caps

- also when the microcode feature for disabling TSX is not available
at boot time, taa_select_mitigation will not disable TSX to ensure
proper mitigation for TAA. Call tsx_init on each CPU after the new
microcode has been loaded

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/include/asm/microcode.h     |  3 +++
 arch/x86/kernel/cpu/common.c         | 28 +++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/core.c | 26 ++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 2b7cc53..7a6a5aa 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -142,4 +142,7 @@ static inline void reload_early_microcode(void)			{ }
 get_builtin_firmware(struct cpio_data *cd, const char *name)	{ return false; }
 #endif
 
+void cpu_set_bug_bits(struct cpuinfo_x86 *c);
+void cpu_clear_bug_bits(struct cpuinfo_x86 *c);
+
 #endif /* _ASM_X86_MICROCODE_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c11daa6..f722c1e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1101,6 +1101,32 @@ static bool cpu_matches(const struct x86_cpu_id *table, unsigned long which)
 	return m && !!(m->driver_data & which);
 }
 
+void cpu_clear_bug_bits(struct cpuinfo_x86 *c)
+{
+	int i;
+	unsigned int bugs[] = {
+		X86_BUG_SPECTRE_V1,
+		X86_BUG_SPECTRE_V2,
+		X86_BUG_SPEC_STORE_BYPASS,
+		X86_FEATURE_IBRS_ENHANCED,
+		X86_BUG_MDS,
+		X86_BUG_MSBDS_ONLY,
+		X86_BUG_SWAPGS,
+		X86_BUG_TAA,
+		X86_BUG_SRBDS,
+		X86_BUG_CPU_MELTDOWN,
+		X86_BUG_L1TF
+	};
+
+	for (i = 0; i < ARRAY_SIZE(bugs); i++)
+		clear_cpu_cap(c, bugs[i]);
+
+	if (c->cpu_index == boot_cpu_data.cpu_index) {
+		for (i = 0; i < ARRAY_SIZE(bugs); i++)
+			setup_clear_cpu_cap(bugs[i]);
+	}
+}
+
 u64 x86_read_arch_cap_msr(void)
 {
 	u64 ia32_cap = 0;
@@ -1111,7 +1137,7 @@ u64 x86_read_arch_cap_msr(void)
 	return ia32_cap;
 }
 
-static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
+void cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index baec68b..2cd983a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -40,6 +40,8 @@
 #include <asm/cmdline.h>
 #include <asm/setup.h>
 
+#include "../cpu.h"
+
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
@@ -542,6 +544,20 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 	return 0;
 }
 
+static void update_cpu_caps(struct cpuinfo_x86 *c)
+{
+	cpu_clear_bug_bits(c);
+
+	/*
+	 * If we are at late loading, we need to re-initialize tsx because
+	 * MSR_IA32_TSX_CTRL might be available as result of the microcode
+	 * update.
+	 */
+	tsx_init();
+
+	get_cpu_cap(c);
+}
+
 /*
  * Returns:
  * < 0 - on error
@@ -550,6 +566,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 static int __reload_late(void *info)
 {
 	int cpu = smp_processor_id();
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	enum ucode_state err;
 	int ret = 0;
 
@@ -579,6 +596,12 @@ static int __reload_late(void *info)
 		ret = -1;
 	}
 
+	if (ret == 0 && c->cpu_index == boot_cpu_data.cpu_index) {
+		update_cpu_caps(c);
+		memcpy(&boot_cpu_data, c, sizeof(boot_cpu_data));
+		cpu_set_bug_bits(c);
+	}
+
 wait_for_siblings:
 	if (__wait_for_cpus(&late_cpus_out, NSEC_PER_SEC))
 		panic("Timeout during microcode update!\n");
@@ -592,6 +615,9 @@ static int __reload_late(void *info)
 	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
 		apply_microcode_local(&err);
 
+	if (ret == 0 && c->cpu_index != boot_cpu_data.cpu_index)
+		update_cpu_caps(c);
+
 	return ret;
 }
 
-- 
1.8.3.1

