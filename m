Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5EDC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD15124656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582182843;
	bh=2YUcYMrgZVnWN/CARA1x1Z4L8XOK9AEca//b0RCdMuc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nyW00DcSXb1v9onIhzQ2UhEDz/y79MUNkWKkakFYEXO73WJRn748tPWEPCisDUD4d
	 WI7SULbXK8+mc+Rr7zpgaYJ9McF8BH0ACsDYg46JJPopIFj8Qmk9lI5l914R8Jfre0
	 9qW7Eagx/wmMAqX/mM+b0k3v7e2Iv3MsvF7qqRXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBTHOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:14:02 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36906 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTHOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:14:02 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 01K7Bl6d011059;
        Thu, 20 Feb 2020 16:11:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 01K7Bl6d011059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582182709;
        bh=RGjdzwfQtcxcoKdnoWUCQmUyQN1VFbdpPZmhgB3NQTg=;
        h=From:To:Cc:Subject:Date:From;
        b=AWHBX0UdXgGdhv2cpgdj49Y1GSquysKyrkVwyMwJbateXpitUPdtm1oyYUf0n5cPe
         zutHkgNQJ2DO/MNHEuFQOVml5GdlGqb291UoCA2/SP0G9xhvUEXPuqcK2QopZ+KVsi
         DAAzVmHYxXU/uhr4gaxXcUvB+LOUOmqFSWsuSaY2hTBMDw7E4T8B4IOje6fYgFbHD4
         3pyg00EK0d9WBtL6pPADmrbyn4XQkxTYqaWPTM5xusKG4sgf15N2fbGbV8xoOc8/ta
         i2FS1sneF/UM/Kb9t0JE9o37m3Zl/ixLhkNU8o2zAruo62J6F8RmYehjA8EW4sEwZT
         nv+juHiW9uAmA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Date:   Thu, 20 Feb 2020 16:11:39 +0900
Message-Id: <20200220071140.14080-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected.

It is because <linux/compiler_types.h> is parsed before vclock_gettime.c
since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
struct attributes").

Since then, <linux/compiler_types.h> is included really early by
using the '-include' option. So, you cannot negate the decision of
<linux/compiler_types.h> in this way.

You can confirm it by checking the pre-processed code, like this:

  $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i

There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.

It it about two years since 28128c61e08e. Nobody has reported a
problem (or, nobody has even noticed the fact that this code is not
working).

It is ugly and unreliable to attempt to undefine a CONFIG option from
C files, and anyway the inlining heuristic is up to the compiler.

Just remove the broken code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/vdso32/vclock_gettime.c     | 4 ----
 arch/x86/entry/vdso/vdso32/vclock_gettime.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/sparc/vdso/vdso32/vclock_gettime.c b/arch/sparc/vdso/vdso32/vclock_gettime.c
index 026abb3b826c..d7f99e6745ea 100644
--- a/arch/sparc/vdso/vdso32/vclock_gettime.c
+++ b/arch/sparc/vdso/vdso32/vclock_gettime.c
@@ -4,10 +4,6 @@
 
 #define	BUILD_VDSO32
 
-#ifndef	CONFIG_CC_OPTIMIZE_FOR_SIZE
-#undef	CONFIG_OPTIMIZE_INLINING
-#endif
-
 #ifdef	CONFIG_SPARC64
 
 /*
diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
index 9242b28418d5..3c26488db94d 100644
--- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
@@ -1,10 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define BUILD_VDSO32
 
-#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-#undef CONFIG_OPTIMIZE_INLINING
-#endif
-
 #ifdef CONFIG_X86_64
 
 /*
-- 
2.17.1

