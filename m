Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93332C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665292076F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584653463;
	bh=XoNLI3PZ0pNJq+KUOpGKAABFZ3n79TrsPWdFjxnE3vk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=dMeE9SxW3Tq7ByeN73a9wE7QcJFNy2G2R2TJtwJnHz4yt3t4b/yesOMxpd7oFxK7f
	 lMLT4AhM+nl4HraoNsLVcMEnam7IwxGBjoRI0ULFofQdoGw+EizcVZh0C9x0wmRFgF
	 4vYBJO3+kKupkDmf+PilBlDBPydFMffxuC3SOagk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgCSVbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgCSVbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:31:01 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0822076F;
        Thu, 19 Mar 2020 21:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584653461;
        bh=XoNLI3PZ0pNJq+KUOpGKAABFZ3n79TrsPWdFjxnE3vk=;
        h=From:To:Cc:Subject:Date:From;
        b=ieHRyfHq7pL92q7bL87ooCp5uvBMPeROvuZBodBy2m/WO4kbpdL5x+/VlN7n/suOM
         E66vN1E62PYp1uFPgh13qyrA0hqlroNFCY2QOZHc/cbpM9gLYRSnBkGIBmuPdlDUGh
         mVvXvy2eEumWDBBwkBs2RtztQkXiX8BBVf3gB9ZA=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] selftests/x86/test_vdso, vdso_restorer: Fix no-vDSO segfaults
Date:   Thu, 19 Mar 2020 14:30:56 -0700
Message-Id: <618ea7b8c55b10d08b1cb139e9a3a957934b8647.1584653439.git.luto@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_vdso would try to call a NULL pointer if the vDSO was missing.

vdso_restorer_32 hit a genuine failure: trying to use the
kernel-provided signal restorer doesn't work if the vDSO is missing.
Skip the test if the vDSO is missing, since the test adds no
particular value in that case.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/test_vdso.c     |  5 +++++
 tools/testing/selftests/x86/vdso_restorer.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 35edd61d1663..42052db0f870 100644
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
index 29a5c94c4b50..fe99f2434155 100644
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
-- 
2.24.1

