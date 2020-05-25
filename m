Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95004C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F798207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590391994;
	bh=3MrK15YX/s/4P2EORQQ2BWMpnOcrBYLaV5od+w/ron4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=un4sa7TqW3Em+101bY0Whg1b9m9s6NAEeHHAThYrUJCE+xSS6gMrHi+Fv7S7SaFhg
	 H3zPoAJNvc0A/f842jQzxH372nJUwCdCg6UQFHALWXEfhCSQcA1vxWNec/dqiXJsGv
	 Li1hrapwdcm/bdiyc4qY30Ii/ntWUXpQSaXL3mkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389145AbgEYHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388947AbgEYHdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:33:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC032065F;
        Mon, 25 May 2020 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590391992;
        bh=3MrK15YX/s/4P2EORQQ2BWMpnOcrBYLaV5od+w/ron4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMxJ6L+dRLraTeE9hVk7QkzUZ9I+y19AK5fv+OuSwQ2swKF/Oq2BUEIWYO2SYgjyK
         APfbZaKODO2unS59HjHgffshFF06kt4B15QHFpc9iwG8+NYBrOKF5GHIaNglSbhRzz
         8F96YIwHGd+KhjXW0cuXhZZgccDDEticGmcrtG+g=
Date:   Mon, 25 May 2020 09:33:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200525073310.GB261205@kroah.com>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com>
 <20200524154219.GU33628@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524154219.GU33628@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 11:42:19AM -0400, Sasha Levin wrote:
> On Sun, May 24, 2020 at 05:00:18PM +0200, Greg KH wrote:
> > On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
> > > On Sat, May 23, 2020 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > The kobject patch that was originally in here has now been reverted, as
> > > > Guenter reported boot problems with it on some of his systems.
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
> > 
> > > Btw, when you end up reverting a patch that was already the top patch,
> > > you might as well just remove it entirely from that tree instead (ie
> > > "git reset --hard HEAD^" instead of "git revert HEAD").
> > > 
> > > Unless somebody else uses your branches and you are afraid that the
> > > non-reverted commit escaped out in the wild that way?
> > 
> > I don't like rebasing or changing the HEAD like that on a public branch.
> > As proof, syzbot started sending me a bunch of "this is the failed
> > commit" messages right after your email, based on it's testing of the
> > tree in linux-next.
> 
> OTOH, leaving commits like this may result in confusion later on because
> of confusion around the "correct" patch.
> 
> Consider this:
> 
> 1. Someone writes a patch named "close memory leak when freeing XYZ"
> 2. We revert it a day later with 'Revert "close memory leak when
> freeing XYZ"'

And the sha1 is in the commit, showing which patch was reverted.

> 3. Now, what would the author of the original patch do? That's right -
> re-submit a patch with an identical subject line and patch description,
> but with a subtle change in the code to fix the bug the original patch
> was reverted for.

Sometimes, yes, but sometimes, as in this case, a totally different
patch will be submitted for the problem :)

But, even if it was there, the sha1 in the revert should allow us to
track this properly.  I can't remember a time where this has caused
problems in the past, can you?

> So now we end up with two "close memory leak when freeing XYZ" commits
> in our git history that are nearly identical. Recipe for a disaster :)

Time and sha1 should show them being different :)

thanks,

greg k-h
