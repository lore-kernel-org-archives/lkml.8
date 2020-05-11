Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24638C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F372E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hqEfK482"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgEKOOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730180AbgEKOOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:14:34 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E712C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T9Qnr/2MzlWVnks5PwjcDz5PI6t5JFXZYCHiiiwBn94=; b=hqEfK482wRokrGdrAabZBo4Dn6
        H0k1Bbwg0Vi08tsmwkQG+EteB+nkAOP2QTEIkjj6zeBYQ0/777WpIlSS9lzfGgDBeQIOmXDYMbbWX
        YtFu681uKQlUn1xvGn2UYqjl0ZYSg24rALU3Km+xSD0EEaTc4rVNG6uSYu3r55wvhdBzr5Aqq7KfU
        Io9bWaAxMDtaK0sSULhOtQtCePnYNi7v2CmOD1byl9nyx+qBCVHu6X/DxRIMPiF7UKt+Ow+yhf5Zn
        BI1R2bVQFU4TkfoTvXgPQggiIVNQ3rWrnB/J3sZS5jreNAM3qK07Ik/TwbApdiTBbq0qSJ4sAomnF
        aD9u7ziQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jY9Bn-0008Hp-90; Mon, 11 May 2020 14:13:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6D007301EFB;
        Mon, 11 May 2020 16:13:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCA4D2870CB3F; Mon, 11 May 2020 16:13:48 +0200 (CEST)
Date:   Mon, 11 May 2020 16:13:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Subject: Re: [patch V4 part 5 07/31] x86/entry: Provide
 idtentry_entry/exit_cond_rcu()
Message-ID: <20200511141348.GH2957@hirez.programming.kicks-ass.net>
References: <20200505135341.730586321@linutronix.de>
 <20200505135828.808686575@linutronix.de>
 <72cb3e24-3f82-7e2a-7630-233749c780c4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72cb3e24-3f82-7e2a-7630-233749c780c4@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 03:53:17PM +0200, Alexandre Chartre wrote:
> 
> On 5/5/20 3:53 PM, Thomas Gleixner wrote:
> > The pagefault handler cannot use the regular idtentry_enter() because on
> > that invokes rcu_irq_enter() the pagefault was caused in the kernel.
> 
> I am struggling to understand this part of the sentence: "because on
> that invokes rcu_irq_enter() the pagefault was caused in the kernel."
> 
> Do you mean: "because that invokes rcu_irq_enter() if the pagefault was
> caused in the kernel." ?

The problem is that rcu_irq_enter() uses per-cpu state and expect
rcu_irq_exit() to be called on the very same cpu we did enter on.

However, #PF likes to schedule and breaks that expectation.

While there are more exceptions that schedule when from userspace, #PF
is the only one that does so when from kernel space, which makes is
'special'.
