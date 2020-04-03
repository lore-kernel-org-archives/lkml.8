Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3714EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E909520787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 00:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbgDCAIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:08:09 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42182 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390235AbgDCAII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 20:08:08 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK9sV-000597-3R; Thu, 02 Apr 2020 18:08:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jK9sU-0001GJ-4z; Thu, 02 Apr 2020 18:08:06 -0600
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
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
Date:   Thu, 02 Apr 2020 19:05:23 -0500
In-Reply-To: <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 2 Apr 2020 16:44:15 -0700")
Message-ID: <87imih8md8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jK9sU-0001GJ-4z;;;mid=<87imih8md8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UA3zrmrj/p6b8R/HYq++Njt3rqPDaiwc=
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

> On Thu, Apr 2, 2020 at 4:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> That is not the direction I intend to take either.
>
> Ahh, good. Because those kinds of "play games with dropping locks in
> the middle based on conditionals" really have been horrible.
>
> Yes, we've done it, and it's almost always been asource of truly subtle bugs.
>
>> The exec_update_mutex is to be a strict subset of today's
>> cred_guard_mutex.  I tried to copy cred_guard_mutex's unlock style so
>> that was obvious and that turns out was messier than I intended.
>
> Yes. That is why I had no problem pulling that subset, and my worries
> were mainly about the explanations and that flag use.
>
>> Since I thought I already knew what was in the patches and the worst
>> problem was the missing unlock of cred_guard_mutex, and I know Bernd's
>> patches had been tested I applied them.  I missed that Bernd had added
>> the exec_mmap_called flag into my patch.  I thought he had only added
>> the missing unlock.
>
> Ahh, so you meant for all of that to be entirely static refactoring,
> rather than the conditional unlock depending on just how far we had
> gotten.
>
> Good, that's generally the much superior approach.

Looking at it right now if I add the unlock to one code path I can
get the flag and free_binprm out of it, and have it completely static.

> I absolutely _hate_ the "drop and retake" model, unless it's a very
> local case with a very explicit retry path.
>
> In contrast, the "we have a flag that shows how far we've gotten"
> _has_ been a successful model, and while I much prefer a static "lock
> pairs with unlock", that "I have done this, so you need to unlock" is
> not entirely out of the question when the static rules become too
> complex to think about.

We do definitely need one of those for the point of no return.  I
need to check if we can set it sooner.  I think we have a weird case
where we can't set the flag because calling force_sigsegv during when
coredumping is rude.

> The vfs code has something similar in FMODE_OPENED which is basically
> a flag saying "I actually made it all the way to the ->open()"
> callback. We used to have a static model, but the rules for when we
> can use fput(), and when we have to use fdrop() were too hard for
> people.
>
>> I spotted the weirdness in unlocking exec_update_mutex, and because it
>> does fix a real world deadlock with ptrace I did not back it out from my
>> tree.
>>
>> I have been much laxer on the details than I like to be my apologies.
>
> Ok, as long as we have a sane plan..
>
> And
>
>> The plan is:
>>         exec_udpate_mutex will cover just the subset of cred_guard_mutex
>>         after the point of no return, and after we do any actions that
>>         might block waiting for userspace to do anything.
>>
>>         So exec_update_mutex will just cover those things that exec
>>         is updating, so if you want an atomic snapshot of them
>>         plus the appropriate struct cred you can grab exec_update_mutex.
>>
>>         I added a new mutex instead of just fixing cred_guard_mutex so
>>         that we can update or revert the individual code paths if it
>>         is found that something is wrong.
>>
>>         The cred_guard_mutex also prevents other tasks from starting
>>         to ptrace the task that is exec'ing, and other tasks from
>>         setting no_new_privs on the task that is exec'ing.
>>
>>         My plan is to carefully refactor the code so it can perform
>>         both the ptrace and no_new_privs checks after the point of
>>         no return.
>
> Ok. Sounds good.
>
>> I have uncovered all kinds of surprises while working in that direction
>> and I realize it is going to take a very delicate and careful touch to
>> achieve my goal.
>>
>> There are silly things like normal linux exec when you are ptraced and
>> exec changes the credentials the ordinary code will continue with the
>> old credentials, but the an LSM enabled your process is likely to be
>> killed instead.
>
> Yeah. The "continue with old credentials" is actually very traditional
> and the original behavior, and is useful for handling the case of
> debugging something that is suid, but doesn't necessarily _require_
> it.

If we continue with old credentials I think we are still setting
AT_SECURE which seems odd.  Especially since it doesn't appear to be
intentional.

> But the LSM's just say yes/no.

Oh I wish what the LSM's were doing was anything approaching as
simple as merely saying yes/no during exec.

> I have this dim memory that it also triggers when you do the debugging
> as root, but that may be some medication-induced memory.

I have a memory of someone fixing something like that years ago.
If you have sufficient privileges while ptracing the current code will
allow you to trace a suid root exec.

>> There is the personal mind blowing scenario where selinux will increase
>> your credentials upon exec but if a magic directive is supplied in it's
>> rules will avoid setting AT_SECURE, so that userspace won't protect
>> itself from hostile takeover from the pre credential change environment.
>> Much to my surprise "noatsecure" is a known and documented feature of
>> selinux.  I am not certain but I think I even spotted it in use on
>> production.
>
> We have had a _ton_ of random small rules so that people could enable
> SElinux in legacy environments.
>
> They are _probably_ effectively dead code in this day and age, but
> it's hard to tell...

For that specific case I attempted to look at the SELinux rules
file on a production RHEL7 configuration and strings told me
"noatsecure" is present.  But the whole thing is a binary blob
and I have not spent enough time to figure out how to properly
return it to test so I can see what that "noatsecure" means.
It might just have been a section header in the binary file.

There are a lot of things like that are either going to need comments
from the relevant maintiners or to just be avoided for the time being.

The plan is small careful patches so I get through it with setting
off the minimal number of landmines.

Eric
