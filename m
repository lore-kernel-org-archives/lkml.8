Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB43C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B9A92065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyzeWhfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXOlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgGXOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:41:24 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9833C0619E5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:41:24 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d18so10042057ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9E66nUvcODIIIOq5t+2qbeVH/MSVvQN11l9oNW6GhyI=;
        b=vyzeWhfzUBv+3aCDt4bAbkZMDVC7ooJXOhKnolfXtu9A3d40lBkGooDb91bIunTCM4
         JhOzmmvBtL2Xz7JyAwEraF9uTjtY3wRYHxwIqE4gz8WQPxsaMaCXm12OwNRghR7xDBho
         vaHCMyrYn81hU9KBurVxoZOQgu1Kj2LXvbkrAUPo+aaliJPrSCFcESce3TkrEU0tyzV4
         9qIlhXFbZkyNo7yUsDaqowQQrrDfOwNx3smuImtKSzHEFHB1VgLf3BvyFmDQCioY+YKZ
         9rNBWCGP3SdRjIaEZGWo+VO6ljJKWzf0P4/9cqtBKzW2bJzvJBM26RwR6PjiwvuKQerz
         eKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9E66nUvcODIIIOq5t+2qbeVH/MSVvQN11l9oNW6GhyI=;
        b=Q6712naKXqDD5wlsoz9ntnuJavj6wkIskOhjwIjydU5MBz5oz64/OKfrtWYkLQ00hV
         kcsJTYuPmJcZSNVRbuvS/U8BWAad2VkgGzujaPIIFn9qfJi/Rok92ApBJFh2PM5KwFcm
         4x9GMTmg5pOK4qg/sF9gj2+QKq1VqvOBVN608/Stsp40Rn84TYHIXPMjqoxMTM6BGqz7
         pycseJohK8AZ/GYWf2SfmzIT2orMSHZpl9xxjQdTHedARRgyW8z3sjTjbyPgGDfQSclb
         4IzJ+7jTxJ+lginxDrPGa0aJuYMDCEq0NhJshFmdirBWiWvKjw4J721cJ/jrs+fZFE0H
         lfVg==
X-Gm-Message-State: AOAM531xuZdSJXsreXE5qV61s6bdAi/T0kH+DLM+Kmkq8YbeFDtSAcBl
        O+/zrmEfmpOF/pnU5XU4dmmq/uUH/0A5TiVdgy3G4Q==
X-Google-Smtp-Source: ABdhPJwAGCFsZ6cfW/RCed2pPReLn9Q4orINjlDAatEH6Czg9iP1uAc2Sj/EmE/i1I7eUakHAEQGgWrRJkRjKipv+Lg=
X-Received: by 2002:a5d:97d1:: with SMTP id k17mr10702728ios.100.1595601683730;
 Fri, 24 Jul 2020 07:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200724094505-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200724094505-mutt-send-email-mst@kernel.org>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Fri, 24 Jul 2020 07:41:12 -0700
Message-ID: <CA+EESO40x0+FW2ek5E=EYoHXt_AX2hvJ6QjbS=GSh9CpJQQRAA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Control over userfaultfd kernel-fault handling
To:     "Michael S. Tsirkin" <mst@redhat.com>, kernel@android.com
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
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Daniel Colascione <dancol@dancol.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:01 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 05:26:30PM -0700, Daniel Colascione wrote:
> > This small patch series adds a new flag to userfaultfd(2) that allows
> > callers to give up the ability to handle user-mode faults with the
> > resulting UFFD file object. In then add a new sysctl to require
> > unprivileged callers to use this new flag.
> >
> > The purpose of this new interface is to decrease the change of an
> > unprivileged userfaultfd user taking advantage of userfaultfd to
> > enhance security vulnerabilities by lengthening the race window in
> > kernel code.
>
> There are other ways to lengthen the race window, such as madvise
> MADV_DONTNEED, mmap of fuse files ...
> Could the patchset commit log include some discussion about
> why these are not the concern please?
>
> Multiple subsystems including vhost have come to rely on
> copy from/to user behaving identically to userspace access.
>
> Could the patchset please include discussion on what effect blocking
> these will have? E.g. I guess Android doesn't use vhost right now.
> Will it want to do it to run VMs in 2021?
>
> Thanks!
>
> > This patch series is split from [1].
> >
> > [1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
>
> So in that series, Kees said:
> https://lore.kernel.org/lkml/202002112332.BE71455@keescook/#t
>
> What is the threat being solved? (I understand the threat, but detailing
>   it in the commit log is important for people who don't know it.)
>

Adding Android security folks, Nick and Jeff, to answer.

> Could you pls do that?
>
> > Daniel Colascione (2):
> >   Add UFFD_USER_MODE_ONLY
> >   Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
> >
> >  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
> >  fs/userfaultfd.c                        | 18 ++++++++++++++++--
> >  include/linux/userfaultfd_k.h           |  1 +
> >  include/uapi/linux/userfaultfd.h        |  9 +++++++++
> >  kernel/sysctl.c                         |  9 +++++++++
> >  5 files changed, 48 insertions(+), 2 deletions(-)
> >
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
