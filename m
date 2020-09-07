Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA687C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57EE12145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgUgUtcH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCcM3bYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgIGGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgIGGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:06:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05811C061574;
        Sun,  6 Sep 2020 23:06:03 -0700 (PDT)
Date:   Mon, 07 Sep 2020 06:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPT9oQPC21g6xntCJxn95T6nJT9qkoIKzRBPckz2sAo=;
        b=KgUgUtcHunPYvjQC133vlThRdEQ31cM92foL2z0ffrVa7vBZSz9S9lR1GpPop/UbX2+kOw
        ObLUOq19rEX+Wb04Xngyx6vrRRz6AECFeM5diaoePty+bUzWH8l8XqfwnzM6ZOcvBv3TJw
        2Wh6LhPqkRggZkxh8FNDUDr3D4SJtwPaEYcNvEynhgTl92wkqQvJtUuZ/jQTlAhuktJNvR
        ZAKxqMPfL5Zjdh47Bp1UMRbUdABnGAtfrKK5tczCykm9Kx1QZGvQYPLuIKv2XTG7hkU1ax
        Mau8dW+8ZiBIfWjuOMZtd0ToptXRUr/a28VbQFXPI/KfJ2TYtJHgtBNxpAL1Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPT9oQPC21g6xntCJxn95T6nJT9qkoIKzRBPckz2sAo=;
        b=tCcM3bYiSzG4sSOji7VRR/Zjq/LgOY4BpXMfqvT3umyG6BUzfCpNzx8dOpu2mGn7Z69Ws4
        fFRA+N3R0YiGe4Dg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/build: Warn on orphan section placement
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902025347.2504702-5-keescook@chromium.org>
References: <20200902025347.2504702-5-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159945875070.20229.5266595565501285727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     83109d5d5fba7abf362f5a443c9f4c4ea10bbc8d
Gitweb:        https://git.kernel.org/tip/83109d5d5fba7abf362f5a443c9f4c4ea10bbc8d
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 01 Sep 2020 19:53:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 10:28:36 +02:00

x86/build: Warn on orphan section placement

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20200902025347.2504702-5-keescook@chromium.org
---
 arch/x86/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 4346ffb..154259f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -209,6 +209,10 @@ ifdef CONFIG_X86_64
 LDFLAGS_vmlinux += -z max-page-size=0x200000
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 archscripts: scripts_basic
 	$(Q)$(MAKE) $(build)=arch/x86/tools relocs
 
