Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E6FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B1B207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHDMdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:33:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47594 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgHDMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:31:13 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k2w5V-0005dF-IX; Tue, 04 Aug 2020 12:30:37 +0000
Date:   Tue, 4 Aug 2020 14:30:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
Message-ID: <20200804123036.2lnkm6it7ko7j3ju@wittgenstein>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
 <20200804115649.kzea757e5wwpk4k3@wittgenstein>
 <87d046sj8w.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d046sj8w.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 07:11:59AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
> >> Every namespace type has its own counter. Some of them are
> >> of refcount_t, some of them are of kref.
> >> 
> >> This patchset introduces generic ns_common::count for any
> >> type of namespaces instead of them.
> >> 
> >> ---
> >
> > I was wondering why that series never made it to me turns out there's
> > some weird bug in my (neo)mutt where it sometimes marks messages as read
> > when I'm deleting completely unrelated messages. That has already cost
> > me a talk slot for an event I really wanted to attend and now it seems
> > to start costing me patches... I need to figure this out.
> >
> > Anyway, thanks for sending this. I pulled this into my tree now.
> 
> Actually why in the world should the reference count be generic?
> 
> What is the point of this patchset?
> 
> What problem does it solve.  Name spaces are not the same, and
> their refcounting needs are not the same so I don't have a clue how it
> helps anything to have a reference count in ns_common.

What is the point of this opposition to this cleanup?

It unifies reference counting across namespaces and gets rid of
inconsistencices. Over the years none of the namespaces seem to have
deviated enough from each that they really have needed separate
reference counting mechanisms.

Christian
