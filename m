Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD51C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D5C2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bOCaQdvF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCLNx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:53:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y2yCU3lEqWiUy5deENEWrtQFGN8rUc5B/pd3ZvWDG1Q=; b=bOCaQdvFQPWcZyPG74rxIHya0M
        NSSnZ8bp91G2eCAtSq3NsCS+68qay12cItBlPavpzUq7KQi+NZA/BnmC3ki4L4oD0NhpJEE/DpFDg
        WRYwbvjGTfFUjArNRFW5A7MZYfTjXCGBHWj2LQXAKIDgiH6qhC75dRibHJcwo8OItP0xhQAXvxEz1
        xamMneohPzfF2RJhtz6i8+QLvY1rqQlCIlka1O/dsaREfq5iAoS6DxROyvU3V6A1EPCkqzhypzl1s
        77vC7cag1uwYR4PtYxRGaQM5Dwj1EfP2jd+fAgG3cSwc4DQEuF0HKHxhRgUBGLdpvE9K3B4O71kHk
        OQGlNktw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOHN-0003I5-1v; Thu, 12 Mar 2020 13:53:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 67DDD305E21;
        Thu, 12 Mar 2020 14:53:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35CDD2010F0F5; Thu, 12 Mar 2020 14:53:39 +0100 (CET)
Date:   Thu, 12 Mar 2020 14:53:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200312135339.GS12561@hirez.programming.kicks-ass.net>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
 <20200309141546.5b574908@gandalf.local.home>
 <87fteh73sp.fsf@nanos.tec.linutronix.de>
 <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
 <87pndk5tb4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pndk5tb4.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:43:27PM +0100, Thomas Gleixner wrote:
> That's why we want the sections and the annotation. If something calls
> out of a noinstr section into a regular text section and the call is not
> annotated at the call site, then objtool can complain and tell you. What
> Peter and I came up with looks like this:
> 
> noinstr foo()
> 	do_protected(); <- Safe because in the noinstr section
> 
> 	instr_begin();	<- Marks the begin of a safe region, ignored
>         		   by objtool
> 
>         do_stuff();     <- All good   
> 
>         instr_end();    <- End of the safe region. objtool starts
> 			   looking again
> 
>         do_other_stuff();  <- Unsafe because do_other_stuff() is
>         		      not protected
> and:
> 
> noinstr do_protected()
>         bar();		<- objtool will complain here
> 
> See?

Find here:

  https://lkml.kernel.org/r/20200312134107.700205216@infradead.org
