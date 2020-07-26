Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DE1206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp/rjJ+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGZKJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:09:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53303 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgGZKJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595758179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sIvwu7K9SqdDH+YyFZSr+t919UDZvpdGGU+tcd+RfA=;
        b=cp/rjJ+OYP8TluCljOLKsu3MC2aNYo9WXLXrmiKHZNPdNBgH15NtJ934FirykrjEXvlnj/
        7fLhz5xV+3bBIiKP6xrITY9ie6iFMBYW1WOTFy8L4vXop3//UxiaVQvSEzyJoEal4i48bj
        SZQNTpSuaQTWrTFSXmbLoHrLk+N7KYI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-pj_d4wJcOyigjSDEooJD_Q-1; Sun, 26 Jul 2020 06:09:37 -0400
X-MC-Unique: pj_d4wJcOyigjSDEooJD_Q-1
Received: by mail-wr1-f72.google.com with SMTP id t12so3003316wrp.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3sIvwu7K9SqdDH+YyFZSr+t919UDZvpdGGU+tcd+RfA=;
        b=g9pjebW/YkbBNYZytj/jUQIu/HgR68tsJxn4v2pdNbij/QZ78tMwiC59jKzMnrVlBJ
         6pCpCtmWBNdS3BJcJetDjAc3dTzGjzSdYGlcUYUcmdurBxIsTb8ATXUQWRDtucj3sVZA
         6DYW78rv+4YWnxJdUOl7VQ/dvvuhHR9F1RRI6JVbTgFI3hAxu4XzMGLczC8+v66pVRvl
         AN0jf++QODI56nYBfmawEPmZfTsvu/0nx65HPAnXVY+VrtmvwgG2gLeZe6L0q3U66xn7
         grIgKMVBGfBEcdYk5muZRg0KuWtgdKOZAX5eWd6QPXhReAp5PEpbQlyFXODQfqJGWG5Y
         YBJQ==
X-Gm-Message-State: AOAM532oaWnKUYt25S2F9Mwvgxlv9MTF4dJtCaVMWPJ7A8lEtAxHGZrd
        azxnVTG9QgEpZ0qswZH6DBI/9fn7qm0sxL4Dmp8Mbg0NKDYM4fZgCqmubAmdELemJFA8QZW7AEl
        KU4Zy88Co0sw8PthoxZqcy0QQ
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr14267320wrp.350.1595758176667;
        Sun, 26 Jul 2020 03:09:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyeagaXIyDRQVUdiTAmZhi8E9eNNbi/NJxhIjqJWdFPNnEzyRTVrBBwxviq/qrNT/O0GBBuQ==
X-Received: by 2002:adf:f6c9:: with SMTP id y9mr14267299wrp.350.1595758176345;
        Sun, 26 Jul 2020 03:09:36 -0700 (PDT)
Received: from redhat.com (93-172-53-68.bb.netvision.net.il. [93.172.53.68])
        by smtp.gmail.com with ESMTPSA id 33sm8625535wri.16.2020.07.26.03.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 03:09:35 -0700 (PDT)
Date:   Sun, 26 Jul 2020 06:09:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>, kernel@android.com,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20200726060348-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-2-dancol@google.com>
 <20200724100153-mutt-send-email-mst@kernel.org>
 <CA+EESO4yw+qoGx9WWJDcDea8EvGQNzHHQFzfG2FcN=iCcET8tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO4yw+qoGx9WWJDcDea8EvGQNzHHQFzfG2FcN=iCcET8tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 07:46:02AM -0700, Lokesh Gidra wrote:
> On Fri, Jul 24, 2020 at 7:28 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 05:26:31PM -0700, Daniel Colascione wrote:
> > > userfaultfd handles page faults from both user and kernel code.  Add a
> > > new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
> > > resulting userfaultfd object refuse to handle faults from kernel mode,
> > > treating these faults as if SIGBUS were always raised, causing the
> > > kernel code to fail with EFAULT.
> > >
> > > A future patch adds a knob allowing administrators to give some
> > > processes the ability to create userfaultfd file objects only if they
> > > pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> > > will exploit userfaultfd's ability to delay kernel page faults to open
> > > timing windows for future exploits.
> > >
> > > Signed-off-by: Daniel Colascione <dancol@google.com>
> >
> > Something to add here is that there is separate work on selinux to
> > support limiting specific userspace programs to only this type of
> > userfaultfd.
> >
> > I also think Kees' comment about documenting what is the threat being solved
> > including some links to external sources still applies.
> >
> > Finally, a question:
> >
> > Is there any way at all to increase security without breaking
> > the assumption that copy_from_user is the same as userspace read?
> >
> >
> > As an example of a drastical approach that might solve some issues, how
> > about allocating some special memory and setting some VMA flag, then
> > limiting copy from/to user to just this subset of virtual addresses?
> > We can then do things like pin these pages in RAM, forbid
> > madvise/userfaultfd for these addresses, etc.
> >
> > Affected userspace then needs to use a kind of a bounce buffer for any
> > calls into kernel.  This needs much more support from userspace and adds
> > much more overhead, but on the flip side, affects more ways userspace
> > can slow down the kernel.
> >
> > Was this discussed in the past? Links would be appreciated.
> >
> Adding Nick and Jeff to the discussion.

I guess a valid alternative is to block major faults in copy
to/from user for a given process/group of syscalls. Userspace can mlock
an area it uses for these system calls.

For example, allow BPF/security linux policy block all major faults
until the next syscall.  Yes that would then include userfaultfd.


> >
> > > ---
> > >  fs/userfaultfd.c                 | 7 ++++++-
> > >  include/uapi/linux/userfaultfd.h | 9 +++++++++
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index e39fdec8a0b0..21378abe8f7b 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -418,6 +418,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> > >
> > >       if (ctx->features & UFFD_FEATURE_SIGBUS)
> > >               goto out;
> > > +     if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> > > +         ctx->flags & UFFD_USER_MODE_ONLY)
> > > +             goto out;
> > >
> > >       /*
> > >        * If it's already released don't get it. This avoids to loop
> > > @@ -2003,6 +2006,7 @@ static void init_once_userfaultfd_ctx(void *mem)
> > >
> > >  SYSCALL_DEFINE1(userfaultfd, int, flags)
> > >  {
> > > +     static const int uffd_flags = UFFD_USER_MODE_ONLY;
> > >       struct userfaultfd_ctx *ctx;
> > >       int fd;
> > >
> > > @@ -2012,10 +2016,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> > >       BUG_ON(!current->mm);
> > >
> > >       /* Check the UFFD_* constants for consistency.  */
> > > +     BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
> > >       BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
> > >       BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
> > >
> > > -     if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> > > +     if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
> > >               return -EINVAL;
> > >
> > >       ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
> > > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > > index e7e98bde221f..5f2d88212f7c 100644
> > > --- a/include/uapi/linux/userfaultfd.h
> > > +++ b/include/uapi/linux/userfaultfd.h
> > > @@ -257,4 +257,13 @@ struct uffdio_writeprotect {
> > >       __u64 mode;
> > >  };
> > >
> > > +/*
> > > + * Flags for the userfaultfd(2) system call itself.
> > > + */
> > > +
> > > +/*
> > > + * Create a userfaultfd that can handle page faults only in user mode.
> > > + */
> > > +#define UFFD_USER_MODE_ONLY 1
> > > +
> > >  #endif /* _LINUX_USERFAULTFD_H */
> > > --
> > > 2.26.2.303.gf8c07b1a785-goog
> > >
> >

