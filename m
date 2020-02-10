Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFD0C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051C720842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581358070;
	bh=1sM8AtptlQsckSDtBEnBFE9IPZB3fksS+0HDhGJ+dJg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=OWUqhzIiM2YF5TpWPEJOAz2kBa5xwZt/plXNVj+rszzE/kho9so3fN1PWPV2n8gHD
	 d1S55UW/Pc5rOaGY4/hGkcdmgQK9JSzJeF+7x0X3m1aE1cMt+JEKlxwOg1OHHZihcL
	 Si26m//5m0+wAeLcPM2BKm/jbc6ZA2trzUKFp8Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBJSHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:07:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgBJSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:07:48 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E09A2085B;
        Mon, 10 Feb 2020 18:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581358067;
        bh=1sM8AtptlQsckSDtBEnBFE9IPZB3fksS+0HDhGJ+dJg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cMOKQJdxaFxq2ApEmJf1PevgGmgXVE5jrc8R0UHdtCxG20ESA9LmVsB2LRNB90GMy
         VFrD6TrDPR8bH+erOL53KbkKprziQGU4GdhWULCffOCsFJrw3P9eMU3cQxMZt6rSD8
         B8dtKhbJbAx8v3aAYc7gldjffniXgQC1jeJDnNoA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DF6A13522700; Mon, 10 Feb 2020 10:07:45 -0800 (PST)
Date:   Mon, 10 Feb 2020 10:07:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210180745.GA4947@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
 <20200210120552.1a06a7aa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210120552.1a06a7aa@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:05:52PM -0500, Steven Rostedt wrote:
> On Mon, 10 Feb 2020 10:46:16 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Furthermore, using srcu would be detrimental, because of how it has
> > smp_mb() in the read side primitives.
> 
> I didn't realize that there was a full memory barrier in the srcu read
> side. Seems to me that itself is rational for reverting it. And also a
> big NAK for any suggestion to have any of the function tracing to use
> it as well (which comes up here and there).

Yeah, that was added some years back when people were complaining about
three synchronize_sched()'s worth of latency for synchronize_srcu().

I did prepare a patch about a year ago that would allow an srcu_struct
to be set up to not need the read-side smp_mb() calls, but this means
longer-latency grace periods (though nowhere near as long as those of
synchronize_rcu_tasks()) and also that the "fast SRCU" readers cannot
be used from idle or offline CPUs.

But an easy change if it is useful.

							Thanx, Paul
