Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DFAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D9B20A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJNoq/YX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgEFPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbgEFPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:36:17 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lkbi0V0mxfen0EUXPkli1HhZu245Pv1mIUCvQhgJgMQ=; b=nJNoq/YXU6Bid3fUxuDaOdV4dQ
        CQKWe6bkZ1bVvgCSRA3TprhJ7SCivVITZ9SkaJrdonM7ZvzU32OhiV6NOG+nhu83Ml/jOM3HZa15n
        PnUN/JrAvbRTvLteVPibhj/iT4UY6RUxAF+xR+lhJq+BGIDFmqxCLa7Nz6NItpH4GjETCIAfnwJpf
        BOEWIv9DMwyogJHsD085Gc4lvpzbJGgEdTGnfOdTm6ybRzU9tWZronacdz4mtusVUnWmGTxmGRtIY
        Z/ewislj2uMEZ4Xlmb+KMtrsNaTAML9qSYyN9xEYXJd7u9o2ivc8YpTwNajqXUksXVnMcVadyqjxV
        6LzAzJig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWM55-0004n1-Gw; Wed, 06 May 2020 15:35:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 491B1301EFB;
        Wed,  6 May 2020 17:35:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97AC6203ECDC3; Wed,  6 May 2020 17:35:28 +0200 (CEST)
Date:   Wed, 6 May 2020 17:35:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
Message-ID: <20200506153528.GC5281@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.560059744@linutronix.de>
 <alpine.LSU.2.21.2005061352050.20724@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2005061352050.20724@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 01:53:36PM +0200, Miroslav Benes wrote:
> On Tue, 5 May 2020, Thomas Gleixner wrote:
> 
> > Make sure task_work runs before any kind of userspace -- very much
> > including signals -- is invoked.
> 
> I might be missing something, but isn't this guaranteed by 
> do_signal()->get_signal()->task_work_run() path?

Yes, that too, that 'hack' can now be removed I suppose.
