Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418F4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15EB02075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590392424;
	bh=85HKHrS8vIZQ1Jx7+Y2oume7WqkdQxHcQQjHI0jNXSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iaWGyCQvKDydePmNd3elnK9FJtWo6xFJnw6SVv2YPbkUTpT9b3i2q1dXo0n6dKzmM
	 ncuylC4lbCBzo4l3YvHpY/aEsA6a8tQRg+w6D7y88vmwdIeactXkolgFMXvR2OZAbP
	 Ao9IlrRhArvbSCIq9XTDHX3ev/EuSkcgBq3lfHx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbgEYHkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbgEYHkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:40:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27CA2073B;
        Mon, 25 May 2020 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590392422;
        bh=85HKHrS8vIZQ1Jx7+Y2oume7WqkdQxHcQQjHI0jNXSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvsLNP/Yi32PY/z61LzCg++53+OVsz9VE1sP8/eReDe7U2wfUMMdXVmo4v//xBjAW
         MesOUUB03cWeP4e0Mjrb+Xqtho98Yq1miRcfF+4ovYOaCjPHxGszYyERsXD5OYfMDa
         6D9NGNCAloOFFn2km4Uj3tlBs6e2y13HH4AP6PhY=
Date:   Mon, 25 May 2020 09:40:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200525074020.GC261205@kroah.com>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
 <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 10:05:28AM -0700, Linus Torvalds wrote:
> On Sun, May 24, 2020 at 8:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
> > >
> > > Hmm. That original patch looks obviously buggy: in kobject_cleanup()
> > > it would end up doing "kobject_put(parent)" regardless of whether it
> > > had actually done __kobject_del() or not.
> > >
> > > That _could_ have been intentional, but considering the commit
> > > message, it clearly wasn't in this case.  It might be worth re-trying
> > > to the commit, just with that fixed.
> >
> > Turns out that wasn't the real problem here, the culprit is the
> > lib/test_printf.c code trying to tear down a kobject tree from the
> > parent down to the children (i.e. in the backwards order).
> 
> Note that the "obviously buggy or at least not documented" behavior of
> that commit 4ef12f719802 ("kobject: Make sure the parent does not get
> released before its children") that got reverted is true regardless.
> 
> Should the parent be released unconditionally (like that commit does),
> or should it be released only when kobject_del() was called when it
> had "state_in_sysfs" set?
> 
> Even if the problem Guenter reported was due to something else, that
> other change is a rather fundamental change and should at least be
> mentioned by the commit log.
> 
> It's entirely possible that the parent dropping should always be done,
> but the way it was done in that reverted commit it looked kind of
> accidental.

I'll revisit this and try to figure it out, but I think what we have
today is still correct.  The only "problem" that people were having with
the original code is the kobject_uevent() path walk when a parent was
gone before the child.  I've sent a patch to solve that problem, so we
"should" be ok.

Unfortunatly, it turns out that the owner of the kobject in question was
assuming that it could always reach the parent when things were being
cleaned up, but it was tearing things down in the backwards order.  So
even if I did move the logic around "correctly" in this patch, it still
died a horrible death (and there was other under-run errors reported as
well by other subsystems.)

So again, I think what we have today is ok.  But I'll beat on it for a
while this week to ensure that.  Time to start using the kunit test
framework for kobjects it seems :)

> > What is really odd now, is that 'git log lib/kobject.c' does not show
> > the change/revert at all.  Is that because there was a revert?  Or is it
> > a git config option/default somewhere that prevents that from showing
> > up?
> 
> No, it's fundamentally how git works.
> 
> Remember: git does _not_ track "changes".
> 
> Any SCM that tracks changes to a file is fundamentally broken, for
> fundamental reasons. It mostly boils down to "what happens when the
> source of the change the same file in two branches is different".
> Think "rename to X" and "create X", and remember all the problems SVN
> has when that happens.
> 
> So no, git never _ever_ tracks "what changed". Instead, git
> fundamentally tracks "what is the state". The "change" is not
> fundamental, it's something that gets computed afterwards when you
> have a "before and after" state.

Doh, ok, that makes more sense.  It's just that a apply/revert sequence
does not happen a lot that I happen to notice this when digging through
the logs for fixes.

> If you want it all, use "git log --full-history", but then you will
> _really_ get the full history and a lot of pointless noise. And even
> then, things like "blame" won't waste time on following merges that
> made no difference in the end.

I'll use --full-history for now on when trying to dig up stable changes,
as that should help.  But ugh, you are right, there is a lot more noise
in there, loads of merge commits that shouldn't matter.  Will add
--no-merges to the line as well, and that helps out.

thanks,

greg k-h
