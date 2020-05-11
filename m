Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E76C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FE8206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgEKKjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728209AbgEKKjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:39:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775CEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:39:43 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jY5q2-0002z3-Ev; Mon, 11 May 2020 12:39:11 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 76327FFBF8; Mon, 11 May 2020 12:39:09 +0200 (CEST)
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
Subject: Re: [patch V4 part 3 10/29] x86/idtentry: Provide macros to define/declare IDT entry points
In-Reply-To: <CALCETrXd+-nvDcwupvbtr8-Gj2RQsGfFiUu-wr86dw4-nJ=S5w@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de> <20200505134904.273363275@linutronix.de> <CALCETrXd+-nvDcwupvbtr8-Gj2RQsGfFiUu-wr86dw4-nJ=S5w@mail.gmail.com>
Date:   Mon, 11 May 2020 12:39:09 +0200
Message-ID: <87blmu4uya.fsf@nanos.tec.linutronix.de>
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
> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Provide DECLARE/DEFINE_IDTENTRY() macros.
>
> Acked-by: Andy Lutomirski <luto@kernel.org>
>
> except:
>
>>
>> DEFINE_IDTENTRY() provides a wrapper which acts as the function
>> definition. The exception handler body is just appended to it with curly
>> brackets. The entry point is marked notrace/noprobe so that irq tracing and
>> the enter_from_user_mode() can be moved into the C-entry point.
>
> "noinstr", perhaps?  I'm guessing you write this text before noinstr
> happened.

Yes.

> Also, would it perhaps make sense in the future to include the
> idtentry macro somehow (via inline asm or gcc options) so that
> DEFINE_IDTENTRY() could emit the stub instead of leaving it to
> DECLARE_IDTENTRY()?  It might end up too messy in practice, I suppose.
> This is obviously not worth changing right now, but maybe down the
> road.

Maybe. Right now my entry/rcu/tracing induced brainmelt is far too
advanced to try thinking about it :)
