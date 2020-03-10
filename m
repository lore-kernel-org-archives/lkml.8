Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F69C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877CF21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ZeQ/xaYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCJPbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:31:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:59504 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCJPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:31:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7D0152706AE;
        Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1cZpvTYtrQgO; Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3EDE82704D4;
        Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3EDE82704D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583854311;
        bh=nj/SYwwa3H2hKOSm4ou98RXCIxnuTFiGSEBDrOICsp8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZeQ/xaYGndMSV9lUtWfMLyF05bj3iZBkxrxj+hrOUTydmCQgXG6u1d63UQQJEKAdM
         F5wHiyHtjBwncUNvRYkq6W8BSyi5tTOLullW0m7d+S6oobVu/JNEKX8VR6Fn7de8YH
         CPCH+dELYbffEy4XQBBP8WJWHm4KpKMmM68ikAkRW2Tn6uZP3+CL1LKztAq9WXCRIc
         Z5rISprbtCcH/5W0ISaJRNvkSc4hm0a7oncXqFWhaTDr0uX/9HbZ4OMilxOpCglYGT
         ofjwjdWp37o2Cfp8RimZNatxs2CKTR8lliExNk3++lOGYl0ZXzr+pvUiCjij6JaV3b
         pVW+WoWJphCMQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zz7YAcnfyUUG; Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2EA312705C0;
        Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
Date:   Tue, 10 Mar 2020 11:31:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Message-ID: <450878559.23455.1583854311078.JavaMail.zimbra@efficios.com>
In-Reply-To: <87pndk5tb4.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home> <87fteh73sp.fsf@nanos.tec.linutronix.de> <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org> <87pndk5tb4.fsf@nanos.tec.linutronix.de>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: Vrvuy5XcnfL0kDVv4taSpI5sQV/3Jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 7:43 AM, Thomas Gleixner tglx@linutronix.de wrote:

[...]
> 
> That's why we want the sections and the annotation. If something calls
> out of a noinstr section into a regular text section and the call is not
> annotated at the call site, then objtool can complain and tell you. What
> Peter and I came up with looks like this:
> 
> noinstr foo()
>	do_protected(); <- Safe because in the noinstr section
> 
>	instr_begin();	<- Marks the begin of a safe region, ignored
>        		   by objtool
> 
>        do_stuff();     <- All good
> 
>        instr_end();    <- End of the safe region. objtool starts
>			   looking again
> 
>        do_other_stuff();  <- Unsafe because do_other_stuff() is
>        		      not protected
> and:
> 
> noinstr do_protected()
>        bar();		<- objtool will complain here
> 
> See?

I think there are two distinct problems we are trying to solve here,
and it would be good to spell them out to see which pieces of technical
solution apply to which.

Problem #1) Tracer invoked from partially initialized kernel context

  - Moving the early/late entry/exit points into sections invisible from
    instrumentation seems to make tons of sense for this.

Problem #2) Tracer recursion

  - I'm much less convinced that hiding entry points from instrumentation
    works for this. As an example, with the isntr_begin/end() approach you
    propose above, as soon as you have a tracer recursing into itself because
    something below do_stuff() has been instrumented, having hidden the entry
    point did not help at all.

So I would be tempted to use the "hide entry/exit points" with explicit
instr begin/end annotation to solve Problem #1, but I'm still thinking there
is value in the per recursion context "in_tracing" flag to prevent tracer
recursion.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
