Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D2EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E624686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgA1Nrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:47:52 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54264 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1Nrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:47:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1iwRDY-00020G-C5; Tue, 28 Jan 2020 06:47:48 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iwRDX-0006bg-Ma; Tue, 28 Jan 2020 06:47:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list\:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
References: <CACT4Y+bg1UKXzZF4a9y+5CfNYRwBc5Gx+GjPS0Dhb1n-Qf50+g@mail.gmail.com>
        <20200126085535.GA3533171@kroah.com>
        <20200126093506.oa2ee5kbptur4zhz@wittgenstein>
Date:   Tue, 28 Jan 2020 07:46:08 -0600
In-Reply-To: <20200126093506.oa2ee5kbptur4zhz@wittgenstein> (Christian
        Brauner's message of "Sun, 26 Jan 2020 10:35:07 +0100")
Message-ID: <87blqn3d9b.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iwRDX-0006bg-Ma;;;mid=<87blqn3d9b.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19TaqhwtfnOs4J3o+rZtj2FKDMPKZsQpjA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: binderfs interferes with syzkaller?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Sun, Jan 26, 2020 at 09:55:35AM +0100, Greg Kroah-Hartman wrote:
>> On Sat, Jan 25, 2020 at 06:49:49PM +0100, Dmitry Vyukov wrote:
>> > Hi binder maintainers,
>> > 
>> > It seems that something has happened and now syzbot has 0 coverage in
>> > drivers/android/binder.c:
>> > https://storage.googleapis.com/syzkaller/cover/ci-upstream-kasan-gce-root.html
>> > It covered at least something there before as it found some bugs in binder code.
>> > I _suspect_ it may be related to introduction binderfs, but it's
>> > purely based on the fact that binderfs changed lots of things there.
>> > And I see it claims to be backward compatible.
>> 
>> It is backwards compatible if you mount binderfs, right?
>
> Yes, it is backwards compatible. The devices that would usually be
> created in devtmpfs are now created in binderfs. The core
> binder-codepaths are the same.

Any chance you can add code to the binderfs case to automatically
create the symlinks to the standard mount location in devtmpfs?

That way existing userspace might not need to care how the kernel is
configured.

Eric

