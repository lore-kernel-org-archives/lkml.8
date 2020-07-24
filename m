Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E95C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D082074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+R57Glr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaRkflcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgGXIeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgGXIdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B41C0619D3;
        Fri, 24 Jul 2020 01:33:53 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vy73SomCTwPXXXMjvuKs5B8EFTSvbhm3CqmpeSiyfL0=;
        b=f+R57GlrjSy3nkkDKddwQE9PXwOGP/Ppj/qnumiiIq1ePEEW8/17T4CSMcEpEHHxP+5200
        tSdeq50XHK2iAJp+6Ii/PBlEyj9hWame1Z28Rbul41TkHn0TtN20pHSNuPWaUWgIaHZd3Q
        IbcchpLZdGG6mv8PFE8UHZ1f/Mqc9D1c7Wcr13QfBCQ1/f3L00L09LguJUVrvbfLMNPtc8
        GUn4Q8QJtMMsJG2fZVi8sxE61eBQzoLNbgCgqL+SGodVGzEA7nd0GMzOx/UmBVyi1An+oC
        aNCwsyEwNmWivRpK28/EjW02fI6dapV1X0Zak5ZORcJhnlThP5RU9VmPPuh/LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579632;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Vy73SomCTwPXXXMjvuKs5B8EFTSvbhm3CqmpeSiyfL0=;
        b=AaRkflcKi/MVyGji+CzqpCha2Bp1N/a9IuY3oKy8oZpP7voQz9vFVu39UCsyQ3WR0UaygG
        PJgSgefO1pibvmCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,bL_switcher: Convert to sched_set_fifo*()
Cc:     rmk+kernel@arm.linux.org.uk,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nicolas Pitre <nico@fluxnic.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557963150.4006.1693953197684064587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     0030c1d4a38757fb54a0c96e5e8b59cc0c4f3f28
Gitweb:        https://git.kernel.org/tip/0030c1d4a38757fb54a0c96e5e8b59cc0c4f3f28
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:20 +02:00

sched,bL_switcher: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

Cc: rmk+kernel@arm.linux.org.uk
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/common/bL_switcher.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 746e1fc..9a9aa53 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -270,12 +270,11 @@ static struct bL_thread bL_threads[NR_CPUS];
 static int bL_switcher_thread(void *arg)
 {
 	struct bL_thread *t = arg;
-	struct sched_param param = { .sched_priority = 1 };
 	int cluster;
 	bL_switch_completion_handler completer;
 	void *completer_cookie;
 
-	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
+	sched_set_fifo_low(current);
 	complete(&t->started);
 
 	do {
