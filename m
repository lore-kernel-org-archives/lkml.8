Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EB42053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WVgk3epd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgENRqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:46:12 -0400
Received: from mail.efficios.com ([167.114.26.124]:39996 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgENRqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:46:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B57B22A73BB;
        Thu, 14 May 2020 13:46:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ftpm0gtnYq5x; Thu, 14 May 2020 13:46:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4BCBA2A7513;
        Thu, 14 May 2020 13:46:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4BCBA2A7513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589478370;
        bh=/GdvTshxrvvhnSKnsBtmJtZGAFcFUSZomUuLaL/1Xdg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WVgk3epdUF7Ha7sppoSPzh48s/EWqTGNJYcMJJnwSMuwRMNp8PlDnQBXGq/kSS+PN
         zaiCeuHW39fga28XonD6C6Zc5CAYVghexVjDDGSZk5GrgltVOszPXh9KTVigoNpmEQ
         mrXs2eBoInChlrlJ098ADx+gGceQS8DB4pZKqIHTvWzdOqtk4v8Ljq5I5q/PAAncH9
         cXWjb38r/7ZAL87bxPooFpWgNDrg89mA2McvwZc11BCyT9N1UE0jOQZvgdkFAC19K5
         XB3VKscPaR7l2bc+Gyzh1X6z+UB/3hxB+o+HpGjZd4EIGc13DrIHsWphZIEFGfC5/Y
         hptmr3Ma1U8TQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UR_rARrfJ9-K; Thu, 14 May 2020 13:46:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 365E12A6C7C;
        Thu, 14 May 2020 13:46:10 -0400 (EDT)
Date:   Thu, 14 May 2020 13:46:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <2107385142.21313.1589478370190.JavaMail.zimbra@efficios.com>
In-Reply-To: <871rnmzarj.fsf@nanos.tec.linutronix.de>
References: <20200505134926.578885807@linutronix.de> <20200505135314.808628211@linutronix.de> <552488029.20647.1589423096441.JavaMail.zimbra@efficios.com> <871rnmzarj.fsf@nanos.tec.linutronix.de>
Subject: Re: [patch V4 part 4 15/24] x86/db: Split out dr6/7 handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/db: Split out dr6/7 handling
Thread-Index: oRKSde8vieHRNXPfgTJdj6DGkq1Icg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 14, 2020, at 1:28 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> ----- On May 5, 2020, at 9:49 AM, Thomas Gleixner tglx@linutronix.de wrote:
>>> +
>>> +static __always_inline void debug_exit(unsigned long dr7)
>>> +{
>>> +	set_debugreg(dr7, 7);
>>> +}
>>

* Question 1

>> Out of curiosity, what prevents the compiler from moving instructions
>> outside of the code regions surrounded by entry/exit ? This is an always
>> inline, which invokes set_debugreg which is inline for CONFIG_PARAVIRT_XXL=n,
>> which in turn uses an asm() (not volatile), without any memory
>> clobber.
>>

?

* Question 2

>> Also, considering that "inline" is not sufficient to ensure the compiler
>> does not emit a traceable function, I suspect you'll also want to mark
>> "native_get_debugreg" and "native_set_debugreg" always inline as well.
> 
> It can move it into a function and call that. Fine. If that function
> stays in the noinstr section then it should not emit a trace stub and if
> it moves it out of the section or reuses another instance in text then
> objtool will complain.
> 
> Checking for trace stubs and other instrumentation nonsense is on the
> objtool wishlist anyway.
> 
> But yes, marking these __always_inline prevents that. Those escaped my
> chase. But I would have found them once I go and fix that paravirt muck.

This answers only my second question (see "Question 1" above).

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
