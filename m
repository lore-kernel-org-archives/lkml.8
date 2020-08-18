Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856FEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D572067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597768108;
	bh=WoGVZDwIK/F9JyxPbF1fAg8BjUCeVwwHlyHeaJ96uK8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TzqPvlOGgUXU0QcPeUIVkCXqMFsBvYpsGst90++LBD8DdVph/QvKt3PxRcQ8jJFjr
	 7jZUVLE7DuunXvLzP1P7BD4PfLJuBucND6BMm7ZX5x0qb03KrTJ3FeIlxN/V6aRDdo
	 Dq+CoH+m1uwTywgBl9CDgCBmJEJviKkSDax2noYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHRQ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgHRQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:26:29 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 048802067C;
        Tue, 18 Aug 2020 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597767989;
        bh=WoGVZDwIK/F9JyxPbF1fAg8BjUCeVwwHlyHeaJ96uK8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Reyv3GJbcCmGMohVyAFQuL23NBpyCL5QalSakoQYkh8b699H1N+5EXpw7G1L904Ag
         7fYDD7/k29a6R4CAIWxpiRuk04htTdgr6Qlly24vvza++Vaf5YTdPCKxftssimNqwT
         L45gOej0uJkpVB/vBAAyZghx0nVAy+YNYcbW/smc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D84E535228F5; Tue, 18 Aug 2020 09:26:28 -0700 (PDT)
Date:   Tue, 18 Aug 2020 09:26:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bitops, kcsan: Partially revert instrumentation for
 non-atomic bitops
Message-ID: <20200818162628.GG27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200813163859.1542009-1-elver@google.com>
 <CANpmjNOvS2FbvAk+j8N0uSuUJgbi=L2_zfK_koOKvJCuys7r7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOvS2FbvAk+j8N0uSuUJgbi=L2_zfK_koOKvJCuys7r7Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:34:28AM +0200, Marco Elver wrote:
> On Thu, 13 Aug 2020 at 18:39, Marco Elver <elver@google.com> wrote:
> > Previous to the change to distinguish read-write accesses, when
> > CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
> > the non-atomic bitops as atomic. We want to partially revert to this
> > behaviour, but with one important distinction: report racing
> > modifications, since lost bits due to non-atomicity are certainly
> > possible.
> >
> > Given the operations here only modify a single bit, assuming
> > non-atomicity of the writer is sufficient may be reasonable for certain
> > usage (and follows the permissible nature of the "assume plain writes
> > atomic" rule). In other words:
> >
> >         1. We want non-atomic read-modify-write races to be reported;
> >            this is accomplished by kcsan_check_read(), where any
> >            concurrent write (atomic or not) will generate a report.
> >
> >         2. We do not want to report races with marked readers, but -do-
> >            want to report races with unmarked readers; this is
> >            accomplished by the instrument_write() ("assume atomic
> >            write" with Kconfig option set).
> >
> > With the above rules, when KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected,
> > it is hoped that KCSAN's reporting behaviour is better aligned with
> > current expected permissible usage for non-atomic bitops.
> >
> > Note that, a side-effect of not telling KCSAN that the accesses are
> > read-writes, is that this information is not displayed in the access
> > summary in the report. It is, however, visible in inline-expanded stack
> > traces. For now, it does not make sense to introduce yet another special
> > case to KCSAN's runtime, only to cater to the case here.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > As discussed, partially reverting behaviour for non-atomic bitops when
> > KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected.
> >
> > I'd like to avoid more special cases in KCSAN's runtime to cater to
> > cases like this, not only because it adds more complexity, but it
> > invites more special cases to be added. If there are other such
> > primitives, we likely have to do it on a case-by-case basis as well, and
> > justify carefully for each such case. But currently, as far as I can
> > tell, the bitops are truly special, simply because we do know each op
> > just touches a single bit.
> > ---
> >  .../bitops/instrumented-non-atomic.h          | 30 +++++++++++++++++--
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> Paul, if it looks good to you, feel free to pick it up.

Queued, thank you!

							Thanx, Paul
