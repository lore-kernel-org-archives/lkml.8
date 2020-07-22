Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8F22B43
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F78QnrC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jkZ6lxtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733154AbgGVWss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:48:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52906 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbgGVWso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:44 -0400
Date:   Wed, 22 Jul 2020 22:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3Zsm5XM9OBmDffs9at+DaOqbM4V2GVf0KVN6w1L27U=;
        b=F78QnrC4p6INZoqajaS7UB9IGQMUJ5eKW2sJmVdR7HUKjTH1qVwb6kx/cIaWFrVGL6h1AD
        9NHitARLmCZy25hQ5teaqRqXtK4NxmOvsSnw0B+z076Lu1uIjKzrK+0ThY25dRD6wNzZeo
        YGNQJuxJ/xq+hxFsCOW+oAUOs9vRyd69p3Qjwoo079KIzBSWByJR1iCSOFM7Y4QBsHXfv+
        sNDTsgiSVYjAttzhMkQi350yG91gK7zLx198371ptYPg40iv/hAcD2ZEvx79GcxR5LMlC/
        sNfoLz8WAV6nx9HNJNqA9kTbJvMEZjPrIPirGmb80+4kek9WZ3QZ7CbqyIkAAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H3Zsm5XM9OBmDffs9at+DaOqbM4V2GVf0KVN6w1L27U=;
        b=jkZ6lxtkk5bAZjWX9XPJRHmpUZFmLpXays2SNipVzb61gr3xL0i2KFHWV2mwnDK5JbGj+a
        NkoKCKvXaQCbROBQ==
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub/arm64: link stub lib.a conditionally
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200604022031.164207-1-masahiroy@kernel.org>
References: <20200604022031.164207-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <159545812203.4006.2339306971648144813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     c1aac64ddc01112e137121a43645b96c3633c41b
Gitweb:        https://git.kernel.org/tip/c1aac64ddc01112e137121a43645b96c3633c41b
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Thu, 04 Jun 2020 11:20:30 +09:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 09 Jul 2020 09:45:09 +03:00

efi/libstub/arm64: link stub lib.a conditionally

Since commit 799c43415442 ("kbuild: thin archives make default for
all archs"), core-y is passed to the linker with --whole-archive.
Hence, the whole of stub library is linked to vmlinux.

Use libs-y so that lib.a is passed after --no-whole-archive for
conditional linking.

The unused drivers/firmware/efi/libstub/relocate.o will be dropped
for ARCH=arm64.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20200604022031.164207-1-masahiroy@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 76359cf..4621fb6 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -143,7 +143,7 @@ export	TEXT_OFFSET
 
 core-y		+= arch/arm64/
 libs-y		:= arch/arm64/lib/ $(libs-y)
-core-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
+libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # Default target when executing plain make
 boot		:= arch/arm64/boot
