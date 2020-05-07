Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C914EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCA72495E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgEGSwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726470AbgEGSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:52:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1FC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:52:43 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWld5-0003YF-Ir; Thu, 07 May 2020 20:52:19 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E6093102652; Thu,  7 May 2020 20:52:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 22/36] tracing: Provide lockdep less trace_hardirqs_on/off() variants
In-Reply-To: <CALCETrU7rf8cizYM1v0Rb6LzufLEbNcAS6Ebx_BW=+3Svk+F2g@mail.gmail.com>
References: <20200505131602.633487962@linutronix.de> <20200505134100.270771162@linutronix.de> <CALCETrU7rf8cizYM1v0Rb6LzufLEbNcAS6Ebx_BW=+3Svk+F2g@mail.gmail.com>
Date:   Thu, 07 May 2020 20:52:18 +0200
Message-ID: <87eervefx9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> trace_hardirqs_on/off() is only partially safe vs. RCU idle. The tracer
>> core itself is safe, but the resulting tracepoints can be utilized by
>> e.g. BPF which is unsafe.
>>
>> Provide variants which do not contain the lockdep invocation so the lockdep
>> and tracer invocations can be split at the call site and placed properly.
>>
>> The new variants also do not use rcuidle as they are going to be called
>> from entry code after/before context tracking.
>
> I can't quite follow this.  Are you saying that the new variants are
> intended to be called by the entry code in a context where tracing is
> acceptable and that the lockdep part will still be called in a context
> where tracing is not acceptable?

Yes. Before RCU is reestablished and after. I'll rephrase.
