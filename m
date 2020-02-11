Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B5EC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C133320708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 16:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KqMs6V0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgBKQ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:27:38 -0500
Received: from mail.efficios.com ([167.114.26.124]:43692 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgBKQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 11:27:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9A87C24DA97;
        Tue, 11 Feb 2020 11:27:36 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hyHf05rlqMDp; Tue, 11 Feb 2020 11:27:36 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4C46A24D8B5;
        Tue, 11 Feb 2020 11:27:36 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4C46A24D8B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581438456;
        bh=ec3kBvO2BqXkmdya9RuZRn0s5WZ1uU9YP5NHT2Lsw+4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KqMs6V0xYFtD+UV2hHMObhS5rf/EEoO3WP7AvYBfNSujX/DzrBO3DhqTIRG3DQ8bS
         hnIxFdkLkpeSGIUkNWpzMiR0B0S3MbE+BWl1bVL4fNYrpRq2x5WK6pDaM5ZgiMbhBc
         6tq3ML4wDKYJs1IubsF+UF8dvQcRAmGYRLU3e/FpWS1O0ambkw/5oqNAnnwjP96m9A
         q5AODi6mbSEebdVs+0U8JIixArTGW0evcEv5cdUSHqlGafFJybmsOcshtTsBHDnIeX
         axDDjxee9K3DKV8zi1ss11vNgGGl1Nuj/TTXwLKiyXNz8GYVHuP70x6CjfCmH2E/g7
         qre8dhICEa1xw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ldVQBVH-F97C; Tue, 11 Feb 2020 11:27:36 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 33A3C24D8B4;
        Tue, 11 Feb 2020 11:27:36 -0500 (EST)
Date:   Tue, 11 Feb 2020 11:27:36 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <698566505.617724.1581438456170.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200211111828.48058768@gandalf.local.home>
References: <20200211095047.58ddf750@gandalf.local.home> <20200211153452.GW14914@hirez.programming.kicks-ass.net> <20200211111828.48058768@gandalf.local.home>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: YC6wRI/vCca3DODmn8oaF1GxqoNM3Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 11, 2020, at 11:18 AM, rostedt rostedt@goodmis.org wrote:

> On Tue, 11 Feb 2020 16:34:52 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> > +		if (unlikely(in_nmi()))
>> > +			goto out;
>> 
>> unless I'm mistaken, we can simply do rcu_nmi_enter() in this case, and
>> rcu_nmi_exit() on the other end.
>> 
>> > +		rcu_irq_enter_irqson();
> 
> The thing is, I don't think this can ever happen. We've had in the
> tracepoint.h:
> 
>		/* srcu can't be used from NMI */			\
>		WARN_ON_ONCE(rcuidle && in_nmi());			\
> 
> And this has yet to trigger.

But that "rcuidle" state is defined on a per-tracepoint basis, whereas
"!rcu_is_watching()" is a state which depends on the current execution
context. I don't follow how the fact that this WARN_ON_ONCE() never
triggered allows us to infer anything about (!rcu_is_watching() && in_nmi()).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
