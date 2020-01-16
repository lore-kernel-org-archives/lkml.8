Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D6BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5B42077C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218787;
	bh=KXhLL6PoSNKM+jjaoA0hF1VDfsgTdLvJrNoz/lyOyHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SO+SPBuKSPMtoARKfd5oWRi833YPoT5c1QkEt+70j3G02ma1Arr6337F00psAgiZZ
	 7TtvxN6KrzUzDc5PX0+R+BCsqkfRIuWGyiCOCpy79zblxSh0sTulGn92TaRWcVN1ok
	 a4L2RaxJ8KMk/ym/0LPdg0/cDhR5WO434QQonsvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbgAPXxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:53:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388142AbgAPXxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:53:03 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ECC120729;
        Thu, 16 Jan 2020 23:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579218782;
        bh=KXhLL6PoSNKM+jjaoA0hF1VDfsgTdLvJrNoz/lyOyHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=deSTanvVmO/nyNCtb2s8wf5T4G6DE3cw+6Dq1dEF6piLEm+WHCGPOnNi0ZRZmDpDD
         uij+GAd4h4bQ5pxpnZTIxhfuR0nlTkL3yFm/EODXfvzZA/cyrZPjWVN98WzeMPo1r0
         sY7S54MCDuX5JE5Trfms6TTc1MkEL8nCyoZzFEKs=
Date:   Thu, 16 Jan 2020 15:53:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     keescook@chromium.org, longman@redhat.com, mingo@kernel.org,
        rppt@linux.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: + watchdog-fix-possible-soft-lockup-warning-at-bootup-v2.patch
 added to -mm tree
Message-Id: <20200116155302.af6474975d7cb53ea3abae94@linux-foundation.org>
In-Reply-To: <878sm7wr7e.fsf@nanos.tec.linutronix.de>
References: <20200107233656.GS5UK5wEy%akpm@linux-foundation.org>
        <878sm7wr7e.fsf@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 12:55:49 +0100 Thomas Gleixner <tglx@linutronix.de> wrote:

> akpm@linux-foundation.org writes:
> 
> > ------------------------------------------------------
> > From: Waiman Long <longman@redhat.com>
> > Subject: watchdog: Fix possible soft lockup warning at bootup
> 
> Completely empty changelog without any justification for this change.

Well, this is the v1->v2 delta.  It's removing an unnecessary change
from the v1 patch.  Normally that's covered in the main patch's
changelog but removing an unneeded change isn't changeloggable.

> > Link: http://lkml.kernel.org/r/20200103151032.19590-1-longman@redhat.com
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  kernel/watchdog.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > --- a/kernel/watchdog.c~watchdog-fix-possible-soft-lockup-warning-at-bootup-v2
> > +++ a/kernel/watchdog.c
> > @@ -496,9 +496,7 @@ static void watchdog_enable(unsigned int
> >  		      HRTIMER_MODE_REL_PINNED_HARD);
> >  
> >  	/* Initialize timestamp */
> > -	if (system_state != SYSTEM_BOOTING)
> > -		__touch_watchdog();
> > -
> > +	__touch_watchdog();
> >  	/* Enable the perf event */
> >  	if (watchdog_enabled & NMI_WATCHDOG_ENABLED)
> >  		watchdog_nmi_enable(cpu);
> > _
> >
> > Patches currently in -mm which might be from longman@redhat.com are
> >
> > watchdog-fix-possible-soft-lockup-warning-at-bootup.patch
> > watchdog-fix-possible-soft-lockup-warning-at-bootup-v2.patch
> 
> Please drop both. The initial one just papers over timer interrupt loss
> and weakens debugging. That V2 thing is just fixing up the wreckage
> introduced in the initial one.

Not really - it's removing a change which was deemed unneeded.

But sure, dropped.
