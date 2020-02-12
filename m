Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1109BC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23EB217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0JqzhBuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBLVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:14:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/oBPWrG9EVgl4LEO/hSDsTUt0NUc1tA6jTJTcYoVfdU=; b=0JqzhBuvcQyBJXQ1KClbpmF3m3
        n92gueIu7+MWZTnnIi/5N8GpQkHF1gHJeFVKgRJcXHSgNRUbtXEulUpM3G3VSxM8iTsJvDyD4BIrF
        CHNwrQEE27vIC+6K/dom06sSQJLNBXJ6MPTAYNCeHbxsRH9GY+8jRWgvM/72aICyQ8e6UgWsS6ZbJ
        WIWEGDdzMTilLvPvk1OIjerEY+J5LiRESEYPCw9yzZfkPVQXalhkEIX4cu3Lipxmrh+hGeATbdu4E
        Hpt6XBjiFNGwmKzH8LtaKTXEFCtwYhouLo0DmhPvbMgodkpcic7Ms1v9xcA4cc1z9gUZX6DVQKp4a
        xdtuHAvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1zKM-0002Kw-0W; Wed, 12 Feb 2020 21:13:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C87163077DC;
        Wed, 12 Feb 2020 22:11:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 911F42019658F; Wed, 12 Feb 2020 22:13:41 +0100 (CET)
Message-Id: <20200212210750.312024711@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 12 Feb 2020 22:01:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: [PATCH v2 9/9] perf,tracing: Allow function tracing when !RCU
References: <20200212210139.382424693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since perf is now able to deal with !rcu_is_watching() contexts,
remove the restraint.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/trace/trace_event_perf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -477,7 +477,7 @@ static int perf_ftrace_function_register
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->flags   = FTRACE_OPS_FL_RCU;
+	ops->flags   = 0;
 	ops->func    = perf_ftrace_function_call;
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 


