Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E857C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DFC206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFKQLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:11:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47872 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:11:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjPnm-0001IU-Aa; Thu, 11 Jun 2020 10:11:38 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjPnl-0004qC-7V; Thu, 11 Jun 2020 10:11:38 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Waiman Long <longman@redhat.com>
Cc:     syzbot <syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        allison@lohutok.net, areber@redhat.com, aubrey.li@linux.intel.com,
        avagin@gmail.com, bfields@fieldses.org, christian@brauner.io,
        cyphar@cyphar.com, gregkh@linuxfoundation.org, guro@fb.com,
        jlayton@kernel.org, joel@joelfernandes.org, keescook@chromium.org,
        linmiaohe@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, mingo@kernel.org,
        oleg@redhat.com, peterz@infradead.org, sargun@sargun.me,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk
References: <000000000000760d0705a270ad0c@google.com>
        <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com>
Date:   Thu, 11 Jun 2020 11:07:27 -0500
In-Reply-To: <69818a6c-7025-8950-da4b-7fdc065d90d6@redhat.com> (Waiman Long's
        message of "Wed, 10 Jun 2020 22:32:44 -0400")
Message-ID: <87pna5si0w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jjPnl-0004qC-7V;;;mid=<87pna5si0w.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Jw6fuaywHMh68c/aQKbIUg4HHXOyXnIw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: possible deadlock in send_sigio
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 4/4/20 1:55 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15f39c5de00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
>> dashboard link: https://syzkaller.appspot.com/bug?extid=a9fb1457d720a55d6dc5
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1454c3b7e00000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a22ac7e00000
>>
>> The bug was bisected to:
>>
>> commit 7bc3e6e55acf065500a24621f3b313e7e5998acf
>> Author: Eric W. Biederman <ebiederm@xmission.com>
>> Date:   Thu Feb 20 00:22:26 2020 +0000
>>
>>      proc: Use a list of inodes to flush from proc
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165c4acde00000
>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=155c4acde00000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=115c4acde00000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+a9fb1457d720a55d6dc5@syzkaller.appspotmail.com
>> Fixes: 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
>>
>> ========================================================
>> WARNING: possible irq lock inversion dependency detected
>> 5.6.0-syzkaller #0 Not tainted
>> --------------------------------------------------------
>> ksoftirqd/0/9 just changed the state of lock:
>> ffffffff898090d8 (tasklist_lock){.+.?}-{2:2}, at: send_sigio+0xa9/0x340 fs/fcntl.c:800
>> but this lock took another, SOFTIRQ-unsafe lock in the past:
>>   (&pid->wait_pidfd){+.+.}-{2:2}
>>
>>
>> and interrupts could create inverse lock ordering between them.
>>
>>
>> other info that might help us debug this:
>>   Possible interrupt unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&pid->wait_pidfd);
>>                                 local_irq_disable();
>>                                 lock(tasklist_lock);
>>                                 lock(&pid->wait_pidfd);
>>    <Interrupt>
>>      lock(tasklist_lock);
>>
>>   *** DEADLOCK ***
>
> That is a false positive. The qrwlock has the special property that it becomes
> unfair (for read lock) at interrupt context. So unless it is taking a write lock
> in the interrupt context, it won't go into deadlock. The current lockdep code
> does not capture the full semantics of qrwlock leading to this false positive.
>

Whatever it was it was fixed with:
63f818f46af9 ("proc: Use a dedicated lock in struct pid")

It is classic lock inversion caused by not disabling irqs.

Unless I am completely mistaken any non-irq code path that does:
	write_lock_irq(&tasklist_lock);
        spin_lock(&pid->lock);

Is susceptible to deadlock with:
	spin_lock(&pid->lock);
        <Interrupt>
        read_lock(&task_list_lock);

Because it remains a lock inversion even with only a read lock taken in
irq context in irq context.

Eric
