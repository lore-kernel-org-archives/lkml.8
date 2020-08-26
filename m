Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E79C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681A7207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598476893;
	bh=wP47mPmI4+nLi8j+Dv3UaXk1NT7veGFnDPlvz/jc1qg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=slVGWvrzL2HxQRU+KLG7B+koMBhMddU1MFsxz6L6xNjWfzxfrDskaUDTiveMSTTPo
	 TnuIltFAUc7VX+nxWLIwnC/gDKzkvg7j2kacppKhRTHEbFMj2j0UkSzZT9zfmgEX9h
	 XZoKPdAmB2Y+yUdIVVd9dWQ1WzoEPKSLQZRqXSFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHZVVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgHZVVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:21:31 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D67F920737;
        Wed, 26 Aug 2020 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598476890;
        bh=wP47mPmI4+nLi8j+Dv3UaXk1NT7veGFnDPlvz/jc1qg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G5eB9+PtcxVan0hnnfXfHh8RnNffxhAqEgx5H++6bGZERQb7dX7JLPTGYxjLaw7Hn
         4Zlfp8cwdQtXKO7bkPsQY0/TgTCb6o97bi1g7HljqojOzdtmXKaYRLaUNGP78ALYzh
         clon7yQgREIVP44CoRYTmYS8Qj+TiNfWv8BhPoXk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF6FA35226D9; Wed, 26 Aug 2020 14:21:30 -0700 (PDT)
Date:   Wed, 26 Aug 2020 14:21:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Use tracing-safe version of prandom
Message-ID: <20200826212130.GU2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200821123126.3121494-1-elver@google.com>
 <CANpmjNMLL+Xqg0MQrtBMxLunUGXVP-mAXKqRH5s0xNSfAUhrzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMLL+Xqg0MQrtBMxLunUGXVP-mAXKqRH5s0xNSfAUhrzg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 02:17:57PM +0200, Marco Elver wrote:
> On Fri, 21 Aug 2020 at 14:31, Marco Elver <elver@google.com> wrote:
> > In the core runtime, we must minimize any calls to external library
> > functions to avoid any kind of recursion. This can happen even though
> > instrumentation is disabled for called functions, but tracing is
> > enabled.
> >
> > Most recently, prandom_u32() added a tracepoint, which can cause
> > problems for KCSAN even if the rcuidle variant is used. For example:
> >         kcsan -> prandom_u32() -> trace_prandom_u32_rcuidle ->
> >         srcu_read_lock_notrace -> __srcu_read_lock -> kcsan ...
> >
> > While we could disable KCSAN in kcsan_setup_watchpoint(), this does not
> > solve other unexpected behaviour we may get due recursing into functions
> > that may not be tolerant to such recursion:
> >         __srcu_read_lock -> kcsan -> ... -> __srcu_read_lock
> >
> > Therefore, switch to using prandom_u32_state(), which is uninstrumented,
> > and does not have a tracepoint.
> >
> > Link: https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com
> > Link: https://lkml.kernel.org/r/20200820172046.GA177701@elver.google.com
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > Applies to latest -rcu/dev only.
> >
> > Let's wait a bit to see what happens with
> >   https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com,
> > just in case there's a better solution that might make this patch redundant.
> 
> Paul, feel free to pick this up.
> 
> I wanted to wait until after plumbers to see what happens, but maybe
> it's better to give the heads-up now, so this is in time for the next
> pull-request. It seems that prandom_u32() will keep its tracepoint,
> which means we definitely need this to make KCSAN compatible with
> tracing again.

Queued and pushed, thank you!

							Thanx, Paul
