Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97418C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D7C20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="It9/bv1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgDHSNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:13:14 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:54164 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730618AbgDHSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:13:14 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id C9C112E153E;
        Wed,  8 Apr 2020 21:13:10 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id weMpEu5e15-DAMawS8n;
        Wed, 08 Apr 2020 21:13:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1586369590; bh=FYJHOBunNAkqZBTOKzs2lAXiPeKDnuhxIxE82v7LAzo=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=It9/bv1ubfflgvX5xoyviU5pKz4zW2+fxSLxd7eUAy9fTD/K1nTyLFeFAEFYd/YGX
         IpaM2nYKwWxyxeSPW9mLxL3bLvMgYnQWU6Sl4pAa82wrLFahJykjYUhbI9kAlReLos
         gBX4WgF5QlqS+bYqnA4E91o0/krVDYgM5E44Gq5g=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8808::1:4])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5CWE3zneGl-DAWOe8xk;
        Wed, 08 Apr 2020 21:13:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] tracing/x86: fix trace event registration for syscalls
 without arguments
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 08 Apr 2020 21:13:10 +0300
Message-ID: <158636958997.7900.16485049455470033557.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syscalls without arguments now has no ABI subs, instead of that macro
SYSCALL_DEFINE0() defines __abi_sys_name as aliase to __do_sys_name.

As a result in find_syscall_meta() kallsyms_lookup() returns
"__do_sys_name" which does not match with declared trace event.

Also see commit 1c758a2202a6 ("tracing/x86: Update syscall trace events
to handle new prefixed syscall func names")

Fixes: d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 arch/x86/include/asm/ftrace.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 85be2f506272..70b96cae5b42 100644
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

