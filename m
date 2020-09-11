Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71A4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB7A21D79
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgIKLdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgIKL3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:29:48 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E44C221EB;
        Fri, 11 Sep 2020 11:29:15 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:29:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Oli Swede <oli.swede@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] arm64: Optimise and update memcpy, user copy
 and string routines
Message-ID: <20200911112911.GA12835@gaia>
References: <20200630194822.1082-1-oli.swede@arm.com>
 <f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com>
 <20200907101003.GA11970@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907101003.GA11970@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 11:10:03AM +0100, Will Deacon wrote:
> On Wed, Jul 01, 2020 at 09:12:49AM +0100, Oli Swede wrote:
> > > Version 3 addressed this but I later found some issues with the fixup
> > > correctness after further testing, and have partially re-written them
> > > here, and addressed some other behaviours of the copy algorithm.
> 
> [...]
> 
> > I am waiting on access to the relevant machine before posting the benchmark
> > results for this optimized memcpy, but Sam reported the following with the
> > similar (but now slightly older) cortex-strings version:
> >   * copy_from_user: 13.17%
> >   * copy_to_user: 4.8%
> >   * memcpy: 27.88%
> >   * copy_in_user: Didn't appear in the test results.
> > This machine will also be used to check the fixups are accurate on a system
> > with UAO - they appear to be exact on a non-UAO system with PAN that I've
> > been working on locally.
> 
> I'm inclined to say that cortex-strings is probably not a good basis for
> our uaccess routines. The code needs to be adapted in a non-straightforward
> way so that we lose pretty much all of the benefits we'd usually get from
> adopted an existing implementation; we can't pull in fixes or improvements
> without a lot of manual effort, we can't reuse existing testing infrastructure
> (see below) and we end up being a "second-class" user of the routines
> because of the discrepancies in implementation.

I was a bit more optimistic about this series until I saw the
copy_user_fixup.S changes (patches 12 to 14). I have a suspicion it's
only Oli (and maybe Robin) who understands it, so from a maintainer's
perspective it doesn't really scale. It's also very fragile with any
minor tweak in the actual copy routine potentially breaking the fixup
code.

> So why don't we use cortex-strings as a basis for the in-kernel routines
> only, preferably in a form where the code can be used directly and updated
> with a script (e.g. similar to how we pull in arch/arm64/crypto routines
> from OpenSSL). We can then roll our own uaccess routines, using a slightly
> more straight-forward implementation which is more amenable to handling
> user faults and doesn't do things like over copying.

I think that's probably the best option. I wouldn't mind replacing the
in-kernel memcpy/strcpy etc. with these patches since the work was done
already but definitely not for the uaccess and fixup routines (we still
have the original implementation in the git log).

A script would work even better. Do we have any issue with licensing
though? Cortex Strings is BSD (3-clause IIRC) and copyright owned by
Linaro. I got them to officially agree with relicensing (dual license)
the latest copy under GPLv2 so that we can contribute it to the kernel.
But since the project license is still BSD, any future updates in there
are BSD-only.

Maybe someone who understands this stuff can confirm that it's ok to
regularly grab the Cortex Strings files into a GPLv2 codebase without
asking for Linaro's permission.

BTW, you could pick the kprobes patch in here, that explicit fixup call
is not necessary.

-- 
Catalin
