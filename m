Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78912C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52F1820575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550330;
	bh=ZMr3cobph3pHX+whIvaq3dvLnbLGICj7rLWUDrQdOC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d/aa9EyVp8TGzIs1LiP+ldVL7vPB6rbq1woxg89sfZhxlrP+QDKZpJrybi6r6VLKK
	 fO/SJofTb8N4abjW4Q2BoZ2bvB4ueh9L5mf1B+ZRkmPvjvsxDRVteHoFYEXS0o1hMY
	 oVkAvCis1fQ/TdRWuCvnmwl1RokwPHIzoZ14kHk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgDVKMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbgDVKLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:11:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5AE20575;
        Wed, 22 Apr 2020 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550315;
        bh=ZMr3cobph3pHX+whIvaq3dvLnbLGICj7rLWUDrQdOC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkyqiBCzn/w/KUAgloKfAdg9DXZbvMm0PYubIceBZtyA7UkSUJQfjNKkmwn8F02af
         zGZYgcUWr3IrJZQFM+1G5KuDgKO0+YTz3BwHisCtn47tOjNxECUavKGN+EFdCGvvNT
         JW/jqWQHBZJXWx8qu5pLry5b+2JKQ9hyhT0MMdpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clement Courbet <courbet@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 094/199] powerpc: Make setjmp/longjmp signature standard
Date:   Wed, 22 Apr 2020 11:57:00 +0200
Message-Id: <20200422095107.457740465@linuxfoundation.org>
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

From: Clement Courbet <courbet@google.com>

commit c17eb4dca5a353a9dbbb8ad6934fe57af7165e91 upstream.

Declaring setjmp()/longjmp() as taking longs makes the signature
non-standard, and makes clang complain. In the past, this has been
worked around by adding -ffreestanding to the compile flags.

The implementation looks like it only ever propagates the value
(in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
with integer parameters.

This allows removing -ffreestanding from the compilation flags.

Fixes: c9029ef9c957 ("powerpc: Avoid clang warnings around setjmp and longjmp")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Clement Courbet <courbet@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200330080400.124803-1-courbet@google.com
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/setjmp.h |    6 ++++--
 arch/powerpc/kernel/Makefile      |    3 ---
 arch/powerpc/xmon/Makefile        |    3 ---
 3 files changed, 4 insertions(+), 8 deletions(-)

--- a/arch/powerpc/include/asm/setjmp.h
+++ b/arch/powerpc/include/asm/setjmp.h
@@ -12,7 +12,9 @@
 
 #define JMP_BUF_LEN    23
 
-extern long setjmp(long *) __attribute__((returns_twice));
-extern void longjmp(long *, long) __attribute__((noreturn));
+typedef long jmp_buf[JMP_BUF_LEN];
+
+extern int setjmp(jmp_buf env) __attribute__((returns_twice));
+extern void longjmp(jmp_buf env, int val) __attribute__((noreturn));
 
 #endif /* _ASM_POWERPC_SETJMP_H */
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -5,9 +5,6 @@
 
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
-# Avoid clang warnings around longjmp/setjmp declarations
-CFLAGS_crash.o += -ffreestanding
-
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ifeq ($(CONFIG_PPC64),y)
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for xmon
 
-# Avoid clang warnings around longjmp/setjmp declarations
-subdir-ccflags-y := -ffreestanding
-
 subdir-ccflags-$(CONFIG_PPC_WERROR) += -Werror
 
 GCOV_PROFILE := n


