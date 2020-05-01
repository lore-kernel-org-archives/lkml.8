Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806FAC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6912B24968
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgEASXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730703AbgEASWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7418CC061A0E;
        Fri,  1 May 2020 11:22:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIu-0003jK-2s; Fri, 01 May 2020 20:22:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF7781C04DD;
        Fri,  1 May 2020 20:22:24 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:24 -0000
From:   "tip-bot2 for Konstantin Khlebnikov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] ftrace/x86: Fix trace event registration for
 syscalls without arguments
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <158636958997.7900.16485049455470033557.stgit@buzz>
References: <158636958997.7900.16485049455470033557.stgit@buzz>
MIME-Version: 1.0
Message-ID: <158835734479.8414.1154640678275011655.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fdc63ff0e49c588884992b4b2656345a5e878b32
Gitweb:        https://git.kernel.org/tip/fdc63ff0e49c588884992b4b2656345a5e878b32
Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate:    Wed, 08 Apr 2020 21:13:10 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 01 May 2020 19:15:40 +02:00

ftrace/x86: Fix trace event registration for syscalls without arguments

The refactoring of SYSCALL_DEFINE0() macros removed the ABI stubs and
simply defines __abi_sys_$NAME as alias of __do_sys_$NAME.

As a result kallsyms_lookup() returns "__do_sys_$NAME" which does not match
with the declared trace event name.

See also commit 1c758a2202a6 ("tracing/x86: Update syscall trace events to
handle new prefixed syscall func names").

Add __do_sys_ to the valid prefixes which are checked in
arch_syscall_match_sym_name().

Fixes: d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/158636958997.7900.16485049455470033557.stgit@buzz

---
 arch/x86/include/asm/ftrace.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 85be2f5..70b96ca 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -61,11 +61,12 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
 {
 	/*
 	 * Compare the symbol name with the system call name. Skip the
-	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
+	 * "__x64_sys", "__ia32_sys", "__do_sys" or simple "sys" prefix.
 	 */
 	return !strcmp(sym + 3, name + 3) ||
 		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
-		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
+		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3)) ||
+		(!strncmp(sym, "__do_sys", 8) && !strcmp(sym + 8, name + 3));
 }
 
 #ifndef COMPILE_OFFSETS
