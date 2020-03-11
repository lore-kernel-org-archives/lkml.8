Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D40C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63C120873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgCKN1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:27:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729501AbgCKN1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:27:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4B23DA57124B05C113E7;
        Wed, 11 Mar 2020 21:26:55 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 21:26:50 +0800
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
To:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
CC:     kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200308140314.GQ5972@shao2-debian>
 <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
 <CAHk-=whGK712fPqmQ3FSHxqe3Aqny4bEeWEvfaytLeLV2+ijCQ@mail.gmail.com>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
 <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name>
 <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
 <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name>
 <f9db707f-74ef-9439-1aec-e1ce8234888e@huawei.com>
 <9ff6eee403d293dd069935ca6979f72131fe5217.camel@kernel.org>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <f450e090-4c37-fb82-c6d9-900a0d2b6644@huawei.com>
Date:   Wed, 11 Mar 2020 21:26:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9ff6eee403d293dd069935ca6979f72131fe5217.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/11 20:52, Jeff Layton wrote:
> On Wed, 2020-03-11 at 09:57 +0800, yangerkun wrote:
> 
> [snip]
> 
>>
>> On 2020/3/11 5:01, NeilBrown wrote:
>>>
>>> I think this patch contains an assumption which is not justified.  It
>>> assumes that if a wait_event completes without error, then the wake_up()
>>> must have happened.  I don't think that is correct.
>>>
>>> In the patch that caused the recent regression, the race described
>>> involved a signal arriving just as __locks_wake_up_blocks() was being
>>> called on another thread.
>>> So the waiting process was woken by a signal *after* ->fl_blocker was set
>>> to NULL, and *before* the wake_up().  If wait_event_interruptible()
>>> finds that the condition is true, it will report success whether there
>>> was a signal or not.
>> Neil and Jeff, Hi,
>>
>> But after this, like in flock_lock_inode_wait, we will go another
>> flock_lock_inode. And the flock_lock_inode it may return
>> -ENOMEM/-ENOENT/-EAGAIN/0.
>>
>> - 0: If there is a try lock, it means that we have call
>> locks_move_blocks, and fl->fl_blocked_requests will be NULL, no need to
>> wake up at all. If there is a unlock, no one call wait for me, no need
>> to wake up too.
>>
>> - ENOENT: means we are doing unlock, no one will wait for me, no need to
>> wake up.
>>
>> - ENOMEM: since last time we go through flock_lock_inode someone may
>> wait for me, so for this error, we need to wake up them.
>>
>> - EAGAIN: since we has go through flock_lock_inode before, these may
>> never happen because FL_SLEEP will not lose.
>>
>> So the assumption may be ok and for some error case we need to wake up
>> someone may wait for me before(the reason for the patch "cifs: call
>> locks_delete_block for all error case in cifs_posix_lock_set"). If I am
>> wrong, please point out!
>>
>>
> 
> That's the basic dilemma. We need to know whether we'll need to delete
> the block before taking the blocked_lock_lock.
> 
> Your most recent patch used the return code from the wait to determine
> this, but that's not 100% reliable (as Neil pointed out). Could we try

I am a little confused, maybe I am wrong.

As Neil say: "If wait_event_interruptible() finds that the condition is 
true, it will report success whether there was a signal or not.", this 
wait_event_interruptible may return 0 for this scenes? so we will go 
loop and call flock_lock_inode again, and after we exits the loop with 
error equals 0(if we try lock), the lock has call locks_move_blocks and 
leave fl_blocked_requests as NULL?

> to do this by doing the delete only when we get certain error codes?
> Maybe, but that's a bit fragile-sounding.
> 
> Neil's most recent patch used presence on the fl_blocked_requests list
> to determine whether to take the lock, but that relied on some very
> subtle memory ordering. We could of course do that, but that's a bit
> brittle too.
> 
> That's the main reason I'm leaning toward the patch Neil sent
> originally and that uses the fl_wait.lock. The existing alternate lock
> managers (nfsd and lockd) don't use fl_wait at all, so I don't think
> doing that will cause any issues.
> 

