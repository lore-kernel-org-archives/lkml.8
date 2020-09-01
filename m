Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472E0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F91E206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1c8+MHc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCDc60mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgIAOud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:50:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgIALs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:48:27 -0400
Date:   Tue, 01 Sep 2020 11:47:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB6k2PvT9OMecc0/+DNkcBt9qNitv8S8etsaj8Hbzus=;
        b=v1c8+MHczK2BdtrJEfDp+zuWme1i7KC4C0Zk7a4ZNrzXXDhHclmYUjzjCixiSWCGTVKjDn
        aF8ia+t/+SmWcN5+b930rtPnHk0I/bab/+yz943BsbnnQStuVZPTR4JrTZoY3Nb/B2EB2K
        /gi2TzHHqJZkgk1ADH3AtT77cISgtLCfPmFCKdUI71D1wE4Ft7L2nzFuTy0hH7mPlbCoe5
        MGEHup2iVIIBonullwZKRRBU+bVUXl+GqZFhtLHU207ML9dgGLP4U5/aN19y0jpiiehmy4
        UByKTdNLfpPZvyqeMIgEoZfMhFL822tvwQdBTDLHwIbRz0ReEbPBjOKvL7YH5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oB6k2PvT9OMecc0/+DNkcBt9qNitv8S8etsaj8Hbzus=;
        b=fCDc60mXof710qvin5wTUE1gY91qvHdhRylsJ/GZQJSaTZrOzOZnNCzH8LUJHYS8s3J7t3
        ayK+UngLO4WUKXBw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm64/mm: Remove needless section quotes
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-9-keescook@chromium.org>
References: <20200821194310.3089815-9-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087863.20229.1161280648421991515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     b4ca91027d8226ae423ce498f03f5b348cf84e36
Gitweb:        https://git.kernel.org/tip/b4ca91027d8226ae423ce498f03f5b348cf84e36
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

arm64/mm: Remove needless section quotes

Fix a case of needless quotes in __section(), which Clang doesn't like.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-9-keescook@chromium.org
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62f..e43c805 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -43,7 +43,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
