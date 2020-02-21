Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C670C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CBF208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NTODENbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgBUNvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:51:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgBUNu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=J2/JgQ4tDRPO/m+ThNDCC94wQ89HSPpvdmylRYiqZEc=; b=NTODENbgN8KC4ORXOCYLfFR+zm
        M/mdsxUAgoFzu8IlSwC7o6RbZwAPQC5BblSgasSZw7BmgCQdYzLQCoJU2UYy97BVv1q+7OCxd7drv
        Se9Jbo4p3bcVq18j0kTfQwWkQIfM/Q1GNA7X4GiyUeEqXp+lVUSW5tSoI+8flXFbxzD7NunvqCFmV
        cQg0seQ8kkC6GU0Snak9ynWf6oznz6C3NzpfHSOuplhLfmIfDqxjIh4hKePCMgk03NWrtPaEU3feU
        QAv1Ur6r5Y3hJC5F7orymt5Jf9u5xi4HMBknc6KEDfn+3TE4C5Cf19tBHVRJ+e1b5UtBibh7jL/Ny
        a65Di+XA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gv-0000q3-Jv; Fri, 21 Feb 2020 13:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CB61307444;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DB6B629D740AD; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.861984902@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: [PATCH v4 14/27] perf,tracing: Prepare the perf-trace interface for RCU changes
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tracepoint interface will stop providing regular RCU context; make
sure we do it ourselves, since perf makes use of regular RCU protected
data.

Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	int rcu_flags;
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
 
+	rcu_flags = trace_rcu_enter();
+
 	perf_trace_buf_update(record, event_type);
 
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
@@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
 	}
 
 	perf_swevent_put_recursion_context(rctx);
+
+	trace_rcu_exit(rcu_flags);
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 


