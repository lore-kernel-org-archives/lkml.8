Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF97C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF4C207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GUJkBVdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMLLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:11:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44458 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:11:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so8703441qtr.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwo6CXoEExY4P7FhgrfOA4x+oRv3QDj7HzIdYTSbXyQ=;
        b=GUJkBVdzgnMf0uZMhvQz3acAlzbV4FMyCI7t0kYp7G0i+Sezxl6ysPMtzU9CleaPK7
         zzh8GYSESpFS4ifdi5j4tEHfKKTulXLoGcUk4plZuV427yJNjbLcluLDNjwj9YY1IEVR
         nXb/DRj9QH44Xc4QntHxM6ZCC7GEA2O1xYUDTvnC7GmsxDthlnAr9r+OKFVROOMbbXSk
         gI4XGR2Ah05yNxJFZwONuA6MlPHQfodqMoLlxZPQRr75St9qUTfOt9jPyaxGELAipg6C
         N0R3z2PqY9wO10Xk2x2y0rarFJMVTbyBpGw7T/f2UlQiDQlxNDJzy7LwUrMkVB/Lkk9q
         Ye/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwo6CXoEExY4P7FhgrfOA4x+oRv3QDj7HzIdYTSbXyQ=;
        b=pvSWYd4ZdNErvqS/eFZGD7Wuxe9yYESOvNI2m+gI7brvficVWHOpHjjHLKbO6MzbtY
         Tq1xg71DXQXToUQ61loKLpBU7RkmVEys9XlKDDRPH5pQqGRiYYnWufkc5BcnlKCXefz6
         nrt+/RgtQRezPnrFIQATT2gg/ura+xB2MWkXwMlHaEleVcsyrBcVYUdejWcEMi5qVRk1
         t6T+6KFp87SaIzQzR7SoqzotpHSPBKSK8v8KQyf2a717YmhZDG/VO7phI+mMATN4uvH5
         Kl0lzJBlNkaCHW58hxXUEf+1XfwAJwyI+1tHBmtFlIFbgT7DZXY7svkwvsvSC8IA7y4S
         u+hQ==
X-Gm-Message-State: APjAAAW4iF5rymqm09OiISa6EtaYAU13WccCcgbdoOUrS7nzEDcXAndb
        rszi92+cjUZFOxttKMgGQ1/411FHVws0HjZUldQTLg==
X-Google-Smtp-Source: APXvYqySTFt6N89yO1Yw19BS0G8z0FzW/aa7I0c2pvH1BRmQrAh93p2lsaSrgQi0i5kQDcsiPwJI34W6NH4r7TefH5k=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr13691627qtp.50.1578913894652;
 Mon, 13 Jan 2020 03:11:34 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
In-Reply-To: <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 13 Jan 2020 12:11:23 +0100
Message-ID: <CACT4Y+bTGp1J9Wn=93LUObdTcWPo2JrChYKF-1v6aXmtvoQgPQ@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Peter Zijlstra <peterz@infradead.org>,
        Cong Wang <xiyou.wangcong@gmail.com>, ap420073@gmail.com
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 11:59 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 28, 2018 at 9:56 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >> > Hello,
> > >> >
> > >> > syzbot found the following crash on:
> > >> >
> > >> > HEAD commit:    c307aaf3eb47 Merge tag 'iommu-fixes-v4.19-rc5' of git://gi..
> > >> > git tree:       upstream
> > >> > console output: https://syzkaller.appspot.com/x/log.txt?x=13810df1400000
> > >> > kernel config:  https://syzkaller.appspot.com/x/.config?x=dfb440e26f0a6f6f
> > >> > dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
> > >> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> > >> >
> > >> > Unfortunately, I don't have any reproducer for this crash yet.
> > >> >
> > >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > >> > Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com
> > >>
> > >> +LOCKDEP maintainers,
> > >>
> > >> What does this BUG mean? And how should it be fixed?
> > >>
> > >> Thanks
> > >>
> > >> > BUG: MAX_LOCKDEP_CHAINS too low!
> > >
> > > Is the his result of endlessly loading and unloading modules?
> > >
> > > In which case, the fix is: don't do that then.
> >
> > No modules involved, we don't have any modules in the image. Must be
> > something else.
> > Perhaps syzkaller just produced a workload so diverse that nobody ever produced.
>
> Peter, Ingo,
>
> This really plagues syzbot testing for more than a year now. These four:
>
> BUG: MAX_LOCKDEP_KEYS too low!
> https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc
>
> BUG: MAX_LOCKDEP_ENTRIES too low!
> https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
>
> BUG: MAX_LOCKDEP_CHAINS too low!
> https://syzkaller.appspot.com/bug?id=bf037f4725d40a8d350b2b1b3b3e0947c6efae85
>
> BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
>
>
> Now running testing I only see a stream of different lockdep bugs mostly:
>
> 2020/01/09 11:41:51 vm-13: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:43:09 vm-9: crash: INFO: task hung in register_netdevice_notifier
> 2020/01/09 11:44:00 vm-26: crash: no output from test machine
> 2020/01/09 11:44:11 vm-8: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:44:28 vm-19: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:46:20 vm-27: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:46:41 vm-15: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:46:45 vm-28: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:46:47 vm-29: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:46:49 vm-22: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:46:50 vm-10: crash: no output from test machine
> 2020/01/09 11:46:52 vm-18: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:46:53 vm-23: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:47:17 vm-20: crash: lost connection to test machine
> 2020/01/09 11:47:48 vm-5: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:47:56 vm-14: crash: WARNING in restore_regulatory_settings
> 2020/01/09 11:48:19 vm-2: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:48:21 vm-7: crash: BUG: MAX_LOCKDEP_ENTRIES too low!
> 2020/01/09 11:48:22 vm-3: crash: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> 2020/01/09 11:48:40 vm-25: crash: BUG: MAX_LOCKDEP_CHAINS too low!
>
> Should we just bump the limits there?
>
> Or are there some ID leaks in lockdep? syzbot has a bunch of very
> simple reproducers for these bugs, so not really a maximally diverse
> load. And I think I saw these bugs massively when testing just a
> single subsystem too, e.g. netfilter.

+Taehee, Cong,

In the other thread Taehee mentioned the creation of dynamic keys for
net devices that was added recently and that they are subject to some
limits.
syzkaller creates lots of net devices for isolation (several dozens
per test process, but then these can be created and destroyed
periodically). I wonder if it's the root cause of the lockdep limits
problems?
