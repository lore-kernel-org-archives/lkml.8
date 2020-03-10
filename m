Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12823C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDED7208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgCJSb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:31:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34856 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgCJSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:31:57 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBjfG-0001FW-W1; Tue, 10 Mar 2020 19:31:39 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 62A48104084; Tue, 10 Mar 2020 19:31:38 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: Instrumentation and RCU
In-Reply-To: <1666704263.23816.1583862003925.JavaMail.zimbra@efficios.com>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <871rq171ca.fsf@nanos.tec.linutronix.de> <1489283504.23399.1583852595008.JavaMail.zimbra@efficios.com> <87imjc5f6a.fsf@nanos.tec.linutronix.de> <1666704263.23816.1583862003925.JavaMail.zimbra@efficios.com>
Date:   Tue, 10 Mar 2020 19:31:38 +0100
Message-ID: <87d09k5aet.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> ----- On Mar 10, 2020, at 12:48 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> How do you "fix" that when you can't reach the tracepoint because you
>> trip over a breakpoint and then while trying to fixup that stuff you hit
>> another one?
>
> I may still be missing something, but if the fixup code (AFAIU the code performing
> the out-of-line single-stepping of the original instruction) belongs to a section
> hidden from instrumentation, it should not be an issue.

Sure, but what guarantees that on the way there is nothing which might
call into instrumentable code? Nothing, really.

That's why I want the explicit sections which can be analyzed by
tools. Humans (including me) are really bad at it was demonstrated
several times.

Thanks,

        tglx
