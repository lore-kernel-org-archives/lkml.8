Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9EB20704
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZaZAMUhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgEZQTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgEZQTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:19:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC06C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8afjZgc+ZxZyr9cWTVCTisT80ltrjNVBpyip7riNXmw=; b=ZaZAMUhOd+4giRubqNVM5e3pHY
        neTV2Uc8BBLtfzeO0pNdFIMZoSgEUUeaQamscjEClj3lue0It/szyaU4QD4W4sLmHxhVzWqiL7tXc
        stIAlaeT+sYFnjvtrmsJ9zAwq2GJtvsoeL4HSBAqI15YTeCY/l4jrM1t42SyioEaDFIyqGJVtlqMl
        Z4Y4e9yhODPaITb0I0t4NNSJsU2nGouyLzmkF9gJlmZHy4i9XO+8DXpzJmSkAfdfMQ4f3vuxuBBwP
        lSX/VHcb7AsT+Gn6HTsh/8pnUxV3r/nCdK6/LJ1a8BFcjVSYFSBiddjPaoqZaEDqlUY30DgsIwNaC
        vpRonofA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIq-0000Ec-5L; Tue, 26 May 2020 16:19:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A269C3069A1;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4ED9420FF793B; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161907.895109676@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:11:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 3/7] smp: Move irq_work_run() out of flush_smp_call_function_queue()
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures flush_smp_call_function_queue() is strictly about
call_single_queue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/smp.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -84,6 +84,7 @@ int smpcfd_dying_cpu(unsigned int cpu)
 	 * still pending.
 	 */
 	flush_smp_call_function_queue(false);
+	irq_work_run();
 	return 0;
 }
 
@@ -191,6 +192,14 @@ static int generic_exec_single(int cpu,
 void generic_smp_call_function_single_interrupt(void)
 {
 	flush_smp_call_function_queue(true);
+
+	/*
+	 * Handle irq works queued remotely by irq_work_queue_on().
+	 * Smp functions above are typically synchronous so they
+	 * better run first since some other CPUs may be busy waiting
+	 * for them.
+	 */
+	irq_work_run();
 }
 
 /**
@@ -267,14 +276,6 @@ static void flush_smp_call_function_queu
 		csd_unlock(csd);
 		func(info);
 	}
-
-	/*
-	 * Handle irq works queued remotely by irq_work_queue_on().
-	 * Smp functions above are typically synchronous so they
-	 * better run first since some other CPUs may be busy waiting
-	 * for them.
-	 */
-	irq_work_run();
 }
 
 /*


