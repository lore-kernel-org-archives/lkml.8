Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6F9C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50EA20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zrz6ff9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgCYTn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:43:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCYTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:43:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJeMkm126847;
        Wed, 25 Mar 2020 19:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VAMTIRUJSMWzB/O4y5ntMsijFXWrX+N9N4mw77rXk/0=;
 b=zrz6ff9tEZ1CLw3STsvDVXJM3lHQZ8flkG0Wo6Enr3fmMW6adAP2fPWCkSDY39zbE/Mn
 FauhLbE0pCg8ltdmeIhyYnetTebMNXTO7Zvw+9uoIFawxR9JZ/1WD6e0bJejBTMD4nYe
 g9WbYegGElmawwtGEbqeJrD/3YpVAJuzyf+NCXImUQGhtv34QZTCk3a1jA9L64Hocsiz
 Ku0KLi0g0s9wdkqzZg1zw1n1vk1pWLp3SK80FUlSSSePhTGxJ0w8B9MaMhEKMgMPk/hE
 1tBmlb2DhFd06RTTLrXRO7fk95qKVtjEE1yu1VWKwkva51H4mZaWrYa9z9MGVm5qok5W 8w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3005kvat05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PJgSNO188060;
        Wed, 25 Mar 2020 19:43:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yxw4s3pjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 19:43:38 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02PJhbFU012316;
        Wed, 25 Mar 2020 19:43:37 GMT
Received: from pneuma.us.oracle.com (/10.39.203.246)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 12:43:37 -0700
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        trenchboot-devel@googlegroups.com
Subject: [RFC PATCH 11/12] kexec: Secure Launch kexec SEXIT support
Date:   Wed, 25 Mar 2020 15:43:16 -0400
Message-Id: <20200325194317.526492-12-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200325194317.526492-1-ross.philipson@oracle.com>
References: <20200325194317.526492-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=942 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to running the next kernel via kexec, the Secure Launch code
closes down private SMX resources and does an SEXIT. This allows the
next kernel to start normally without any issues starting the APs etc.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/slaunch.c | 65 +++++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c       |  3 ++
 2 files changed, 68 insertions(+)

diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
index fea15b0e36b7..516964408fe5 100644
--- a/arch/x86/kernel/slaunch.c
+++ b/arch/x86/kernel/slaunch.c
@@ -633,3 +633,68 @@ static void __exit slaunch_exit(void)
 late_initcall(slaunch_late_init);
 
 __exitcall(slaunch_exit);
+
+static inline void txt_getsec_sexit(void)
+{
+	asm volatile (".byte 0x0f,0x37\n"
+		      : : "a" (SMX_X86_GETSEC_SEXIT));
+}
+
+void slaunch_sexit(void)
+{
+	void __iomem *config;
+	u64 one = 1, val;
+
+	if (!(slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)))
+		return;
+
+	if (smp_processor_id() != 0) {
+		pr_err("Error TXT SEXIT must be called on CPU 0\n");
+		return;
+	}
+
+	config = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_err("Error SEXIT failed to ioremap TXT private reqs\n");
+		return;
+	}
+
+	/* Clear secrets bit for SEXIT */
+	memcpy_toio(config + TXT_CR_CMD_NO_SECRETS, &one, sizeof(u64));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	/* Unlock memory configurations */
+	memcpy_toio(config + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(u64));
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	/* Close the TXT private register space */
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+	memcpy_toio(config + TXT_CR_CMD_CLOSE_PRIVATE, &one, sizeof(u64));
+
+	/*
+	 * Calls to iounmap are not being done because of the state of the
+	 * system this late in the kexec process. Local IRQs are disabled and
+	 * iounmap causes a TLB flush which in turn causes a warning. Leaving
+	 * thse mappings is not an issue since the next kernel is going to
+	 * completely re-setup memory management.
+	 */
+
+	/* Map public registers and do a final read fence */
+	config = ioremap(TXT_PUB_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
+			 PAGE_SIZE);
+	if (!config) {
+		pr_err("Error SEXIT failed to ioremap TXT public reqs\n");
+		return;
+	}
+
+	memcpy_fromio(&val, config + TXT_CR_E2STS, sizeof(u64));
+
+	/* Disable SMX mode */
+	cr4_set_bits(X86_CR4_SMXE);
+
+	/* Do the SEXIT SMX operation */
+	txt_getsec_sexit();
+
+	pr_emerg("TXT SEXIT complete.");
+}
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 15d70a90b50d..08105eeebf90 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -37,6 +37,7 @@
 #include <linux/compiler.h>
 #include <linux/hugetlb.h>
 #include <linux/frame.h>
+#include <linux/slaunch.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1173,6 +1174,8 @@ int kernel_kexec(void)
 		cpu_hotplug_enable();
 		pr_emerg("Starting new kernel\n");
 		machine_shutdown();
+
+		slaunch_sexit();
 	}
 
 	machine_kexec(kexec_image);
-- 
2.25.1

