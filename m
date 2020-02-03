Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF1C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642CA21741
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580745754;
	bh=ng4f3LBqSvC9IA75BiWlMTBK0oaU1qkTurbY5hi6jmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UjfA6kGgzAUSh47goXcV18nIfDlGz/cWWssHzWMfemfsM/wT+9XOVlwreI38fwpXk
	 B3w2ZaYWcDR8FlOdzrtPZuPCKowDo+eNqDNsq8u+VvLr9erqu8cJ1z9eepzZPg62Kg
	 d2eJJIQ2DU68Smvl4iQZWibhWEtt0iZFmIyRw6Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgBCQCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgBCQCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:02:33 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A6D120721;
        Mon,  3 Feb 2020 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580745752;
        bh=ng4f3LBqSvC9IA75BiWlMTBK0oaU1qkTurbY5hi6jmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=doY9Zt0A1fwTGeIE+xiu6Je684fdhKakhzIz5vjAegJNO84761iCkOGDNr2CnJ7RO
         7RTKo8x0i5b+gFRhnzEkyVONsAqVsjD07QnYJDRvYAaiIQx8HHonZr2ApJS00tziUG
         yYqIxmsb5fQ8jX15h5CWOY4ylOYo3tqOPWIupZZE=
Date:   Mon, 3 Feb 2020 16:02:28 +0000
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Eric Dumazet' <edumazet@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200203160227.GA7274@willie-the-truck>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131184322.GA11457@worktop.programming.kicks-ass.net>
 <CANn89iLBL1qbrEucm2FU02oNbf=x3_4K93TmZ3yS2ZNWm8Qrsg@mail.gmail.com>
 <CANn89i+pExLRqJxbamGv=uDi2kWY-1CKsh1DcAgfdh9DjpQx3A@mail.gmail.com>
 <26258e70c35e4c108173a27317e64a0b@AcuMS.aculab.com>
 <20200203155839.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203155839.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 07:58:39AM -0800, Paul E. McKenney wrote:
> On Mon, Feb 03, 2020 at 03:45:54PM +0000, David Laight wrote:
> > From: Eric Dumazet
> > > Sent: 31 January 2020 18:53
> > > 
> > > On Fri, Jan 31, 2020 at 10:48 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > 
> > > > This is nice, now with have data_race()
> > > >
> > > > Remember these patches were sent 2 months ago, at a time we were
> > > > trying to sort out things.
> > > >
> > > > data_race() was merged a few days ago.
> > > 
> > > Well, actually data_race() is not there yet anyway.
> > 
> > Shouldn't it be NO_DATA_RACE() ??
> 
> No, because you use data_race() when there really are data races, but you
> want KCSAN to ignore them.  For example, diagnostic code that doesn't
> participate in the actual concurrency design and that doesn't run all
> that often might use data_race().  For another example, if a developer
> knew that data races existed, but that the compiler could not reasonably
> do anything untoward with those data races, that developer might well
> choose to use data_race() instead of READ_ONCE().  Especially if the
> access in question was on a fastpath where helpful compiler optimizations
> would be prohibited by use of READ_ONCE().

Yes, and in this particular case I think we can remove some WRITE_ONCE()s
from the non-RCU hlist code too (similarly for hlist_nulls).

Will
