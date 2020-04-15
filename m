Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993FF20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896140AbgDOKFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:05:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896126AbgDOKFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:05:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF381063;
        Wed, 15 Apr 2020 03:05:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 501AF3F68F;
        Wed, 15 Apr 2020 03:05:46 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:05:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 3/6] arm64/vdso: Add time napespace page
Message-ID: <20200415100539.GA27339@C02TD0UTHF1T.local>
References: <20200225073731.465270-1-avagin@gmail.com>
 <20200225073731.465270-4-avagin@gmail.com>
 <20200414172014.GA6705@C02TD0UTHF1T.local>
 <CANaxB-yBeSmYdZL6gbe-agDAaEVcYHrxUCojQ4xaWpsWinQsyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaxB-yBeSmYdZL6gbe-agDAaEVcYHrxUCojQ4xaWpsWinQsyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 07:34:41PM -0700, Andrei Vagin wrote:
> On Tue, Apr 14, 2020 at 10:20 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 11:37:28PM -0800, Andrei Vagin wrote:
> > > Allocate the time namespace page among VVAR pages.  Provide
> > > __arch_get_timens_vdso_data() helper for VDSO code to get the
> > > code-relative position of VVARs on that special page.
> > >
> > > If a task belongs to a time namespace then the VVAR page which contains
> > > the system wide VDSO data is replaced with a namespace specific page
> > > which has the same layout as the VVAR page. That page has vdso_data->seq
> > > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > > VCLOCK_TIMENS to enforce the time namespace handling path.
> > >
> > > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > > update of the VDSO data is in progress, is not really affecting regular
> > > tasks which are not part of a time namespace as the task is spin waiting
> > > for the update to finish and vdso_data->seq to become even again.
> > >
> > > If a time namespace task hits that code path, it invokes the corresponding
> > > time getter function which retrieves the real VVAR page, reads host time
> > > and then adds the offset for the requested clock which is stored in the
> > > special VVAR page.
> > >
> > > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > > ---
> > >  arch/arm64/include/asm/vdso.h                 |  6 ++++++
> > >  .../include/asm/vdso/compat_gettimeofday.h    | 11 ++++++++++
> > >  arch/arm64/include/asm/vdso/gettimeofday.h    |  8 ++++++++
> > >  arch/arm64/kernel/vdso.c                      | 20 ++++++++++++++++---
> > >  arch/arm64/kernel/vdso/vdso.lds.S             |  5 ++++-
> > >  arch/arm64/kernel/vdso32/vdso.lds.S           |  5 ++++-
> > >  include/vdso/datapage.h                       |  1 +
> > >  7 files changed, 51 insertions(+), 5 deletions(-)
> >
> > > +#ifdef CONFIG_TIME_NS
> > > +static __always_inline const struct vdso_data *__arch_get_timens_vdso_data(void)
> > > +{
> > > +     const struct vdso_data *ret;
> > > +
> > > +     asm volatile("mov %0, %1" : "=r"(ret) : "r"(_timens_data));
> > > +
> > > +     return ret;
> > > +}
> > > +#endif
> >
> > What is this inline assembly for? The commit message doesn't mention it,
> > there's no explanation here, and the native version doesn't do likewise
> > so it seems rather surprising.
> 
> __arch_get_vdso_data is  right before this function and there is a
> comment which explains this:
> https://github.com/torvalds/linux/blob/master/arch/arm64/include/asm/vdso/compat_gettimeofday.h#L137
> 
> """
> /*
> * This simply puts &_vdso_data into ret. The reason why we don't use
> * `ret = _vdso_data` is that the compiler tends to optimize this in a
> * very suboptimal way: instead of keeping &_vdso_data in a register,
> * it goes through a relocation almost every time _vdso_data must be
> * accessed (even in subfunctions). This is both time and space
> * consuming: each relocation uses a word in the code section, and it
> * has to be loaded at runtime.
> *
> * This trick hides the assignment from the compiler. Since it cannot
> * track where the pointer comes from, it will only use one relocation
> * where __arch_get_vdso_data() is called, and then keep the result in
> * a register.
> */
> """
> 
> I decided to not duplicate the comment because these two functions are
> very similar and close to each other.

Ah, I was not aware of that context. Could we just add a trivial comment
to say "see __arch_get_vdso_data" or something like that?

It's a shame we're not using OPTIMIZER_HIDE_VAR() for that, as it can
generate slightly better code and is easier to read than bare asm.

Thanks,
Mark.
