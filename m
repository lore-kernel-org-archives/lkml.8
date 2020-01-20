Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDADDC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03E722527
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579551840;
	bh=MGYF9sxyULgvtOFmV1/7xXzuS/dRJ0cOB18po2SSB88=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vjCqOWhb7bo9IZomzCrGf1nJfePalIQ1gN+WOrjdXBAJwsJf8DwVR+E3vy1kM9eUX
	 n8fyaGWyoAXuw5kK6FhZSYsrqEOo2NsVtDgusVPZFEoy+Y72uJnmNpRAq9JMJHZoWW
	 6C4OdKip0KSpp1fxu/FnE+2OCp+ekOEbWW5VV3Xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgATUYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:24:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgATUX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:23:59 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602D1217F4;
        Mon, 20 Jan 2020 20:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579551839;
        bh=MGYF9sxyULgvtOFmV1/7xXzuS/dRJ0cOB18po2SSB88=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Trz8UogvdPwi2ySUu9Nwbjk2CqLrbqnWjTsaoea8dGq5C83+UM6VoeRaX+AQNMkUp
         SiXDMwHuve0psLIHdw4GzPXzs4DEjX/uLdXjOaZHmNw2lQy8w3j6DEckWRLepiYhG6
         pUISqZizIio+gthN/zSK0TpC61CAB9lNZnhUyJLY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A1093522745; Mon, 20 Jan 2020 12:23:59 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:23:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>, andreyknvl@google.com,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org, boqun.feng@gmail.com, arnd@arndb.de,
        viro@zeniv.linux.org.uk, christophe.leroy@c-s.fr, dja@axtens.net,
        mpe@ellerman.id.au, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@kernel.org, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, cyphar@cyphar.com, keescook@chromium.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/5] asm-generic, kcsan: Add KCSAN instrumentation for
 bitops
Message-ID: <20200120202359.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200120141927.114373-1-elver@google.com>
 <20200120141927.114373-3-elver@google.com>
 <20200120144048.GB14914@hirez.programming.kicks-ass.net>
 <20200120162725.GE2935@paulmck-ThinkPad-P72>
 <20200120165223.GC14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120165223.GC14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:52:23PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 20, 2020 at 08:27:25AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 20, 2020 at 03:40:48PM +0100, Peter Zijlstra wrote:
> > > On Mon, Jan 20, 2020 at 03:19:25PM +0100, Marco Elver wrote:
> > > > Add explicit KCSAN checks for bitops.
> > > > 
> > > > Note that test_bit() is an atomic bitop, and we instrument it as such,
> > > 
> > > Well, it is 'atomic' in the same way that atomic_read() is. Both are
> > > very much not atomic ops, but are part of an interface that facilitates
> > > atomic operations.
> > 
> > True, but they all are either inline assembly or have either an
> > implicit or explicit cast to volatile, so they could be treated
> > the same as atomic_read(), correct?  If not, what am I missing?
> 
> Sure, but that is due to instrumentation requirements, not anything
> else.
> 
> Also note the distinct lack of __test_bit(), to mirror the non-atomic
> __set_bit() and __clear_bit().

OK, I will bite.  ;-)

We also don't have __atomic_read() and __atomic_set(), yet atomic_read()
and atomic_set() are considered to be non-racy, right?

							Thanx, Paul
