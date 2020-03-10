Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC12C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A282051A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lXJM1f64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCJPY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:24:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:57480 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgCJPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:24:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BB3FC27071B;
        Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1d1w8WYouvD8; Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6663727071A;
        Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6663727071A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583853864;
        bh=gp7Kmc8jBY4NbIeSZBjG4II/f2jxwB5Vq1ocHtrdySk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lXJM1f64opRz4b+Bia2GTEg/bwe7oQ5oYbh1U4wbAwiZvvKSgPnN01Kd8oFjVL77P
         Nyf85rEh0AAEcwAaRWL/t8WFFGQdOQMSmTpeai1JBLllaUx3Iw1LMWblbldTlU5pUk
         43cMgdFyVspZYlizE76t/BhHbcJVsLCXh6otSy6X2rSZXxR9ajfYgH8RyjRTBqXTVu
         Hylzmi7WAgbfHxykEz8zTFUJmqkDKI77Bw0UExqv1BG0pvbgR0fOk2uJJR96H8PmoG
         VEe5xlO6EOzd2+b8Wb0aRGQ/tWBnUCOjsdNb3BFMKyAup+fyda50n8XN12J8Ri5XsT
         m/A1o75F8OC6w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id imPTwLp3Rtwx; Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 584E22703DB;
        Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
Date:   Tue, 10 Mar 2020 11:24:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Message-ID: <1659630114.23432.1583853864272.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home> <87fteh73sp.fsf@nanos.tec.linutronix.de> <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: oPBNQoQiPYdHi8VoaO0FSLCrNzp3nQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 4:09 AM, Masami Hiramatsu mhiramat@kernel.org wrote:

> Hi,
> 
> On Mon, 09 Mar 2020 19:59:18 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 

[...]

>> which is also in section "text" then the analysis tool will find the
>> missing offlimit_safecall() - or what ever method we chose to annotate
>> that stuff. Surely not an annotation on the called function itself
>> because that might be safe to call in one context but not in another.
> 
> Hmm, what the offlimit_safecall() does? and what happen if the
> do_fragile_stuff_on_enter() invokes a library code? I think we also need
> to tweak kbuild to duplicate some library code to the off-limit text area.
> 
>> These annotations are halfways easy to monitor for abuse and they should
>> be prominent enough in the code that at least for the people dealing
>> with that kind of code they act as a warning flag.
> 
> This off-limit text will be good for entries, but I think we still not
> able to remove all NOKPROBE_SYMBOLS with this.
> 
> For example __die() is marked a NOKPROBE because if we hit a recursive
> int3, it calls BUG() to dump stacks etc for debug. So that function
> must NOT probed. (I think we also should mark all backtrace functions
> in this case, but not yet) Would we move those backtrace related
> functions (including printk, and console drivers?) into the offlimit
> text too?
> 
> Hmm, if there is a bust_kprobes(), that can be easy to fix this issue.

In order to solve the recursion issue without losing instrumentation
coverage of traps and significant system events, I really think we should
look into adding some kind of "in_tracing" flag near each stack. We could
name this "struct recursion_context" or something similar. We could then
add this structure alongside each thread and ISR stack, but make sure traps
(including breakpoints) still point to the recursion context of whatever
caused the trap.

This should allow us to detect and prevent recursion from tracers directly
at the instrumentation level.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
