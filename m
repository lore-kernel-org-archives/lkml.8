Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9EC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCDC20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LDBmw5/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgDVL3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726983AbgDVL3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:37 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFB6C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=AUG4+R3sLn9gfr9uqiOQAek/4HyjDe3RQ+y2B8oUNa4=; b=LDBmw5/tBTv8yBxK7OaQwaVgVt
        jSYDDnKvmarH6Gsh9FSxnbOto6EDnKepidkuD1x64k5LgFYR9RRgT3JP8P8KVpoANaMVPJoZbWvIe
        xjjVJ2xRHsH1uhMYdOCOzbeNxNh4Bv7Yrv9LfrBhxBdtjcy7WGBNLWgl5A6nEIdiJY6Usz0v2z/Ve
        gIuydJcTgFWZmV31mywQ5kzJZ8AnA1XgxcRfu0NExsHsh3qeOOTFiOOc0NiZv1EkeU4l446gcgc9X
        Hsqsqb88IFllz9hkkh+BsjqK+1IOJS6q2h1MMrHrXc1gVtOaaYH1JoUPXnb2OsHF6i3CzV43TT6/x
        rA9SoXwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006qo-RG; Wed, 22 Apr 2020 11:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47A5930796B;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D9A4B22B9588A; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.811655681@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, ulf.hansson@linaro.org
Subject: [PATCH 10/23] sched,mmc: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

Cc: ulf.hansson@linaro.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/mmc/core/sdio_irq.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -139,11 +139,10 @@ EXPORT_SYMBOL_GPL(sdio_signal_irq);
 static int sdio_irq_thread(void *_host)
 {
 	struct mmc_host *host = _host;
-	struct sched_param param = { .sched_priority = 1 };
 	unsigned long period, idle_period;
 	int ret;
 
-	sched_setscheduler(current, SCHED_FIFO, &param);
+	sched_set_fifo_low(current);
 
 	/*
 	 * We want to allow for SDIO cards to work even on non SDIO


