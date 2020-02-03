Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C648C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1C20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580745521;
	bh=RHjlVOlmohcRY28alvHfcJe32q4TVF5P2eQ6qHs54Cs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=fjrBULLWzEVxsPowklLgfaY4sTgAC+ZWByJVdx/95yERH1Mb24+0QUVd0x5yVt6gl
	 FGF2NH6PYaPCWdMgS5kSJPjw7apOo/sPFApCDr78fxi8Rp8oI/BqJw36dGEXdGBCi2
	 TBxM76sTbHIvSgw+QQHZnCqKuYITRl+FUv4lcEgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgBCP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbgBCP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 10:58:40 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949B12087E;
        Mon,  3 Feb 2020 15:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580745519;
        bh=RHjlVOlmohcRY28alvHfcJe32q4TVF5P2eQ6qHs54Cs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=VpZjPV9qofw2iE96np4AHC0ilA/Wqh8JQBr9+VsP2IdkjoK8RNbJolbw3QSjOWgbZ
         i7k6ZbP35rGfxn5/D5Tc9ZM4nWfygmiyN90lMfLlnFn/iFsXlP0itUr1oCbH0SwAS9
         VXr4AyCsGoIVTshPhvZCktG6zkWEzFXoGh17H1hs=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6C7793522718; Mon,  3 Feb 2020 07:58:39 -0800 (PST)
Date:   Mon, 3 Feb 2020 07:58:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Eric Dumazet' <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200203155839.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 03:45:54PM +0000, David Laight wrote:
> From: Eric Dumazet
> > Sent: 31 January 2020 18:53
> > 
> > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > >
> > 
> > > This is nice, now with have data_race()
> > >
> > > Remember these patches were sent 2 months ago, at a time we were
> > > trying to sort out things.
> > >
> > > data_race() was merged a few days ago.
> > 
> > Well, actually data_race() is not there yet anyway.
> 
> Shouldn't it be NO_DATA_RACE() ??

No, because you use data_race() when there really are data races, but you
want KCSAN to ignore them.  For example, diagnostic code that doesn't
participate in the actual concurrency design and that doesn't run all
that often might use data_race().  For another example, if a developer
knew that data races existed, but that the compiler could not reasonably
do anything untoward with those data races, that developer might well
choose to use data_race() instead of READ_ONCE().  Especially if the
access in question was on a fastpath where helpful compiler optimizations
would be prohibited by use of READ_ONCE().

							Thanx, Paul
