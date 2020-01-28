Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67925C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C03A24685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgA1Ny5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:54:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgA1Ny4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:54:56 -0500
Received: from ip5f5bd665.dynamic.kabel-deutschland.de ([95.91.214.101] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iwRKG-0005ee-6F; Tue, 28 Jan 2020 13:54:44 +0000
Date:   Tue, 28 Jan 2020 14:54:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: binderfs interferes with syzkaller?
Message-ID: <20200128135443.v6w4yxbs4cnq62ac@wittgenstein>
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
 <20200126085535.GA3533171@kroah.com>
 <20200126093506.oa2ee5kbptur4zhz@wittgenstein>
 <87blqn3d9b.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blqn3d9b.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 07:46:08AM -0600, Eric W. Biederman wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
> 
> > On Sun, Jan 26, 2020 at 09:55:35AM +0100, Greg Kroah-Hartman wrote:
> >> On Sat, Jan 25, 2020 at 06:49:49PM +0100, Dmitry Vyukov wrote:
> >> > Hi binder maintainers,
> >> > 
> >> > It seems that something has happened and now syzbot has 0 coverage in
> >> > drivers/android/binder.c:
> >> > https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
> >> > It covered at least something there before as it found some bugs in binder code.
> >> > I _suspect_ it may be related to introduction binderfs, but it's
> >> > purely based on the fact that binderfs changed lots of things there.
> >> > And I see it claims to be backward compatible.
> >> 
> >> It is backwards compatible if you mount binderfs, right?
> >
> > Yes, it is backwards compatible. The devices that would usually be
> > created in devtmpfs are now created in binderfs. The core
> > binder-codepaths are the same.
> 
> Any chance you can add code to the binderfs case to automatically
> create the symlinks to the standard mount location in devtmpfs?

Yeah, that's certainly doable and should be fairly easy. My reasoning
for not doing it was that it would be trivial for userspace to add in
the symlinks with an init script or service file.
We can also place this CONFIG_BINDERFS_DEVTMFPS_SYMLINK (random name)
which defaults to Y. Then - if userspace decides to completely move
from /dev/binder* to /dev/binderfs/binder* nodes and doesn't need the
symlinks - they can opt out of this by setting it to N. If Todd agrees
that something like this makes for Android too then we can do this.

Christian
