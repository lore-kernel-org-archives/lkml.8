Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3D3C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4EA2071E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 21:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLvqqzEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgAWV43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 16:56:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30281 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727215AbgAWV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 16:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579816586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+0VnNQu9UMoXCLNhPM/TS67VMiYE2w9OTMD3hYOX6g=;
        b=cLvqqzEzbCbbdRojF9d4wnanhpE+ymTA67NaIcHuBKki96JvyHF2LOITPA+uxPHavluRT8
        8NOrEzyfTkLrB/D+yfrRIn5uTjxmd09stT+aETxV6jgs00sUQB1fkz1nzTEoPG+mfx6Yrg
        Cp33Xrr8jgmhC8wFZKDiewA6ZbKgwNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-1nkxB7eZP5ec4fmyt-u6-w-1; Thu, 23 Jan 2020 16:56:22 -0500
X-MC-Unique: 1nkxB7eZP5ec4fmyt-u6-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0845107ACC7;
        Thu, 23 Jan 2020 21:56:21 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DDE83B0;
        Thu, 23 Jan 2020 21:56:21 +0000 (UTC)
Date:   Thu, 23 Jan 2020 16:56:19 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@gmail.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]sched/rt: Stop for_each_process_thread() iterations in
 tg_has_rt_tasks()
Message-ID: <20200123215616.GA14789@pauld.bos.csb>
References: <152415882713.2054.8734093066910722403.stgit@localhost.localdomain>
 <20180420092540.GG24599@localhost.localdomain>
 <0d7fbdab-b972-7f86-4090-b49f9315c868@virtuozzo.com>
 <854a5fb1-a9c1-023f-55ec-17fa14ad07d5@virtuozzo.com>
 <20180425194915.GH4064@hirez.programming.kicks-ass.net>
 <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f76872b-85e6-63bd-e503-fcaec69e28e3@virtuozzo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 26, 2018 at 12:54:41PM +0300 Kirill Tkhai wrote:
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> tg_rt_schedulable() iterates over all child task groups,
> while tg_has_rt_tasks() iterates over all linked tasks.
> In case of systems with big number of tasks, this may
> take a lot of time.
> 
> I observed hard LOCKUP on machine with 20000+ processes
> after write to "cpu.rt_period_us" of cpu cgroup with
> 39 children. The problem occurred because of tasklist_lock
> is held for a long time and other processes can't do fork().
> 
> PID: 1036268  TASK: ffff88766c310000  CPU: 36  COMMAND: "criu"
>  #0 [ffff887f7f408e48] crash_nmi_callback at ffffffff81050601
>  #1 [ffff887f7f408e58] nmi_handle at ffffffff816e0cc7
>  #2 [ffff887f7f408eb0] do_nmi at ffffffff816e0fb0
>  #3 [ffff887f7f408ef0] end_repeat_nmi at ffffffff816e00b9
>     [exception RIP: tg_rt_schedulable+463]
>     RIP: ffffffff810bf49f  RSP: ffff886537ad7d50  RFLAGS: 00000202
>     RAX: 0000000000000000  RBX: 000000003b9aca00  RCX: ffff883e9cb4b1b0
>     RDX: ffff887d0be43608  RSI: ffff886537ad7dd8  RDI: ffff8840a6ad0000
>     RBP: ffff886537ad7d68   R8: ffff887d0be431b0   R9: 00000000000e7ef0
>     R10: ffff88164fc39400  R11: 0000000000023380  R12: ffffffff81ef8d00
>     R13: ffffffff810bea40  R14: 0000000000000000  R15: ffff8840a6ad0000
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> --- <NMI exception stack> ---
>  #4 [ffff886537ad7d50] tg_rt_schedulable at ffffffff810bf49f
>  #5 [ffff886537ad7d70] walk_tg_tree_from at ffffffff810c6c91
>  #6 [ffff886537ad7dc0] tg_set_rt_bandwidth at ffffffff810c6dd0
>  #7 [ffff886537ad7e28] cpu_rt_period_write_uint at ffffffff810c6eea
>  #8 [ffff886537ad7e38] cgroup_file_write at ffffffff8111cfd3
>  #9 [ffff886537ad7ec8] vfs_write at ffffffff8121eced
> #10 [ffff886537ad7f08] sys_write at ffffffff8121faff
> #11 [ffff886537ad7f50] system_call_fastpath at ffffffff816e8a7d
> 
> The patch reworks tg_has_rt_tasks() and makes it to iterate over
> task group process list instead of iteration over all tasks list.
> This makes the function to scale well, and reduces its execution
> time.
> 
> Note, that since tasklist_lock doesn't protect a task against
> sched_class changing, we don't introduce new races in comparison
> to that we had before.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  kernel/sched/rt.c |   21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 7aef6b4e885a..a40535c604b8 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2395,10 +2395,11 @@ const struct sched_class rt_sched_class = {
>   */
>  static DEFINE_MUTEX(rt_constraints_mutex);
>  
> -/* Must be called with tasklist_lock held */
>  static inline int tg_has_rt_tasks(struct task_group *tg)
>  {
> -	struct task_struct *g, *p;
> +	struct task_struct *task;
> +	struct css_task_iter it;
> +	int ret = 0;
>  
>  	/*
>  	 * Autogroups do not have RT tasks; see autogroup_create().
> @@ -2406,12 +2407,16 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> +	css_task_iter_start(&tg->css, 0, &it);
> +	while ((task = css_task_iter_next(&it))) {
> +		if (rt_task(task)) {
> +			ret = 1;
> +			break;
> +		}
>  	}
> +	css_task_iter_end(&it);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  struct rt_schedulable_data {
> @@ -2510,7 +2515,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  		return -EINVAL;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
>  		goto unlock;
> @@ -2528,7 +2532,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	}
>  	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
>  unlock:
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return err;
> @@ -2582,9 +2585,7 @@ static int sched_rt_global_constraints(void)
>  	int ret = 0;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	ret = __rt_schedulable(NULL, 0, 0);
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return ret;

Sorry to necro this...  

I have a customer case that has hit the issue here. It looks like this
fix didn't end up going in. 

The only way I could reproduce it myself was to add a udelay(2) to 
the tg_has_rt_tasks loop. With this patch applied, even with the 
udelay nothing bad happens.

Kirill, did you have a good way to reproduce it without adding 
delays? 

Peter, is there any chance of taking something like this?

Is there a better fix? 


Thanks,
Phil

-- 

