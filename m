Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D21C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C0720857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="n+EbahP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgDWRbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:31:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46346 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbgDWRbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:31:04 -0400
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5993D1EC0D79;
        Thu, 23 Apr 2020 19:31:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587663063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=r4OL11TH+fTo0NNwv+4evRIfxa9+U11aNGFnhjxhNqc=;
        b=n+EbahP280zPlUpPoH0ixnYJEhus3hnYtW9M+sKHgVNqyOVsI6vpsO/L5f8SJVC6LO3oFp
        1KQWny+ktdhF1oPkquTyXMUcITSA6CNg/Ma/tYHkz8vCok+aP4F+I3px7kTsJtvBcRryqf
        YUe87PkmKIE14xsGBGqXBfQM7MymD/U=
Date:   Thu, 23 Apr 2020 19:30:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Matz <matz@suse.de>, Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200423173058.GE26021@zn.tnic>
References: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
 <20200423161126.GD26021@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423161126.GD26021@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 06:12:24PM +0200, Borislav Petkov wrote:
> Ok,
> 
> I have tried to summarize our odyssey so far and here's what I came up
> with. Just built latest gcc from the git repo and it seems to work.
> 
> Next I need to come up with a slick way of testing the compiler...

Maybe something like this. Seems to work with both.

---
From: Borislav Petkov <bp@suse.de>
Date: Thu, 23 Apr 2020 19:28:28 +0200
Subject: [PATCH] Check compiler

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/Makefile             | 4 ++++
 scripts/x86-check-compiler.sh | 9 +++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 scripts/x86-check-compiler.sh

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..38d3eec5062e 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Unified Makefile for i386 and x86_64
 
+#  Check the compiler
+sane_compiler := $(shell $(srctree)/scripts/x86-check-compiler.sh $(CC))
+$(if $(sane_compiler),$(error $(CC) check failed. Aborting),)
+
 # select defconfig based on actual architecture
 ifeq ($(ARCH),x86)
   ifeq ($(shell uname -m),x86_64)
diff --git a/scripts/x86-check-compiler.sh b/scripts/x86-check-compiler.sh
new file mode 100755
index 000000000000..b2b5b54b6939
--- /dev/null
+++ b/scripts/x86-check-compiler.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Check whether the compiler tail-call optimizes across an asm() statement.
+# Fail the build if it does.
+
+echo "int foo(int a); int bar(int a) { int r = foo(a); asm(\"\"); return r; }" |\
+	     $* -O2 -x c -c -S - -o - 2>/dev/null |\
+	     grep -E "^[[:blank:]]+jmp[[:blank:]]+.*"
-- 
2.21.0

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
