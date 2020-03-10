Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF046C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DC321D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="U5fVceVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCJShd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:37:33 -0400
Received: from mail.efficios.com ([167.114.26.124]:47974 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:37:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DF614271C70;
        Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WL9bLm33BooY; Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9B3F5271C6F;
        Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9B3F5271C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583865451;
        bh=eGfri0G7sERwSsFs3uQxZh1dlaIB473RbVMXTjRjpWc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=U5fVceVWhYgkU8T16mIH+UH3OBkxJwgWGEA/ErWPNfnmgzYR3hmU7RepWNJ7+nfKF
         txdSd3Rplj70f3UW1FCyrozTF63nIPJqBdox5B2deElQh3yBqUEmJh+NF1whXww13i
         wN4OudPQiuWAu3rKG+jep6SAgWE/tkQO5T7JPKixDPkvXKCqfLpXHWvxdjXvAyU/uK
         M6YEjxpq9th1W/2SlFz5mx+NEyjGIswryWgIk7cLCm+92fT4J9ovHqqtvSlhUdJh68
         WxGEWciwob+FaVAjfSL0KXYCHtXPr4to8AgUk9JDiHS0ThLf/MvyBzhQKmep3/iLTg
         d81cAvEwhOSAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EirE6v3bsrvy; Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8E892271B6C;
        Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
Date:   Tue, 10 Mar 2020 14:37:31 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <799177238.23913.1583865451495.JavaMail.zimbra@efficios.com>
In-Reply-To: <87d09k5aet.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <871rq171ca.fsf@nanos.tec.linutronix.de> <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com> <87imjc5f6a.fsf@nanos.tec.linutronix.de> <1666704263.23816.1583862003925.JavaMail.zimbra@efficios.com> <87d09k5aet.fsf@nanos.tec.linutronix.de>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: 06r5HuF/850lcpCTrawcQQsFC9RdIA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 2:31 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
>> ----- On Mar 10, 2020, at 12:48 PM, Thomas Gleixner tglx@linutronix.de wrote:
>>> How do you "fix" that when you can't reach the tracepoint because you
>>> trip over a breakpoint and then while trying to fixup that stuff you hit
>>> another one?
>>
>> I may still be missing something, but if the fixup code (AFAIU the code
>> performing
>> the out-of-line single-stepping of the original instruction) belongs to a
>> section
>> hidden from instrumentation, it should not be an issue.
> 
> Sure, but what guarantees that on the way there is nothing which might
> call into instrumentable code? Nothing, really.
> 
> That's why I want the explicit sections which can be analyzed by
> tools. Humans (including me) are really bad at it was demonstrated
> several times.

AFAIU, my in_tracer flag proposal complements yours.

The explicit sections thingy is required for early/late entry/exit code,
but does nothing to prevent "explicitly marked" safe-to-instrument kernel
code from triggering infinite recursion.

My flag proposal handles that second issue.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
