Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112F9C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFED2053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9kn2F4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e9IIohao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHOVwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgHOVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45092C09B04F;
        Sat, 15 Aug 2020 08:47:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 15:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597506410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJiOU8mAJuAeFjX4cBj1OC2CmBz/7FhgRkAnQxo82Hk=;
        b=E9kn2F4kyUoVWmQbz6l28Fm1ZIMo4c2kzD+OtlDQBq30xN6MpR98cEEa5S+0ixdZCh/f6V
        lOBwDbTusoU9hMxiQc3yYOCNCBa8YUvDD/+fPDTYn07ALmfNPlqEtL2TDsDo+aysCdnH00
        rAXTSNdwMoJK5EnzVp5rkSje3RIdS7q3VxKxaFC0mJsLsn32uVvmZYwkxY4sib4pzpxUsU
        ABElAh9JG8pNO7hGa3mpmHRlgRjiFhVP6uXTMbFoefiwtlWEFTAnnZhtUemY1/sbr8VZQu
        k91TrHspeXMM3vLmQVxPDHbh6YPv81kahBgEgMRrJM0LH0OWDsI1u7M1HIebSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597506410;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hJiOU8mAJuAeFjX4cBj1OC2CmBz/7FhgRkAnQxo82Hk=;
        b=e9IIohao6B9Rf9caOvcab9Awg1OvRNLKPfwj54plIq4/Moo5hej7VwlTKLfKTfG6x3JKae
        Wvv+HHwUwaNl9nAQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Avoid needless paravirt step
 clearing page table entries
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815100641.26362-7-jgross@suse.com>
References: <20200815100641.26362-7-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <159750640968.3192.2279401610614202728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     7c9f80cb76ec9f14c3b25509168b1a2f7942e418
Gitweb:        https://git.kernel.org/tip/7c9f80cb76ec9f14c3b25509168b1a2f7942e418
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Sat, 15 Aug 2020 12:06:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 15 Aug 2020 13:52:12 +02:00

x86/paravirt: Avoid needless paravirt step clearing page table entries

pte_clear() et al are based on two paravirt steps today: one step to
create a page table entry with all zeroes, and one step to write this
entry value.

Drop the first step as it is completely useless.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200815100641.26362-7-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f0464b8..d25cc68 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -448,7 +448,7 @@ static inline pudval_t pud_val(pud_t pud)
 
 static inline void pud_clear(pud_t *pudp)
 {
-	set_pud(pudp, __pud(0));
+	set_pud(pudp, native_make_pud(0));
 }
 
 static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
@@ -485,15 +485,15 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 } while (0)
 
 #define pgd_clear(pgdp) do {						\
-	if (pgtable_l5_enabled())						\
-		set_pgd(pgdp, __pgd(0));				\
+	if (pgtable_l5_enabled())					\
+		set_pgd(pgdp, native_make_pgd(0));			\
 } while (0)
 
 #endif  /* CONFIG_PGTABLE_LEVELS == 5 */
 
 static inline void p4d_clear(p4d_t *p4dp)
 {
-	set_p4d(p4dp, __p4d(0));
+	set_p4d(p4dp, native_make_p4d(0));
 }
 
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -504,12 +504,12 @@ static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	set_pte(ptep, __pte(0));
+	set_pte(ptep, native_make_pte(0));
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	set_pmd(pmdp, __pmd(0));
+	set_pmd(pmdp, native_make_pmd(0));
 }
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
