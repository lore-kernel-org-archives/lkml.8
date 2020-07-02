Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606F3214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xYlA/A8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgGBPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:22:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44848 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgGBPWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:22:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwIEf146381;
        Thu, 2 Jul 2020 15:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GpJrQPhTZvvSbMWNjOm498MhcaQbFbCs10gESS1+0xI=;
 b=xYlA/A8hRbkqMTvdtKZOVGdKV+BSjnSV/43Pi/fygIdrOenXgv4+GmaJN/F4wQ2WZbCJ
 yIg9OwlXh2R4AzumhH287b9NF1P9w86VblqV/44sTZnoMLBgLIkvhzcwHMGtkRy3F0kC
 btnfwexegvANmurtCzl5mCfjdh104w7fvR2hlccUsRQX3PunNGWxNTqrus/N6mzxng85
 7s1H7o8wfAF6gfPR74O7+e0SIPyLXJ07pTig3Ksl2uI66SyhP5R5WyES1JkS2EnqfhOr
 jy0pXPsYXRbLVMJqP/2sKgiRIie0mZpecxCShYc3lyFZs7Phlj5a/kS3jowkxmoGo/nR 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrnh2he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:21:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EwoKn090063;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31xg19j71x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 062FLkXm000822;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:55 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 7/7] x86: cpu: update blacklist spec features for late loading
Date:   Thu,  2 Jul 2020 18:18:27 +0300
Message-Id: <1593703107-8852-8-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=1 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=1 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we have loaded a broken microcode at boot time, all the
speculation features will be blacklisted. Created a new
function for Intel CPUs to verify if we have a broken microcode
loaded or not and whitelist/blacklist features as needed.

This has to be done before get_cpu_cap because it uses these
black/white lists.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/include/asm/microcode_intel.h |  1 +
 arch/x86/kernel/cpu/intel.c            | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/microcode/intel.c  |  5 ++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index d85a07d..74c87cc 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -74,6 +74,7 @@ static inline u32 intel_get_microcode_revision(void)
 extern void show_ucode_info_early(void);
 extern int __init save_microcode_in_initrd_intel(void);
 void reload_ucode_intel(void);
+void check_intel_bad_spectre_microcode(struct cpuinfo_x86 *c);
 #else
 static inline __init void load_ucode_intel_bsp(void) {}
 static inline void load_ucode_intel_ap(void) {}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c25a67a..286168e 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -170,6 +170,34 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	return false;
 }
 
+/*
+ * check_intel_bad_spectre_microcode verifies if a valid microcode was
+ * loaded and whitelist/blacklist the features related to speculation control.
+ */
+void check_intel_bad_spectre_microcode(struct cpuinfo_x86 *c)
+{
+	int i;
+	unsigned int features[] = {
+		X86_FEATURE_IBRS,
+		X86_FEATURE_IBPB,
+		X86_FEATURE_STIBP,
+		X86_FEATURE_SPEC_CTRL,
+		X86_FEATURE_MSR_SPEC_CTRL,
+		X86_FEATURE_INTEL_STIBP,
+		X86_FEATURE_SSBD,
+		X86_FEATURE_SPEC_CTRL_SSBD
+	};
+
+	if (bad_spectre_microcode(c)) {
+		for (i = 0; i < ARRAY_SIZE(features); i++)
+			set_bit(features[i], (unsigned long *)cpu_caps_cleared);
+	} else {
+		for (i = 0; i < ARRAY_SIZE(features); i++)
+			clear_bit(features[i],
+				  (unsigned long *)cpu_caps_cleared);
+	}
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 2ef4338..73a5a52 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -854,8 +854,11 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	c->microcode	 = rev;
 
 	/* Update boot_cpu_data's revision too, if we're on the BSP: */
-	if (bsp)
+	if (bsp) {
 		boot_cpu_data.microcode = rev;
+		/* Whitelist/blacklist speculation control features. */
+		check_intel_bad_spectre_microcode(c);
+	}
 
 	return ret;
 }
-- 
1.8.3.1

