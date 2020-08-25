Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC5C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1B3207F7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHYQiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:38:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54802 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHYQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:38:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kAbxL-00H0Y9-3q; Tue, 25 Aug 2020 10:37:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kAbxJ-0006FB-SK; Tue, 25 Aug 2020 10:37:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@suse.com, christian.brauner@ubuntu.com, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, esyr@redhat.com,
        christian@kellner.me, areber@redhat.com, shakeelb@google.com,
        cyphar@cyphar.com, oleg@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com,
        walken@google.com, daniel.m.jordan@oracle.com, avagin@gmail.com,
        bernd.edlinger@hotmail.de, john.johansen@canonical.com,
        laoar.shao@gmail.com, timmurray@google.com, minchan@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>
References: <20200824153036.3201505-1-surenb@google.com>
Date:   Tue, 25 Aug 2020 11:34:11 -0500
In-Reply-To: <20200824153036.3201505-1-surenb@google.com> (Suren
        Baghdasaryan's message of "Mon, 24 Aug 2020 08:30:36 -0700")
Message-ID: <87imd6n0qk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kAbxJ-0006FB-SK;;;mid=<87imd6n0qk.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ivDnjXPoNOaQ5Sbo9GtQ7QzaAzyR6xy4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 1/1] mm, oom_adj: don't loop through tasks in __set_oom_adj when not necessary
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suren Baghdasaryan <surenb@google.com> writes:

> Currently __set_oom_adj loops through all processes in the system to
> keep oom_score_adj and oom_score_adj_min in sync between processes
> sharing their mm. This is done for any task with more that one mm_users,
> which includes processes with multiple threads (sharing mm and signals).
> However for such processes the loop is unnecessary because their signal
> structure is shared as well.
> Android updates oom_score_adj whenever a tasks changes its role
> (background/foreground/...) or binds to/unbinds from a service, making
> it more/less important. Such operation can happen frequently.
> We noticed that updates to oom_score_adj became more expensive and after
> further investigation found out that the patch mentioned in "Fixes"
> introduced a regression. Using Pixel 4 with a typical Android workload,
> write time to oom_score_adj increased from ~3.57us to ~362us. Moreover
> this regression linearly depends on the number of multi-threaded
> processes running on the system.
> Mark the mm with a new MMF_PROC_SHARED flag bit when task is created with
> (CLONE_VM && !CLONE_THREAD && !CLONE_VFORK). Change __set_oom_adj to use
> MMF_PROC_SHARED instead of mm_users to decide whether oom_score_adj
> update should be synchronized between multiple processes. To prevent
> races between clone() and __set_oom_adj(), when oom_score_adj of the
> process being cloned might be modified from userspace, we use
> oom_adj_mutex. Its scope is changed to global and it is renamed into
> oom_adj_lock for naming consistency with oom_lock. The combination of
> (CLONE_VM && !CLONE_THREAD) is rarely used except for the case of vfork().
> To prevent performance regressions of vfork(), we skip taking oom_adj_lock
> and setting MMF_PROC_SHARED when CLONE_VFORK is specified. Clearing the
> MMF_PROC_SHARED flag (when the last process sharing the mm exits) is left
> out of this patch to keep it simple and because it is believed that this
> threading model is rare. Should there ever be a need for optimizing that
> case as well, it can be done by hooking into the exit path, likely
> following the mm_update_next_owner pattern.
> With the combination of (CLONE_VM && !CLONE_THREAD && !CLONE_VFORK) being
> quite rare, the regression is gone after the change is applied.

This patch still makes my head hurt.

The obvious wrong things I have mentioned below.


> Fixes: 44a70adec910 ("mm, oom_adj: make sure processes sharing mm have same view of oom_score_adj")
> Reported-by: Tim Murray <timmurray@google.com>
> Debugged-by: Minchan Kim <minchan@kernel.org>
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>
> v2:
> - Implemented proposal from Michal Hocko in:
> https://lore.kernel.org/linux-fsdevel/20200820124109.GI5033@dhcp22.suse.cz/
> - Updated description to reflect the change
>
> v1:
> - https://lore.kernel.org/linux-mm/20200820002053.1424000-1-surenb@google.com/
>
>  fs/proc/base.c                 |  7 +++----
>  include/linux/oom.h            |  1 +
>  include/linux/sched/coredump.h |  1 +
>  kernel/fork.c                  | 21 +++++++++++++++++++++
>  mm/oom_kill.c                  |  2 ++
>  5 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 617db4e0faa0..cff1a58a236c 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1055,7 +1055,6 @@ static ssize_t oom_adj_read(struct file *file, char __user *buf, size_t count,
>  
>  static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  {
> -	static DEFINE_MUTEX(oom_adj_mutex);
>  	struct mm_struct *mm = NULL;
>  	struct task_struct *task;
>  	int err = 0;
> @@ -1064,7 +1063,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  	if (!task)
>  		return -ESRCH;
>  
> -	mutex_lock(&oom_adj_mutex);
> +	mutex_lock(&oom_adj_lock);
>  	if (legacy) {
>  		if (oom_adj < task->signal->oom_score_adj &&
>  				!capable(CAP_SYS_RESOURCE)) {
> @@ -1095,7 +1094,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		struct task_struct *p = find_lock_task_mm(task);
>  
>  		if (p) {
> -			if (atomic_read(&p->mm->mm_users) > 1) {
> +			if (test_bit(MMF_PROC_SHARED, &p->mm->flags)) {
>  				mm = p->mm;
>  				mmgrab(mm);
>  			}
> @@ -1132,7 +1131,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
>  		mmdrop(mm);
>  	}
>  err_unlock:
> -	mutex_unlock(&oom_adj_mutex);
> +	mutex_unlock(&oom_adj_lock);
>  	put_task_struct(task);
>  	return err;
>  }
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index f022f581ac29..861f22bd4706 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -55,6 +55,7 @@ struct oom_control {
>  };
>  
>  extern struct mutex oom_lock;
> +extern struct mutex oom_adj_lock;
                       ^^^^^^^^^^^^^^

I understand moving this lock by why renaming it?

>  static inline void set_current_oom_origin(void)
>  {
> diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
> index ecdc6542070f..070629b722df 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -72,6 +72,7 @@ static inline int get_dumpable(struct mm_struct *mm)
>  #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
>  #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
>  #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
> +#define MMF_PROC_SHARED	27	/* mm is shared while sighand is not */
           ^^^^^^^^^^^^^^^              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Arguably this is misnamed MMF_MULTIPROCESS is probably better.
The comment is definitely wrong.

>  #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
>  
>  #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190861bd..6fce8ffa9b8b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1809,6 +1809,25 @@ static __always_inline void delayed_free_task(struct task_struct *tsk)
>  		free_task(tsk);
>  }
>  
> +static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
> +{
> +	/* Skip if kernel thread */
> +	if (!tsk->mm)
> +		return;
> +
> +	/* Skip if spawning a thread or using vfork */
> +	if ((clone_flags & (CLONE_VM | CLONE_THREAD | CLONE_VFORK)) != CLONE_VM)
> +		return;
> +
> +	/* We need to synchronize with __set_oom_adj */
> +	mutex_lock(&oom_adj_lock);
> +	set_bit(MMF_PROC_SHARED, &tsk->mm->flags);
> +	/* Update the values in case they were changed after copy_signal */
> +	tsk->signal->oom_score_adj = current->signal->oom_score_adj;
> +	tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
> +	mutex_unlock(&oom_adj_lock);

The copying and the setting of a bit on a mm should be logically
separate things.

This really makes my head hurt because the functionality is not
separated out.  I don't have a clue how we could maintain this
copy_oom_score_adj function.


> +}
> +
>  /*
>   * This creates a new process as a copy of the old one,
>   * but does not actually start it yet.
> @@ -2281,6 +2300,8 @@ static __latent_entropy struct task_struct *copy_process(
>  	trace_task_newtask(p, clone_flags);
>  	uprobe_copy_process(p, clone_flags);
>  
> +	copy_oom_score_adj(clone_flags, p);
> +
>  	return p;
>  
>  bad_fork_cancel_cgroup:
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index e90f25d6385d..c22f07c986cb 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -64,6 +64,8 @@ int sysctl_oom_dump_tasks = 1;
>   * and mark_oom_victim
>   */
>  DEFINE_MUTEX(oom_lock);
> +/* Serializes oom_score_adj and oom_score_adj_min updates */
> +DEFINE_MUTEX(oom_adj_lock);
>  
>  static inline bool is_memcg_oom(struct oom_control *oc)
>  {

Eric
