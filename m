Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43385C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C25220774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgDVLBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:01:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:49028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgDVLB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:01:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30876ABD6;
        Wed, 22 Apr 2020 11:01:25 +0000 (UTC)
Message-ID: <1587553284.9537.96.camel@suse.cz>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Harald Arnesen <harald@skogtun.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Apr 2020 13:01:24 +0200
In-Reply-To: <ecdc6ffa-0137-4ca0-3bdb-cf37178ba4ff@skogtun.org>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
         <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
         <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
         <20200421212347.GV2483@worktop.programming.kicks-ass.net>
         <1587546150.9537.84.camel@suse.cz>
         <aec3c60e-2794-7eb2-eb11-ff2781223e90@skogtun.org>
         <ecdc6ffa-0137-4ca0-3bdb-cf37178ba4ff@skogtun.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 12:22 +0200, Harald Arnesen wrote:
> Harald Arnesen [22.04.2020 11:37]:
> 
> > Giovanni Gherdovich [22.04.2020 11:02]:
> > > 
> > > Harald:
> > > 
> > > I'll echo Linus' request of testing that the patch series linked above fixes
> > > the problem on your machine. Since you're testing -rc kernels and bisecting
> > > bugs I assume you're comfortable with patching and compiling kernels, but if
> > > that is not the case I am more than happy to assist by providing either an RPM
> > > or a DEB package, depending on the distribution you're running. Let me know.
> > Will try patching first, if I'm not successful, you may compile a DEB
> > package for me.
> 
> I can confirm that my Thinkpad T510i boots normally with the four
> patches added.
> 
> Thanks!

That's awesome, thank you for testing.

Regarding the turbostat output you attached to an earlier email, it confirms
the suspicion that the 4C turbo is reported as zero (being a 2 cores / 4 threads
machine), explaining why the fix works:

  cpu2: MSR_TURBO_RATIO_LIMIT: 0x00001313
  19 * 133.3 = 2533.3 MHz max turbo 2 active cores
  19 * 133.3 = 2533.3 MHz max turbo 1 active cores

In the above, bits 31:24 are zero. It's not a universal rule, though: my laptop
also has a 2 cores / 4 threads cpu, and that same MSR says:

  cpu3: MSR_TURBO_RATIO_LIMIT: 0x1b1b1b1b1b1d
  27 * 100.0 = 2700.0 MHz max turbo 6 active cores
  27 * 100.0 = 2700.0 MHz max turbo 5 active cores
  27 * 100.0 = 2700.0 MHz max turbo 4 active cores
  27 * 100.0 = 2700.0 MHz max turbo 3 active cores
  27 * 100.0 = 2700.0 MHz max turbo 2 active cores
  29 * 100.0 = 2900.0 MHz max turbo 1 active cores

So despite my CPU being similar to yours, it wouldn't show the bug. There is
even more: the bug can show on large core counts too, as seen in
https://lore.kernel.org/lkml/bf43772d-48e5-01d4-dd03-330110e487fa@linux.intel.com/
Like Xu from Intel has an Atom P-Series with 24 physical cores, yet their
MSR goes like:

  MSR_TURBO_RATIO_LIMIT: 0x00000016

which means only the 1C turbo is reported non-zero (that machine doesn't have
turbo at all, 1C turbo is the same as base frequency).


Thanks,
Giovanni
