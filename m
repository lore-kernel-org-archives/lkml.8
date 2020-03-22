Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64705C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B65E20658
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCVPBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:01:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39654 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgCVPBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:01:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jG26q-0007KC-AV; Sun, 22 Mar 2020 09:01:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jG26o-0006ct-SH; Sun, 22 Mar 2020 09:01:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Manfred Spraul <manfred@colorfullife.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Yoji <yoji.fujihar.min@gmail.com>, linux-kernel@vger.kernel.org
References: <20200322110901.GA25108@redhat.com>
        <87lfnsh3tm.fsf@x220.int.ebiederm.org>
Date:   Sun, 22 Mar 2020 09:59:21 -0500
In-Reply-To: <87lfnsh3tm.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Sun, 22 Mar 2020 09:17:09 -0500")
Message-ID: <87d094h1va.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jG26o-0006ct-SH;;;mid=<87d094h1va.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hnlWp498cLyqut6dW7PGT5auYs1RSBds=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] ipc/mqueue.c: change __do_notify() to bypass check_kill_permission()
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Oleg Nesterov <oleg@redhat.com> writes:
>
>> Commit cc731525f26a ("signal: Remove kernel interal si_code magic")
>> changed the value of SI_FROMUSER(SI_MESGQ), this means that mq_notify()
>> no longer works if the sender doesn't have rights to send a signal.
>>
>> Change __do_notify() to use do_send_sig_info() instead of kill_pid_info()
>> to avoid check_kill_permission().
>
> I totally see why you are doing this.  To avoid the permission check,
> and since this process requested the signal it makes sense to bypass the
> permission checks.  The code needs to make certain that this signal is
> canceled or otherwise won't be sent after an exec.
>
> That said I don't like it.  I would really like to remove the signal
> sending interfaces that take a task_struct.
>
> Looking at the code I currently see several places where we have this
> kind of semantic (sending a requested signal to a process from the
> context of another process): do_notify_parent, pdeath_signal, f_setown,
> and mq_notify.

Scratch the fctnl(F_SETOWN,...) case for sending SIGIO.  While
frequently that applies to sending to yourself it isn't required and
that path does have a permission check.  So that whole case is clearly
something different.

That still leaves us with at least 3 very similar cases in the kernel.

Eric


> When 4 different pieces of code are doing effectively the same thing and
> have very similar if not the exact same concerns and they are all doing
> things differently then we have a maintenance problem.
>
> Especially with the concerns about being able to send a signal after
> exec, and cause havoc.
>
> Oleg is there any chance you can see if you can find a common helper
> or a common idiom that all three cases can and should use?  Espeically
> with concerns about being able to send signals to a suid process that
> would normally fail I think there is an issue here.
>
> At the very least can you add a big fat comment about the semantics
> that userspace expects in this case?
>
>> This needs the additional notify.sigev_signo != 0 check, shouldn't we
>> change do_mq_notify() to deny sigev_signo == 0 ?
>
> I wonder if the author of the code simply did not realize that
> valid_signal allows 0.  As this is a posix interface we should be able
> to check the posix spec and see if it gives any useful guidance about
> signal 0.
>
> Eric
>
>
>
>> Reported-by: Yoji <yoji.fujihar.min@gmail.com>
>> Fixes: cc731525f26a ("signal: Remove kernel interal si_code magic")
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> ---
>>  ipc/mqueue.c | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
>> index 49a05ba3000d..3145fae162c1 100644
>> --- a/ipc/mqueue.c
>> +++ b/ipc/mqueue.c
>> @@ -775,12 +775,15 @@ static void __do_notify(struct mqueue_inode_info *info)
>>  	if (info->notify_owner &&
>>  	    info->attr.mq_curmsgs == 1) {
>>  		struct kernel_siginfo sig_i;
>> +		struct task_struct *task;
>>  		switch (info->notify.sigev_notify) {
>>  		case SIGEV_NONE:
>>  			break;
>>  		case SIGEV_SIGNAL:
>> +			/* do_mq_notify() accepts sigev_signo == 0, why?? */
>> +			if (!info->notify.sigev_signo)
>> +				break;
>>  			/* sends signal */
>> -
>>  			clear_siginfo(&sig_i);
>>  			sig_i.si_signo = info->notify.sigev_signo;
>>  			sig_i.si_errno = 0;
>> @@ -790,11 +793,13 @@ static void __do_notify(struct mqueue_inode_info *info)
>>  			rcu_read_lock();
>>  			sig_i.si_pid = task_tgid_nr_ns(current,
>>  						ns_of_pid(info->notify_owner));
>> -			sig_i.si_uid = from_kuid_munged(info->notify_user_ns, current_uid());
>> +			sig_i.si_uid = from_kuid_munged(info->notify_user_ns,
>> +						current_uid());
>> +			task = pid_task(info->notify_owner, PIDTYPE_PID);
>> +			if (task)
>> +				do_send_sig_info(info->notify.sigev_signo,
>> +						&sig_i, task, PIDTYPE_TGID);
>>  			rcu_read_unlock();
>> -
>> -			kill_pid_info(info->notify.sigev_signo,
>> -				      &sig_i, info->notify_owner);
>>  			break;
>>  		case SIGEV_THREAD:
>>  			set_cookie(info->notify_cookie, NOTIFY_WOKENUP);
