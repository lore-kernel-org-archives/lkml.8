Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40311C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180EC208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jHKHuzjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgBKPTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:19:21 -0500
Received: from mail.efficios.com ([167.114.26.124]:53654 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728563AbgBKPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:19:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 932F424D18E;
        Tue, 11 Feb 2020 10:19:18 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 26pbH5EzZl0C; Tue, 11 Feb 2020 10:19:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3B31224D18D;
        Tue, 11 Feb 2020 10:19:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3B31224D18D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581434358;
        bh=9R5XSbWrIWWtI2XeGqI7V3shuI47gpCNPyA7CiyFgus=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jHKHuzjLurBa/hVKB2CzVt7qMtBIqWlIlpKygHHDS2+fC7n+8i45kZ7Erh5UeiFJZ
         ftY6tg0cWlHrne75ZsahYMnYFU/WssVxBF/KFk7bC2hYVBPgBOx/rtQixDG16H8L/p
         tR2xL06yHlTcbJfO0LUv08J451x9TTAPAhPQ6BAjwLAxeYgFh/ZNRN41qRmLvCBhBe
         3dWsaO/D9PdiYxzsA8WH0/z3m+HjzXnU1qBt/OuG2jOXurXFT/AMa6iOadIZ7t6PGI
         w66ffX19kqnBbyu22GIz/wO7r/1fnLMW6bRmronNDG9D/rAU+Ef+oQJzzA8XrSaWcb
         CTdBoszBSITUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gWyJNOxmf0j8; Tue, 11 Feb 2020 10:19:18 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 24C9624CBA0;
        Tue, 11 Feb 2020 10:19:18 -0500 (EST)
Date:   Tue, 11 Feb 2020 10:19:18 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Message-ID: <962026294.617571.1581434358053.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200210212222.59a8c519@rorschach.local.home>
References: <20200210170643.3544795d@gandalf.local.home> <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com> <20200210212222.59a8c519@rorschach.local.home>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing/perf: Move rcu_irq_enter/exit_irqson() to perf trace point hook
Thread-Index: Qsnlc2BD5rDXAR83Nev90DoiF2Bx7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 10, 2020, at 9:22 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 10 Feb 2020 19:30:32 -0500 (EST)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Feb 10, 2020, at 5:06 PM, rostedt rostedt@goodmis.org wrote:
>> 
>> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> 
>> Hi Steven,
> 
> Hi Mathieu!
[...]
>> 
>> Which brings a question about handling of NMIs: in the proposed patch, if
>> a NMI nests over rcuidle context, AFAIU it will be in a state
>> !rcu_is_watching() && in_nmi(), which is handled by this patch with a simple
>> "return", meaning important NMIs doing hardware event sampling can be
>> completely lost.
>> 
>> Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI context,
>> is it at all valid to use rcu_read_lock/unlock() as perf does from NMI handlers,
>> considering that those can be nested on top of rcuidle context ?
>> 
> 
> Note, in the __DO_TRACE macro, we've had this for a long time:
> 
>		/* srcu can't be used from NMI */			\
>		WARN_ON_ONCE(rcuidle && in_nmi());			\
> 
> With nothing triggering.

The "rcuidle" argument is only true for tracepoints which are declared to be used
within the rcuidle code. AFAIK, it does not cover tracepoints which can be placed
in NMI handlers. The state I am concerned about is really:

WARN_ON_ONCE(!rcu_is_watching() && in_nmi())

As pointed out by Peter further down in this thread.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
