Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1800C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B4A24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtPRYThk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgBUNvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:51:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgBUNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8DaqIg7UENVHdYwECwUjUJk0MIkR26PVzWqkahzuJg0=; b=XtPRYThkgjXPbZj3X48/eaFzhk
        a3iMI4lSlCFrGqyb9fZU/vp3dmBeyqwKODW5qBxn2dx6bBoAjVoeVE3R02LKYNt7OYnD2fRFXpshh
        AT8T8v3GI8eZ6aobdRAUjtaI4akLyLoONG5jbx8Nkcdov5kU6IGDpXnwjTboeqiKkGrc4cQTIi5cS
        TYoYEKzd8bqrOztLXoZIufA6tW2FkemjrevGzBxl/WLMRi3fdVv6eev7tOCRI6MlQjcGODXwm1d0a
        bGVWCanmqpoQYvGIKlKEZHiiwOfRO+dZQrrnM5QZBH+AKsP7+q8Iexp5H0V0bLT43zVIPfEt4SIg6
        uJ+BvZQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gw-0006V6-2M; Fri, 21 Feb 2020 13:50:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CB79307455;
        Fri, 21 Feb 2020 14:48:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D5B3729D740AB; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.793377175@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 13/27] x86,tracing: Add comments to do_nmi()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few comments to do_nmi() as a result of the audit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/nmi.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -529,11 +529,14 @@ do_nmi(struct pt_regs *regs, long error_
 	 * continue to use the NMI stack.
 	 */
 	if (unlikely(is_debug_stack(regs->sp))) {
-		debug_stack_set_zero();
+		debug_stack_set_zero(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 1);
 	}
 #endif
 
+	/*
+	 * It is important that no tracing happens before nmi_enter()!
+	 */
 	nmi_enter();
 
 	inc_irq_stat(__nmi_count);
@@ -542,10 +545,13 @@ do_nmi(struct pt_regs *regs, long error_
 		default_do_nmi(regs);
 
 	nmi_exit();
+	/*
+	 * No tracing after nmi_exit()!
+	 */
 
 #ifdef CONFIG_X86_64
 	if (unlikely(this_cpu_read(update_debug_stack))) {
-		debug_stack_reset();
+		debug_stack_reset(); /* notrace due to Makefile */
 		this_cpu_write(update_debug_stack, 0);
 	}
 #endif


