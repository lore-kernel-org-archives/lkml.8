Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E89C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470EE20708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Tx7Jh+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgEFPw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgEFPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:52:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9748C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9Ofom/V/5JWGYf5Urppy3ErnpSNhHqm9qgBkF/mkejk=; b=0Tx7Jh+bulUD0eq5XJo4Y4mPn2
        8GsEmjUE4CJ5Y1E8cmncn924gr8CedEhbQX4znZJCmHBk9nO1CDW06Mp7NCGtAmXgWf0F6eWwoLln
        eWa9BzQDboq0GmNxMv73LTc1/4wDSj2H9Ck4wCmuBDwTtUTeRBCDqd7U/5D3yv9hTsdgaxnxMXzW7
        n5of1rp41i+LShr+HGWVrXIFsmvuW3aiScLLBUCJ4eIxsfeWdX7RNw84kthQYZQmjOCui96tobtWO
        FXHF43/QuJh+EKNca5lF7vV+L5VdoCyawGdCSnVHq+XlVnBlaeJjwDcXSdaiEE5fBH6JgAAu/du18
        caIrG7jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWMKs-0005Hy-MP; Wed, 06 May 2020 15:51:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 275FE30018B;
        Wed,  6 May 2020 17:51:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2F5D203ECDC2; Wed,  6 May 2020 17:51:48 +0200 (CEST)
Date:   Wed, 6 May 2020 17:51:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
Subject: Re: [patch V4 part 2 01/18] x86/entry/64: Move non entry code into
 .text section
Message-ID: <20200506155148.GF5281@hirez.programming.kicks-ass.net>
References: <20200505134112.272268764@linutronix.de>
 <20200505134340.227579223@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134340.227579223@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:41:13PM +0200, Thomas Gleixner wrote:
> All ASM code which is not part of the entry functionality can move out into
> the .text section. No reason to keep it in the non-instrumentable entry
> section.

Just to note to self (or others), I'm planning to move all this into
arch/x86/kernel/kernel.S (bike-shed away) sometime after all this lands.
These things simply do not belong in entry.S at all.
