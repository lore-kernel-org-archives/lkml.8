Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47727C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A42082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mvdUvAsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgBLPOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:14:23 -0500
Received: from mail.efficios.com ([167.114.26.124]:35984 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbgBLPOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:14:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 30F122565FE;
        Wed, 12 Feb 2020 10:14:21 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uCkcnQ8ODkoA; Wed, 12 Feb 2020 10:14:21 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E3C15256987;
        Wed, 12 Feb 2020 10:14:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E3C15256987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581520460;
        bh=mW2NXnzY6Fox50h6j/jkDgJSsUhd0Yb5gYCdadXil9o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mvdUvAsQjqTqthMLUHmoh844evr5sdQsidamfP3xEtimLTe4SjNLpvqiTeV8SZzQy
         IbFEVRWkB9xtQmb9Lu7QjeHikEin5qLfHrRG8tQezp+WhUPx1BvNcZMBuW32hH0QSc
         u2YuFw8Kk7hb0CCckiXm00rRTSJwhIei8za8EMuvjOu4sqpHnoXld4LcL0NO/8b4aB
         SIYFq/kg4zkGaDrLDYBWM4nKncD7UqcHMxKS216qoWp3AS5zCyQgjyc8imx/0SCcgN
         IFyOHBlVvN6eQBduxwcTNt+PA/DzhoK9XBTasfFhOSlSG2yonnNA9TcLB4iuRWmiOa
         U2IS9zXIAbOKA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K7RhqByAevvq; Wed, 12 Feb 2020 10:14:20 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id CD8F8256553;
        Wed, 12 Feb 2020 10:14:20 -0500 (EST)
Date:   Wed, 12 Feb 2020 10:14:20 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <1771156780.158.1581520460744.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200212080220.GO14897@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home> <20200211153452.GW14914@hirez.programming.kicks-ass.net> <20200211111828.48058768@gandalf.local.home> <20200211172952.GY14914@hirez.programming.kicks-ass.net> <903136616.617885.1581442521855.JavaMail.zimbra@efficios.com> <20200212080220.GO14897@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3899 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: mO9rXol55U3N6uNBOWWh5IuLvZAWrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 12, 2020, at 3:02 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Feb 11, 2020 at 12:35:21PM -0500, Mathieu Desnoyers wrote:
> 
>> Minor nits:
>> 
>> Why not make these an enum ?
>> 
>> > +
>> > +#define trace_rcu_enter()					\
>> > +({								\
>> > +	unsigned long state = 0;				\
>> > +	if (!rcu_is_watching())	{				\
>> > +		if (in_nmi()) {					\
>> > +			state = __TR_NMI;			\
>> > +			rcu_nmi_enter();			\
>> > +		} else {					\
>> > +			state = __TR_IRQ;			\
>> > +			rcu_irq_enter_irqson();			\
>> > +		}						\
>> > +	}							\
>> > +	state;							\
>> > +})
>> > +
>> > +#define trace_rcu_exit(state)					\
>> > +do {								\
>> > +	switch (state) {					\
>> > +	case __TR_IRQ:						\
>> > +		rcu_irq_exit_irqson();				\
>> > +		break;						\
>> > +	case __IRQ_NMI:						\
>> > +		rcu_nmi_exit();					\
>> > +		break;						\
>> > +	default:						\
>> > +		break;						\
>> > +	}							\
>> > +} while (0)
>> 
>> And convert these into static inline functions ?
> 
> Probably the same reason the rest of the file is macros; header hell.
> 
> Now, I could probably make these inlines, but then I'd have to add more
> RCU function declariations to this file (which is outside of
> rcupdate.h). Do we want to do that?

Probably not :) I was just wondering why.

Thanks,

Mathieu

> 
> The reason these were in this file is because I want to keep the comment
> and implementation near to nmi_enter/exit.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
