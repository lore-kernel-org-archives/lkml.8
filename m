Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7E8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E107E22CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 23:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0fj4/Jd5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RtXLoRvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHFXjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 19:39:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60908 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgHFXit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 19:38:49 -0400
Date:   Thu, 06 Aug 2020 23:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596757127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpe6YTkV44HAJlNIEEmmAavR1L5M4e4miMoT9IbpiR8=;
        b=0fj4/Jd5BbZPGwf3L7GlhUiQkm48zILc8QUremzOBtu+Xm+HdNFxOGP7L2s+KjOgETRny2
        h56Ovvwz5szuWVuVAbPCiCmbJj7HyXu+Hcp+JX/B6rdWSodwJkohfLkc2ajD5To9znomhX
        pSKJP8m3OI+hwNJylj4GMOhkXzcwBeQMWql5NKKUEuhtFKm8VdEIKD9pmtANnENWPyA38w
        zm3B035Xffw7jqxhkZ/sfVGN3q2kgzf7/vhHfV6nUIA/arL8yPGplj9GhgPDpD7UMhskay
        eCrcvFJKguAc0K7cn8oKukI1KZA9STPuhzqf/z8jX2+myWBVaHf+TFH7BR1qtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596757127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mpe6YTkV44HAJlNIEEmmAavR1L5M4e4miMoT9IbpiR8=;
        b=RtXLoRvfm52g5tI4i3o+EVeIRkEiI04qkWo3INjIMhWo98nU6wYlhq/a7G7FzUT6Vpjldj
        DyZFpG9lNBC6sWBA==
From:   "tip-bot2 for Shuo Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acrn: Allow ACRN guest to use X2APIC mode
Cc:     Yakui Zhao <yakui.zhao@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806113802.9325-1-shuo.a.liu@intel.com>
References: <20200806113802.9325-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Message-ID: <159675712730.3192.10606013510070138850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     86d709ce30eaa65706090865662a08d7bdd30c54
Gitweb:        https://git.kernel.org/tip/86d709ce30eaa65706090865662a08d7bdd30c54
Author:        Shuo Liu <shuo.a.liu@intel.com>
AuthorDate:    Thu, 06 Aug 2020 19:38:02 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Aug 2020 01:32:00 +02:00

x86/acrn: Allow ACRN guest to use X2APIC mode

The ACRN Hypervisor did not support x2APIC and thus x2APIC support was
disabled by always returning false when VM checked for x2APIC support.

ACRN received full support of x2APIC and exports the capability through
CPUID feature bits.

Let VM decide if it needs to switch to x2APIC mode according to CPUID
features.

Originally-by: Yakui Zhao <yakui.zhao@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20200806113802.9325-1-shuo.a.liu@intel.com
---
 arch/x86/kernel/cpu/acrn.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 1da9b1c..3b08cdf 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -11,6 +11,7 @@
 
 #include <linux/interrupt.h>
 #include <asm/apic.h>
+#include <asm/cpufeatures.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
 #include <asm/idtentry.h>
@@ -29,12 +30,7 @@ static void __init acrn_init_platform(void)
 
 static bool acrn_x2apic_available(void)
 {
-	/*
-	 * x2apic is not supported for now. Future enablement will have to check
-	 * X86_FEATURE_X2APIC to determine whether x2apic is supported in the
-	 * guest.
-	 */
-	return false;
+	return boot_cpu_has(X86_FEATURE_X2APIC);
 }
 
 static void (*acrn_intr_handler)(void);
