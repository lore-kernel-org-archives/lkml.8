Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B0A206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="TqTg7bkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgG0J26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:28:58 -0400
Received: from smtp2.axis.com ([195.60.68.18]:7630 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0J25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1110; q=dns/txt; s=axis-central1;
  t=1595842137; x=1627378137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LDGMiNDyHEEpsPh7ha2tAju2Qa0XvBjPxQymomgNiZU=;
  b=TqTg7bkhR+PqETWVSxuQSXyVt0r3xPSF9Ul65CZIUgCW51/JcChQB6WO
   /+2D7lkoBtgkOfeRfmqfhT4Xm+v3aeBykBlhe31exacC+6Gv5HLrwtMw+
   TNUeND8fBbJpA4pehYDsVaLCVV6yMp7LN0hhcI1d9pAq+H7vLKoU/JBvR
   1aQmSPhN6VGbU4Il+Zvo6uSgP+cDFTRR8E6GWdQHPDo8mVc7FKXEuXjb3
   qz86EFEZG7WOD4gxnwLJptjLcsTcInwxYWHingvx3RFcNLvCFhkLxA47C
   FHeKayKOBRYmRlKRhRfVyad7ctS8XYahK/gRL/1ZPn2O7vy41cJqvYpOI
   A==;
IronPort-SDR: 6H1P+HoGSEAeLwpLTlTr0VvQFeuXjp8ZiRVbfqpCucp2qs7Y3oONw1sIApR7+BuqX59LlHKR6Z
 v2/Dx9AV0YivCd+WqOn80QKd+MiCGOMCYf8xC1ZyKNp0DMJvE1IvU4tYfVw9F6XS+RZcBP8ma5
 +41Lyuo0alSXbXx9zNM2sk8bw1OGJ6wer4b0QwH2q41UXBKyEDyzEXwUDzwoVokL0OrKgodMqB
 JA2AkAOtYcD6LLa4T37ALsr/BbkUzpUps+5aN48/RRb9stWj+tYd9kIw3bCuzxRFau+DVgvtnw
 0jo=
X-IronPort-AV: E=Sophos;i="5.75,402,1589234400"; 
   d="scan'208";a="10911943"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <kernel@axis.com>, <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Remove outdated comment in stack handling
Date:   Mon, 27 Jul 2020 11:28:40 +0200
Message-ID: <20200727092840.18659-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comment describes the behaviour before commit 2a820bf74918
("tracing: Use percpu stack trace buffer more intelligently").  Since
that commit, interrupts and NMIs do use the per-cpu stacks so the
comment is no longer correct.  Remove it.

(Note that the FTRACE_STACK_SIZE mentioned in the comment has never
existed, it probably should have said FTRACE_STACK_ENTRIES.)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 kernel/trace/trace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5..0a0fd197888c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2932,12 +2932,6 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 		skip++;
 #endif
 
-	/*
-	 * Since events can happen in NMIs there's no safe way to
-	 * use the per cpu ftrace_stacks. We reserve it and if an interrupt
-	 * or NMI comes in, it will just have to use the default
-	 * FTRACE_STACK_SIZE.
-	 */
 	preempt_disable_notrace();
 
 	stackidx = __this_cpu_inc_return(ftrace_stack_reserve) - 1;
-- 
2.25.1

