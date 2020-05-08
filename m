Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0768EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61972083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9gNKQtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgEHRMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:12:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgEHRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588957933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8+r27QEVc922AMQwlflZfe/5bYEencNqgqRoffWDxwc=;
        b=K9gNKQtP6STRKkwTw0EqAHYUC4ifN//pUZtMRIGEsfe00Eh8AWOEtfdv1vQMqsLhR7kaYo
        KhYzaNyfWl9t9v3x8YiRnK9aEjnO7fqhMYLw2Mj8QzX/5V9R9qwtVDfRmLtagVN3RU0C2m
        EA6RW678Gtd9GHz8Zr/hMNjZpxcM+Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-fqwc1f5WMGS_lRcgvfSCyg-1; Fri, 08 May 2020 13:12:12 -0400
X-MC-Unique: fqwc1f5WMGS_lRcgvfSCyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82BB8107BEFE;
        Fri,  8 May 2020 17:12:09 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06EF810016E8;
        Fri,  8 May 2020 17:12:05 +0000 (UTC)
Date:   Fri, 8 May 2020 12:12:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>, Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 35/36] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200508171203.kjhpk4c6zo3xy3ci@treble>
References: <20200505131602.633487962@linutronix.de>
 <20200505134101.525508608@linutronix.de>
 <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
 <1603808584.1778.1588875478687.JavaMail.zimbra@efficios.com>
 <20200508085002.GT5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508085002.GT5298@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:50:02AM +0200, Peter Zijlstra wrote:
> On Thu, May 07, 2020 at 02:17:58PM -0400, Mathieu Desnoyers wrote:
> > ----- On May 7, 2020, at 2:04 PM, Andy Lutomirski luto@kernel.org wrote:
> > 
> > > On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >>
> > >> From: Peter Zijlstra <peterz@infradead.org>
> > >>
> > >> A few exceptions (like #DB and #BP) can happen at any location in the code,
> > >> this then means that tracers should treat events from these exceptions as
> > >> NMI-like. The interrupted context could be holding locks with interrupts
> > >> disabled for instance.
> > >>
> > >> Similarly, #MC is an actual NMI-like exception.
> > > 
> > > Is it permissible to send a signal from inside nmi_enter()?  I imagine
> > > so, but I just want to make sure.
> > 
> > If you mean sending a proper signal, I would guess not.
> > 
> > I suspect you'll rather want to use "irq_work()" from NMI context to ensure
> > the rest of the work (e.g. sending a signal or a wakeup) is performed from
> > IRQ context very soon after the NMI, rather than from NMI context.
> > 
> > AFAIK this is how this is done today by perf, ftrace, ebpf, and lttng.
> 
> What Mathieu says. But I suspect you want to keep reading until
> part4-18. That should get you what you really want.

LALALALA

At least give a spoiler alert for those of us still enjoying part 1!

-- 
Josh

