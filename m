Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B605C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE338206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OUfKFlq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgEFPnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:43:30 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89466C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u0YYQVhXHIfbmlhXLAhGQg38u9gDWp5ox/okKq13K8o=; b=OUfKFlq6LEbAWFZ4LFm1/8+tyI
        v4rKG3i2JovGGiqaFe7jeDDqBOHxQ5GGGgMUFr148kvnwrwpPyAVyQiDHafaedS8a2E3Cp4ZWwyJP
        HAG+K/0YNGUR9mRMNMxfjRRQlBHn0W+VcZM6+/cw8rb8t9oQUfZ4KYZI0aszs8AnkLlxb9VngHxKW
        ZY55PITShy8720SXMnrwCJNP8z9fM8W6ziVn/FBb0iWlUbfffPlaTYX08YDmASoL3h79Wh6nb3OPx
        VPj7gHO0jP8NcErmy+B6Zlfqz0I8TFaKtcKpv8/bysEEUKR5Oy4Qzbss4E46mFWWWLwTy9Hj0ixBa
        N8BPgiYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMCF-00052X-U8; Wed, 06 May 2020 15:42:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07543301DFC;
        Wed,  6 May 2020 17:42:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E983B203ECDC0; Wed,  6 May 2020 17:42:53 +0200 (CEST)
Date:   Wed, 6 May 2020 17:42:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 19/36] x86/entry: Exclude low level entry code
 from sanitizing
Message-ID: <20200506154253.GE5281@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.970057117@linutronix.de>
 <CAMzpN2i9bZhxagk1dNhHpZmYyHjNiPQU_yRmwY9y85LemkNFNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzpN2i9bZhxagk1dNhHpZmYyHjNiPQU_yRmwY9y85LemkNFNw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:39:01PM -0400, Brian Gerst wrote:
> On Tue, May 5, 2020 at 10:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > The sanitizers are not really applicable to the fragile low level entry
> > code. code. Entry code needs to carefully setup a normal 'runtime'
> > environment.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/entry/Makefile |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > --- a/arch/x86/entry/Makefile
> > +++ b/arch/x86/entry/Makefile
> > @@ -3,6 +3,14 @@
> >  # Makefile for the x86 low level entry code
> >  #
> >
> > +KASAN_SANITIZE := n
> > +UBSAN_SANITIZE := n
> > +KCOV_INSTRUMENT := n
> > +
> > +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
> > +CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
> > +CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
> 
> Is this necessary for syscall_*.o?  They just contain the syscall
> tables (ie. data).

Proabaly not, but I just made sure to kill everything, less chance an
accident happens.
