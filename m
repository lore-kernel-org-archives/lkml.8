Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83DAC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA762070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtAP3h/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEHJd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgEHJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:33:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7CC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 02:33:25 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w29so285613qtv.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqXEjDaG+YGx0nXjgZ4W5HNVqJo925K86iqD302veHY=;
        b=GtAP3h/Z3PPH676mNtyFuDUd4QaE5wVZcq8hFWKATjr8OQA3NHM4mBIm5tr/e/Wfle
         tZKpzU4KBXvnm6U0NS6/6xvZh7Fgx0c6DwIGy5767Jz/8WsGfIW5qkCS1hyfJ1ZbadCw
         GersB2jGOkAqejndKmS66DV6IbmaK92JxrTFROGWp2iqaQkag9RKnVcmL59NzCQV92sO
         WAM893lT9sOa5/5sMWDdkHv8gY9ior9kh9wFL1hUBe8Sgn6Oni3wAdkBHHOHBXV5q9aR
         qd8OGJHs/s7fPbDOwxw6lZAh4fSrlSA3Q9+8rK5BMSjvJIX5l55A/Q/+oe8st5oXQFY5
         frBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqXEjDaG+YGx0nXjgZ4W5HNVqJo925K86iqD302veHY=;
        b=NrSYsBFhDtd2snLeXsrhD+i6tku1STd8Sf0geOGtHdoC8R/arW12NuTVe0t4NldmF+
         vd7PKiuiLvXkGq/VTNWx+VO0v+OzLRTObUjUEw14JrstB72fxB364TTj8dMQc+aGeBhz
         NGWHL8qLZCWgeqeaMmyAB+pu1K/JOGpiN2OZr/NqgBFWl70jfH1m0jXqrkVuNMr2FT4i
         uku164myv3LC/T6UXj+0hUdrjXPq+FTRR+zGlN/XjmdpZjcDA3KycCnqHA8KIcqDJZx1
         xc3Lh6Gvzf7xjPEOenHzSRDReDUF326lZu4Di/JEepVRoBYiDw3ZSHShlNvhZLUHDRt/
         9Cgw==
X-Gm-Message-State: AGi0Pub1Z6ygHA6xZJ6nRdkG39WLJmSSddnu5DWw5P+DrfQCnTbV75K9
        SL4BoyZVHEeJTrzqvYKUFb0iQTUNlbB6DRe9wrEoTw==
X-Google-Smtp-Source: APiQypJBReLlNI1lkKoH4ewz6Q2tA9L1d0ig5UwPjkpDV+PBKuDen+TP7tDZu/7zCfjlmMaE4Q+aq6NmYCbIFlSp4NM=
X-Received: by 2002:aed:3668:: with SMTP id e95mr2108070qtb.50.1588930403993;
 Fri, 08 May 2020 02:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039420505a14e4951@google.com> <1588755226.13662.17.camel@suse.com>
 <CAAeHK+zOdghTAu647iKBEU+0LqkYYOk0f7gPk_4T6BjNi=2sAQ@mail.gmail.com> <CAAeHK+xu_0BrnM5SKo5zNFvwunMDQWa+foD-y7MpnqjkP8tcbg@mail.gmail.com>
In-Reply-To: <CAAeHK+xu_0BrnM5SKo5zNFvwunMDQWa+foD-y7MpnqjkP8tcbg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 8 May 2020 11:33:12 +0200
Message-ID: <CACT4Y+b3q4C-1+L6Sa3fgOYEa3+XGuzfrfauaH_v9KXS7xH9Yw@mail.gmail.com>
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

On Thu, May 7, 2020 at 5:56 PM 'Andrey Konovalov' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Wed, May 6, 2020 at 1:50 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, May 6, 2020 at 10:54 AM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > Am Freitag, den 20.03.2020, 12:28 -0700 schrieb syzbot:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
> > > >
> > >
> > > Hi,
> > >
> > > is this bug still active and can a test be run on it? I requested one
> > > yesterday. If my analysis is correct this bug has security
> > > implications, so it is kind of important.
> >
> > I see your request in the queue and it's been registered and
> > completed, but for some reason syzbot didn't send an email with a
> > response.
> >
> > Let me try this once again:
> >
> > #syz test: https://github.com/google/kasan.git e17994d1
>
> Still no response. Dmitry, any idea what could be wrong here?

I suspect it has something to do with the fact that the bug is already
fixed (has a fixing commit).

...right, it was broken by:
https://github.com/google/syzkaller/commit/f8368f999a1964df6d39a225cd3f5ab3942dd755
and we lack a test for this scenario. It was supposed to only disable
mailing of bisection jobs.
