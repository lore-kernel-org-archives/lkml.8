Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DF82054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xs2/7IIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgHTQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHTQfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:35:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF61C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v6s2A+JSqWJPzSwI5rBekbsr39F4L/vyOyCnBGRLWAk=; b=Xs2/7IIQoOkB61oMa6gfqIYs/s
        kuI1fdOQ8sgMANLILrzlg1+Zawa3CJ0x6s1qI8qsQVxUvrX43uv+HvMIeT2aUXYL0x+f21nMQvicc
        NGVhfvh/dHLfqimMQvZQQbSTChWaDtketU64pscLBeVs8NDxIzEG6lAd3sl/5cFgX7ye7542P6GRu
        Sd0MXQ7qdnXULGkQ+XwUp+YdzBoOrns71kmTV4jCPFndH/o7u9XD/szuQn8oEfCGSYQvIYX/5EScu
        Y72VArJwjAPuYDhYR1Kgl0upBjzLMgwpgPUFZxbRYdirN+C63GiM3V6LmpkxDwdqFT41Jnmt9Zh6f
        +AA5V2Dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8nWj-00025S-8v; Thu, 20 Aug 2020 16:34:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 117E3302526;
        Thu, 20 Aug 2020 18:34:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E8BD32BE18A13; Thu, 20 Aug 2020 18:34:53 +0200 (CEST)
Date:   Thu, 20 Aug 2020 18:34:53 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
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
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820163453.GE1362448@hirez.programming.kicks-ass.net>
References: <20200820103832.486877479@infradead.org>
 <20200820104905.294802764@infradead.org>
 <CAMzpN2gmCu0q_8gLAOcSuLjpKF+rNj=wiCFsGZXgNwz000HCvg@mail.gmail.com>
 <20200820150841.GB1362448@hirez.programming.kicks-ass.net>
 <20200820151659.b7q7hspe5zsf46eg@treble>
 <20200820152111.GC1362448@hirez.programming.kicks-ass.net>
 <20200820161729.cxzjsdqtgr6vktqx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820161729.cxzjsdqtgr6vktqx@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:17:29AM -0500, Josh Poimboeuf wrote:
> On Thu, Aug 20, 2020 at 05:21:11PM +0200, peterz@infradead.org wrote:

> > qemu-gdb stub should eat the event before it lands in the guest
> 
> Are we sure about that?  I triggered the warning just now, stepping
> through the debug handler.

Not sure at all, that's what seemed reasonable, but since when did that
stop virt ;-)

Also, can you trigger that same with upstream? Because I suspect this
ought to tickle the old code too.
