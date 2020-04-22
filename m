Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D4C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177022082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VZB26DIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgDVLaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727097AbgDVL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:48 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEA6C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FSGVkZgs7/88SC5w7WgFJUw80xu17DYMThybzZVOej0=; b=VZB26DIlnVGN6EEAkeMuB3/PCz
        Uvt8VfogxFG5rrV/IZNCoPdHx69DKIyu8/ec8uTMHvqgsMzxnUHQD4dW/XK+HEtsJtKMsYNl1E3ji
        hpcXl0LW4+BjbiHY8wzyln9kvxmG24k3wAhJ82GMinb5b/yyW5Mvpl3aRsyNugfs7hjEEy9EEIf7k
        Oi/VAUNILNsVKkdSHvv7BeXtW3W8djS0SgsCxUjOt77DOKAt4EVIuif6sV9jhqlak4FjA59VcbNQr
        fJ2Exp6JNEK25cTPzcl3zkoZeoHKeu6llFS6X2pKXFJr1A68DPLOzUlELmDParlXXppoTvWObiVcY
        o7Bwwf7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006qq-SL; Wed, 22 Apr 2020 11:29:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3AD73075D8;
        Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BB35E2019523A; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.397571979@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, herbert@gondor.apana.org.au
Subject: [PATCH 03/23] sched,crypto: Convert to sched_set_fifo*()
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

Use sched_set_fifo() to request SCHED_FIFO and delegate
actual priority selection to userspace. Effectively no change in
behaviour.

Cc: herbert@gondor.apana.org.au
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 crypto/crypto_engine.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/crypto/crypto_engine.c
+++ b/crypto/crypto_engine.c
@@ -396,7 +396,6 @@ EXPORT_SYMBOL_GPL(crypto_engine_stop);
  */
 struct crypto_engine *crypto_engine_alloc_init(struct device *dev, bool rt)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
 	struct crypto_engine *engine;
 
 	if (!dev)
@@ -428,7 +427,7 @@ struct crypto_engine *crypto_engine_allo
 
 	if (engine->rt) {
 		dev_info(dev, "will run requests pump with realtime priority\n");
-		sched_setscheduler(engine->kworker->task, SCHED_FIFO, &param);
+		sched_set_fifo(engine->kworker->task);
 	}
 
 	return engine;


