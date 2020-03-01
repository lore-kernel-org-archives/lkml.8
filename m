Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57441C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C6E246C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 20:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geEqLlC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgCAUAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 15:00:53 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41152 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgCAUAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 15:00:51 -0500
Received: by mail-ot1-f66.google.com with SMTP id v19so7623840ote.8
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eSJCogFW+5WEfqSVoqYuW5WPipQ09ya4rXn8XpVI9lk=;
        b=geEqLlC1SOE3TSZPMu4eY2C7kEQ3iAEu8+MjDZth1yJJEz3aYIl8RZzNGqXKo+fdBK
         L3piqmGBZ+R6u2jb71FG+otXTb5dexaFNTIMqfdFtBwyUv8J83uWWiWpJL700olDe1KU
         jdQ95KSTEviW1p++P8rmN10buW8MUjs1Ce5bxgvibleP8FVy2pIqdkf+iVbKv0OxIfep
         R3lnoXwspaouzFJKvOL2TU0Ri+Z9X4sJEOZJahs/nnjs5Uj7mCy6y8dFFjwiRQtUui/3
         PYeYJCJjLDd5jpik81hu7laW8Arud8MEejgRzp/E94E5OSXDgeoA9nO6m2RJMQ1ob9wA
         F/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eSJCogFW+5WEfqSVoqYuW5WPipQ09ya4rXn8XpVI9lk=;
        b=NLi3voGjoyiXI6dA8S3tFA/hPRy+6g35mcP9mmn/FJJ7MYVwBS2cAWfeesmMcX9xME
         hV04nnaSD040XvDr1/QJQwxvwtL1MJUucgJUU2lE1Bs+7nIAVOCfoo7MJ9IBUSJmVkeS
         bz6WJ9zS7WNlShPAxMYfL7gTV+QnAVP9AI8jBgYCu6bOBUEhlCb5aw8/6Go4AmGJTFe/
         5qDCD9ybqlTLtCnf4bfbEhT/SM3qtCaJ0fKqegFh6Di8SGemBBMjryHCaUDPX8aQze80
         pJRpKbm0dlClYBz+GdL1F6JXM1PATFZCKcIM6a6LIr/4GvXOkz15G+LKul3BvkmTmba4
         d26Q==
X-Gm-Message-State: APjAAAUsS2rU+bEP0H4e0EXAZNkTbpQS73pMMRQqFT7Rg00wYJsHnfRl
        cZ8DxPUeWz9GFcYV1AKkwcP7WarNN/28UKOlsC63QQ==
X-Google-Smtp-Source: APXvYqxlPmGGj6lqZ/+U20/sqfXaMGOTkoLMW6nyRqaPvY8us5RwnrwLaHiGmuMsLhOUI/kEd8nfooddFe4/2Iz0+l8=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr10976903otl.110.1583092849244;
 Sun, 01 Mar 2020 12:00:49 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez3QHVpMJ9Rb_Q4LEE6uAqQJeS1Myu82U=fgvUfoeiscgw@mail.gmail.com> <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
In-Reply-To: <20200301185244.zkofjus6xtgkx4s3@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 1 Mar 2020 21:00:22 +0100
Message-ID: <CAG48ez3mnYc84iFCA25-rbJdSBi3jh9hkp569XZTbFc_9WYbZw@mail.gmail.com>
Subject: Re: [PATCH] exec: Fix a deadlock in ptrace
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 1, 2020 at 7:52 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Mar 01, 2020 at 07:21:03PM +0100, Jann Horn wrote:
> > On Sun, Mar 1, 2020 at 12:27 PM Bernd Edlinger
> > <bernd.edlinger@hotmail.de> wrote:
> > > The proposed solution is to have a second mutex that is
> > > used in mm_access, so it is allowed to continue while the
> > > dying threads are not yet terminated.
> >
> > Just for context: When I proposed something similar back in 2016,
> > https://lore.kernel.org/linux-fsdevel/20161102181806.GB1112@redhat.com/
> > was the resulting discussion thread. At least back then, I looked
> > through the various existing users of cred_guard_mutex, and the only
> > places that couldn't be converted to the new second mutex were
> > PTRACE_ATTACH and SECCOMP_FILTER_FLAG_TSYNC.
> >
> >
> > The ideal solution would IMO be something like this: Decide what the
> > new task's credentials should be *before* reaching de_thread(),
> > install them into a second cred* on the task (together with the new
> > dumpability), drop the cred_guard_mutex, and let ptrace_may_access()
> > check against both. After that, some further restructuring might even
>
> Hm, so essentially a private ptrace_access_cred member in task_struct?

And a second dumpability field, because that changes together with the
creds during execve. (Btw, currently the dumpability is in the
mm_struct, but that's kinda wrong. The mm_struct is removed from a
task on exit while access checks can still be performed against it, and
currently ptrace_may_access() just lets the access go through in that
case, which weakens the protection offered by PR_SET_DUMPABLE when
used for security purposes. I think it ought to be moved over into the
task_struct.)

> That would presumably also involve altering various LSM hooks to look at
> ptrace_access_cred.

When I tried to implement this in the past, I changed the LSM hook to
take the target task's cred* as an argument, and then called the LSM
hook twice from ptrace_may_access(). IIRC having the target task's
creds as an argument works for almost all the LSMs, with the exception
of Yama, which doesn't really care about the target task's creds, so
you have to pass in both the task_struct* and the cred*.
