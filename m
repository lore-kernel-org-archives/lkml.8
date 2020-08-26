Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20CFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4920767
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGbJ2Yi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHZAYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHZAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:24:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:24:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e11so306054ils.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 17:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PhaVc46fB3y3C+IQtYQZZ5zU6t7TWG1wQZ/Bjf9fao=;
        b=rGbJ2Yi3tEgAgxB4tjVSu9oxzSlEA/v8vXQjwgRt0dmviuoTszefr/h4MVmsMdHcIP
         O/5zMbkShEMy61fbnpMD6bsp/L1BJE/HIl3ajGibH9pGHPJf1nfgAQ4eNBB0+szyYhYr
         ryXLeNC+Q9B56lJTTe5lGxuEhHm1xjmzI/ZI2XBG2it/vZ7Y5jD56J+dufKiDqLJHnrZ
         NP0+7wKSYfyNi1MFHF8L6smcFp5df/grB0wJuOr3pjFDYX8j2bgHPhCj5Ohv5bLGPpIG
         AfU7A4BHTWfRftS5XbnVU7NYJsdPe+BMazyvfSxrDahCA4Zay7kv3INPh0NdjZf0sEBY
         8nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PhaVc46fB3y3C+IQtYQZZ5zU6t7TWG1wQZ/Bjf9fao=;
        b=JCTLSV6WfcTSN6CmplU5XzgPB3FNTaj4Mcx8AY5uGbfenJYosOdRAa6Hq0RzyiI7Wx
         twi1vApOmewvEWVZHF0P39Quig1SrujtSFVAZofDRc2Zp/9sJ4TsSe7gGZw/7g5y8cxk
         ZBa41d5i6I1Uxjzi5H161a3zT3qbV3PpYpupwmeFLJJfBdbI6tT9lJKqnzrNdATf1acF
         2VxCjdMGCkRPnF3KFJgR1qcsE7PEki3MzS6H51y7p5ZwuQppjrpkKOF7kvizLbjNZI90
         mOkx7X+HdYbSO0iy2MLe6+TvSywR7vDY28dbbnHR7VF8g0P4sC0CwFmZsfE20Xxt1upx
         Pm+g==
X-Gm-Message-State: AOAM532qRu6O/FKOE/nJioirUNWUIjDtj7XQ+UyPxjl4u7ofPvD1EUL3
        JQcWo/G9bThkefxh5dG7m2ADNwgxlgqFCyI1VBf32A==
X-Google-Smtp-Source: ABdhPJzdIClyagWUDzamz8fAV/d2I4gI7NVREIzSGQv3DSbz0qFNSFZoQmgbvGFPGEeCYhE+Mm6VlCgbpqGu28sMmLw=
X-Received: by 2002:a92:d688:: with SMTP id p8mr11697017iln.82.1598401473429;
 Tue, 25 Aug 2020 17:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200822014018.913868-1-lokeshgidra@google.com>
 <20200822014018.913868-2-lokeshgidra@google.com> <20200824123247.finquufqpr6i7umb@linutronix.de>
In-Reply-To: <20200824123247.finquufqpr6i7umb@linutronix.de>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 25 Aug 2020 17:24:22 -0700
Message-ID: <CA+EESO5E5Kg1YaCP5FpPx4Qtnmf3H506f9ZA26=vugLDk=GkDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 5:32 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-08-21 18:40:17 [-0700], Lokesh Gidra wrote:
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
> >
> >  SYSCALL_DEFINE1(userfaultfd, int, flags)
> >  {
> > +     static const int uffd_flags = UFFD_USER_MODE_ONLY;
> >       struct userfaultfd_ctx *ctx;
> >       int fd;
> Why?

Not sure! I guess Daniel didn't want to repeat the long flag name twice.

Thanks for catching that. I'll send another version fixing this.
>
> Sebastian
