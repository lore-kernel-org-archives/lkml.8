Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750F3206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdXMMs/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ilxDs9El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgGPPao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:30:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgGPPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:30:36 -0400
Date:   Thu, 16 Jul 2020 15:30:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594913434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBVGjRPpGZHRaqdX1zko42An6S3IYk96HvtOlF5TMy0=;
        b=rdXMMs/uu+SNJRgx46YM7REw4nN+f7sjOLI7TInWlzqBie5WTUOmzQz7s8Wqaqz1yc9Qci
        4YdE3WYdVVVUh15Smig6GoecbFbamCP2VePKIriPTabW2NtyD0KUSJgqGr6NZvCtQHj0lM
        Gj6mEDdlYxD1JFXCelqr0Wob+IAi0//bIWzv7+UcUlka40Dj0XAkTrZ7jyGOoSpVSNnXrU
        zsh3aVxaIU9sALrYa27+GphHJb73h4qyt48IdiIKXN4o2586anGqVv6G7zRcTcLH2ZCA/C
        82QcJnh/fq9npj3YEDje9oRAGyuTbpft3p5NsjkLEaC1SrPaeVXpaBhR1sn+vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594913434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBVGjRPpGZHRaqdX1zko42An6S3IYk96HvtOlF5TMy0=;
        b=ilxDs9ElUyiFNbWF4vK44Lr6DiIlFixuGgOpYeIiI+7zgF3WazXBW0mdjNdLlHBE7UZuKf
        C2m8YoclaTheEADg==
From:   "tip-bot2 for Sedat Dilek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200714194740.4548-1-sedat.dilek@gmail.com>
References: <20200714194740.4548-1-sedat.dilek@gmail.com>
MIME-Version: 1.0
Message-ID: <159491343409.4006.12274516170496995947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5769fe26f389b0002ed48fd16d642a1d86edaf79
Gitweb:        https://git.kernel.org/tip/5769fe26f389b0002ed48fd16d642a1d86edaf79
Author:        Sedat Dilek <sedat.dilek@gmail.com>
AuthorDate:    Tue, 14 Jul 2020 21:47:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jul 2020 17:25:10 +02:00

x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV

When assembling with Clang via `make LLVM_IAS=1` and CONFIG_HYPERV enabled,
we observe the following error:

<instantiation>:9:6: error: expected absolute expression
 .if HYPERVISOR_REENLIGHTENMENT_VECTOR == 3
     ^
<instantiation>:1:1: note: while in macro instantiation
idtentry HYPERVISOR_REENLIGHTENMENT_VECTOR asm_sysvec_hyperv_reenlightenment sysvec_hyperv_reenlightenment has_error_code=0
^
./arch/x86/include/asm/idtentry.h:627:1: note: while in macro instantiation
idtentry_sysvec HYPERVISOR_REENLIGHTENMENT_VECTOR sysvec_hyperv_reenlightenment;
^
<instantiation>:9:6: error: expected absolute expression
 .if HYPERVISOR_STIMER0_VECTOR == 3
     ^
<instantiation>:1:1: note: while in macro instantiation
idtentry HYPERVISOR_STIMER0_VECTOR asm_sysvec_hyperv_stimer0 sysvec_hyperv_stimer0 has_error_code=0
^
./arch/x86/include/asm/idtentry.h:628:1: note: while in macro instantiation
idtentry_sysvec HYPERVISOR_STIMER0_VECTOR sysvec_hyperv_stimer0;

This is caused by typos in arch/x86/include/asm/idtentry.h:

HYPERVISOR_REENLIGHTENMENT_VECTOR -> HYPERV_REENLIGHTENMENT_VECTOR
HYPERVISOR_STIMER0_VECTOR         -> HYPERV_STIMER0_VECTOR

For more details see ClangBuiltLinux issue #1088.

Fixes: a16be368dd3f ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1088
Link: https://github.com/ClangBuiltLinux/linux/issues/1043
Link: https://lore.kernel.org/patchwork/patch/1272115/
Link: https://lkml.kernel.org/r/20200714194740.4548-1-sedat.dilek@gmail.com

---
 arch/x86/include/asm/idtentry.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 5efaaed..80d3b30 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -624,8 +624,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
 #endif
 
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
