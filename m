Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3548C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B092620825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PLuwFdpH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="babi0z/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgH0H4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgH0Hy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591E3C06121A;
        Thu, 27 Aug 2020 00:54:27 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5POmiO7QMK4MekcrkPAoXvJOY3pcgqR7UzJKNAiRog=;
        b=PLuwFdpHE9Km6+Uv4zLKPGcrITKbwG6Wb2kX6o3ZHpxV6CAqxXxdReeJ2LpDHNikNTJKku
        A25gvThnaR9EU6E00FOqoOWRgC8ukpa6j3002dU4Nm+nkKGzRmRZ9F5VEPq+uNpxHpMlzI
        OrsRNb/nfwrcHu2wmLDuZEeYRKt1QE/rPsbC79LpcRUAB+W+L3jINbsvrFh4RsYstAcnlJ
        emctglw3zLdfYH3HA0KKa84v6d8rgBIgjGerCJ3dT902500DyX192wSZbmXEtu6FhuUvKD
        uSAPRfutEHAa1JPGtfoVT5arv1/Ba4dT6laBt8bSs0G9eT5F3sOMzkqAQW/WHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514865;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5POmiO7QMK4MekcrkPAoXvJOY3pcgqR7UzJKNAiRog=;
        b=babi0z/jqMmsJVK7G9mMOLThdSHnJzfxiypF9FcG1P6/g1R3zKupuASuR50cgtnAVC2ieF
        KrloJ/OkjremxhDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] mips: Implement arch_irqs_disabled()
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826101653.GE1362448@hirez.programming.kicks-ass.net>
References: <20200826101653.GE1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159851486517.20229.2725037338489816617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     99dc56feb7932020502d40107a712fa302b32082
Gitweb:        https://git.kernel.org/tip/99dc56feb7932020502d40107a712fa302b32082
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 22 Aug 2020 18:04:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:55 +02:00

mips: Implement arch_irqs_disabled()

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200826101653.GE1362448@hirez.programming.kicks-ass.net
---
 arch/mips/include/asm/irqflags.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 47a8ffc..f5b8300 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -137,6 +137,11 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return !(flags & 1);
 }
 
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
 #endif /* #ifndef __ASSEMBLY__ */
 
 /*
