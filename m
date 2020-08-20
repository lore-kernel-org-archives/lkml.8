Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A133C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A420724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgHTOrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:47:16 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43338 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHTOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:47:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8lqB-006zQX-6o; Thu, 20 Aug 2020 08:46:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8lqA-0001YY-E6; Thu, 20 Aug 2020 08:46:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, adobriyan@gmail.com, akpm@linux-foundation.org,
        gladkov.alexey@gmail.com, walken@google.com,
        daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
        <87zh6pxzq6.fsf@x220.int.ebiederm.org>
        <20200820124241.GJ5033@dhcp22.suse.cz>
        <87lfi9xz7y.fsf@x220.int.ebiederm.org>
        <87d03lxysr.fsf@x220.int.ebiederm.org>
        <20200820132631.GK5033@dhcp22.suse.cz>
        <874koxxwn5.fsf@x220.int.ebiederm.org>
        <20200820140451.GC4546@redhat.com>
Date:   Thu, 20 Aug 2020 09:43:18 -0500
In-Reply-To: <20200820140451.GC4546@redhat.com> (Oleg Nesterov's message of
        "Thu, 20 Aug 2020 16:04:52 +0200")
Message-ID: <87364hwf7d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8lqA-0001YY-E6;;;mid=<87364hwf7d.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Tnh/hUsIF58mi4H1Z7Pw+g9j5YSK3gCY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 08/20, Eric W. Biederman wrote:
>>
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1139,6 +1139,10 @@ static int exec_mmap(struct mm_struct *mm)
>>  	vmacache_flush(tsk);
>>  	task_unlock(tsk);
>>  	if (old_mm) {
>> +		mm->oom_score_adj = old_mm->oom_score_adj;
>> +		mm->oom_score_adj_min = old_mm->oom_score_adj_min;
>> +		if (tsk->vfork_done)
>> +			mm->oom_score_adj = tsk->vfork_oom_score_adj;
>
> too late, ->vfork_done is NULL after mm_release().

Good point.  

> And this can race with __set_oom_adj(). Yes, the current code is racy too,
> but this change adds another race, __set_oom_adj() could already observe
> ->mm != NULL and update mm->oom_score_adj.

I am not certain about races but we should be able to do something like:

in exec_mmap:
        if (old_mm) {
		mm->oom_score_adj = old_mm->oom_score_adj;
        	mm->oom_score_adj_min = old_mm->oom_score_adj_min;
        	if (tsk->signal->vfork_oom_score_adj_set) {
                	mm->oom_score_adj = tsk->vfork_oom_score_adj;
                	tsk->signal->vfork_oom_score_adj_set = false;
                }
        }

in __set_oom_adj:
	if (mm) {
		mm->oom_score_adj = oom_adj;
                tsk->signal->vfork_oom_score_adj_set = false;
        } else {
		tsk->vfork_score_adj = old_mm->oom_score_adj;
                tsk->signal->vfork_oom_score_adj_set = true;
        }

There might even be a special oom_score_adj value we can use instead of
a separate flag.  I am just not familiar enough with oom_score_adj to know.

We should be able to do something like that where we know the value is
set and only use it if so.  And a subsequent _set_oom_adj without
observing vfork_done set will clear the value in signal_struct.

We have to be a bit careful to get the details right but it should be
straight forward.


Michal also has a point about oom_score_adj_min, and I really don't
understand the oom logic value well enough to guess how that should
work.


Although to deal with some of the races it probably only makes sense
to call complete_vfork_done in exec after the new mm has been installed,
and while exec_update_mutex is held.  I don't think anyone every
anticipated using vfork_done as a flag.

Eric

