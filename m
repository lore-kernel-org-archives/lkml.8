Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF15BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76520784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kSCZ8NGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgDVLcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:32:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB89C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=MALwg3l9cgtJk6A3vhjWRzuMBe1NnH2qFD2RDhnqbEo=; b=kSCZ8NGZv5KMKdoo3/XXr09oAc
        JdOEuXpQTUx/NoTou8J5DnTwJjscB2O/m2p42Qj31FphBcbnyOCpISUC9NgxQKCeasha6Par/2d/f
        ydPyfx9YvE3SjbsMY4JPzvdj99/zTSGIgK1QvTEJtS9GlePsgWmWgMpdOEe7ZysJvV6xroiLbT51f
        W2KwaDJ/aA6B6XR0k+/IRPmzihP0CbQe6aTwLeFJZYzwZyCkTdJR3ndRMYVcazWmRs1c61tNYTlnZ
        8ZzrdIA3YIGZcU6B3eMs008ln7FMblwkMLDKRDrvpGQFwF9A631mVdiVodqdvgYHemliQYQNqp6ZY
        WJLiqRTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006qm-Br; Wed, 22 Apr 2020 11:29:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFEE9307479;
        Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B708D20195236; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.339113081@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, nico@fluxnic.net, rmk+kernel@arm.linux.org.uk
Subject: [PATCH 02/23] sched,bL_switcher: Convert to sched_set_fifo*()
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

Cc: nico@fluxnic.net
Cc: rmk+kernel@arm.linux.org.uk
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/common/bL_switcher.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -270,12 +270,11 @@ static struct bL_thread bL_threads[NR_CP
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


