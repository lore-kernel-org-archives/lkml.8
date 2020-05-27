Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11865C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BAC20888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A8k7USeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgE0KUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:20:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52498 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0KUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iKY4vjyoS0+YT9NdstlMwtWCWyiGdldVFQTqjCKizzg=; b=A8k7USeUVsSoGYLpMTrMMwNOWR
        cNOPAHGBVka0GW/mMPLTWsdzvO4R1jopMT4aq2DSM/Z0H4AYMv7hfQj9ktxoG7If2pFS8GrOsv7nE
        busjA9T+fxaN/36CH2hAjjFRk1mKRwE6/HWK8gMGQnRTEQOJ1Dn/dkJwodfw9EBgqa4rPQaokkfve
        nyFdAgy/9IXWblmO0mYEVwqtOH6vEOGyX9GsienJ3+ICE0m2ZCG5vvMkFnFMyDLmsYAHxpNrhqlwU
        +X+FGnpO6O1vyoscyfWx3wFjwuNoNUzPLdUhGnN0e4i6pYg+uPjuQibnbt3nYO4Iwb8Lm7qhTMnIL
        CKwMVtQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdt5m-0000oi-8n; Wed, 27 May 2020 10:15:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7AC6304BDF;
        Wed, 27 May 2020 12:15:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B065E2BD9C2AA; Wed, 27 May 2020 12:15:13 +0200 (CEST)
Date:   Wed, 27 May 2020 12:15:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, paulmck@kernel.org,
        joel@joelfernandes.org
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200527101513.GJ325303@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
 <20200527095645.GH325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527095645.GH325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:56:45AM +0200, Peter Zijlstra wrote:

> This is rcu_is_cpu_rrupt_from_idle()'s lockdep_assert_in_irq() tripping
> up (it's comment is obviously a bit antiquated).
> 
> Now, if I read that code correctly, it actually relies on
> rcu_irq_enter() and thus really wants to be in an interrupt. Is there
> any way this code can be made to work from the new context too?
> 
> After all, all that really is different is not having gone throught he
> bother of setting up the IRQ context, nothing else changed -- it just so
> happens you actually relied on that ;/

At first glance, something like the below could work. But obviously I
might have overlooked something more subtle than a brick :-)

---

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90c8be22d57a..0792c032a972 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -426,8 +426,11 @@ EXPORT_SYMBOL_GPL(rcu_momentary_dyntick_idle);
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	/* Called only from within the scheduling-clock interrupt */
-	lockdep_assert_in_irq();
+	/*
+	 * Usually called from the tick; but also used from smp_call_function()
+	 * for expedited grace periods.
+	 */
+	lockdep_assert_irqs_disabled();
 
 	/* Check for counter underflows */
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) < 0,
@@ -435,8 +438,11 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) <= 0,
 			 "RCU dynticks_nmi_nesting counter underflow/zero!");
 
-	/* Are we at first interrupt nesting level? */
-	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) != 1)
+	/*
+	 * Are we at first interrupt nesting level? -- or below, when running
+	 * directly from the idle loop itself.
+	 */
+	if (__this_cpu_read(rcu_data.dynticks_nmi_nesting) > 1)
 		return false;
 
 	/* Does CPU appear to be idle from an RCU standpoint? */
