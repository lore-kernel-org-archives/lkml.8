Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E80C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0EB2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgCTKhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:37:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35237 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCTKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:37:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFF1L-0001rf-9M; Fri, 20 Mar 2020 11:36:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0D311C229B;
        Fri, 20 Mar 2020 11:36:54 +0100 (CET)
Date:   Fri, 20 Mar 2020 10:36:54 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86/vdso: Fix no-vDSO segfaults
Cc:     kbuild test robot <lkp@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <618ea7b8c55b10d08b1cb139e9a3a957934b8647.1584653439.git.luto@kernel.org>
References: <618ea7b8c55b10d08b1cb139e9a3a957934b8647.1584653439.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <158470061455.28353.13715473417067109216.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     07f24dc95daca49b8a2e804edc024dd4e91610ac
Gitweb:        https://git.kernel.org/tip/07f24dc95daca49b8a2e804edc024dd4e91610ac
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 19 Mar 2020 14:30:56 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 Mar 2020 11:20:04 +01:00

selftests/x86/vdso: Fix no-vDSO segfaults

test_vdso would try to call a NULL pointer if the vDSO was missing.

vdso_restorer_32 hit a genuine failure: trying to use the
kernel-provided signal restorer doesn't work if the vDSO is missing.
Skip the test if the vDSO is missing, since the test adds no particular
value in that case.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/618ea7b8c55b10d08b1cb139e9a3a957934b8647.1584653439.git.luto@kernel.org
---
 tools/testing/selftests/x86/test_vdso.c     |  5 +++++
 tools/testing/selftests/x86/vdso_restorer.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 35edd61..42052db 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -259,6 +259,11 @@ static void test_one_clock_gettime(int clock, const char *name)
 
 static void test_clock_gettime(void)
 {
+	if (!vdso_clock_gettime) {
+		printf("[SKIP]\tNo vDSO, so skipping clock_gettime() tests\n");
+		return;
+	}
+
 	for (int clock = 0; clock < sizeof(clocknames) / sizeof(clocknames[0]);
 	     clock++) {
 		test_one_clock_gettime(clock, clocknames[clock]);
diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index 29a5c94..fe99f24 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -15,6 +15,7 @@
 
 #include <err.h>
 #include <stdio.h>
+#include <dlfcn.h>
 #include <string.h>
 #include <signal.h>
 #include <unistd.h>
@@ -46,11 +47,23 @@ int main()
 	int nerrs = 0;
 	struct real_sigaction sa;
 
+	void *vdso = dlopen("linux-vdso.so.1",
+			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-gate.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso) {
+		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
+		return 0;
+	}
+
 	memset(&sa, 0, sizeof(sa));
 	sa.handler = handler_with_siginfo;
 	sa.flags = SA_SIGINFO;
 	sa.restorer = NULL;	/* request kernel-provided restorer */
 
+	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
+
 	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
 		err(1, "raw rt_sigaction syscall");
 
@@ -63,6 +76,8 @@ int main()
 		nerrs++;
 	}
 
+	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
+
 	sa.flags = 0;
 	sa.handler = handler_without_siginfo;
 	if (syscall(SYS_sigaction, SIGUSR1, &sa, 0) != 0)
