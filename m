Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37346C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20EBB21744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgHDO5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:57:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51557 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:57:41 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2yNP-0007lj-8B; Tue, 04 Aug 2020 14:57:15 +0000
Date:   Tue, 4 Aug 2020 16:57:14 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        avagin@gmail.com, serge@hallyn.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
Message-ID: <20200804145714.rcz6vg3bo6chsuoh@wittgenstein>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
 <20200804115649.kzea757e5wwpk4k3@wittgenstein>
 <87d046sj8w.fsf@x220.int.ebiederm.org>
 <20200804123036.2lnkm6it7ko7j3ju@wittgenstein>
 <87r1smpmvk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1smpmvk.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 08:21:51AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Tue, Aug 04, 2020 at 07:11:59AM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian.brauner@ubuntu.com> writes:
> >> 
> >> > On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
> >> >> Every namespace type has its own counter. Some of them are
> >> >> of refcount_t, some of them are of kref.
> >> >> 
> >> >> This patchset introduces generic ns_common::count for any
> >> >> type of namespaces instead of them.
> >> >> 
> >> >> ---
> >> >
> >> > I was wondering why that series never made it to me turns out there's
> >> > some weird bug in my (neo)mutt where it sometimes marks messages as read
> >> > when I'm deleting completely unrelated messages. That has already cost
> >> > me a talk slot for an event I really wanted to attend and now it seems
> >> > to start costing me patches... I need to figure this out.
> >> >
> >> > Anyway, thanks for sending this. I pulled this into my tree now.
> >> 
> >> Actually why in the world should the reference count be generic?
> >> 
> >> What is the point of this patchset?
> >> 
> >> What problem does it solve.  Name spaces are not the same, and
> >> their refcounting needs are not the same so I don't have a clue how it
> >> helps anything to have a reference count in ns_common.
> >
> > What is the point of this opposition to this cleanup?
> >
> > It unifies reference counting across namespaces and gets rid of
> > inconsistencices. Over the years none of the namespaces seem to have
> > deviated enough from each that they really have needed separate
> > reference counting mechanisms.
> 
> First this posting is the first I have seen of it, unless it was a
> subset of the weird /proc/namespaces/ patchset that has design problems.
> In which case I never got this far.
> 
> Second I don't see a motivation for this.  The only point to place a
> reference count in ns_common is if it makes something easier.  What
> does it make easier and what does it make harder?
> 
> For a pure cleanup the questions are what are the trade offs.
> There are potential performance differences between refcount_t and
> kfref.
> 
> From a practical matter it makes absolutely no sense in the least to
> talk about the reference count, when some of the namespaces have more
> than one reference count, with difference semantics and they interrelate
> in somewhat subtle ways.
> 
> Further depending on what is happening sharing code that does not
> have a fundamental reason to be shared, can make maintenance more
> difficult as the entire generic infrastructure will need to be updated
> instead of just that the part that focuses on the one thing.
> 
> So I am opposed because the patchset does not explain at all why it
> makes sense to do, nor what tradeoffs were considered, nor what
> testing was done.
> 
> This change is not as trivial as a spelling change so it is not ok to
> say it is just a cleanup and move on.  A change in the reference
> counting can be noticable.  This needs at least to be acknowledged in
> the change log and at a minimum a hand wavy reason put forth why it is
> ok.
> 
> 
> Instead what I am seeing as justification is this is a trivial cleanup
> and no one will notice or care.   And it is not that trivial so I
> object to the patchset.

The "not seeing a motivation for this" is a suprising argument to me to
which I honestly can only respond that I don't see a motivation for not
doing this. It unifies and simplifies code and removes variance.

There can't be performance differences between kref and refcount_t since
kref is implemented on top of refcount_t. All functions that Kirill is
replacing are static inline wrappers around refcount_t helpers.

I have no idea why it is wrong talking about reference counts just
because something can have multiple counters or reference counters.

Another way of looking at this is that this patchset removes maintenance
by moving the shared parts of reference counting into a single place.
They are literally shared across all namespaces. I don't see a specific
worry other than the very hand wavy "if we ever have to change something
we have to update the whole generic infrastructure". That could be used
to shoot down 30 cleanup patchsets each development cycle that
significantly contribute to code legibility and maintenance. This is
also how it should work and one of the great benefits of the namespace
infra along with other parts of the kernel is that it is nice and
generic.

If you have issues with the patch descriptions than I'm sure Kirill will
be happy to adapt them to include more detail. If he can't I'm happy to.

Since past experience tells me that we're unlikely to settle this
dispute let's bring in a few more people to take a look at this.

Christian
