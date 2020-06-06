Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9000C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA60F2065C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFFEpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 00:45:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgFFEpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 00:45:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0564Xe3r140479;
        Sat, 6 Jun 2020 00:45:16 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g41c0bv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 00:45:15 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0564ivrh026510;
        Sat, 6 Jun 2020 04:45:13 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7r1nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Jun 2020 04:45:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0564jBRL47775810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Jun 2020 04:45:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 628ADAE057;
        Sat,  6 Jun 2020 04:45:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC231AE053;
        Sat,  6 Jun 2020 04:45:09 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.181.79])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  6 Jun 2020 04:45:09 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fadump: update kernel logs before fadump crash begins
Date:   Sat,  6 Jun 2020 10:15:06 +0530
Message-Id: <20200606044506.44551-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-06_01:2020-06-04,2020-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 suspectscore=1 cotscore=-2147483648 priorityscore=1501
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006060029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we hit the fadump crash via the panic path the pstore update is
missing. This is observed when commit 8341f2f222d7 ("sysrq: Use panic()
to force a crash") changed the sysrq-trigger to take panic path instead
of die path.

The PPC panic event handler addresses the system panic in two different
ways based on the system configuration. It first allows the FADump (if
configured) to handle the kernel panic else forwards the call to platform
specific panic function. Now pstore update is missing only if FADump
handles the kernel panic, the platform-specific panic function do update
the pstore by calling panic_flush_kmsg_end function.

The simplest approach to handle this issue is to add pstore update in PPC
panic handler before FADump handles the panic. But this leads to multiple
pstore updates in case FADump is not configured and platform-specific
panic function serves the kernel panic.

Hence the function panic_flush_kmsg_end (used by the platform-specific
panic function to update the kernel logs) is split into two functions, one
will update the pstore (called in ppc panic event handler) and others will
flush the kmsg on the console (called in platform specific panic function).

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/include/asm/bug.h         |  2 ++
 arch/powerpc/kernel/setup-common.c     |  1 +
 arch/powerpc/kernel/traps.c            | 12 +++++++++++-
 arch/powerpc/platforms/ps3/setup.c     |  2 +-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 338f36cd9934..9268551a69bc 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -118,6 +118,8 @@ extern void _exception_pkey(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
 extern bool die_will_crash(void);
 extern void panic_flush_kmsg_start(void);
+extern void panic_flush_kmsg_dump(void);
+extern void panic_flush_kmsg_console(void);
 extern void panic_flush_kmsg_end(void);
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 7f8c890360fe..2d546a9e8bb1 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -699,6 +699,7 @@ static int ppc_panic_event(struct notifier_block *this,
 	 * want interrupts to be hard disabled.
 	 */
 	hard_irq_disable();
+	panic_flush_kmsg_dump();
 
 	/*
 	 * If firmware-assisted dump has been registered then trigger
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 82a3438300fd..bb6bc19992b3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -169,15 +169,25 @@ extern void panic_flush_kmsg_start(void)
 	bust_spinlocks(1);
 }
 
-extern void panic_flush_kmsg_end(void)
+extern void panic_flush_kmsg_dump(void)
 {
 	printk_safe_flush_on_panic();
 	kmsg_dump(KMSG_DUMP_PANIC);
+}
+
+extern void panic_flush_kmsg_console(void)
+{
 	bust_spinlocks(0);
 	debug_locks_off();
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 }
 
+extern void panic_flush_kmsg_end(void)
+{
+	panic_flush_kmsg_dump();
+	panic_flush_kmsg_console();
+}
+
 static unsigned long oops_begin(struct pt_regs *regs)
 {
 	int cpu;
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index b29368931c56..f96ba34284a1 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -101,7 +101,7 @@ static void ps3_panic(char *str)
 	printk("   System does not reboot automatically.\n");
 	printk("   Please press POWER button.\n");
 	printk("\n");
-	panic_flush_kmsg_end();
+	panic_flush_kmsg_console();
 
 	while(1)
 		lv1_pause(1);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0c8421dd01ab..66ecb88c4b8e 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -788,7 +788,7 @@ static void __init pSeries_setup_arch(void)
 
 static void pseries_panic(char *str)
 {
-	panic_flush_kmsg_end();
+	panic_flush_kmsg_console();
 	rtas_os_term(str);
 }
 
-- 
2.25.4

