Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04626C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE18B20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="X6WKn1iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgFATCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgFATCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:02:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:02:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s19so8083606edt.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2AE9zA522dGubyF5+BcWXLnStw6uvUihnoLcDF2u4E=;
        b=X6WKn1iBvcV6+zLFWptbRHbE8t8cLcnVQBkjk3mU9xb/mXLna5lzKLHhGukjDNB1g3
         MQCJEtx5lsUQ4EK3cKdvthLCA5tq2Vjckr7gISvq6Czgfm349xD2ntTDpnwMOAWPusG9
         Wjw8ZkICVRATuJ7eUr2rgqjdjUAoZojzieQd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2AE9zA522dGubyF5+BcWXLnStw6uvUihnoLcDF2u4E=;
        b=VU5G9C4kKpDoHwe4ktAxNfrsCLs/AqmiZzzdkejn5Xe0qgzHDo6FvoM0xUFk0UuJE9
         b9cYe5+4N2q/Ysn3XUJ7QUhdxp3tUqXPQEREAcYvMH1HsJ+YKndCYvpm8uDAVT8AZiJR
         IVOjh95Ey0vhOOhGV1GcV817fNd5yvMay2E0J2XEfaCEQXCGdeILes/YvFPFa3lYigG8
         Fwj72jMNc2vHdhVXbQ8ikY2rV4bdEJF0hRcxTZpo2+P9Uj01paypKcHQZ9OJTUkSlZRR
         /5oefgLbsp4H//frUcnHwc23+UBAN6OG8kEm4Outfx0t3Mbx3gCTpfbdGiHq4x34U2pQ
         6LjA==
X-Gm-Message-State: AOAM533LJTwgUPLkro4UTjayyblhQYtdq1H0nfxqjsTaUsqVbJkkHLfQ
        GznCcwQ9gnOwKanU6XI2dI3bC2d6hwaldiPVWAiCzw==
X-Google-Smtp-Source: ABdhPJz2Ys9IBVALZHNzovIQqmMTrWJqhKK0ulR/xBQgSgDjHnohALleHcNZrxWPzazLrTxkpwSUZEO/tto16xW88tY=
X-Received: by 2002:a50:cf4c:: with SMTP id d12mr23338318edk.121.1591038167079;
 Mon, 01 Jun 2020 12:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110858.3265-1-sargun@sargun.me> <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook> <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook> <20200530140837.GM23230@ZenIV.linux.org.uk> <202005300834.6419E818A7@keescook>
In-Reply-To: <202005300834.6419E818A7@keescook>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 1 Jun 2020 12:02:10 -0700
Message-ID: <CAMp4zn88ZKwKJyp+ekZnbVsjbTceHCM7d5yTqsR63BNP1QMv7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 9:07 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sat, May 30, 2020 at 03:08:37PM +0100, Al Viro wrote:
> > On Fri, May 29, 2020 at 07:43:10PM -0700, Kees Cook wrote:
> >
> > > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > > move the put_user() after instead? I think cleanup would just be:
> > > replace_fd(fd, NULL, 0)
> >
> > Bollocks.
> >
> > Repeat after me: descriptor tables can be shared.  There is no
> > "cleanup" after you've put something there.
>
> Right -- this is what I was trying to ask about, and why I didn't like
> the idea of just leaving the fd in the table on failure. But yeah, there
> is a race if the process is about to fork or something.
>
> So the choice here is how to handle the put_user() failure:
>
> - add the put_user() address to the new helper, as I suggest in [1].
>   (exactly duplicates current behavior)
> - just leave the fd in place (not current behavior: dumps a fd into
>   the process without "agreed" notification).
> - do a double put_user (once before and once after), also in [1].
>   (sort of a best-effort combo of the above two. and SCM_RIGHTS is
>   hardly fast-pth).
>
> -Kees
>
> [1] https://lore.kernel.org/linux-api/202005282345.573B917@keescook/
>
> --
> Kees Cook

I'm going to suggest we stick to the approach of doing[1]:
1. Allocate FD
2. put_user
3. "Receive" and install file into FD

That is the only way to preserve the current behaviour in which userspace
is notified about *every* FD that is received via SCM_RIGHTS. The
scm_detach_fds code as it reads today does effectively what is above,
in that the fd is not installed until *after* the put user. Therefore
if put_user
gets an EFAULT or ENOMEM, it falls through to the MSG_CTRUNC bit.

The approach suggested[2] has a "change" in behaviour, in that (all in
file_receive):
1. Allocate FD
2. Receive file
3. put_user

Based on what Al Viro said, I don't think we can simply add step #4,
being "just" uninstall the FD.

[1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2179418.html
[2]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2179453.html
