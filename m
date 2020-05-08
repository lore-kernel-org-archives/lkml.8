Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D50FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02390208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KaviCZs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbgEHIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:50:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E261C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+1tEAOhXwR/61ofjbRaYkL5ORf3axWauPvShyvvL4s=; b=KaviCZs96c2geYi33EX+zLup5l
        8YwsL37kMAZWZy7ebN0+E2jiaNT2lJRQ4zqIAlityiyxLRJ3iZxrS4kvSvHpe6moi2mfkN9DJ8W1d
        36qPkzYWfmEuzlZIKmgEUtdSSqLVS2efb0p1fcktfXE8v4u2CX6mvkoGp0hwlApLwJp6uv3T1vrrv
        cacMElbAEKZfKugeExS+HyUtXIwpL9A7QONIMDi2j5WO0zNA7R22cgbbKSHM0bcZepYq0q0ckc4Vj
        8vtzie7x13ZPGBoRbbAfW1l+jgRkcOBLpoXWqHIFOJHYjb4ucozLVQbVtA4Y8DlVmTSpGyM6jd3g1
        9r0tco8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyho-0002b8-F2; Fri, 08 May 2020 08:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC9B83012DC;
        Fri,  8 May 2020 10:50:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 987BD2B93BDC1; Fri,  8 May 2020 10:50:02 +0200 (CEST)
Date:   Fri, 8 May 2020 10:50:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 35/36] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200508085002.GT5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134101.525508608@linutronix.de>
 <CALCETrXfemPJrVx+Nfp7k_PvKGezSK46_+dL5oNNV3o5i1qWVw@mail.gmail.com>
 <1603808584.1778.1588875478687.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603808584.1778.1588875478687.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 02:17:58PM -0400, Mathieu Desnoyers wrote:
> ----- On May 7, 2020, at 2:04 PM, Andy Lutomirski luto@kernel.org wrote:
> 
> > On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> From: Peter Zijlstra <peterz@infradead.org>
> >>
> >> A few exceptions (like #DB and #BP) can happen at any location in the code,
> >> this then means that tracers should treat events from these exceptions as
> >> NMI-like. The interrupted context could be holding locks with interrupts
> >> disabled for instance.
> >>
> >> Similarly, #MC is an actual NMI-like exception.
> > 
> > Is it permissible to send a signal from inside nmi_enter()?  I imagine
> > so, but I just want to make sure.
> 
> If you mean sending a proper signal, I would guess not.
> 
> I suspect you'll rather want to use "irq_work()" from NMI context to ensure
> the rest of the work (e.g. sending a signal or a wakeup) is performed from
> IRQ context very soon after the NMI, rather than from NMI context.
> 
> AFAIK this is how this is done today by perf, ftrace, ebpf, and lttng.

What Mathieu says. But I suspect you want to keep reading until
part4-18. That should get you what you really want.
