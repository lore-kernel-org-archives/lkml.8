Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958C3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E01020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S49gs35w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHDXev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHDXet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:34:49 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E5C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 16:34:49 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a5so28797904ioa.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGGF1J+ERy5X4cdVoozyTYTiQ8qrIwcki9GpVzuiAac=;
        b=S49gs35wchf/23S3uxZ+WP+evpMxe77HR56i82lZK5NggPBf9C072uwY/MRzBWTJUT
         uUkbo0r79QLmayMwJRaE7WWdaAvmRYlCw8pmFEetEeImITMz5f2Ch0y9KoVwOU84XUKz
         akVPWCRo77xUXadUti0PP1Cp9LhmUXz8zP6Tik+uyWkZVOMUlb+rhvvUm/6QBHvpcVS0
         GbmAXJIh2pl/ZVu288keExqTOg9TgMKZO8x3TMPp2xYJUgXnTLSFljth/xgJZ3DD5T48
         e4WzIsHdU67WlRmMsL0A8ZT3iW5ad5SKqWVlzhjuJoaQoFUlkcMv2avPx8JFFaR/UBv0
         8iuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGGF1J+ERy5X4cdVoozyTYTiQ8qrIwcki9GpVzuiAac=;
        b=hS28CiYIkA13ULQw+kqB1rzp2FEug5tS8Txj2CMnD+Y2TxshC8rvN0mskC00UnMPEr
         7KMn41sRe2OkUv/Nrhe4sKCmga8VebrX5Ba58XioW2nNyd2CKJvMQZKvEa0CVMzDxWZJ
         4uNyCQEVeECklus/7w2QlQVeaX4Ji/A+4JDdOiakXssI6Lq3MhDwXfyI/SUmTfqbla2d
         cVSHty0YlTidcQGoMLH0aMiRd8keFgvfEcrlhobTyoRGQ8gNSJQmkC24Oc2ccBS38iTr
         ehSohABBXD66QStkqxduHJOhH5kou4tZqf3pin62EBwmUrH+haizQq2uiISHBvn+gFEK
         8SjQ==
X-Gm-Message-State: AOAM532ZCpL5lC3rH5TEUEbLvtvJvXukKu9VKV3uHcW7j0U5D2GqusBo
        bYdRrFOiezQ/xFMny5+ro60C1Ozvh+9t7GAz42iaqg==
X-Google-Smtp-Source: ABdhPJxWwj+mGIKejG+Y+aEk2jXUwSEzd/PT3OCVEnMiGbJ2xhGfjVDUJ/Wp8D4RrKrlxyXIqKF7qjPbHA/qTDTnUZs=
X-Received: by 2002:a5d:824f:: with SMTP id n15mr405195ioo.95.1596584088451;
 Tue, 04 Aug 2020 16:34:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200804203155.2181099-1-lokeshgidra@google.com>
 <20200804204543.GA1992048@gmail.com> <CA+EESO6XGpiTLnxPraZqBigY7mh6G2jkHa2PKXaHXpzdrZd4wA@mail.gmail.com>
 <20200804205846.GB1992048@gmail.com>
In-Reply-To: <20200804205846.GB1992048@gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 4 Aug 2020 16:34:37 -0700
Message-ID: <CA+EESO7EtZSHmVTMJ53sHMUfrt0E8G7ywBZpYjh1f+oDpjW8=w@mail.gmail.com>
Subject: Re: [PATCH] Userfaultfd: Avoid double free of userfault_ctx and
 remove O_CLOEXEC
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, James Morris <jmorris@namei.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Calin Juravle <calin@google.com>, kernel-team@android.com,
        yanfei.xu@windriver.com,
        syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 1:58 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 01:49:30PM -0700, Lokesh Gidra wrote:
> > On Tue, Aug 4, 2020 at 1:45 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Tue, Aug 04, 2020 at 01:31:55PM -0700, Lokesh Gidra wrote:
> > > > when get_unused_fd_flags returns error, ctx will be freed by
> > > > userfaultfd's release function, which is indirectly called by fput().
> > > > Also, if anon_inode_getfile_secure() returns an error, then
> > > > userfaultfd_ctx_put() is called, which calls mmdrop() and frees ctx.
> > > >
> > > > Also, the O_CLOEXEC was inadvertently added to the call to
> > > > get_unused_fd_flags() [1].
> > > >
> > > > Adding Al Viro's suggested-by, based on [2].
> > > >
> > > > [1] https://lore.kernel.org/lkml/1f69c0ab-5791-974f-8bc0-3997ab1d61ea@dancol.org/
> > > > [2] https://lore.kernel.org/lkml/20200719165746.GJ2786714@ZenIV.linux.org.uk/
> > > >
> > > > Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > >
> > > What branch does this patch apply to?  Neither mainline nor linux-next works.
> > >
> > On James Morris' tree (secure_uffd_v5.9 branch).
> >
>
> For those of us not "in the know", that apparently means branch secure_uffd_v5.9
> of https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>
> Perhaps it would make more sense to resend your original patch series with this
> fix folded in?
>
OK. I'll resend the whole patch series with the fixes soon.

> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index ae859161908f..e15eb8fdc083 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -2042,24 +2042,18 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >               O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS),
> >               NULL);
> >       if (IS_ERR(file)) {
> > -             fd = PTR_ERR(file);
> > -             goto out;
> > +             userfaultfd_ctx_put(ctx);
> > +             return PTR_ERR(file);
> >       }
> >
> > -     fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> > +     fd = get_unused_fd_flags(O_RDONLY);
> >       if (fd < 0) {
> >               fput(file);
> > -             goto out;
> > +             return fd;
> >       }
> >
> >       ctx->owner = file_inode(file);
> >       fd_install(fd, file);
> > -
> > -out:
> > -     if (fd < 0) {
> > -             mmdrop(ctx->mm);
> > -             kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> > -     }
> >       return fd;
>
> This introduces the opposite bug: now it's hardcoded to *not* use O_CLOEXEC,
> instead of using the flag the user passed in the flags argument to the syscall.

I get your point. I agree the flags passed in to the syscall should be used.
>
> - Eric
