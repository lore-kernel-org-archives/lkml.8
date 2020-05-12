Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C9FCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C982075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgELQOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:14:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgELQOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:14:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50689ABBD;
        Tue, 12 May 2020 16:14:42 +0000 (UTC)
Date:   Tue, 12 May 2020 09:09:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        paulmck@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] kernel/sys: only rely on rcu for getpriority(2)
Message-ID: <20200512160915.n3plwrwwrlpfqyrs@linux-p48b>
References: <20200512000353.23653-1-dave@stgolabs.net>
 <20200512000353.23653-2-dave@stgolabs.net>
 <20200512150936.GA28621@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200512150936.GA28621@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020, Oleg Nesterov wrote:

>On 05/11, Davidlohr Bueso wrote:
>>
>> Currently the tasklist_lock is shared mainly in order to observe
>> the list atomically for the PRIO_PGRP and PRIO_USER cases, as
>> the actual lookups are already rcu-safe,
>
>not really...
>
>do_each_pid_task(PIDTYPE_PGID) can race with change_pid(PIDTYPE_PGID)
>which moves the task from one hlist to another. Yes, it is safe in
>that task_struct can't go away. But still this is not right because
>do_each_pid_task() can scan the wrong (2nd) hlist.

Hmm I didn't think about this case, I guess this is also busted in
ioprio_get(2) then.

>
>> (ii) exit (deletion), this window is small but if a task is
>> deleted with the highest nice and it is not observed this would
>> cause a change in return semantics. To further reduce the window
>> we ignore any tasks that are PF_EXITING in the 'old' version of
>> the list.
>
>can't understand...
>
>could you explain in details why do you think this PF_EXITING check
>makes any sense?

My logic was that if the task with the highest prio exited while we
were iterating the list, it would not be necessarily seen with rcu
and the syscall would return the highest prio of a task that exited;
and checking against PF_EXITING was a way to ignore such scenarios
as we were going to race with it anyway.

At this point it seems that we can just remove the lock for the
PRIO_PROCESS case.

Thanks,
Davidlohr
