Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5E522527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="me+nHO+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgA0RLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:11:16 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46294 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0RLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:11:16 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so7907860qtr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XsWyww+QgbXklC8MxgHKR4SlweUpSlsMS025zYGjX0o=;
        b=me+nHO+RJJ9pwknvGMxNKY4E+IIq2rfX81uDSJep64/JNvaqDYDa7kfwa5++7pg6Qc
         9qBxYeCKnArlG4B9+YtIuqZL8vsEJ5u1Ve8INj+sdQMjZ986c8lrmZafuE4Lg5h/H5oS
         tL1QvrBbFhgf9wPlM7BniGAn/nU7M9lQ70hdnBieA257ntb2JE3szZlI1EHsp6GoaV48
         3w0ns7UQ+ky4syC0xGMztwp786ZkcVq6GNGSU7pqOEreCBgzFqIBxlqhZXZCHeaZjg72
         A8cQzmR0i0cncpMm+ifTbo4l/ZMmlVWdFpgkrcBi/ceyOOx2NCTkZoGZbOvB4eSlgc/h
         E7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsWyww+QgbXklC8MxgHKR4SlweUpSlsMS025zYGjX0o=;
        b=NIVr1o+aRhh79MNI4g6M1pNlaEdBeeqqtBubfg09wTRT6xUQRvG6jHfTdb4Wk4AcYs
         OUKdQYgVIkwd7jIYKElryZzWsl+r5Wk6Jgs3Y+PacoZMkcX7ZV3sBdmlR6URHHCLc92z
         SqLzmMsMR38CjkIUSCNtmSgXcrCO2DwIENq+S3rROl5vQs/CHIM5eJIqKwoyW7cME5fm
         eWxmQ+MelCb+rv/H59n/dZ+veNrzAGTf6ax2SEe7z3x2W1vjF2KTH08YGTUFLLNQ8XM3
         bFViqvhw/JGmedLa+p8BuJH+4paRcK0Y+vSTlUcPGcn91hxZ6ofZBAL8yQxx10YsWUOA
         Cuxg==
X-Gm-Message-State: APjAAAUESAWxtKbDDU6Bh4/PL/iqoZhh0OdawJdBXFaIgu7QOBKQU8OH
        MMzxIeZz0+uZBaf2TqaIjCwEN14o9RDUIcbAEurW8A==
X-Google-Smtp-Source: APXvYqy5VT6LPP1sTcdJXPvGsFwol8OQElSUlAhWZheS+bJq22dM6OyWwO3nO6ssFpbLCp4wFxPtJv7ZkLGtKtOiTvg=
X-Received: by 2002:ac8:340c:: with SMTP id u12mr16371700qtb.257.1580145074290;
 Mon, 27 Jan 2020 09:11:14 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
 <CACT4Y+bckC4k-EpWiCkD+BBo5ypmkcb2g8Axb62LnBbwJjcqdw@mail.gmail.com> <20200126095132.bq33azq7paqvedzx@wittgenstein>
In-Reply-To: <20200126095132.bq33azq7paqvedzx@wittgenstein>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jan 2020 18:11:02 +0100
Message-ID: <CACT4Y+ZNJY9D3xmk21M7qaBjbD+1_GeigA1Z1FGHwC+3MNT-gw@mail.gmail.com>
Subject: Re: binderfs interferes with syzkaller?
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 10:51 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sat, Jan 25, 2020 at 07:13:03PM +0100, Dmitry Vyukov wrote:
> > On Sat, Jan 25, 2020 at 6:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > Hi binder maintainers,
> > >
> > > It seems that something has happened and now syzbot has 0 coverage in
> > > drivers/android/binder.c:
> > > https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> > > It covered at least something there before as it found some bugs in binder code.
> > > I _suspect_ it may be related to introduction binderfs, but it's
> > > purely based on the fact that binderfs changed lots of things there.
> > > And I see it claims to be backward compatible.
> > >
> > > syzkaller strategy to reach binder devices is to use
> > > CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
> > > give each test process a private one):
> > > https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671
> > >
> > > Then it knows how to open these /dev/binderN devices:
> > > https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
> > > and do stuff with them.
> > >
> > > Did these devices disappear or something?
> >
> > Oh, I see, it's backwards compatible if it's not enabled, right?
>
> It's backwards compatible.
> Let me give a little more detail. The legacy binder interface would
> create all devices listed in the module parameter
> CONFIG_ANDROID_BINDER_DEVICES. These devices were created using
> misc_register(&binder_device->miscdev);
> in the host's devtmpfs mount.
> If binderfs is enabled these devices are now created in the binderfs
> instance instead.
> For full backwards compatibility with old Android versions symlinks (or
> bind mounts) can be provided in the host's devtmpfs. This is what I
> recommended a few months ago.
>
> > And we enabled it because, well, enabling things generally gives more
> > coverage. I guess I will disable CONFIG_ANDROID_BINDERFS for now to
>
> I would at least try to test both somehow. It's likely that binderfs
> will replace legacy binder devices so if we could keep testing it
> somehow that would be great.
>
> > restore coverage in the binder itself.
>
> I'm not completely sure what you mean here. The binder IPC codepaths are
> nearly the same. The difference is mostly in how the device information
> is cast out before actual binder-ipc operations take place.
> In any case, testing both would obviously be preferred but binderfs
> strikes me as more worthy of testing.

I've reverted CONFIG_ANDROID_BINDERFS to "is not set" for now as the
easiest option. We've got 35% coverage of binder.c again.

By "restore coverage" I meant that even if the IPC codepaths are
nearly the same tests knew to open /dev/binderN and these disappeared,
so no test could open any binder device and get any coverage in binder
code.

If anybody wants to try to test both, you are very welcome ;)
If you are hinting that I should do it, a single person can't test all
2000 subsystems in kernel, and testing each of them requires quite
some domain expertise. This really requires involvement of developers
of the code. I am sure there is lots to improve in the IPC codepaths
as well.
