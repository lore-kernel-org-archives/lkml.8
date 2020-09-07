Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B9AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6FD2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pLu3QBBt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1L38T8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIGGGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIGGGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:06:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F151CC061573;
        Sun,  6 Sep 2020 23:06:03 -0700 (PDT)
Date:   Mon, 07 Sep 2020 06:05:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqxPCfBVsq4bjsOxWBa+uOdpA/zPBZj2JVst5UAJ/N4=;
        b=pLu3QBBt7DQlMzAP41yUSGmYp5DVEzgaUgTjPfDr2N2u+LzkH5qy1WaEqHfsC6LF8Sg634
        KHGPSdWii1xcZQh4hkaicxp+bDIgeBh1ywr+cpQ0nJCC0SUK+6xZTkPCt7L5U7L6XIv1Lt
        7+qYspjYQNlDLVIVMMiOm+jWt3TGJmbc4BR91OR7YShwKxl0+Ebcys9BH/HSBLEFfHuj5e
        LfvIWmp5JcZozJfeUOCYU8olXR+KwQoxooNod4nDpNyfp3vcDvNAAdYZb5Mt4LpnujlBaI
        BgcWWYTQ0iZ1CXWQ+vdQz2ZeCTDl8ADm1A3J8PUfbXYx74gEnqU9m+arz5om+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqxPCfBVsq4bjsOxWBa+uOdpA/zPBZj2JVst5UAJ/N4=;
        b=d1L38T8S+GTEEv7b7viRMJau1NswTmM5DfMf9Q/ivm2xU/0jTGu6hXg1Er4cBxNxlrSV6r
        eYB68GrAhknql5Bg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm/boot: Warn on orphan section placement
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902025347.2504702-4-keescook@chromium.org>
References: <20200902025347.2504702-4-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159945875109.20229.17726709562064025433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     4409d2f8dfe7d5088567d4ba00133f876ee586c7
Gitweb:        https://git.kernel.org/tip/4409d2f8dfe7d5088567d4ba00133f876ee586c7
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 01 Sep 2020 19:53:45 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 10:28:35 +02:00

arm/boot: Warn on orphan section placement

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20200902025347.2504702-4-keescook@chromium.org
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b1147b7..58028ab 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,6 +123,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
