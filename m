Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C091C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BED62070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gt73EGD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHJLRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgHJLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:16:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A549C061786;
        Mon, 10 Aug 2020 04:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3igqfKE7wm2QUrHPRQNhxnr922Z1BD0XrDzIpjrIz1c=; b=Gt73EGD1FnQwHG+2qD6EIyFJs5
        IVYOWpzDBS3ugNneUzf3K7vpNGONIJ6avirkC9b6JEcGipUvj5vmrH67i314h7CA3lRFBWFTKYFnp
        ppLgFjP8gATQ0HzkogSbFpTdA2Ouz8ZXL4Tgisctr7ZIiYxEhhTnTF2TQQYa7lcUhVnLjXRspAnud
        mJ1djHdcR2wn6qdL89oqaVtosKHnbTnLIDafjOUCamSIzgFKeAPCeeTxwrLDEWig6nutGOk6LZm7F
        8r5ZhpqXmf6IguozDxyBmBoi2QNOis8HWteKWyd9KW160Xa+pu5pzysGsQi9bBSDm5RCMyZQFd8z9
        w+uZlu2Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k55nK-0003sh-I5; Mon, 10 Aug 2020 11:16:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42F2A301A7A;
        Mon, 10 Aug 2020 13:16:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30F9B2B491BED; Mon, 10 Aug 2020 13:16:44 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:16:44 +0200
From:   peterz@infradead.org
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to
 build
Message-ID: <20200810111644.GP2674@hirez.programming.kicks-ass.net>
References: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
 <20200804133438.GK2674@hirez.programming.kicks-ass.net>
 <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:23:48PM +0300, Anatoly Pugachev wrote:
> On Tue, Aug 4, 2020 at 4:34 PM <peterz@infradead.org> wrote:
> >
> > On Tue, Aug 04, 2020 at 04:17:16PM +0300, Anatoly Pugachev wrote:
> > > Hello!
> > >
> > > Linus git master sources:
> > >
> > > $ git desc
> > > v5.8-2483-gc0842fbc1b18
> > >
> >
> > Ooh, it looks like that series wasn't cut back far enough :/
> >
> > 859247d39fb0 ("seqlock: lockdep assert non-preemptibility on seqcount_t
> > write") does indeed also introduce problems.
> >
> > I've been working on untangling the header mess for the full series and
> > the below patch is what I currently have.
> >
> > ---
> > Subject: seqlock,headers: Untangle the spaghetti monster
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Jul 30 13:20:47 CEST 2020
> >
> > By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> > attacked.
> 
> Thanks Peter!
> 
> It doesn't apply cleanly over master git, but it least makes kernel
> compilable / bootable on sparc64:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent

Should contain an updated version.
