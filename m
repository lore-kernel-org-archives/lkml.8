Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E937C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A5820774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552728;
	bh=vDbC//cFoiarsCOyRPOI0FBifzs1I3USmWge+kKgjaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRhYQ/7kwMmBf+NDT0UN1rZ6LFzpMMCW4CeZVRZjNHG9YalOQ3wOhghOz875LaSZw
	 A8cPsSLQD02/H+ulkNYH4gXYxgk89MEyp9VsAYILNEpvh2ZSZEhwrBjHpW2QJ90RQ1
	 EBzCoAA5qO8blprHHCBQpjSE2VmIKFeWAOv1/Dt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgDVKKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbgDVKKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:10:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618212075A;
        Wed, 22 Apr 2020 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550216;
        bh=vDbC//cFoiarsCOyRPOI0FBifzs1I3USmWge+kKgjaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOJuVmEmlvb4tR2AQriYQmPRPPHoaeQnZLnXBQzuBRinvGdwNHAdthi5Xqs3D1mpr
         6TTG/SGR1J4ny3uxFHN/Pm9agKx511hvPPFfGnNXA+62RHxj0WkFA3PUszcoQ9YNQk
         hSuKqLzzr4xPD4xkBYuBA05rkbHILZwli/OCnhlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 015/199] selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault
Date:   Wed, 22 Apr 2020 11:55:41 +0200
Message-Id: <20200422095059.731868273@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095057.806111593@linuxfoundation.org>
References: <20200422095057.806111593@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 6f22238f32173..12aaa063196e7 100644
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
2.20.1



