Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0490C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC14206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgD0TuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:50:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53344 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgD0TuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:50:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT9lX-0006L6-BZ; Mon, 27 Apr 2020 13:50:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jT9lV-0003xk-91; Mon, 27 Apr 2020 13:50:07 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
        <87ftcv1nqe.fsf@x220.int.ebiederm.org>
        <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
        <20200424173927.GB26802@redhat.com>
        <87mu6ymkea.fsf_-_@x220.int.ebiederm.org>
        <87blnemj5t.fsf_-_@x220.int.ebiederm.org>
        <87zhaxqkwa.fsf@nanos.tec.linutronix.de>
Date:   Mon, 27 Apr 2020 14:46:51 -0500
In-Reply-To: <87zhaxqkwa.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Mon, 27 Apr 2020 12:32:21 +0200")
Message-ID: <87a72wd844.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jT9lV-0003xk-91;;;mid=<87a72wd844.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18j5AH/+MVgbJoMSFliM5bTtu8iUZh+Nco=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 2/6] posix-cpu-timers: Use PIDTYPE_TGID to simplify the logic in lookup_task
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>> Using pid_task(find_vpid(N), PIDTYPE_TGID) guarantees that if a task
>> is found it is at that moment the thread group leader.  Which removes
>> the need for the follow on test has_group_leader_pid.
>>
>> I have reorganized the rest of the code in lookup_task for clarity,
>> and created a common return for most of the code.
>
> Sorry, it's way harder to read than the very explicit exits which were
> there before.

My biggest gripe is the gettime and the ordinary !thread case should
be sharing code and they are not.  I know historically why they don't
but for all practical purposes has_group_leader_pid and
thread_group_leader are the same test.


>> The special case for clock_gettime with "pid == gettid" is not my
>> favorite.  I strongly suspect it isn't used as gettid is such a pain,
>> and passing 0 is much easier.  Still it is easier to keep this special
>> case than to do the reasarch that will show it isn't used.
>
> It might be not your favorite, but when I refactored the code I learned
> the hard way that one of the test suites has assumptions that
> clock_gettime(PROCESS) works from any task of a group and not just for
> the group leader. Sure we could fix the test suite, but test code tends
> to be copied ...

Do you know which test suite?
It would be nice to see such surprising code with my own eyes.

I completely agree that clock_gettime(PROCESS) should work for any task
of a group.  I would think anything with a constant like that would just
be passing in 0, which is trivial.  Looking up your threadid seems like
extra work.

Mostly my complaint is that the gettime subcase is an awkward special
case.  Added in 33ab0fec3352 ("posix-timers: Consolidate
posix_cpu_clock_get()") and the only justification for changing the
userspace ABI was that it made things less awkward to combine to
branches of code.

>>  /*
>>   * Functions for validating access to tasks.
>>   */
>> -static struct task_struct *lookup_task(const pid_t pid, bool thread,
>> +static struct task_struct *lookup_task(const pid_t which_pid, bool thread,
>>  				       bool gettime)
>>  {
>>  	struct task_struct *p;
>> +	struct pid *pid;
>>  
>>  	/*
>>  	 * If the encoded PID is 0, then the timer is targeted at current
>>  	 * or the process to which current belongs.
>>  	 */
>> -	if (!pid)
>> +	if (!which_pid)
>>  		return thread ? current : current->group_leader;
>>  
>> -	p = find_task_by_vpid(pid);
>> -	if (!p)
>> -		return p;
>> -
>> -	if (thread)
>> -		return same_thread_group(p, current) ? p : NULL;
>> -
>> -	if (gettime) {
>> +	pid = find_vpid(which_pid);
>> +	if (thread) {
>> +		p = pid_task(pid, PIDTYPE_PID);
>> +		if (p && !same_thread_group(p, current))
>> +			p = NULL;
>> +	} else {
>>  		/*
>>  		 * For clock_gettime(PROCESS) the task does not need to be
>>  		 * the actual group leader. tsk->sighand gives
>> @@ -76,13 +75,13 @@ static struct task_struct *lookup_task(const pid_t pid, bool thread,
>>  		 * reference on it and store the task pointer until the
>>  		 * timer is destroyed.
>
> Btw, this comment is wrong since
>
>      55e8c8eb2c7b ("posix-cpu-timers: Store a reference to a pid not a task")

It is definitely stale.  It continues to describe the motive for
limiting ourselves to a thread_group_leader.

I am cooking up a patch to tweak that comment, and get replace of
has_group_leader_pid.  Since it is unnecessary I just want to decouple
that work from this patchset.

Eric


