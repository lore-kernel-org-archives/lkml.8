Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B78C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CAC20796
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 06:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GhscpEag";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TiSh7O5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgIGGFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:05:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIGGFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 02:05:53 -0400
Date:   Mon, 07 Sep 2020 06:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmZKSCN3+6pV2/92G4WHoEYPtg3SqP1ndcFRKpdZNOc=;
        b=GhscpEagv/FUbnIW9+ybGBBfJOzvXY+Jgbe1U0AJjL4ydPtQ0B8t1/kAfEecbn6s4tPSlN
        OqNKwgLvBoayU5jwoakdNTODoLvOw6KLbnuFIbQLDBPtkqUSu9QZ0CiHBj+NfcuQ7oVaWY
        BFdeNLZb9uraJwQXc9ngZamQUmtX2L8KthrMfVzpTl0SrakbCSlsDLmhXZpDmAxPkCCvuv
        UOaJTnYAFPom44SP/a4/6s6yqpPMcQsVSXBWwU3Jo10KfXCXXgYkCy6geYZlespMQ12FoS
        +vJGI05G9zmOeR2gKGFKOjzuz0nHQBS/F+HmV5tVTjGlIRxW4nfVMHUivD6E9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599458751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MmZKSCN3+6pV2/92G4WHoEYPtg3SqP1ndcFRKpdZNOc=;
        b=TiSh7O5Lx2rEkrn5m17hyD8z2wQT7/O2CUwcsQgNoWRMTU2PSBnd1ji79n0J10n6ycGLAb
        mPXSkFYaREKF4nAA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] x86/boot/compressed: Warn on orphan section placement
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902025347.2504702-6-keescook@chromium.org>
References: <20200902025347.2504702-6-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159945875015.20229.3592882775194866773.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     6e0bf0e0e55000742a53c5f3b58f8669e0091a11
Gitweb:        https://git.kernel.org/tip/6e0bf0e0e55000742a53c5f3b58f8669e0091a11
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 01 Sep 2020 19:53:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Sep 2020 10:28:36 +02:00

x86/boot/compressed: Warn on orphan section placement

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20200902025347.2504702-6-keescook@chromium.org
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5b7f6e1..871cc07 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -54,6 +54,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
