Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A57222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uZSEV2T+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgCJRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:22:47 -0400
Received: from mail.efficios.com ([167.114.26.124]:39044 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:22:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 79FE62715E5;
        Tue, 10 Mar 2020 13:22:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GpSxpXmxG8xx; Tue, 10 Mar 2020 13:22:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 211232715E2;
        Tue, 10 Mar 2020 13:22:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 211232715E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583860966;
        bh=Uw/TaRbZl18k/fBlIngjHyFHLjtgjXWgf9OpMAJuJjI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uZSEV2T+H8yfYrJYrTNvHlr7JT08DvIofMeqnUi09eA5DtrWSlLXYfRhs/V4OeK9L
         WTA5jIY/ugh6x/Q4vcyzCrlakdX8DjxbQpw4klMdvsQXdwtCsMkthbajF7fb/j50po
         2zygVc23QqvaWj48PJr1DR6rMVNc9eXMYo7on6FpoHOgdk8lynGVuhp62EKNGu2UQj
         e//8exj1QOwc5hNOSFrCR8Rkjdos0GjdIGUr13AdCN5LYzkgx57hNKmpRF2f9QRbWI
         TbiJRo7bZbyUTzf+mLG1/X05LT5iUp82g/S/Lq7EZpOTqOQt6wEqNE/myJezPbu5w+
         R1uK4yfW23rlg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hhp3oRbRPtRI; Tue, 10 Mar 2020 13:22:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 117DA2711F8;
        Tue, 10 Mar 2020 13:22:46 -0400 (EDT)
Date:   Tue, 10 Mar 2020 13:22:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <1800881789.23773.1583860965967.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200310164927.GD2935@paulmck-ThinkPad-P72>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309204710.GU2935@paulmck-ThinkPad-P72> <379743142.23419.1583853207158.JavaMail.zimbra@efficios.com> <20200310164927.GD2935@paulmck-ThinkPad-P72>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: S50nOpd4XNE2sbWADgwAqB5o0A8OxA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 12:49 PM, paulmck paulmck@kernel.org wrote:

> On Tue, Mar 10, 2020 at 11:13:27AM -0400, Mathieu Desnoyers wrote:
>> 
>> 
>> ----- On Mar 9, 2020, at 4:47 PM, paulmck paulmck@kernel.org wrote:
>> [...]
>> 
>> > 
>> > Suppose that we had a variant of RCU that had about the same read-side
>> > overhead as Preempt-RCU, but which could be used from idle as well as
>> > from CPUs in the process of coming online or going offline?  I have not
>> > thought through the irq/NMI/exception entry/exit cases, but I don't see
>> > why that would be problem.
>> > 
>> > This would have explicit critical-section entry/exit code, so it would
>> > not be any help for trampolines.
>> > 
>> > Would such a variant of RCU help?
>> > 
>> > Yeah, I know.  Just what the kernel doesn't need, yet another variant
>> > of RCU...
>> 
>> Hi Paul,
>> 
>> I think that before introducing yet another RCU flavor, it's important
>> to take a step back and look at the tracer requirements first. If those
>> end up being covered by currently available RCU flavors, then why add
>> another ?
> 
> Well, we have BPF requirements as well.
> 
>> I can start with a few use-cases I have in mind. Others should feel free
>> to pitch in:
>> 
>> Tracing callsite context:
>> 
>> 1) Thread context
>> 
>>    1.1) Preemption enabled
>> 
>>    One tracepoint in this category is syscall enter/exit. We should introduce
>>    a variant of tracepoints relying on SRCU for this use-case so we can take
>>    page faults when fetching userspace data.
> 
> Agreed, SRCU works fine for the page-fault case, as the read-side memory
> barriers are in the noise compared to page-fault overhead.  Back in
> the day, there were light-weight system calls.  Are all of these now
> converted to VDSO or similar?

There is a big difference between allowing page faults to happen, and expecting
page faults to happen every time. I suspect many use-cases will end up having
a fast-path which touches user-space data which is in the page cache, but
may end up triggering page faults in rare occasions.

Therefore, this might justify an SRCU which has low-overhead read-side.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
