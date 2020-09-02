Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E8CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F2F20786
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3Sevns+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIBEao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:30:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726770AbgIBEaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:30:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0824DSIw084335;
        Wed, 2 Sep 2020 00:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cXJ1hb+rxB2SKxqD4eqkp6G4YrcNWaRqf6p7TUeDxs0=;
 b=W3Sevns+gNxse1raWcKRAyjBi8BsYNgCOp0GRpz5DIK7k4iKBcfSRzf3bBuheVoa4Php
 gGdpQfvElEskZmnH4tKg0SFTiQ36P79HfgAFH6n4msP890KRGRSODhXzh+aYWE8krHv6
 m0EbbmWsEBLX7RPXBs1fc1oExdtY7clenC0tZlVCkT4vfmvyv9idszcCny0gm8ZbMHLw
 mzcunEbkaXxkWtAqFdvWgHH5/8Qao0SUx/XbAz9bcCNAWtnSFXCRy+nofPQRoVZFF002
 LTGdiKenQnOwHYya/8Mx8croN3dZYPK+YTzfl4YjFZ0HP1DKLW0e10wX0AknsbNCFM9+ qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462gakj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:20 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0824NTtt103773;
        Wed, 2 Sep 2020 00:30:20 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462gajp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:20 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0824RNpV008587;
        Wed, 2 Sep 2020 04:30:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8c80m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:30:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0824UE1259572530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 04:30:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44AE4A4062;
        Wed,  2 Sep 2020 04:30:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5A39A405B;
        Wed,  2 Sep 2020 04:30:11 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 04:30:11 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] powerpc/watchpoint/selftests: Tests for kernel accessing user memory
Date:   Wed,  2 Sep 2020 09:59:45 +0530
Message-Id: <20200902042945.129369-9-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce tests to cover simple scenarios where user is watching
memory which can be accessed by kernel as well. We also support
_MODE_EXACT with _SETHWDEBUG interface. Move those testcases out-
side of _BP_RANGE condition. This will help to test _MODE_EXACT
scenarios when CONFIG_HAVE_HW_BREAKPOINT is not set, eg:

  $ ./ptrace-hwbreak
  ...
  PTRACE_SET_DEBUGREG, Kernel Access Userspace, len: 8: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RO, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, RW, len: 1: Ok
  PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace, len: 1: Ok
  success: ptrace-hwbreak

Suggested-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 48 ++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
index fc477dfe86a2..2e0d86e0687e 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -20,6 +20,8 @@
 #include <signal.h>
 #include <sys/types.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
+#include <linux/limits.h>
 #include "ptrace.h"
 
 #define SPRN_PVR	0x11F
@@ -44,6 +46,7 @@ struct gstruct {
 };
 static volatile struct gstruct gstruct __attribute__((aligned(512)));
 
+static volatile char cwd[PATH_MAX] __attribute__((aligned(8)));
 
 static void get_dbginfo(pid_t child_pid, struct ppc_debug_info *dbginfo)
 {
@@ -138,6 +141,9 @@ static void test_workload(void)
 			write_var(len);
 	}
 
+	/* PTRACE_SET_DEBUGREG, Kernel Access Userspace test */
+	syscall(__NR_getcwd, &cwd, PATH_MAX);
+
 	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, WO test */
 	write_var(1);
 
@@ -150,6 +156,9 @@ static void test_workload(void)
 	else
 		read_var(1);
 
+	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace test */
+	syscall(__NR_getcwd, &cwd, PATH_MAX);
+
 	/* PPC_PTRACE_SETHWDEBUG, MODE_RANGE, DW ALIGNED, WO test */
 	gstruct.a[rand() % A_LEN] = 'a';
 
@@ -293,6 +302,24 @@ static int test_set_debugreg(pid_t child_pid)
 	return 0;
 }
 
+static int test_set_debugreg_kernel_userspace(pid_t child_pid)
+{
+	unsigned long wp_addr = (unsigned long)cwd;
+	char *name = "PTRACE_SET_DEBUGREG";
+
+	/* PTRACE_SET_DEBUGREG, Kernel Access Userspace test */
+	wp_addr &= ~0x7UL;
+	wp_addr |= (1Ul << DABR_READ_SHIFT);
+	wp_addr |= (1UL << DABR_WRITE_SHIFT);
+	wp_addr |= (1UL << DABR_TRANSLATION_SHIFT);
+	ptrace_set_debugreg(child_pid, wp_addr);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "Kernel Access Userspace", wp_addr, 8);
+
+	ptrace_set_debugreg(child_pid, 0);
+	return 0;
+}
+
 static void get_ppc_hw_breakpoint(struct ppc_hw_breakpoint *info, int type,
 				  unsigned long addr, int len)
 {
@@ -338,6 +365,22 @@ static void test_sethwdebug_exact(pid_t child_pid)
 	ptrace_delhwdebug(child_pid, wh);
 }
 
+static void test_sethwdebug_exact_kernel_userspace(pid_t child_pid)
+{
+	struct ppc_hw_breakpoint info;
+	unsigned long wp_addr = (unsigned long)&cwd;
+	char *name = "PPC_PTRACE_SETHWDEBUG, MODE_EXACT";
+	int len = 1; /* hardcoded in kernel */
+	int wh;
+
+	/* PPC_PTRACE_SETHWDEBUG, MODE_EXACT, Kernel Access Userspace test */
+	get_ppc_hw_breakpoint(&info, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr, 0);
+	wh = ptrace_sethwdebug(child_pid, &info);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	check_success(child_pid, name, "Kernel Access Userspace", wp_addr, len);
+	ptrace_delhwdebug(child_pid, wh);
+}
+
 static void test_sethwdebug_range_aligned(pid_t child_pid)
 {
 	struct ppc_hw_breakpoint info;
@@ -452,9 +495,10 @@ static void
 run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
 {
 	test_set_debugreg(child_pid);
+	test_set_debugreg_kernel_userspace(child_pid);
+	test_sethwdebug_exact(child_pid);
+	test_sethwdebug_exact_kernel_userspace(child_pid);
 	if (dbginfo->features & PPC_DEBUG_FEATURE_DATA_BP_RANGE) {
-		test_sethwdebug_exact(child_pid);
-
 		test_sethwdebug_range_aligned(child_pid);
 		if (dawr || is_8xx) {
 			test_sethwdebug_range_unaligned(child_pid);
-- 
2.26.2

