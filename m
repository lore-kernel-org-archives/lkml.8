Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BFAC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D5321D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dm4Jj9bL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgCJX4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:56:20 -0400
Received: from mail.efficios.com ([167.114.26.124]:39838 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:56:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EF79D2749C3;
        Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zw2gTWDpFAZg; Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9FE2D274D01;
        Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9FE2D274D01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583884577;
        bh=5+o2q81iJKpSXYqIrAAN4cqWXccpMlM3thCTsGSomhs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dm4Jj9bLxop/lUZuzUYILSJ11X3sSAP1dTymiJ6EJ9KR+7a0k8ZdqsuxmxqiXBRa3
         ZwiP7EaRX51bdru9DQ074862cYooHoy6Llv16on4vSZugTW1l46m/QpK0XxMhF14T7
         q2F029bwMk/XKlXM3Mh9nR44d49cm3HdeKOvcAgsvj1Yf0KsOX40WQjhdSqQYKYgLC
         2h3vtxB9ExATO15vjlfoUd63Qj8WT1mEYpdaYI/mMuFguW+I6E8rInh8x9Qr/frUvv
         yFVXTY2ycwhwNnNPvOViFTYRGXMevQ7U6CS89/6ZgMXVQprq1LUH5WrUrUWQp1a9wk
         iLM5WeuR9WrAQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2VIwxeN5l-wn; Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 92185274AAB;
        Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
Date:   Tue, 10 Mar 2020 19:56:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        fweisbec <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
Message-ID: <1425816045.24643.1583884577489.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200310235219.GL2935@paulmck-ThinkPad-P72>
References: <20200310202054.5880-1-mathieu.desnoyers@efficios.com> <20200310205319.GH2935@paulmck-ThinkPad-P72> <561555431.24628.1583883873699.JavaMail.zimbra@efficios.com> <20200310235219.GL2935@paulmck-ThinkPad-P72>
Subject: Re: [PATCH] tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
Thread-Index: +rJk+uGnKqEfUuJ3zJM3z8A55XlNow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 7:52 PM, paulmck paulmck@kernel.org wrote:

> On Tue, Mar 10, 2020 at 07:44:33PM -0400, Mathieu Desnoyers wrote:
>> ----- On Mar 10, 2020, at 4:53 PM, paulmck paulmck@kernel.org wrote:
>> 
>> > On Tue, Mar 10, 2020 at 04:20:54PM -0400, Mathieu Desnoyers wrote:
>> >> commit e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use
>> >> SRCU") aimed at improving performance of rcuidle tracepoints by using
>> >> SRCU rather than temporarily enabling tree-rcu every time.
>> >> 
>> >> commit 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson()
>> >> for rcuidle tracepoints") adds back the high-overhead enabling of
>> >> tree-rcu because perf expects RCU to be watching when called from
>> >> rcuidle tracepoints.
>> >> 
>> >> It turns out that by using "rcu_is_watching()" and conditionally
>> >> calling the high-overhead rcu_irq_enter/exit_irqson(), the original
>> >> motivation for using SRCU in the first place disappears.
>> > 
>> > Adding Alexei on CC for his thoughts, given that these were his
>> > benchmarks.  I believe that he also has additional use cases.
>> 
>> Good point! Sorry I forgot to add Alexei to my CC list for that
>> patch.
>> 
>> > But given the use cases you describe, this seems plausible.  This does
>> > mean that tracepoints cannot be attached to the CPU-hotplug code that
>> > runs on the incoming/outgoing CPU early/late in that process, though
>> > that might be OK.
>> 
>> Do you mean standard tracepoints or rcuidle tracepoints ?
>> 
>> Are there any such tracepoints early/late in the cpu hotplug code today ?
> 
> I have no idea.  You would know better than I.  However, I would expect
> that the same common-code issue that applies to exception-entry/exit
> code might also apply to the CPU hotplug code.

I would also expect early/late CPU hotplug states to fall into the same
category of "low-level entry/exit" code which Thomas would like to hide
from instrumentation.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
