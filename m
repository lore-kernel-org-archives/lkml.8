Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E40C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A7020829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589781071;
	bh=dz1NLA05YEt3Wk/LMdrxBkIZ9j2HNwOH9sYub6ThKBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P4o0IWhq+VRV7JF9HL3RYkQOuwPvJOtoIczDxrIzrO/MLfuLsiHmwZUqDAPoeOx+f
	 38hyOCH4hG8vTT/BLOfg4xlMilKLdiEMET8vp9n2FlbpS/rFRvbXM4ZWKWeDWz8dOg
	 yrf0wjpBy3umSoPiXu1oJXR4DtCY4WKWHHEflF1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgERFvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbgERFvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:51:10 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B4A20829
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589781069;
        bh=dz1NLA05YEt3Wk/LMdrxBkIZ9j2HNwOH9sYub6ThKBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OMZgNa7serQ3AlhQ0KLdX6Q8iUMPXb89N8zTspXY5UZVzChoffmff75OcdhqnvTPh
         /iuOT/Kqk4k7ef40PAqDLVuHZA2mJMNz7MGWPchUX+Z77nBjlkga82RuIBCpWx3J/v
         OHam1f+0Jkt9eCmaTPF0w6/Q7p9+w63OWi65mF0k=
Received: by mail-wm1-f50.google.com with SMTP id z72so8814979wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:51:09 -0700 (PDT)
X-Gm-Message-State: AOAM531eubBHPUuu5OB6yuvtFb81KUY48R/I7MwKV4tgcjEXZI4uzLCs
        Ze3BLV4QkylLV2duJ/dmQddHWco9iR+TPn3DtheyBQ==
X-Google-Smtp-Source: ABdhPJyqFopkK20thpxTyZ8lo46k/gI4305XQCWQEex4ptyAQFZbCktv0aHklGx7jYTx+eQyaDZBmXgbAb0iqg/bk3A=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr17514996wmf.138.1589781068047;
 Sun, 17 May 2020 22:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235124.783722942@linutronix.de>
 <CALCETrW2negGYRSQ8dqFVdiWGtYpYf6nKe5_hkotNv0e5mNBxA@mail.gmail.com> <87zha7c5h5.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zha7c5h5.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 17 May 2020 22:50:56 -0700
X-Gmail-Original-Message-ID: <CALCETrVuA25n_d-3KMvvDxuqZeBEEYb6n=QAXOhBFkgS1Dk+UA@mail.gmail.com>
Message-ID: <CALCETrVuA25n_d-3KMvvDxuqZeBEEYb6n=QAXOhBFkgS1Dk+UA@mail.gmail.com>
Subject: Re: [patch V6 04/37] x86: Make hardware latency tracing explicit
To:     Thomas Gleixner <tglx@linutronix.de>
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 1:48 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >>
> >> The hardware latency tracer calls into trace_sched_clock and ends up in
> >> various instrumentable functions which is problemeatic vs. the kprobe
> >> handling especially the text poke machinery. It's invoked from
> >> nmi_enter/exit(), i.e. non-instrumentable code.
> >>
> >> Use nmi_enter/exit_notrace() instead. These variants do not invoke the
> >> hardware latency tracer which avoids chasing down complex callchains to
> >> make them non-instrumentable.
> >>
> >> The real interesting measurement is the actual NMI handler. Add an explicit
> >> invocation for the hardware latency tracer to it.
> >>
> >> #DB and #BP are uninteresting as they really should not be in use when
> >> analzying hardware induced latencies.
> >>
> >
> >> @@ -849,7 +851,7 @@ static void noinstr handle_debug(struct
> >>  static __always_inline void exc_debug_kernel(struct pt_regs *regs,
> >>                                              unsigned long dr6)
> >>  {
> >> -       nmi_enter();
> >> +       nmi_enter_notrace();
> >
> > Why can't exc_debug_kernel() handle instrumentation?  We shouldn't
> > recurse into #DB since we've already cleared DR7, right?
>
> It can later on. The point is that the trace stuff calls into the world
> and some more before the entry handling is complete.
>
> Remember this is about ensuring that all the state is properly
> established before any of this instrumentation muck can happen.
>
> DR7 handling is specific to #DB and done even before nmi_enter to
> prevent recursion.

So why is this change needed?
