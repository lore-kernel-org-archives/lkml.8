Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788B1C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49951216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANvNB+It"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEHNvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgEHNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:51:15 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98B2C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:51:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb4so536637qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GusIZDLyGKObXLaDX4j+AFjvmp6VctXRvo86A2qqRTY=;
        b=ANvNB+ItxhX0LukDFkSlO2iamrJWhTqBNZPAgLOI6TGvXVQPER9P9dHO9R8MaBHuIy
         oLGFZJUoXZFa8iwl6dq3NdzLCUqzOffrEczbkWDBaEULHTE8DyRA4gzeIW/0KyUdfoZk
         0EN1fAzWX46X7xZc/n6FSXWTN4OqzOka0t/R7AiwOx5u8vrIHWJaEu7/TFd5ArWCSdJE
         qGBIGF213IBiQEfaVnzFK/7fjksPzih2dpuhG4lUf4DrsHZllxQS9ILc6ZbXo7NHQrpB
         eZDqHBg2Rl0sOb1Nid4ANC6bx+zqlI94M1gYZQnYiQjzXnOAFoOvuJUj2DRS8/nLUX/x
         qoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GusIZDLyGKObXLaDX4j+AFjvmp6VctXRvo86A2qqRTY=;
        b=LbPd2SpZw+Ea55ppfNNngRyDNBlt8ulFZVGTO3fgS/N3Osg4FsTotjVwpdImA4fmN3
         Jj6XW4kxRmVBXNFGvUWkxn963GTuOkUCX/uE4qysdaIg8IHCtZ2zF1L7HDPV1ZwcPNYC
         AK4R0WjVT3s9CanuvjtPqaHNN5yJbKemvxtltUXx3qcB92DdWJEM18UU1P0FVgD9HFKG
         NvX22SSOeKMWb/xVx6Sj3aH1fM6UaLZNz7V4Iwbj1XFVt7d2SoBNdVwlGvAkwuukYXI8
         apmBY/oAk+2BKvNBiU/qA8wj4hVBfE63lZZmV9jCcINcL9xYbFIPCMo4xsq2fp0b1w5V
         9ppg==
X-Gm-Message-State: AGi0PuYwISdxNVd2/P9ycCPqoHjv9qAJQnveNj27hd5Z0Q9UPNFcxWuX
        XJ7VhSJN8XOV5O817MmBpMP+D0HygOkvBVktTVivAA==
X-Google-Smtp-Source: APiQypJg4Ssy15CyoMVkq6xudLjz21kzjN5o45bwMN5wiI7VqSjH9DFdZGHTskHEuLGotdcf0EmU0mry1fYPeJ1gU6c=
X-Received: by 2002:ad4:53a2:: with SMTP id j2mr2924644qvv.159.1588945874489;
 Fri, 08 May 2020 06:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039420505a14e4951@google.com> <1588755226.13662.17.camel@suse.com>
 <CAAeHK+zOdghTAu647iKBEU+0LqkYYOk0f7gPk_4T6BjNi=2sAQ@mail.gmail.com>
 <CAAeHK+xu_0BrnM5SKo5zNFvwunMDQWa+foD-y7MpnqjkP8tcbg@mail.gmail.com>
 <CACT4Y+b3q4C-1+L6Sa3fgOYEa3+XGuzfrfauaH_v9KXS7xH9Yw@mail.gmail.com> <CACT4Y+YBz0uAqYw0_-1eRsuUgHvPgpwrf2RGyHJwsyAUGbBd5g@mail.gmail.com>
In-Reply-To: <CACT4Y+YBz0uAqYw0_-1eRsuUgHvPgpwrf2RGyHJwsyAUGbBd5g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 May 2020 15:51:02 +0200
Message-ID: <CACT4Y+bFYVk_6L7pKY7YvzFjNuqRFmSQU5YoCxWMM4is5ofjBA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
To:     Andrey Konovalov <andreyknvl@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, nishkadg.linux@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 12:31 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, May 7, 2020 at 5:56 PM 'Andrey Konovalov' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > On Wed, May 6, 2020 at 1:50 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > >
> > > > On Wed, May 6, 2020 at 10:54 AM Oliver Neukum <oneukum@suse.com> wrote:
> > > > >
> > > > > Am Freitag, den 20.03.2020, 12:28 -0700 schrieb syzbot:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> > > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> > > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > is this bug still active and can a test be run on it? I requested one
> > > > > yesterday. If my analysis is correct this bug has security
> > > > > implications, so it is kind of important.
> > > >
> > > > I see your request in the queue and it's been registered and
> > > > completed, but for some reason syzbot didn't send an email with a
> > > > response.
> > > >
> > > > Let me try this once again:
> > > >
> > > > #syz test: https://github.com/google/kasan.git e17994d1
> > >
> > > Still no response. Dmitry, any idea what could be wrong here?
> >
> > I suspect it has something to do with the fact that the bug is already
> > fixed (has a fixing commit).
> >
> > ...right, it was broken by:
> > https://github.com/google/syzkaller/commit/f8368f999a1964df6d39a225cd3f5ab3942dd755
> > and we lack a test for this scenario. It was supposed to only disable
> > mailing of bisection jobs.
>
> Fixed in https://github.com/google/syzkaller/commit/2b98fdbcbcac6e99d12c88857406ef446bcac872
> and added a test to fix this behavior for future.
> Thanks for the report.

syzbot dashboard will now also show patch testing requests on the bug
page for better transparency, see e.g. for this bug:
https://syzkaller.appspot.com/bug?id=093ce698cf84160a66868dcac5394e105342f8c5#jobs

FTR, implemented in:
https://github.com/google/syzkaller/commit/e97b06d3cef9296e9d0e827c42bccdd36b555986
