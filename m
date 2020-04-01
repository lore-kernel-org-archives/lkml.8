Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BC4C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B486720784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DCWoZP8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgDAIhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:37:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37750 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:37:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id de14so28644991edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Pb5WxXo01OUrPYKfuGBoAi7COZxVQpsVUvg17nkA6w=;
        b=DCWoZP8f/dOkjW5uYoUFpfMxBGbKeZuXpLeJJK8mTpafT0iBm07aAautrwxGNxNPuH
         kwa+oyklRAFDRmQ9G/64ndypZ3iC1AQSMWoHkTRNK/CJ98o+a+FWbDoEu0LWLRzfWA12
         BQCicYA5Tma7uC+qkVwM5zNRNQOh9LLVhWIgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Pb5WxXo01OUrPYKfuGBoAi7COZxVQpsVUvg17nkA6w=;
        b=aEEjsl5ngHPFo/RGWQEI5bxD+PDrQGWmYrnKYLvpcnlkDmWiK1pTR0e6S4WD7ZMPy2
         ITgzSSXV9NFqIBIrICdRhPmyM8PfHO+QUDPZ3O26BrMDxoZAd2EJx3kgAXtpveSJ1HBl
         E3L2TPQYeqzyAWMk54cxvmYH83tLN3rSlIVXpROEs9jMdIbyu0ewLJFgh6DEaH4EGeEU
         XeILceECd3VtYZIleRRh7HWk4peMBHsYdzWxlsmzABR+/7f+U0lTgpVFx9FL4mKYPVfa
         AO7JIIt2R3ggWZ2dvfEjcoKpKS/LS9hwCq2HhvIvdZNcD94wFwxl0ReQl0GturOAxIGw
         SnJQ==
X-Gm-Message-State: ANhLgQ0FahesWZoetHNXB4QISGvKvvHRffQa9i4oWCvAHZCaeGc1uFBC
        CSEnuQBxjFXGl3MmUnaD+EWJbOJ/rPKWMCgFiLIO/g==
X-Google-Smtp-Source: ADFU+vv25aObxVqudxs/b4t6TUDhdA8HhF0PuGfXX6HSZBIvhctUM+bsT6LQzuUGvDuTHabWaoYU8+dr8sw8QJ3EQ4c=
X-Received: by 2002:a50:8326:: with SMTP id 35mr19766368edh.134.1585730253359;
 Wed, 01 Apr 2020 01:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
 <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
 <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com> <2465266.1585729649@warthog.procyon.org.uk>
In-Reply-To: <2465266.1585729649@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 10:37:22 +0200
Message-ID: <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 10:27 AM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > According to dhowell's measurements processing 100k mounts would take
> > about a few seconds of system time (that's the time spent by the
> > kernel to retrieve the data,
>
> But the inefficiency of mountfs - at least as currently implemented - scales
> up with the number of individual values you want to retrieve, both in terms of
> memory usage and time taken.

I've taken that into account when guesstimating a "few seconds per
100k entries".  My guess is that there's probably an order of
magnitude difference between the performance of a fs based interface
and a binary syscall based interface.  That could be reduced somewhat
with a readfile(2) type API.

But the point is: this does not matter.  Whether it's .5s or 5s is
completely irrelevant, as neither is going to take down the system,
and userspace processing is probably going to take as much, if not
more time.  And remember, we are talking about stopping and starting
the automount daemon, which is something that happens, but it should
not happen often by any measure.

> With fsinfo(), I've tried to batch values together where it makes sense - and
> there's no lingering memory overhead - no extra inodes, dentries and files
> required.

The dentries, inodes and files in your test are single use (except the
root dentry) and can be made ephemeral if that turns out to be better.
My guess is that dentries belonging to individual attributes should be
deleted on final put, while the dentries belonging to the mount
directory can be reclaimed normally.

Thanks,
Miklos
