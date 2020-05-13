Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0982C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9719520714
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbgEMBvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgEMBvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:51:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6406D206F5;
        Wed, 13 May 2020 01:51:10 +0000 (UTC)
Date:   Tue, 12 May 2020 21:51:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 01/29] x86/traps: Mark fixup_bad_iret()
 noinstr
Message-ID: <20200512215108.5ea110b7@oasis.local.home>
In-Reply-To: <CALCETrW1pZ0NiN3F4g3=S+KpM79T9PbaYVC3Zr5p6P2rvk4v0A@mail.gmail.com>
References: <20200505134354.774943181@linutronix.de>
        <20200505134903.346741553@linutronix.de>
        <CALCETrW1pZ0NiN3F4g3=S+KpM79T9PbaYVC3Zr5p6P2rvk4v0A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020 17:39:00 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > This is called from deep entry ASM in a situation where instrumentation
> > will cause more harm than providing useful information.
> >  
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> Maybe add to changelog:
> 
> Switch from memmove() to memcpy() because memmove() can't be called
> from noinstr code.

Yes please, because I was about to say that there was changes that
didn't seem to fit the change log.

I would also add a comment in the code saying that we need the temp
variable to use memcpy as memmove can't be used in noinstr code.

-- Steve
