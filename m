Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC686C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8954E21556
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="peqLmI8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgDWQMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:12:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59874 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbgDWQMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:12:30 -0400
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 359101EC0D8B;
        Thu, 23 Apr 2020 18:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587658348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igXY94ymhLHLbnPRtnKA4PNuErVbqZgvsorBI0rNWao=;
        b=peqLmI8cJ8W/N2QOqUSbPOHkRtSxEjEpdwqMcu38lbOvRyAxZpei7UDucs+XubPxFWZ5jv
        4MmNQ9G2RzSjWc9nXUbLk8ZPmEmB5eMEC9oxqk0F+5JL/Nu8sEnhJbJyonUMb9lZmK/+hU
        YagnwcoyZJpaZfYDnvTkATAMBPmv4Os=
Date:   Thu, 23 Apr 2020 18:12:24 +0200
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
Subject: [PATCH] x86: Fix early boot crash on gcc-10, next try
Message-ID: <20200423161126.GD26021@zn.tnic>
References: <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <CAKwvOd=Dza3UBfeUzs2RW6ko5fDr3jYeGQAYpJXqyEVns6DJHg@mail.gmail.com>
 <20200422192113.GG26846@zn.tnic>
 <CAKwvOdkbcO8RzoafON2mGiSy5P96P5+aY8GySysF2my7q+nTqw@mail.gmail.com>
 <20200422212605.GI26846@zn.tnic>
 <CAKwvOd=exxhfb8N6=1Q=wBUaYcRDEq3L1+TiHDLz+pxWg8OuwQ@mail.gmail.com>
 <20200423125300.GC26021@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423125300.GC26021@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,

I have tried to summarize our odyssey so far and here's what I came up
with. Just built latest gcc from the git repo and it seems to work.

Next I need to come up with a slick way of testing the compiler...

Thx.

---
From: Borislav Petkov <bp@suse.de>

... or the odyssey of trying to disable the stack protector for the
function which generates the stack canary value.

The whole story started with Sergei reporting a boot crash with a kernel
built with gcc-10:

  Kernel panic — not syncing: stack-protector: Kernel stack is corrupted in: start_secondary
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc5—00235—gfffb08b37df9 #139
  Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./H77M—D3H, BIOS F12 11/14/2013
  Call Trace:
    dump_stack
    panic
    ? start_secondary
    __stack_chk_fail
    start_secondary
    secondary_startup_64
  -—-[ end Kernel panic — not syncing: stack—protector: Kernel stack is corrupted in: start_secondary

This happens because gcc-10 tail-call optimizes the last function call
in start_secondary() - cpu_startup_entry() - and thus emits a stack
canary check which fails because the canary value changes after the
boot_init_stack_canary() call.

To fix that, the initial attempt was to mark the one function which
generates the stack canary with:

  __attribute__((optimize("-fno-stack-protector"))) ... start_secondary(void *unused)

however, using the optimize attribute doesn't work cumulatively
as the attribute does not add to but rather replaces previously
supplied optimization options - roughly all -fxxx options.

The key one among them being -fno-omit-frame-pointer and thus leading to
not present frame pointer - frame pointer which the kernel needs.

The next attempt to prevent compilers from tail-call optimizing
the last function call cpu_startup_entry(), shy of carving out
start_secondary() into a separate compilation unit and building it with
-fno-stack-protector, is this one.

The current solution is short and sweet, and reportedly, is supported by
both compilers so let's see how far we'll get this time.

Reported-by: Sergei Trofimovich <slyfox@gentoo.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200314164451.346497-1-slyfox@gentoo.org
---
 arch/x86/kernel/smpboot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3b9bf8c7e29d..e9f44727fccd 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -266,6 +266,14 @@ static void notrace start_secondary(void *unused)
 
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+
+	/*
+	 * Prevent tail call to cpu_startup_entry() because the stack protector
+	 * guard has been changed a couple of functions up, in
+	 * boot_init_stack_canary() and must not be checked before tail calling
+	 * another function.
+	 */
+	asm ("");
 }
 
 /**
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
