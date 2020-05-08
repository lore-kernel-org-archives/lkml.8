Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BDBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EAE208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eOw5+0bJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgEHIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEHIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:40:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0607C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PXrV0xYDcwWffKlCqKyNIQPeMAzYFVJQBcqnnwwuGo0=; b=eOw5+0bJSMC/+bRVooGbVJ25A/
        ujWx6DoZVNs3rxAaDrEXkdhkMKxJGAANrWJH3BdrxYVnRo8MH1Q02Lsi+sJZ0iZT5hhvIUX2SaMNa
        bg1O0RZuXcz8dX47wmopqGQA7z5o3X/gkae1OPbab7Zd0oGR5EsNIKonJU6nUUzkQCiEpVbl6KFxy
        1SUTOiPrQzzOVh8hwkjcC2y6HwhApt/5oCO39yXmZWhZDOdRkX0v0m7fxpC43Tti1j/FoAKk13duI
        KtWpbyAwIWqknvf6fNbZZRVEj4VtT8Zq8f1DUXBy8M/GYq5dP8LtFCSQayJtlTailkRqzAlk7GH++
        nVp4c0Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyYD-0004Fu-Ji; Fri, 08 May 2020 08:40:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7277B301E02;
        Fri,  8 May 2020 10:40:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AD7C2038FB82; Fri,  8 May 2020 10:40:07 +0200 (CEST)
Date:   Fri, 8 May 2020 10:40:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
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
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [patch V4 part 1 07/36] locking/atomics: Flip fallbacks and
 instrumentation
Message-ID: <20200508084007.GQ5298@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.769149955@linutronix.de>
 <20200507194127.262bc543@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507194127.262bc543@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:41:27PM -0400, Steven Rostedt wrote:
> On Tue, 05 May 2020 15:16:09 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > Currently instrumentation of atomic primitives is done at the
> > architecture level, while composites or fallbacks are provided at the
> > generic level.
> > 
> > The result is that there are no uninstrumented variants of the
> > fallbacks. Since there is now need of such (see the next patch),
> 
> Just a comment on the change log. Can we avoid saying "see the next patch"?
> A few years from now, if we stumble on changes in this commit and need to
> see that next patch, if something happened to lore, it may be difficult to
> find what that next patch was.

Even I can get git-log to tell me what the next patch is, and I'm an
absolute disaster with git. But yes, valid point.

> But saying that patch's subject, would be
> just a simple search in the git history.
> 
> That said, looking at "the next patch" which is "x86/doublefault: Remove
> memmove() call", does that patch really have a need for such?

No, the next patch was part4-2, so it already isn't accurate.
