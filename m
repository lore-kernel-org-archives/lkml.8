Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17A523119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kMlwX2KC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ybqcPxBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgHFROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:14:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730102AbgHFRKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:01 -0400
Date:   Thu, 06 Aug 2020 17:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RM82mvGB9xHHLFX9L5uZJx49nhDyo16+bh6kN2BD0Qc=;
        b=kMlwX2KCgbqCvdU7ycv3qbAQ/rt16EL6XxSzYZRmhYWQqVD2TaH9QHfINeeg/EWcSUnXcB
        bML6tE6A8iwKTTQSSEU7DeRoytgRvumFr7g22KOFclceyvidRCGhhicF6njEwB542PHPf2
        T1ovF8fXy+iIXHZv//Pxn9wDh5dQOtxXIjO2CC+Ym/LRDFBGzZ4HTmu1s4lz8tUDvSgVKP
        mutAdMC3aXzoLmY4uPldH2b+xN/ngYSPYSE6O28C38R4WegauNJi/r4Lap0MXUhDtNmZ/Z
        dlnGC7MRLywZqxkNBEzzeykRXsDbXDD7T/UMQissBRYxQKwZ8JBMDJz3skoPPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RM82mvGB9xHHLFX9L5uZJx49nhDyo16+bh6kN2BD0Qc=;
        b=ybqcPxBZPnd0keqLOiFRCwChs8bdPxRVy0VRJ1IMl4cZPuSOfUyS5MI2Mj4vB1j74mHQRD
        Kg4m7fTRyyOTV8BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86: Select POSIX_CPU_TIMERS_TASK_WORK
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200730102337.888613724@linutronix.de>
References: <20200730102337.888613724@linutronix.de>
MIME-Version: 1.0
Message-ID: <159673379799.3192.4481379459137146476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     0099808553ad4f9c04ad7afd966f6d7f470f247f
Gitweb:        https://git.kernel.org/tip/0099808553ad4f9c04ad7afd966f6d7f470f247f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 30 Jul 2020 12:14:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 16:50:59 +02:00

x86: Select POSIX_CPU_TIMERS_TASK_WORK

Move POSIX CPU timer expiry and signal delivery into task context.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200730102337.888613724@linutronix.de
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fd03cef..a82e715 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -209,6 +209,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
