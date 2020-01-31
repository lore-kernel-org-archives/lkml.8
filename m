Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1927A21734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580503927;
	bh=ggViF55VCZoAIomrRrDA8sGhLP1UgxQv53jNUU3zMSU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KKz/ogrJAoe6xXruikF+mgM0W6l+uZu9DJPtw3n2QvI104geLrkKtS/b1mNLpiacQ
	 IVGRKP+HC3A7Xl1fgAqLYJ4C2T476To180pO+PB8vCnhpIOI2aVd9hxS+0DTDrTd/R
	 0Z4hRlURxAfG6Z4cNpJgwNo3+FloWuzNFerpuVvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgAaUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:52:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaUwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 15:52:06 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [199.201.64.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C28F214D8;
        Fri, 31 Jan 2020 20:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580503925;
        bh=ggViF55VCZoAIomrRrDA8sGhLP1UgxQv53jNUU3zMSU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L63j83frlXKKBxND2q4Oo+yOp8q55JTTp2QcM1SLfnUxRiuxd4ui0ZRIjv8+6anoT
         v4zlep3CWaXrvLmtWAesgQhTXTL3kbr+Yl4v40UId5X09E19tAzZyT2BE3T7QB0eTc
         J1JTV+S9pjYQP4TD8eIGTaHNrpJgrVhap1mYMvHc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A682E3522722; Fri, 31 Jan 2020 12:52:04 -0800 (PST)
Date:   Fri, 31 Jan 2020 12:52:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Eric Dumazet <edumazet@google.com>, Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131205204.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
 <20200131165718.GA5517@willie-the-truck>
 <CANn89iKmSBPKJGw--WaJJhCdu2wz2aq-ve+E8z=gfsYj6Zom_A@mail.gmail.com>
 <20200131172058.GB5517@willie-the-truck>
 <CANn89iJNgPOzCdc-7QoC+dawJVn7tLQxmrx58GL8PT9rDVT2hA@mail.gmail.com>
 <87blqj4ddg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blqj4ddg.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:47:23PM +0100, Thomas Gleixner wrote:
> Eric Dumazet <edumazet@google.com> writes:
> > On Fri, Jan 31, 2020 at 9:21 AM Will Deacon <will@kernel.org> wrote:
> >> Without serialisation, timer_pending() as currently implemented does
> >> not reliably tell you whether the timer is in the hlist. Is that not a
> >> problem?
> >
> > No it is not a problem.
> 
> Even if we would take the base lock then this is just a snapshot, which
> can be wrong at the moment the lock is dropped. So why bother?

The risk of leaving it as-is or of using data_race() is that if it is
checked multiple times, the compiler might use the old value.  Yes,
we could say that things like barrier() should be used in those cases,
but READ_ONCE() has the advantage of making it so that no one has to
worry about those cases.

							Thanx, Paul
