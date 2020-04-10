Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBEAC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9BE206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490723;
	bh=rXNVyeTWN1PwcxtA3YxF+ZGQmp65KQpCYuDUWuHLwSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuVnNyiwHa0q0EynT3derSPOJYZyajmuuHKMOpd+nPkWXnXpFty8/6a8KtfpEJ9Jy
	 VKX7O7TqEfvIcV8xQyOsDoOIcI0uSzOvWZ6Y0f8/qLQTxP1QFJQP3z8qcJmjJcgiq4
	 9DPAaF8lMPSg6osXorsg71hWL64x1bo9314FcE5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgDJDwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbgDJDvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:51:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18F0B215A4;
        Fri, 10 Apr 2020 03:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490684;
        bh=rXNVyeTWN1PwcxtA3YxF+ZGQmp65KQpCYuDUWuHLwSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqzpMYVN1imC2Uj6RacOPWtHii+iFL1R9ndRW174JgqENgZ2QRNDYfuPhMVfnK4LJ
         AupWoYv7MLH+/VP6Phz8rnHabjMFbud3vjqMc1O+lxu6ucZdYn0dKEdvAuJEko0DyY
         vX3rykbDyIEqhY8g5fFp0PZWpsmajG8m5F8OHpNQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/8] selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault
Date:   Thu,  9 Apr 2020 23:51:15 -0400
Message-Id: <20200410035122.10065-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035122.10065-1-sashal@kernel.org>
References: <20200410035122.10065-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 630b99ab60aa972052a4202a1ff96c7e45eb0054 ]

If AT_SYSINFO is not present, don't try to call a NULL pointer.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/faaf688265a7e1a5b944d6f8bc0f6368158306d3.1584052409.git.luto@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/x86/ptrace_syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/ptrace_syscall.c b/tools/testing/selftests/x86/ptrace_syscall.c
index 5105b49cd8aa5..8b3c1236f04dc 100644
--- a/tools/testing/selftests/x86/ptrace_syscall.c
+++ b/tools/testing/selftests/x86/ptrace_syscall.c
@@ -284,8 +284,12 @@ int main()
 
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
2.20.1

