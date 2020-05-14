Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE54C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E012065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RcKHDjZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgENJdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:33:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75859C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cVHXoLB2mKPJ84h2fIyDOysMGSEkFTC+SjVjPPzZLB4=; b=RcKHDjZAzs8ZFQuurs9chdvEMs
        Ug3zPq0RzbPHbGa65zKp4w3X5G10dMdyurJesgWwc/d5hzxl8wAX1JAIpAOcGvsToBopebGu2j8ar
        LErFASg53ubd4FBnlXOHGsaCgGS3nYRcN7Fl9CtlB3mfLAmApp3uaFU30NFMRax4h+MyphZK5Rxk+
        3UVOHv4Xb+HC/Kdjoru9eIptT2B0k1G/At6rkuDumsIDsv7BbRmSC1xHAMOdz6eKdDUJ1Ems0l/Nb
        AqggijEUCueqTIqbh3Pn7UxLijTGh+ZxjPWj0i3PK5bQ9TFz83TIgs9yUvwWrwjFJHuUiWzltxKQV
        rof4KKPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZAEe-0002Vl-Np; Thu, 14 May 2020 09:33:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 229B0301A66;
        Thu, 14 May 2020 11:32:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF06D213C8B59; Thu, 14 May 2020 11:32:57 +0200 (CEST)
Date:   Thu, 14 May 2020 11:32:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
Message-ID: <20200514093257.GT2978@hirez.programming.kicks-ass.net>
References: <20200505134926.578885807@linutronix.de>
 <20200505135313.517429268@linutronix.de>
 <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 09:57:52PM -0700, Andy Lutomirski wrote:
> On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> > Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
> > creeps in and ruins things.
> >
> > That is; this is the INT3 text poke handler, strictly limit the code
> > that runs in it, lest it inadvertenly hits yet another INT3.
> 
> 
> Acked-by: Andy Lutomirski <luto@kernel.org>
> 
> Does objtool catch this error?

It does not. I'll put it on the (endless) todo list..
