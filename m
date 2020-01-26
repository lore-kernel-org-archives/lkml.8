Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D9EC35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C732071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 09:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAZJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 04:51:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57130 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgAZJvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 04:51:38 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iveZn-0000sp-Ii; Sun, 26 Jan 2020 09:51:31 +0000
Date:   Sun, 26 Jan 2020 10:51:33 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: binderfs interferes with syzkaller?
Message-ID: <20200126095132.bq33azq7paqvedzx@wittgenstein>
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
 <CACT4Y+bckC4k-EpWiCkD+BBo5ypmkcb2g8Axb62LnBbwJjcqdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+bckC4k-EpWiCkD+BBo5ypmkcb2g8Axb62LnBbwJjcqdw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 07:13:03PM +0100, Dmitry Vyukov wrote:
> On Sat, Jan 25, 2020 at 6:49 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > Hi binder maintainers,
> >
> > It seems that something has happened and now syzbot has 0 coverage in
> > drivers/android/binder.c:
> > https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> > It covered at least something there before as it found some bugs in binder code.
> > I _suspect_ it may be related to introduction binderfs, but it's
> > purely based on the fact that binderfs changed lots of things there.
> > And I see it claims to be backward compatible.
> >
> > syzkaller strategy to reach binder devices is to use
> > CONFIG_ANDROID_BINDER_DEVICES to create a bunch of binderN devices (to
> > give each test process a private one):
> > https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L5671
> >
> > Then it knows how to open these /dev/binderN devices:
> > https://github.com/google/syzkaller/blob/master/sys/linux/dev_binder.txt#L22
> > and do stuff with them.
> >
> > Did these devices disappear or something?
> 
> Oh, I see, it's backwards compatible if it's not enabled, right?

It's backwards compatible.
Let me give a little more detail. The legacy binder interface would
create all devices listed in the module parameter
CONFIG_ANDROID_BINDER_DEVICES. These devices were created using 
misc_register(&binder_device->miscdev);
in the host's devtmpfs mount.
If binderfs is enabled these devices are now created in the binderfs
instance instead.
For full backwards compatibility with old Android versions symlinks (or
bind mounts) can be provided in the host's devtmpfs. This is what I
recommended a few months ago.

> And we enabled it because, well, enabling things generally gives more
> coverage. I guess I will disable CONFIG_ANDROID_BINDERFS for now to

I would at least try to test both somehow. It's likely that binderfs
will replace legacy binder devices so if we could keep testing it
somehow that would be great.

> restore coverage in the binder itself.

I'm not completely sure what you mean here. The binder IPC codepaths are
nearly the same. The difference is mostly in how the device information
is cast out before actual binder-ipc operations take place.
In any case, testing both would obviously be preferred but binderfs
strikes me as more worthy of testing.

Christian
