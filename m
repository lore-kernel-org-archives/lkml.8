Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD9FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61172073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390887AbgDCM77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:59:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:36454 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgDCM75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:59:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jKLvL-0003Ro-SW; Fri, 03 Apr 2020 06:59:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jKLvK-0004vx-B3; Fri, 03 Apr 2020 06:59:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        syzbot <syzbot+f675f964019f884dbd0f@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, gregkh@linuxfoundation.org, guro@fb.com,
        jlayton@kernel.org, joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
References: <00000000000011d66805a25cd73f@google.com>
        <20200403091135.GA3645@redhat.com>
        <20200403093612.mtd7edubsng24uuh@wittgenstein>
Date:   Fri, 03 Apr 2020 07:57:04 -0500
In-Reply-To: <20200403093612.mtd7edubsng24uuh@wittgenstein> (Christian
        Brauner's message of "Fri, 3 Apr 2020 11:36:12 +0200")
Message-ID: <87y2rc7mn3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jKLvK-0004vx-B3;;;mid=<87y2rc7mn3.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19N3Q2vee0CO2AL8kND4TBE4La6X4qmAFM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: possible deadlock in send_sigurg
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Apr 03, 2020 at 11:11:35AM +0200, Oleg Nesterov wrote:
>> On 04/02, syzbot wrote:
>> >
>> >                       lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4923
>> >                       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>> >                       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>> >                       spin_lock include/linux/spinlock.h:353 [inline]
>> >                       proc_pid_make_inode+0x1f9/0x3c0 fs/proc/base.c:1880
>> 
>> Yes, spin_lock(wait_pidfd.lock) is not safe...
>> 
>> Eric, at first glance the fix is simple.
>> 
>> Oleg.
>> 
>> 
>> diff --git a/fs/proc/base.c b/fs/proc/base.c
>
> Um, when did this lock get added to proc/base.c in the first place and
> why has it been abused for this?

Because struct pid is too bloated already.

> People just recently complained loudly about this in the
> cred_guard_mutex thread that abusing locks for things they weren't
> intended for is a bad idea...

The problem there is/was holding locks over places they shouldn't.
It looks like I made an equally dump mistake with struct pid.

That said can you take a look at calling putting do_notify_pidfd
someplace sane.  I can't see how it makes sense to call that in
the same set of circumstances where we notify the parent.

Reparenting should not be a concern, nor should ptracing.  Which I think
means that do_notify_pid can potentially get called many times more
than it needs to be.

Not to mention it is being called a bit too soon when called from
do_notify_parent.  Which I saw earlier is causing problems.  Signal
sending can call do_notify_parent early because everything just queues
up and no action is taken.  Wake-ups on the other hand trigger more
immediate action.

There is no connection to the current bug except this discussion
just remimded me about do_notify_pidfd and I figured I should say
something before I forget again.

Eric
