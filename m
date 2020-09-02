Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5A2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01412151B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgIBJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:08:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47035 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:08:53 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kDOl8-0000WB-GK; Wed, 02 Sep 2020 09:08:50 +0000
Date:   Wed, 2 Sep 2020 11:08:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Christian Brauner <christian@brauner.io>,
        syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] seccomp: don't leak memory when filter install races
Message-ID: <20200902090849.bvevcuhtae73pplm@wittgenstein>
References: <20200902014017.934315-1-tycho@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902014017.934315-1-tycho@tycho.pizza>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 07:40:16PM -0600, Tycho Andersen wrote:
> In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> the listener fd, then check to see if we can actually use it later in
> seccomp_may_assign_mode(), which can fail if anyone else in our thread
> group has installed a filter and caused some divergence. If we can't, we
> partially clean up the newly allocated file: we put the fd, put the file,
> but don't actually clean up the *memory* that was allocated at
> filter->notif. Let's clean that up too.
> 
> To accomplish this, let's hoist the actual "detach a notifier from a
> filter" code to its own helper out of seccomp_notify_release(), so that in
> case anyone adds stuff to init_listener(), they only have to add the
> cleanup code in one spot. This does a bit of extra locking and such on the
> failure path when the filter is not attached, but it's a slow failure path
> anyway.
> 
> Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> ---

This looks sane to me!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

One thing I noticed when checking the failure paths. In init_listener we
allocate the notifier by directly storing it into filter->notif and if
anon_inode_getfile() fails we simply kfree(filter->notif) but don't NULL
it and leave filter->notif pointing to freed memory.
Since we have a few places where we check filter->notif whether it is
initialized or not maybe we should NULL filter->notif if init_listener()
fails or alloc the notifier into a tmp variable and only assign it to
filter->notif after we can't fail anymore in init_listener().

Just a thought since the error path in seccomp_set_mode_filter() is a
little more complex. :)

Thanks!
Christian
