Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C777FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB672065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PsORa6e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYlFvW67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGZQ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:29:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGZQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:29:55 -0400
Date:   Sun, 26 Jul 2020 16:29:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595780993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKt0EFknrv4loToQvabpAEaWdgdQ8W7fCEUFKVi0/Lk=;
        b=1PsORa6eWtA4aQtnG0XXqnbTgMOisgM70C+c7HG1BwDnzplNXgUicu3Z4d5fpN2GNFiQJC
        w9CE7O5bdokEgEZHSvdtksDHaobD3uGle/ySmYt9oP5OHyx98eQ5sbCTC8AuMvMk9EVEC5
        aH/2jcjSLvbezYkToPcaQyo7WXv7AFfQ4lLp4Iz9WdbYhKG905Mx9L+OBnD2GuSOqM2nP9
        e+dInAwvXMflez3+jRC8klIjl0p0NAMymzqf5jGUmdyqnhJokaDtZvIQQGeNi9Uga0rR1e
        Qeb/d6rBgcbPqupsyGK8ZcPcr5ceipiyhbGDzVTNumjrYQ73gIzCVemSSSF1fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595780993;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKt0EFknrv4loToQvabpAEaWdgdQ8W7fCEUFKVi0/Lk=;
        b=NYlFvW67GtL6OmxXH1zJkuXN9qtaBiDAYfnI7CtJjKfGx34pfwkPLN0In0ypb8Ng605xyA
        VwtBwwOV1usrLjCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Correct __secure_computing() stub
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159578099290.4006.9697621810385218017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     3135f5b73592988af0eb1b11ccbb72a8667be201
Gitweb:        https://git.kernel.org/tip/3135f5b73592988af0eb1b11ccbb72a8667be201
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 26 Jul 2020 18:14:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 26 Jul 2020 18:22:27 +02:00

entry: Correct __secure_computing() stub

The original version of that used secure_computing() which has no
arguments. Review requested to switch to __secure_computing() which has
one. The function name was correct, but no argument added and of course
compiling without SECCOMP was deemed overrated.

Add the missing function argument.

Fixes: 6823ecabf030 ("seccomp: Provide stub for __secure_computing()")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/seccomp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 03d28c3..51f234b 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -58,10 +58,11 @@ static inline int seccomp_mode(struct seccomp *s)
 
 struct seccomp { };
 struct seccomp_filter { };
+struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 static inline int secure_computing(void) { return 0; }
-static inline int __secure_computing(void) { return 0; }
+static inline int __secure_computing(const struct seccomp_data *sd) { return 0; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
