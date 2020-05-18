Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4267F20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgERIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgERIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:04:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA030C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:04:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jaajp-0004W8-4K; Mon, 18 May 2020 10:03:05 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 748921006FB; Mon, 18 May 2020 10:03:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
In-Reply-To: <CALCETrVuA25n_d-3KMvvDxuqZeBEEYb6n=QAXOhBFkgS1Dk+UA@mail.gmail.com>
References: <20200515234547.710474468@linutronix.de> <20200515235124.783722942@linutronix.de> <CALCETrW2negGYRSQ8dqFVdiWGtYpYf6nKe5_hkotNv0e5mNBxA@mail.gmail.com> <87zha7c5h5.fsf@nanos.tec.linutronix.de> <CALCETrVuA25n_d-3KMvvDxuqZeBEEYb6n=QAXOhBFkgS1Dk+UA@mail.gmail.com>
Date:   Mon, 18 May 2020 10:03:04 +0200
Message-ID: <877dx9zn47.fsf@nanos.tec.linutronix.de>
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
> On Sun, May 17, 2020 at 1:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Remember this is about ensuring that all the state is properly
>> established before any of this instrumentation muck can happen.
>>
>> DR7 handling is specific to #DB and done even before nmi_enter to
>> prevent recursion.
>
> So why is this change needed?

We really want nmi_enter() to be the carefully crafted mechanism which
establishes correct state in whatever strange context the exception
hits. Not more, not less.

Random instrumentation has absolutely no business there and I went a
long way to make sure that this is enforcible by objtool.

Aside of that the tracing which is contained in nmi_enter() is about
taking timestamps for hardware latency detection. If someone runs
hardware latency detection with active break/watchpoints then I really
can't help it.

Thanks,

        tglx
