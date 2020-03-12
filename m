Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4618C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B5F20736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584052554;
	bh=frLG7D0WmDbeJXAKsWnO/TTOThd5CNKRFtvEisk7fRo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D6XW1pNPoaDGZSXpYvUpCY1eCtsLEimcj/9O281Fweesrb6fYNNRXNjb3oIigLy2v
	 B9yRxmxHzP/A9SmJDFpjHheWpFx3GlVMuAIYhFYRYmGyHkFL63EIWnTuH7BP6HrU84
	 0xe/SfECRay39SVsjpEQfDjMCp4buarq0LxCX7fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCLWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:35:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgCLWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:35:53 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2C5206CD;
        Thu, 12 Mar 2020 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584052553;
        bh=frLG7D0WmDbeJXAKsWnO/TTOThd5CNKRFtvEisk7fRo=;
        h=From:To:Cc:Subject:Date:From;
        b=fO+DLU8mbjH/YGxm0XGb4Zzj300yIwKgddeUNf9A77bULU0LVK5WJxrCxMPmdXjSe
         0r5bwloy1yddS90la48hgQ55bqANHt4Fe+YHo+EdY4LedQ5nquaqe/c/4MiD7zobTR
         kIvIbwEMjcq3mPxNfRHbvjkOyOnMJmoTMaL6KNgQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault
Date:   Thu, 12 Mar 2020 15:35:51 -0700
Message-Id: <faaf688265a7e1a5b944d6f8bc0f6368158306d3.1584052409.git.luto@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If AT_SYSINFO is not present, don't try to call a NULL pointer.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 6f22238f3217..12aaa063196e 100644
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
-- 
2.24.1

