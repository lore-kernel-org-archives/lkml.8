Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0085C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AC42072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583433672;
	bh=SI67L1QpN86QO1mVrZpYPeR9UMqgmHas5Yh6SXS3L0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fnnbh9Z5H08lDEHfaY66pGRCB19AjNUPDpfSxx0zZd2meec6qjwGMJBSoJXQQkxFY
	 MNiKDXmtJxy6gQjLc3ZQxgamT61eLtwDJINldpWsmOzKSTN3eYqZWQfLzFI6UGS3SV
	 sf3CKvpZp2iWlsXvOmaO8Bp+MWSGJ/T95F/ri+8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCESlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:41:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39594 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCESlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:41:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id f10so7236971ljn.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyFYtqx37jEduc84+d5pwBxcfH/mxsB1MriBNxAX86U=;
        b=RHIX8oyd/XhxPGVZ1D8Gc7950WIw8PdXBWEEFQBGahK8v+TiZSToq8FzyieSsSUgZL
         LyrLSR6LXPvkeaUzuRnALL+vrw927bPnQhlbOm7VzIawQuLGpIw9vXotbZKKexGzj51P
         wyQEn8I3s2PxzDqma64uA7+QmDlRvDZZy4RaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyFYtqx37jEduc84+d5pwBxcfH/mxsB1MriBNxAX86U=;
        b=qeLM7YW0dKmtjI7TJGKXWeIDjSydaRVJxeEpwSGbMoFHfYes52qpukpJLITr6h07Es
         kYLlcVl1MePqOQdan1zv/rVo9K7mcp2yqqWWpFS/hm67zcxn/DQ3v12xpymS3hYb/+aF
         V90XpV57HiyabFcUuysh9kjSbRCuj2C4ICzet8QjtYimD/tDQIHw45SPOSRMMJCtzG7c
         W2rsDJGe3UVsncxFf0jmMGFj7nMTL1tWkLM4hiuBf3GdZdjdLcbFQZ9eAA1FUrM12P60
         LXl0Z+Z3ZZz4W3UnAQDBIsqzMke4SzPc8NQOfzIQYA/cL2EODoqe1J+K2ycvp+BBchc+
         dVZw==
X-Gm-Message-State: ANhLgQ1/iI4BbpRodiw2uDAQxwjB1Zh9gjHx1Yt2RVKAhdcDPjyjYiBn
        v8OG+KmrKiKILFAoJ5EKoMYXiMs3bXKa6Q==
X-Google-Smtp-Source: ADFU+vuYozBgNz+/E3RdR9nIa04vVPy6nJQLhbY71fbPs0LPaHE4PayuIa4cUbugpauSwXnUBS3POQ==
X-Received: by 2002:a2e:6a09:: with SMTP id f9mr5886673ljc.107.1583433669060;
        Thu, 05 Mar 2020 10:41:09 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b20sm16041022ljp.20.2020.03.05.10.41.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:41:08 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id q19so7246980ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:41:07 -0800 (PST)
X-Received: by 2002:a05:651c:502:: with SMTP id o2mr6169123ljp.150.1583433667474;
 Thu, 05 Mar 2020 10:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
 <CANaxB-zjYecWpjMoX6dXY3B5HtVu8+G9npRnaX2FnTvp9XucTw@mail.gmail.com>
 <CAHk-=wjd6BKXEpU0MfEaHuOEK-StRToEcYuu6NpVfR0tR5d6xw@mail.gmail.com>
 <CAHk-=wgs8E4JYVJHaRV2hMn3dxUnM8i0Kn2mA1SjzJdsbB9tXw@mail.gmail.com>
 <CAHk-=wiaDvYHBt8oyZGOp2XwJW4wNXVAchqTFuVBvASTFx_KfA@mail.gmail.com>
 <20200218182041.GB24185@bombadil.infradead.org> <CAHk-=wi8Q8xtZt1iKcqSaV1demDnyixXT+GyDZi-Lk61K3+9rw@mail.gmail.com>
 <20200218223325.GA143300@gmail.com> <CAHk-=wgKHFB9-XggwOmBCJde3V35Mw9g+vGnt0JGjfGbSgtWhQ@mail.gmail.com>
 <CANaxB-xTTDcshttGnVMgDLm96CC8FYsQT4LpobvCWSQym2=8qA@mail.gmail.com>
In-Reply-To: <CANaxB-xTTDcshttGnVMgDLm96CC8FYsQT4LpobvCWSQym2=8qA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Mar 2020 12:40:51 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgpHbbOhYtxC1rrZ4xjm1GSfZk6_roKU4++3TQVFDMXiw@mail.gmail.com>
Message-ID: <CAHk-=wgpHbbOhYtxC1rrZ4xjm1GSfZk6_roKU4++3TQVFDMXiw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 5, 2020 at 12:20 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> After this change, one more criu test became flaky. This is due to one
> of corner cases, so I am not sure that we need to fix something in the
> kernel. I have fixed this issue in the test. I am not sure that this
> will affect any real applications.

It's an interesting test-case, but it's really not doing anything you
should rely on.

The code basically expects a pipe write() to be "atomic" for something
bigger than PIPE_BUF. We've never really guaranteed that (and POSIX
doesn't), but we had this special case where readers would continue to
read as long as there was an active writer, which kind of approximated
that for some cases (and your test-case in particular).

A reader that wants to read everything should do multiple read() calls
until it gets an EOF (or gets the expected buffer size). A regular
read() on a pipe can simply always return a partial buffer (it will
always do so in the case of signals, but what you're seeing is that it
will also now do it if the kernel buffers emptied even when there was
a writer that was ready to fill them again).

And I suspect it wasn't actually the commit you point to that changes
the behavior, I think it's actually the "pipe: remove
'waiting_writers' merging logic" that changed behavior for your test

But because it's then timing-dependent on whether the reader gets all
the data or not, it might bisect to any commit after that point.
Particularly since some of the other commits change timing too..

We could re-introduce the "continue reading while there are active
writers" logic, but if this is the only test that triggers that, I'd
prefer to wait until some real user notices...

But if CRIU itself depends on this behavior (rather than just a test),
then I guess we need to.

So is it just a test-case, or does CRIU itself depend on that "reads
get full buffers"? As mentioned, that really _is_ fundamentally broken
if there is any chance of signals..

                Linus
