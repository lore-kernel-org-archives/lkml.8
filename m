Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A82206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594232438;
	bh=TonelHlHtWDNOIWLPcZdK8GZofB+N27b/F2Vm9vTRh8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gtDLPV9Gh8UtEvs+8cSh3e6vhVNagITa+BE8L9u72G1TBCJHHddqbk0nEPaS9ebGk
	 /66jKeFm7XR358n5u4Gap83P7CBjytFiB/sxKQ1Sh1sUhpE6BMNBHjaEiCIcvGLYaI
	 +76/k70uBa17fB9JS1uM+ALA/B4YZecgn51bk1ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGHSUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHSUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:20:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B4720658;
        Wed,  8 Jul 2020 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594232436;
        bh=TonelHlHtWDNOIWLPcZdK8GZofB+N27b/F2Vm9vTRh8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ukj3cLrdjnebjlAukmmTASRyw1pa2gMozxAYVE8k3Aal5uTo6H7tEBiy5eJN+QxXL
         gRJwrI65r1HmPmI3ecywXxV/5VkFMVuEu4tbgwYCZmqCvbTsSU6mGg/xNvJwWULf34
         9NfF2Ngood+DO+fV+U5vOrrqOFGolG0eKpdqBV2Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 503CE3522635; Wed,  8 Jul 2020 11:20:36 -0700 (PDT)
Date:   Wed, 8 Jul 2020 11:20:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Matt Turner <mattst88@gmail.com>,
        kernel-team <kernel-team@android.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200708182036.GR9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck>
 <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72>
 <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72>
 <20200707102915.GI10992@arm.com>
 <20200707225122.GJ9247@paulmck-ThinkPad-P72>
 <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
 <20200708091620.GF597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708091620.GF597537@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 11:16:20AM +0200, Peter Zijlstra wrote:
> On Tue, Jul 07, 2020 at 04:01:28PM -0700, Nick Desaulniers wrote:
> > I'm trying to put together a Micro Conference for Linux Plumbers
> > conference focused on "make LLVM slightly less shitty."  Do you all
> > plan on attending the conference? Would it be worthwhile to hold a
> > session focused on discussing this (LTO and memory models) be
> > worthwhile?
> 
> I'd love to have a session about compilers and memory ordering with both
> GCC and CLANG in attendance.
> 
> We need a solution for dependent-loads and control-dependencies for both
> toolchains.

What Peter said!  ;-)

							Thanx, Paul
