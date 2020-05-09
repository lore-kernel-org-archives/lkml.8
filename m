Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FACC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9073520CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEIKQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgEIKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:16:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38378C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 03:16:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jXMWd-0005Ym-Nr; Sat, 09 May 2020 12:16:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 121C0100C8A; Sat,  9 May 2020 12:16:07 +0200 (CEST)
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
Subject: Re: [patch V4 part 2 06/18] x86/entry: Move irq flags tracing to prepare_exit_to_usermode()
In-Reply-To: <CALCETrWAWHByoifmzcXpMpYgcABkRNNM3ihsJ1pe5jzaayvkHA@mail.gmail.com>
References: <20200505134112.272268764@linutronix.de> <20200505134340.703783926@linutronix.de> <CALCETrWAWHByoifmzcXpMpYgcABkRNNM3ihsJ1pe5jzaayvkHA@mail.gmail.com>
Date:   Sat, 09 May 2020 12:16:07 +0200
Message-ID: <87mu6h4dnc.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> This is another step towards more C-code and less convoluted ASM.
>>
>> Similar to the entry path, invoke the tracer before context tracking which
>> might turn off RCU and invoke lockdep as the last step before going back to
>> user space. Annotate the code sections in exit_to_user_mode() accordingly
>> so objtool won't complain about the tracer invocation.
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> Note to self: the nmi code needs to be reworked to go through
> prepare_exit_to_usermode(), too.  I'll do this once this whole pile
> lands.

Why? NMI does not set any work stuff or preemption. If something needs
to be done then NMI raises irq_work which uses the regular path.

Thanks,

        tglx
