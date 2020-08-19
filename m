Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C21C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB9A2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaPDSEfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHSWrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:47:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33536 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbgHSWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597877260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXnTSgNfg8RNoeGnfUHV2QiCinLcEjZGZZliKpRTfWM=;
        b=UaPDSEfVAjxlJU4F2oi5AfPU82SsvdNcsI8ks8QL7lTEy2N5b97wObP3IHWYi46GT4gvYE
        5Zx6GH6MAfAom2ySAa/tcvJp2IzumdzR/A5sxTLRLVNb7HU+pFb4aaTW06rBEFG6vQS0jh
        6VnhMe3rInX1anCYVZlbyysddSraYPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-4rdRZyruNsOTxOvAhWr_RA-1; Wed, 19 Aug 2020 18:47:38 -0400
X-MC-Unique: 4rdRZyruNsOTxOvAhWr_RA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C72F801AE5;
        Wed, 19 Aug 2020 22:47:36 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EB4919C4F;
        Wed, 19 Aug 2020 22:47:33 +0000 (UTC)
Date:   Wed, 19 Aug 2020 17:47:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kyle Huey <me@kylehuey.com>, Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Will Deacon <will@kernel.org>
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
Message-ID: <20200819224731.3edo5lqw6lbuprdx@treble>
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net>
 <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
 <20200819213534.GQ3982@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819213534.GQ3982@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:35:34PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 19, 2020 at 12:28:16PM -0700, Kyle Huey wrote:
> 
> > > I'm guess that is not the expected outcome, is that the same failure you
> > > saw?
> > 
> > Yes. Is status also 0x4d00 for you?
> 
> Indeed.
> 
> > The program is expected to complete with no assertions firing.
> 
> When I comment out the break-on-exec test, the break-on-write test
> succeeds.
> 
> When I add a few printk()'s to our #DB handler (6) the program will
> magically work again.

I added some trace_printk()'s and I think the #DB handler is calling
schedule????

exc_debug_user()
  irqentry_exit_to_user_mode()
    exit_to_user_mode_prepare()
      exit_to_user_mode_loop()
        schedule()

So #DB schedules out, then the process scheduls in and tells ptrace to
set the data breakpoint in DR7.  Then the #DB handler schedules back in
and overwrites DR7 with the original value.

What amazes me is that it successfully schedules back to the end of the
#DB handler finish and everything keeps working.

Do we not have assertions in the scheduler to catch this?

-- 
Josh

