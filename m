Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E464AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5202065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U4jpM5eg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgENJUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:20:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21019C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/uwK69cKvIIvKOO5ymbYqzBNjG47n+IyGnvHw5vJrl0=; b=U4jpM5egpZ5/F/T2TZKbxuiiMB
        kGuNxkxBQX50aexS/vNQcdKYfMcMk5FcXYzlSSvUv90v4fMYALjiVnyRPZz6KEZUU4Cy6kJ+aHM4/
        Uvmi5y6228cvJvA6OyzsB8sQSgC3XtT6ER7lG8pDpXtiApswWFfb1gwo6Ar0wHhhl8W52j1uy5wIQ
        boVDvMxTIcxxYneZMAxQmEbe8qK0hZHF40KYTz3Ht9D4F93WPiRaMZeWCkSnH8+i+3+xgbltYArkx
        6RdAIc9iqbsmHOvbpZCh9TsCtSpgmfAtTK0tQtHMvLxEFSH+yx2S5QYpjat3P0vwioegH4lzn8jov
        XUmy0IEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZA1m-0005lb-Gc; Thu, 14 May 2020 09:19:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 74E72301205;
        Thu, 14 May 2020 11:19:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 47CF724C14F19; Thu, 14 May 2020 11:19:40 +0200 (CEST)
Date:   Thu, 14 May 2020 11:19:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
Message-ID: <20200514091940.GS2978@hirez.programming.kicks-ass.net>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.560059744@linutronix.de>
 <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com>
 <20200513171047.04c2c10e@gandalf.local.home>
 <87v9kzz862.fsf@nanos.tec.linutronix.de>
 <1779765540.20682.1589424713646.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1779765540.20682.1589424713646.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:51:53PM -0400, Mathieu Desnoyers wrote:

> Yes, I'm very well aware of this. But the patch commit message states:
> 
> "Make sure task_work runs before any kind of userspace -- very much
> including signals -- is invoked."
> 
> which seems to imply that "userspace" can be "invoked" before the task_work
> runs. Which makes no sense whatsoever. Hence my confused state.

I initially missed the run_task_work in the signal handling maze. Then
later figured this order still made more sense, but apparently there's
an actual problem.

I've no problem with the patch getting dropped.
