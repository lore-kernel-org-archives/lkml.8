Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCF6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A8E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389988AbgDBXE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:04:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:49346 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgDBXE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:04:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK8sp-0005Tp-0a; Thu, 02 Apr 2020 17:04:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK8sg-00008X-Tf; Thu, 02 Apr 2020 17:04:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
Date:   Thu, 02 Apr 2020 18:01:32 -0500
In-Reply-To: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 2 Apr 2020 14:46:24 -0700")
Message-ID: <87lfnda3w3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jK8sg-00008X-Tf;;;mid=<87lfnda3w3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/abTF2Bu9l/bRBd6j4R51hnTCJ4P/fyIE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> There are two more patches, which might be of interest for you, just to
>> make the picture complete.
>> It is not clear if we go that way, or if Eric has a yet better idea.
>>
>> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
>> https://www.spinics.net/lists/kernel/msg3459067.html
>
> There is no way I would ever take that patch.
>
> The amount of confusion in that patch is not acceptable. Randomly
> unlocking the new lock?
>
> That code makes everything worse, it's completely incomprehensible,
> the locking rules make no sense ahwt-so-ever.
>
> I'm seriously starting to feel like I should not have pulled this
> code, because the future looks _worse_ than what we used to have.
>
> No. No no no. Eric, this is not an acceptable direction.

That is not the direction I intend to take either.

I was hoping I could put off replying to this thread for a bit because
I only managed to get 4 hours of sleep last night and I am not as alert
to technical details as I would like to be.

Long story short:

The exec_update_mutex is to be a strict subset of today's
cred_guard_mutex.  I tried to copy cred_guard_mutex's unlock style so
that was obvious and that turns out was messier than I intended.

I thought the changes to the individual locking changes were
sufficiently unsubtle that they did not need my personal attention.
Especially as they are just a substitution of one lock for another
with a slightly smaller scope.

I started working on the the series of changes that reorganizes
the changes in exec.

It was reported that something had gone wrong with my introduction
of exec_update_mutex and I pulled it from linux-next.

By the time I was ready to start putting humpty dumpty back together
again Bernd had collected everything up and had it working.  I had seen
that he had been given the feedback about better change descriptions.

I had looked at the code of his patches earlier and the basic changes
were trivial.

Since I thought I already knew what was in the patches and the worst
problem was the missing unlock of cred_guard_mutex, and I know Bernd's
patches had been tested I applied them.  I missed that Bernd had added
the exec_mmap_called flag into my patch.  I thought he had only added
the missing unlock.

I spotted the weirdness in unlocking exec_update_mutex, and because it
does fix a real world deadlock with ptrace I did not back it out from my
tree.

I have been much laxer on the details than I like to be my apologies.

The plan is:
	exec_udpate_mutex will cover just the subset of cred_guard_mutex
        after the point of no return, and after we do any actions that
	might block waiting for userspace to do anything.

	So exec_update_mutex will just cover those things that exec
        is updating, so if you want an atomic snapshot of them
        plus the appropriate struct cred you can grab exec_update_mutex.
        
	I added a new mutex instead of just fixing cred_guard_mutex so
        that we can update or revert the individual code paths if it
        is found that something is wrong.

	The cred_guard_mutex also prevents other tasks from starting
        to ptrace the task that is exec'ing, and other tasks from
        setting no_new_privs on the task that is exec'ing.

        My plan is to carefully refactor the code so it can perform
        both the ptrace and no_new_privs checks after the point of
        no return.

I have uncovered all kinds of surprises while working in that direction
and I realize it is going to take a very delicate and careful touch to
achieve my goal.

There are silly things like normal linux exec when you are ptraced and
exec changes the credentials the ordinary code will continue with the
old credentials, but the an LSM enabled your process is likely to be
killed instead.

There is the personal mind blowing scenario where selinux will increase
your credentials upon exec but if a magic directive is supplied in it's
rules will avoid setting AT_SECURE, so that userspace won't protect
itself from hostile takeover from the pre credential change environment.
Much to my surprise "noatsecure" is a known and documented feature of
selinux.  I am not certain but I think I even spotted it in use on
production.

I will catch up on my sleep before I allow any more changes, and I will
see replacing the called_exec_mmap flag with something saner.

Eric
