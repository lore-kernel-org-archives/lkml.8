Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3588C433E5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDF82075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594162288;
	bh=qIo6PpemCQ+WG0zoOl3DhnPnPq5fufAVnvuCuXl7avY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xEwrqGYpdvwUzcdgdA1+OTmk9aMMDu6BbgQQzfRfwbnrJwCUCflI/8oAkKTaG5jni
	 BylE3I/qiWz+LhTNDkhB+sEaFcGMk4mJF6x96BgtA+VzSQ+by99pV369EBGwSA043T
	 kJlP3y6ZHv5AR+6ibbwSOrnKs+Da2LpsoidpOIWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgGGWv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgGGWvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 18:51:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6882077D;
        Tue,  7 Jul 2020 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594162282;
        bh=qIo6PpemCQ+WG0zoOl3DhnPnPq5fufAVnvuCuXl7avY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vft7wP4CGTu/pzkjM310cWRe9nFX1kueTyt1f6M2IB30J2j1PpTPgpsoiGegnaYlj
         881JZtwKyNQerDXnE5Eff3Ao4RRD5V2rUIoj913s1rZys6ycR/YsU6Y1ZgvorjPp9v
         /Np+mb1EDtvMlz6TfBXgbsMv6vAE7D9WNVTuF1kM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B5C6C35234B0; Tue,  7 Jul 2020 15:51:22 -0700 (PDT)
Date:   Tue, 7 Jul 2020 15:51:22 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200707225122.GJ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72>
 <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72>
 <20200707102915.GI10992@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707102915.GI10992@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 11:29:15AM +0100, Dave Martin wrote:
> On Mon, Jul 06, 2020 at 10:36:28AM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 06, 2020 at 06:05:57PM +0100, Dave Martin wrote:

[ . . . ]

> > > The underlying problem here seems to be that the necessary ordering
> > > rule is not part of what passes for the C memory model prior to C11.
> > > If we want to control the data flow, don't we have to wrap the entire
> > > dereference in a macro?
> > 
> > Yes, exactly.  Because we are relying on things that are not guaranteed
> > by the C memory model, we need to pay attention to the implementations.
> > As I have said elsewhere, the price of control dependencies is eternal
> > vigilance.
> > 
> > And this also applies, to a lesser extent, to address and data
> > dependencies, which are also not well supported by the C standard.
> > 
> > There is one important case in which the C memory model -does- support
> > control dependencies, and that is when the dependent write is a normal
> > C-language write that is not involved in a data race.  In that case,
> > if the compiler broke the control dependency, it might have introduced
> > a data race, which it is forbidden to do.  However, this rule can also
> > be broken when the compiler knows too much, as it might be able to prove
> > that breaking the dependency won't introduce a data race.  In that case,
> > according to the standard, it is free to break the dependency.
> 
> Which only matters because the C abstract machine may not match reality.
> 
> LTO has no bearing on the abstract machine though.
> 
> If specific compiler options etc. can be added to inhibit the
> problematic optimisations, that would be ideal.  I guess that can't
> happen overnight though.

Sadly, I must agree.

> > > > > > We likely won't realise if/when this goes wrong, other than impossible to
> > > > > > debug, subtle breakage that crops up seemingly randomly. Ideally, we'd be
> > > > > > able to detect this sort of thing happening at build time, and perhaps
> > > > > > even prevent it with compiler options or annotations, but none of that is
> > > > > > close to being available and I'm keen to progress the LTO patches in the
> > > > > > meantime because they are a requirement for CFI.
> > > > > 
> > > > > My concern was not so much why LTO makes things dangerous, as why !LTO
> > > > > makes things safe...
> > > > 
> > > > Because ignorant compilers are safe compilers!  ;-)
> > > 
> > > AFAICT ignorance is no gurantee of ordering in general -- the compiler
> > > is free to speculatively invent knowledge any place that the language
> > > spec allows it to.  !LTO doesn't stop this happening.
> > 
> > Agreed, according to the standard, the compiler has great freedom.
> > 
> > We have two choices: (1) Restrict ourselves to live within the confines of
> > the standard or (2) Pay continued close attention to the implementation.
> > We have made different choices at different times, but for many ordering
> > situations we have gone with door #2.
> > 
> > Me, I have been working to get the standard to better support our
> > use case.  This is at best slow going.  But don't take my word for it,
> > ask Will.
> 
> I can believe it.  They want to enable optimisations rather than prevent
> them...

Right in one!  ;-)

> > > Hopefully some of the knowledge I invented in my reply is valid...
> > 
> > It is.  It is just that there are multiple valid strategies, and the
> > Linux kernel is currently taking a mixed-strategy approach.
> 
> Ack.  The hope that there is a correct way to fix everything dies
> hard ;)

Either that, or one slowly degrades ones definition of "correct".  :-/

> Life was cosier before I started trying to reason about language specs.

Same here!

							Thanx, Paul
