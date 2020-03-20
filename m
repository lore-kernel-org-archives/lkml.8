Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1016C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE092072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCTKhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:37:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35238 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:37:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFF1L-0001re-1t; Fri, 20 Mar 2020 11:36:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 725111C0DD3;
        Fri, 20 Mar 2020 11:36:54 +0100 (CET)
Date:   Fri, 20 Mar 2020 10:36:54 -0000
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault
Cc:     kbuild test robot <lkp@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <faaf688265a7e1a5b944d6f8bc0f6368158306d3.1584052409.git.luto@kernel.org>
References: <faaf688265a7e1a5b944d6f8bc0f6368158306d3.1584052409.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <158470061410.28353.14485077057273139954.tip-bot2@tip-bot2>
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

Commit-ID:     630b99ab60aa972052a4202a1ff96c7e45eb0054
Gitweb:        https://git.kernel.org/tip/630b99ab60aa972052a4202a1ff96c7e45eb0054
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Thu, 12 Mar 2020 15:35:51 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 Mar 2020 11:28:47 +01:00

selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault

If AT_SYSINFO is not present, don't try to call a NULL pointer.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/faaf688265a7e1a5b944d6f8bc0f6368158306d3.1584052409.git.luto@kernel.org
---
 tools/testing/selftests/x86/ptrace_syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 6f22238..12aaa06 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -414,8 +414,12 @@ int main()
 
 #if defined(__i386__) && (!defined(__GLIBC__) || __GLIBC__ > 2 || __GLIBC_MINOR__ >= 16)
 	vsyscall32 = (void *)getauxval(AT_SYSINFO);
-	printf("[RUN]\tCheck AT_SYSINFO return regs\n");
-	test_sys32_regs(do_full_vsyscall32);
+	if (vsyscall32) {
+		printf("[RUN]\tCheck AT_SYSINFO return regs\n");
+		test_sys32_regs(do_full_vsyscall32);
+	} else {
+		printf("[SKIP]\tAT_SYSINFO is not available\n");
+	}
 #endif
 
 	test_ptrace_syscall_restart();
