Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5F1920825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKrelA+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGR0AJ6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgH0H4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36722 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgH0Hy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:28 -0400
Date:   Thu, 27 Aug 2020 07:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62zr3mifYWo2qFO2ry90kgKzoaJAUJLfUd8oLkMWHWo=;
        b=NKrelA+n5PJSnx63tLsTYsEC9bFWHtHT8aEs3EW6GiM3kqXtZam6lju4J2tIaUdy7GQ+oA
        aOAU8yyv+KVCe8sy+CJb/MwQUVX/hpi7kQxvWywnCCRhbwdS9Y05ErkbOGXQxb+p+Uep/F
        twglG0/KHMcNLuJ2rBAxSYJMvAODweMY33Z5z4ivuPZJmahhDCZufYtaiCWnZlNwP1CNfB
        zlPTvZR2cAZXgIEtGJum/Ld4GlzeQR2SdUUcinHxg+VLKG6D9tbnj/b4MxUvSzukIvYxkp
        /UctNIeKpEYdCFUF590yrrsMZMGKbwKKPQ/SlOuZDdgLjEKooMhYBXij0T9UoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62zr3mifYWo2qFO2ry90kgKzoaJAUJLfUd8oLkMWHWo=;
        b=zGR0AJ6bqQrDBaOD92GK3SmTaX/AnyNfPmppT2kBilZc2PXplfo7BbwUakZpJrdGigvOVF
        0nkN0iC9lQPho3Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] arm64: Implement arch_irqs_disabled()
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.664425120@infradead.org>
References: <20200821085348.664425120@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486557.20229.3433546217475344640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     021c109330ebc1f54b546c63a078ea3c31356ecb
Gitweb:        https://git.kernel.org/tip/021c109330ebc1f54b546c63a078ea3c31356ecb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Aug 2020 10:40:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:55 +02:00

arm64: Implement arch_irqs_disabled()

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200821085348.664425120@infradead.org
---
 arch/arm64/include/asm/irqflags.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index aa4b652..ff328e5 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -95,6 +95,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return res;
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 static inline unsigned long arch_local_irq_save(void)
 {
 	unsigned long flags;
