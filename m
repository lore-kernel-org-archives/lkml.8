Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF843C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802492075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIJO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:56:26 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:52374 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbgIJOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:55:34 -0400
Date:   Thu, 10 Sep 2020 09:37:51 -0400
From:   Rich Felker <dalias@libc.org>
To:     Rob Landley <rob@landley.net>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: fix syscall tracing
Message-ID: <20200910133751.GE3265@brightrain.aerifal.cx>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
 <20200907174436.GK3265@brightrain.aerifal.cx>
 <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
 <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 06:02:05AM -0500, Rob Landley wrote:
> On 9/10/20 4:55 AM, John Paul Adrian Glaubitz wrote:
> > Hi Rich!
> > 
> > On 9/7/20 7:44 PM, Rich Felker wrote:
> >>> Can we still get this merged as a hotfix for 5.9?
> >>
> >> Yes, fixes for regressions in the same release cycle are in-scope (the
> >> whole point of having -rc's). I have at least one other fix that needs
> >> to go in too and was just giving it a little time to make sure
> >> everything's ok now and that there are no more.
> > 
> > Let me know if there is anything else left for testing.
> 
> Could you also merge the fix the build break, ala:
> 
> > The vmlinux image is a current vanilla Linux kernel using an initramfs filesystem:
> > 
> >   make ARCH=sh CROSS_COMPILE=sh2eb-linux-muslfdpic- j2_defconfig vmlinux
> > 
> > And trying to do that in current git dies with:
> > 
> >   CC      init/version.o
> > In file included from ./include/linux/spinlock.h:318,
> >                  from ./arch/sh/include/asm/smp.h:11,
> >                  from ./include/linux/smp.h:82,
> >                  from ./include/linux/lockdep.h:14,
> >                  from ./include/linux/rcupdate.h:29,
> >                  from ./include/linux/rculist.h:11,
> >                  from ./include/linux/pid.h:5,
> >                  from ./include/linux/sched.h:14,
> >                  from ./include/linux/utsname.h:6,
> >                  from init/version.c:14:
> > ./include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
> > ./include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function
> > 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
> >    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> >       |   ^~~~~~~~~~~~
> >       |   xchg_acquire
> > ./include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct
> > raw_spinlock'} has no member named 'dep_map'
> >    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> >       |                     ^~
> > 
> > And so on and so forth for pages. I bisected it to:
> > 
> > commit 0cd39f4600ed4de859383018eb10f0f724900e1b
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Thu Aug 6 14:35:11 2020 +0200
> > 
> >     locking/seqlock, headers: Untangle the spaghetti monster
> 
> Which I reported to Rich on the 2nd and he had me test a one line patch fixing
> it (adding an extra #include) on the 3rd, but I just did a fresh pull and the
> j2_defconfig build still broke a week later.

Yes, that's presently the other regression fix I have queued for the
second pull request.

Rich
