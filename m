Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23595C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F3F207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590332423;
	bh=ExqW7NIyE1gfn859H2A2OJhujQQV6uYkBUt8FcXrzl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v2PVhvAn0DHV/RO2VHPSjWwxEDqgvZJMUeXJ10DdXkDcYf0p7q0HdBXmbFhBiIEs8
	 lX5r1UsqP6YsT5khgE6qlgkWDcTjI90gAMBhBQCu5TV4TqkiXGXdsCQU8yBb0VYdKu
	 xd74FUj8z01DSjMkU/dx1ps+sFTwHrTkSh97EsRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgEXPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729579AbgEXPAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB6F2075F;
        Sun, 24 May 2020 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590332421;
        bh=ExqW7NIyE1gfn859H2A2OJhujQQV6uYkBUt8FcXrzl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yby8QqK0vxxuXOaIeljFk0W1Gws+9XMNMWrZV8iqsNQJBrq+A9dCJubcWwbqfQQk8
         Kd8uM66tTq5i39fNMF49nMWqPqpne2Z7ogF00amCwsZdQCmuRhawxgStP3oabe4X8a
         v5+dn6pvao1V/6WV3Z8hQqYMZtPGCWR4EGRQluPI=
Date:   Sun, 24 May 2020 17:00:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
Message-ID: <20200524150018.GB11262@kroah.com>
References: <20200523131759.GA55886@kroah.com>
 <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
> On Sat, May 23, 2020 at 8:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > The kobject patch that was originally in here has now been reverted, as
> > Guenter reported boot problems with it on some of his systems.
> 
> Hmm. That original patch looks obviously buggy: in kobject_cleanup()
> it would end up doing "kobject_put(parent)" regardless of whether it
> had actually done __kobject_del() or not.
> 
> That _could_ have been intentional, but considering the commit
> message, it clearly wasn't in this case.  It might be worth re-trying
> to the commit, just with that fixed.

Turns out that wasn't the real problem here, the culprit is the
lib/test_printf.c code trying to tear down a kobject tree from the
parent down to the children (i.e. in the backwards order).

> Btw, when you end up reverting a patch that was already the top patch,
> you might as well just remove it entirely from that tree instead (ie
> "git reset --hard HEAD^" instead of "git revert HEAD").
> 
> Unless somebody else uses your branches and you are afraid that the
> non-reverted commit escaped out in the wild that way?

I don't like rebasing or changing the HEAD like that on a public branch.
As proof, syzbot started sending me a bunch of "this is the failed
commit" messages right after your email, based on it's testing of the
tree in linux-next.

What is really odd now, is that 'git log lib/kobject.c' does not show
the change/revert at all.  Is that because there was a revert?  Or is it
a git config option/default somewhere that prevents that from showing
up?

Odd, 'git blame lib/kobject.c' doesn't show it either.  Yet e6764aa0e553
("Revert "kobject: Make sure the parent does not get released before its
children"") is in your tree.  What am I missing here?

thanks,

greg k-h
