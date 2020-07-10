Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F52C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9608E2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594404296;
	bh=BuGVKM7rrsUCZjTvAdy2HByYM2r2OiEDWrLNJoH0UjU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZswqGMm1Bbu3d//W5XoBuQQY4z4bedMXo52SgVT3LY3972qyIYILbWk8khTDiv46w
	 HWaBChOFEDKEYTBq9vGwgQafyvvknfyTMfZmeLewCJTIf8GQislkwsTBbLtD1QNJr4
	 POCfPbVON2kV42BXkqfgkOlUYzjUS1Bj/kiPg4OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGJSEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgGJSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:04:54 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1490A2076A;
        Fri, 10 Jul 2020 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594404294;
        bh=BuGVKM7rrsUCZjTvAdy2HByYM2r2OiEDWrLNJoH0UjU=;
        h=From:To:Cc:Subject:Date:From;
        b=EAhxjKT01Wmfvs25rU5P5FvNC5R7IdOhaemCWQm7R9286cKrGR/bFaj13K3G80UEw
         WH2C6X4jk4fO1A6XYy4AxgoiAlYBWKci/8sYV1zJm5Au8ZOUJJE1Ge+7toUM0LXTx1
         J62tU8gILHTkJjqlc//RCL1JqyAKA9LcbUgZ3meM=
From:   Andy Lutomirski <luto@kernel.org>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] seccomp.2: Improve x32 and nr truncation notes
Date:   Fri, 10 Jul 2020 11:04:51 -0700
Message-Id: <4c7e1cfa3978de83713b71a3f29c8c5f250cf0c6.1594404029.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 man2/seccomp.2 | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/man2/seccomp.2 b/man2/seccomp.2
index a1b1a28db9bf..e491825600e8 100644
--- a/man2/seccomp.2
+++ b/man2/seccomp.2
@@ -342,16 +342,38 @@ is used on the system call number to tell the two ABIs apart.
 .\"     an extra instruction in system_call to mask off the extra bit,
 .\"     so that the syscall table indexing still works.
 .PP
-This means that in order to create a seccomp-based
-deny-list for system calls performed through the x86-64 ABI,
-it is necessary to not only check that
-.IR arch
-equals
-.BR AUDIT_ARCH_X86_64 ,
-but also to explicitly reject all system calls that contain
+This means that a policy must either deny all syscalls with
 .BR __X32_SYSCALL_BIT
-in
-.IR nr .
+or it must recognize syscalls with and without
+.BR __X32_SYSCALL_BIT
+set.  A list of syscalls to be denied based on
+.IR nr
+that does not also contain
+.IR nr
+values with
+.BR __X32_SYSCALL_BIT
+set can be bypassed by a malicious program that sets
+.BR __X32_SYSCALL_BIT .
+.PP
+Additionally, kernels prior to 5.4 incorrectly permitted
+.IR nr
+in the ranges 512-547 as well as the corresponding non-x32 syscalls ored
+with
+.BR __X32_SYSCALL_BIT .
+For example,
+.IR nr
+== 521 and
+.IR nr
+== (101 |
+.BR __X32_SYSCALL_BIT )
+would result in invocations of
+.BR ptrace (2)
+with potentially confused x32-vs-x86_64 semantics in the kernel.
+Policies intended to work on kernels before 5.4 must ensure that they
+deny or otherwise correctly handle these system calls.  On kernels
+5.4 and newer, such system calls will return -ENOSYS without doing
+anything.
+.\" commit 6365b842aae4490ebfafadfc6bb27a6d3cc54757
 .PP
 The
 .I instruction_pointer
@@ -368,8 +390,8 @@ and
 system calls to prevent the program from subverting such checks.)
 .PP
 When checking values from
-.IR args
-against a deny-list, keep in mind that arguments are often
+.IR args,
+keep in mind that arguments are often
 silently truncated before being processed, but after the seccomp check.
 For example, this happens if the i386 ABI is used on an
 x86-64 kernel: although the kernel will normally not look beyond
-- 
2.25.4

