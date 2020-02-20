Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E02C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCC2208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582238013;
	bh=mzPiCbr8XYsvkRVHCAOzgYnZ6/GsVqT7alkkqsg2qmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uxXqkf3ykP2bOF1od8mI27fXkRoQraU6VZJUpdKcIpul5TO0hIm8Rt5FHWd8UYFNw
	 8qj4WrZI8+soJVB77RRZ2uqnffpwC55IRgJX62ALkpLeVzr8CpebUMt+haRpSg1Cxk
	 alDeKKjYwGqJCJjrI+Z6/kbWpe5u52Y7VjExbI9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgBTWdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:33:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37319 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgBTWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:33:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so532lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=QiMLUGsRq9HWg+G+gXiEaS3g8vcEPOTXS0nkdYQXIsCA2EjphiI1+TGu1HVJ3od+BY
         4nIUXqbNSwvfL1zzmPatevn6ccupRjp+aZGa5eL8bOeMqUiv7Bg7Hz5IKilERFOA99sS
         jMLLQ3OrRmjEMgFi9TJzZnDfd0rXWYetgu1bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrNmlOpMVxzFXh2A2oJzXRWZK2fGDe1+SPIAN4gWybk=;
        b=cpKkUYiNwidk7Blo16tT7rz1FB5tA6QCfEjuQkWVkx4ED65qzPeRCKLf+Tn8P5RxSw
         Hn3Sg0Ul1rcLbf6BjyyyqAsdPZYKB1pFieyNIeFdsKDTmMKbtuslPJy70fHUFbwYlLyf
         roeLNufDzeR5h3soVE3DEGjP3sL5qXGjq63Cn7XVbOg7VmJqWuIywf7DUFrgVWSVQFby
         52L+G4rUa8jhuIWQO8f6WIeoUbT7X6JD1lWWBd2AdFAelCSryo9laOQ63zqy8fIHJ3y9
         hWlA0npb6dpmopPDFH0+U8CBEteM91AegkJZAMG1Th21S+pjrjz3P2MBL9Wxycjqe6/w
         Mvxw==
X-Gm-Message-State: APjAAAUDZueqMfgHrk1UvIW361rJHF1ZR5dfde2/4cv3LXuC/ejFk+6h
        4SbyTvqJpXXGEFnSKiYFF8frZCnJGZ8=
X-Google-Smtp-Source: APXvYqyUNwKD2WDj16QkB3x/SO3VBozWwt32oYyW3vPRVKx3/nTzlG09C9g3Qv3atE29VO463egxXw==
X-Received: by 2002:a05:6512:31c3:: with SMTP id j3mr2554120lfe.144.1582238008271;
        Thu, 20 Feb 2020 14:33:28 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l1sm475804lfg.56.2020.02.20.14.33.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 14:33:27 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e18so112920ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:33:26 -0800 (PST)
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr19716647ljj.241.1582238006401;
 Thu, 20 Feb 2020 14:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
 <87v9odlxbr.fsf@x220.int.ebiederm.org> <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org> <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
 <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
 <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87h7zl9e7u.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Feb 2020 14:33:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Message-ID: <CAHk-=wht3ZWRaYs8QBXuftfuiFGOTjjZ9zj3-Dz7dkiBhJNBrQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] proc: Mov rcu_read_(lock|unlock) in proc_prune_siblings_dcache
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:51 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Don't make it look like rcu_read_lock is held over the entire loop
> instead just take the rcu_read_lock over the part of the loop that
> matters.  This makes the intent of the code a little clearer.

No, this is horrid.

Maybe it makes the intent clearer, but it also causes that "continue"
case to unlock and relock immediately.

And maybe that case never triggers, and that's ok. But then it needs a
big comment about it.

              Linus
