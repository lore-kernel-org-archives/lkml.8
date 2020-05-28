Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C822075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J4SfAVTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391347AbgE1Owz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391338AbgE1Owu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:52:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE581C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=m/qXhgROsCuKqJ8zJO3SywPxuLp4K6FX13+F60lh9EY=; b=J4SfAVTlIaP1mxLF+/2JgJ//Mr
        i/wKbdCsMEJfoBXKqtUapBCtu5faP63IsRJc0Nh0QRfPN9cxaQxajwrJNBtcCXIk6BU2TdzdlEtse
        TSKBZoqwn7vEw0dn5k/CR54DTU0C8e5TucnA7gFe8pvQRlsknONTRemfa3Q4697mm+019h4/dKfTS
        ZvMfVLld+6vwCNe1uQuFIwywbkgytoKfohBCY7BDYMbeJT46VsvI59jafvjnkynVzJTltaSWZVR9D
        q+hhaYGEeiSBpgmotvTppdxyJUZHGKiqmJkmCgvzM/TKkIVDtsnMtdcp7bZ5/OLGAMAwP+xtGlq1r
        MOmLuKqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeJti-0006PW-QA; Thu, 28 May 2020 14:52:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA76330704D;
        Thu, 28 May 2020 16:52:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DB84203DD1DA; Thu, 28 May 2020 16:52:40 +0200 (CEST)
Date:   Thu, 28 May 2020 16:52:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ftrace,bug: Improve traceoff_on_warn
Message-ID: <20200528145240.GF706495@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,

While doing some tracing, I found a huge portion of the per-cpu buffer
was taken by printk/serial output because we're disabling the trace far
too late (after printing the CUT string).

Improve matters for architectures that have GENERIC_BUG + _BUG_FLAGS by
killing the tracer in the exception handler before printing anything
much.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/bug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index 8c98af0bf585..7103440c0ee1 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/bug.h>
 #include <linux/sched.h>
 #include <linux/rculist.h>
+#include <linux/ftrace.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -153,6 +154,8 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	if (!bug)
 		return BUG_TRAP_TYPE_NONE;
 
+	disable_trace_on_warning();
+
 	file = NULL;
 	line = 0;
 	warning = 0;
