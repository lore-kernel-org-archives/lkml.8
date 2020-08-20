Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD49C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1040F207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgHTNAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:00:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42122 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgHTM6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:58:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8k97-00AeLu-MA; Thu, 20 Aug 2020 06:58:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k8k96-0001vI-Nm; Thu, 20 Aug 2020 06:58:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20200820002053.1424000-1-surenb@google.com>
        <87zh6pxzq6.fsf@x220.int.ebiederm.org>
        <20200820124241.GJ5033@dhcp22.suse.cz>
        <87lfi9xz7y.fsf@x220.int.ebiederm.org>
Date:   Thu, 20 Aug 2020 07:54:44 -0500
In-Reply-To: <87lfi9xz7y.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 20 Aug 2020 07:45:37 -0500")
Message-ID: <87d03lxysr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k8k96-0001vI-Nm;;;mid=<87d03lxysr.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19E902mpzZ/0RJGbVRpvQ/hKnf/i0hasRo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

2> Michal Hocko <mhocko@suse.com> writes:
>
>> On Thu 20-08-20 07:34:41, Eric W. Biederman wrote:
>>> Suren Baghdasaryan <surenb@google.com> writes:
>>> 
>>> > Currently __set_oom_adj loops through all processes in the system to
>>> > keep oom_score_adj and oom_score_adj_min in sync between processes
>>> > sharing their mm. This is done for any task with more that one mm_users,
>>> > which includes processes with multiple threads (sharing mm and signals).
>>> > However for such processes the loop is unnecessary because their signal
>>> > structure is shared as well.
>>> > Android updates oom_score_adj whenever a tasks changes its role
>>> > (background/foreground/...) or binds to/unbinds from a service, making
>>> > it more/less important. Such operation can happen frequently.
>>> > We noticed that updates to oom_score_adj became more expensive and after
>>> > further investigation found out that the patch mentioned in "Fixes"
>>> > introduced a regression. Using Pixel 4 with a typical Android workload,
>>> > write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
>>> > this regression linearly depends on the number of multi-threaded
>>> > processes running on the system.
>>> > Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
>>> > CLONE_VM and !CLONE_SIGHAND. Change __set_oom_adj to use MMF_PROC_SHARED
>>> > instead of mm_users to decide whether oom_score_adj update should be
>>> > synchronized between multiple processes. To prevent races between clone()
>>> > and __set_oom_adj(), when oom_score_adj of the process being cloned might
>>> > be modified from userspace, we use oom_adj_mutex. Its scope is changed to
>>> > global and it is renamed into oom_adj_lock for naming consistency with
>>> > oom_lock. Since the combination of CLONE_VM and !CLONE_SIGHAND is rarely
>>> > used the additional mutex lock in that path of the clone() syscall should
>>> > not affect its overall performance. Clearing the MMF_PROC_SHARED flag
>>> > (when the last process sharing the mm exits) is left out of this patch to
>>> > keep it simple and because it is believed that this threading model is
>>> > rare. Should there ever be a need for optimizing that case as well, it
>>> > can be done by hooking into the exit path, likely following the
>>> > mm_update_next_owner pattern.
>>> > With the combination of CLONE_VM and !CLONE_SIGHAND being quite rare, the
>>> > regression is gone after the change is applied.
>>> 
>>> So I am confused.
>>> 
>>> Is there any reason why we don't simply move signal->oom_score_adj to
>>> mm->oom_score_adj and call it a day?
>>
>> Yes. Please read through 44a70adec910 ("mm, oom_adj: make sure processes
>> sharing mm have same view of oom_score_adj")
>
> That explains why the scores are synchronized.
>
> It doesn't explain why we don't do the much simpler thing and move
> oom_score_adj from signal_struct to mm_struct. Which is my question.
>
> Why not put the score where we need it to ensure that the oom score
> is always synchronized?  AKA on the mm_struct, not the signal_struct.

Apologies.  That 44a70adec910 does describe that some people have seen
vfork users set oom_score.  No details unfortunately.

I will skip the part where posix calls this undefined behavior.  It
breaks userspace to change.

It still seems like the code should be able to buffer oom_adj during
vfork, and only move the value onto mm_struct during exec.

Eric

