Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AD62168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgDWHuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgDWHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:49:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A2C03C1AB;
        Thu, 23 Apr 2020 00:49:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRWcE-0008RZ-FH; Thu, 23 Apr 2020 09:49:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E8F701C04D7;
        Thu, 23 Apr 2020 09:49:43 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:49:43 -0000
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Documentation: document UACCESS warnings
Cc:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Matt Helsley <mhelsley@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158762818353.28353.5362585986312936988.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e378fa17d3fac5b118381923abd2636f45a98c6e
Gitweb:        https://git.kernel.org/tip/e378fa17d3fac5b118381923abd2636f45a98c6e
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Thu, 26 Mar 2020 11:37:06 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 22 Apr 2020 10:53:49 +02:00

objtool: Documentation: document UACCESS warnings

Compiling with Clang and CONFIG_KASAN=y was exposing a few warnings:

  call to memset() with UACCESS enabled

Document how to fix these for future travelers.

Link: https://github.com/ClangBuiltLinux/linux/issues/876
Suggested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Suggested-by: Matt Helsley <mhelsley@vmware.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/Documentation/stack-validation.txt | 26 +++++++++++++++-
 1 file changed, 26 insertions(+)

diff --git a/tools/objtool/Documentation/stack-validation.txt b/tools/objtool/Documentation/stack-validation.txt
index de09467..faa47c3 100644
--- a/tools/objtool/Documentation/stack-validation.txt
+++ b/tools/objtool/Documentation/stack-validation.txt
@@ -289,6 +289,32 @@ they mean, and suggestions for how to fix them.
       might be corrupt due to a gcc bug.  For more details, see:
       https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70646
 
+9. file.o: warning: objtool: funcA() call to funcB() with UACCESS enabled
+
+   This means that an unexpected call to a non-whitelisted function exists
+   outside of arch-specific guards.
+   X86: SMAP (stac/clac): __uaccess_begin()/__uaccess_end()
+   ARM: PAN: uaccess_enable()/uaccess_disable()
+
+   These functions should be called to denote a minimal critical section around
+   access to __user variables. See also: https://lwn.net/Articles/517475/
+
+   The intention of the warning is to prevent calls to funcB() from eventually
+   calling schedule(), potentially leaking the AC flags state, and not
+   restoring them correctly.
+
+   It also helps verify that there are no unexpected calls to funcB() which may
+   access user space pages with protections against doing so disabled.
+
+   To fix, either:
+   1) remove explicit calls to funcB() from funcA().
+   2) add the correct guards before and after calls to low level functions like
+      __get_user_size()/__put_user_size().
+   3) add funcB to uaccess_safe_builtin whitelist in tools/objtool/check.c, if
+      funcB obviously does not call schedule(), and is marked notrace (since
+      function tracing inserts additional calls, which is not obvious from the
+      sources).
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask the objtool maintainer for help.
