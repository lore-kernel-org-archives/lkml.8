Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36353C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E918120796
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJLxL+B3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B1DpaR0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIGGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIGGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:06:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C465C061575;
        Sun,  6 Sep 2020 23:06:03 -0700 (PDT)
Date:   Mon, 07 Sep 2020 06:05:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599458752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWhrUXu+2RpzGQb8rdfKI0UqVKHS9QTwANRPeSNGXDU=;
        b=hJLxL+B3mko57BVHUchbgJiOZ6uO1VzkLoECWTBoyBtyM/8Bxu39XxV4pm/GhIadNTz17i
        Y3DhfAVOaKWCr7BUTCoVkoRTwGO/06jJwjm7oFnwIdDaKUA9W46auJkAPhsT/oVjdGLgpg
        d4bmeI0W3dLw4eyCKNfV3EST1O30zblQHcqPoCIgpgCvHeA5SroMLHwgLIrHAdke/df2MW
        OmckkUUoQUEXylaS1raCtO77x8335fn/v5sustBjfpF9JzBkffGjn3XCi944wmhBN9ZY0F
        ifHcEUHj6l2L3jdR3rXtwHnPIw73g2EBzXW1coVrsDeb32yr5W54KB1CDDoUdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599458752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWhrUXu+2RpzGQb8rdfKI0UqVKHS9QTwANRPeSNGXDU=;
        b=B1DpaR0k0a+zUGkk8ZKY0BKwKnPhZOzITpHWzUggvwLAuMSxirPXEDsbLlCHTmt8aYMl9K
        OOFUgyghlZaeM7Bw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm/build: Warn on orphan section placement
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902025347.2504702-3-keescook@chromium.org>
References: <20200902025347.2504702-3-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159945875149.20229.4351707198821263152.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     5a17850e251a55bba6d65aefbfeacfa9888cd2cd
Gitweb:        https://git.kernel.org/tip/5a17850e251a55bba6d65aefbfeacfa9888cd2cd
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 01 Sep 2020 19:53:44 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 10:28:35 +02:00

arm/build: Warn on orphan section placement

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20200902025347.2504702-3-keescook@chromium.org
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e87735..e589da3 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
