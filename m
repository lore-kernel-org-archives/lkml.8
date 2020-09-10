Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E326C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5C3207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 23:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dOA0UGdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIJXXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIJXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:23:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:23:38 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g29so5221336pgl.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZlWTPzwnFebLtigNccl4tjbrW0gsqr46B59u1z1FFA=;
        b=dOA0UGdZffykEDVFV5x73+yCWBWIlUrVtj4MMIscHn4LpaVFku+Lb/PL6gRkxnm1vZ
         YQtquyZNoDWaqY4lEV/VozXDLalb++kiyQoq03ZBSmrlGx9ZTcBYZ0jBlZcmIRKCJW1D
         s4/HOiAjmIJqYmvwrRbh9IMsuVVPfZWurgnSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZlWTPzwnFebLtigNccl4tjbrW0gsqr46B59u1z1FFA=;
        b=IYCm1In/6s32hltFLdar1wKu+axhDnwbEBGMZnGoogWVc8pB+dTOCAm5xURmBal4rg
         K2nZ3riDF8JMEGay+Lqu/zKwKWbRyuDohiP87WQi6MqhmNqsNSSZbmXHBWCBcgByP6Cy
         f6axXJ9Tk7AS4QTYPPJ//0H7Q1mrnTtp/pypm42s8Z7StsI6whLOvyCamYAy2EHanjrT
         BgFwFmQmdh//Nr38uLig9LcuJzKbJH9TilACBCpS3jkNYN3XPI5DTst98nXty1+sgnua
         gbUUE5PKGjORfals62iaOSTkwi18O4009bfvrygzEG/Gbazz53EdnIhxFnn+KOCtXXDK
         buww==
X-Gm-Message-State: AOAM530Qfl5yWBeekynfx89e5D6jF24DJCXVUi0df9rOsuNpBE8wiPIE
        /0nY6yjSZJx6wb1kMklig1q7aC6QXZgUo/q2
X-Google-Smtp-Source: ABdhPJySX/oxzYxna6vYvM5uKjPmSo3YGwyPKsF8h/2buuprnWQYn7q+j2AuULSEWZaZx2k9GZ6/tg==
X-Received: by 2002:a17:902:fe8c:b029:d0:cbe1:e74a with SMTP id x12-20020a170902fe8cb02900d0cbe1e74amr8174123plm.37.1599780218173;
        Thu, 10 Sep 2020 16:23:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm150436pfp.214.2020.09.10.16.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:23:37 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:23:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 2/6] security/fbfam: Add the api to manage statistics
Message-ID: <202009101618.2D05F2588@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-3-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:03PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> Create a statistical data structure to hold all the necessary
> information involve in a fork brute force attack. This info is a
> timestamp for the first fork or execve and the number of crashes since
> then. Moreover, due to this statitistical data will be shared between
> different tasks, a reference counter it is necessary.
> 
> For a correct management of an attack it is also necessary that all the
> tasks hold statistical data. The same statistical data needs to be
> shared between all the tasks that hold the same memory contents or in
> other words, between all the tasks that have been forked without any
> execve call.
> 
> When a forked task calls the execve system call, the memory contents are
> set with new values. So, in this scenario the parent's statistical data
> no need to be share. Instead, a new statistical data structure must be
> allocated to start a new cycle.
> 
> The statistical data that every task holds needs to be clear when a task
> exits. Due to this data is shared across multiples tasks, the reference
> counter is useful to free the previous allocated data only when there
> are not other pointers to the same data. Or in other words, when the
> reference counter reaches zero.
> 
> So, based in all the previous information add the api to manage all the
> commented cases.
> 
> Also, add to the struct task_struct a new field to point to the
> statitistical data related to an attack. This way, all the tasks will
> have access to this information.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>

I think patch 1 should be merged into this one since the former doesn't
really *do* anything. ;)

> ---
>  include/fbfam/fbfam.h   |  18 +++++
>  include/linux/sched.h   |   4 +
>  security/Makefile       |   4 +
>  security/fbfam/Makefile |   2 +
>  security/fbfam/fbfam.c  | 163 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 191 insertions(+)
>  create mode 100644 include/fbfam/fbfam.h
>  create mode 100644 security/fbfam/Makefile
>  create mode 100644 security/fbfam/fbfam.c
> 
> diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
> new file mode 100644
> index 000000000000..b5b7d1127a52
> --- /dev/null
> +++ b/include/fbfam/fbfam.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _FBFAM_H_
> +#define _FBFAM_H_
> +
> +#include <linux/sched.h>
> +
> +#ifdef CONFIG_FBFAM
> +int fbfam_fork(struct task_struct *child);
> +int fbfam_execve(void);
> +int fbfam_exit(void);
> +#else
> +static inline int fbfam_fork(struct task_struct *child) { return 0; }

This appears to map well to LSM hook "task_alloc".

> +static inline int fbfam_execve(void) { return 0; }

This appears to map well to LSM hook "bprm_committing_creds".

> +static inline int fbfam_exit(void) { return 0; }

This appears to map well to LSM hook "task_free".

> +#endif
> +
> +#endif /* _FBFAM_H_ */
> +
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index afe01e232935..00e1aa5e00cd 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1315,6 +1315,10 @@ struct task_struct {
>  	struct callback_head		mce_kill_me;
>  #endif
>  
> +#ifdef CONFIG_FBFAM
> +	struct fbfam_stats		*fbfam_stats;
> +#endif

This could be part of the task_struct security blob used by LSMs.

> +
>  	/*
>  	 * New fields for task_struct should be added above here, so that
>  	 * they are included in the randomized portion of task_struct.
> diff --git a/security/Makefile b/security/Makefile
> index 3baf435de541..36dc4b536349 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+= bpf/
>  # Object integrity file lists
>  subdir-$(CONFIG_INTEGRITY)		+= integrity
>  obj-$(CONFIG_INTEGRITY)			+= integrity/
> +
> +# Object fbfam file lists
> +subdir-$(CONFIG_FBFAM)			+= fbfam
> +obj-$(CONFIG_FBFAM)			+= fbfam/
> diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
> new file mode 100644
> index 000000000000..f4b9f0b19c44
> --- /dev/null
> +++ b/security/fbfam/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_FBFAM) += fbfam.o
> diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
> new file mode 100644
> index 000000000000..0387f95f6408
> --- /dev/null
> +++ b/security/fbfam/fbfam.c
> @@ -0,0 +1,163 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/current.h>
> +#include <fbfam/fbfam.h>
> +#include <linux/errno.h>
> +#include <linux/gfp.h>
> +#include <linux/jiffies.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
> +
> +/**
> + * struct fbfam_stats - Fork brute force attack mitigation statistics.
> + * @refc: Reference counter.
> + * @faults: Number of crashes since jiffies.
> + * @jiffies: First fork or execve timestamp.
> + *
> + * The purpose of this structure is to manage all the necessary information to
> + * compute the crashing rate of an application. So, it holds a first fork or
> + * execve timestamp and a number of crashes since then. This way the crashing
> + * rate in milliseconds per fault can be compute when necessary with the
> + * following formula:
> + *
> + * u64 delta_jiffies = get_jiffies_64() - fbfam_stats::jiffies;
> + * u64 delta_time = jiffies64_to_msecs(delta_jiffies);
> + * u64 crashing_rate = delta_time / (u64)fbfam_stats::faults;
> + *
> + * If the fbfam_stats::faults is zero, the above formula can't be used. In this
> + * case, the crashing rate is zero.
> + *
> + * Moreover, since the same allocated structure will be used in every fork
> + * since the first one or execve, it's also necessary a reference counter.
> + */
> +struct fbfam_stats {
> +	refcount_t refc;
> +	unsigned int faults;
> +	u64 jiffies;
> +};
> +
> +/**
> + * fbfam_new_stats() - Allocation of new statistics structure.
> + *
> + * If the allocation is successful the reference counter is set to one to
> + * indicate that there will be one task that points to this structure. The
> + * faults field is initialize to zero and the timestamp for this moment is set.
> + *
> + * Return: NULL if the allocation fails. A pointer to the new allocated
> + *         statistics structure if it success.
> + */
> +static struct fbfam_stats *fbfam_new_stats(void)
> +{
> +	struct fbfam_stats *stats = kmalloc(sizeof(struct fbfam_stats),
> +					    GFP_KERNEL);
> +
> +	if (stats) {
> +		refcount_set(&stats->refc, 1);
> +		stats->faults = 0;
> +		stats->jiffies = get_jiffies_64();
> +	}
> +
> +	return stats;
> +}
> +
> +/*
> + * fbfam_fork() - Fork management.
> + * @child: Pointer to the child task that will be created with the fork system
> + *         call.
> + *
> + * For a correct management of a fork brute force attack it is necessary that
> + * all the tasks hold statistical data. The same statistical data needs to be
> + * shared between all the tasks that hold the same memory contents or in other
> + * words, between all the tasks that have been forked without any execve call.
> + *
> + * To ensure this, if the current task doesn't have statistical data when forks
> + * (only possible in the first fork of the zero task), it is mandatory to
> + * allocate a new one. This way, the child task always will share the statistics
> + * with its parent.
> + *
> + * Return: -ENOMEN if the allocation of the new statistics structure fails.
> + *         Zero otherwise.
> + */
> +int fbfam_fork(struct task_struct *child)
> +{
> +	struct fbfam_stats **stats = &current->fbfam_stats;
> +
> +	if (!*stats) {
> +		*stats = fbfam_new_stats();
> +		if (!*stats)
> +			return -ENOMEM;
> +	}
> +
> +	refcount_inc(&(*stats)->refc);
> +	child->fbfam_stats = *stats;
> +	return 0;
> +}
> +
> +/**
> + * fbfam_execve() - Execve management.
> + *
> + * When a forked task calls the execve system call, the memory contents are set
> + * with new values. So, in this scenario the parent's statistical data no need
> + * to be share. Instead, a new statistical data structure must be allocated to
> + * start a new cycle. This condition is detected when the statistics reference
> + * counter holds a value greater than or equal to two (a fork always sets the
> + * statistics reference counter to two since the parent and the child task are
> + * sharing the same data).
> + *
> + * However, if the execve function is called immediately after another execve
> + * call, althought the memory contents are reset, there is no need to allocate
> + * a new statistical data structure. This is possible because at this moment
> + * only one task (the task that calls the execve function) points to the data.
> + * In this case, the previous allocation is used and only the faults and time
> + * fields are reset.
> + *
> + * Return: -ENOMEN if the allocation of the new statistics structure fails.
> + *         -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +int fbfam_execve(void)
> +{
> +	struct fbfam_stats **stats = &current->fbfam_stats;
> +
> +	if (!*stats)
> +		return -EFAULT;
> +
> +	if (!refcount_dec_not_one(&(*stats)->refc)) {
> +		/* execve call after an execve call */
> +		(*stats)->faults = 0;
> +		(*stats)->jiffies = get_jiffies_64();
> +		return 0;
> +	}
> +
> +	/* execve call after a fork call */
> +	*stats = fbfam_new_stats();
> +	if (!*stats)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +/**
> + * fbfam_exit() - Exit management.
> + *
> + * The statistical data that every task holds needs to be clear when a task
> + * exits. Due to this data is shared across multiples tasks, the reference
> + * counter is useful to free the previous allocated data only when there are
> + * not other pointers to the same data. Or in other words, when the reference
> + * counter reaches zero.
> + *
> + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +int fbfam_exit(void)
> +{
> +	struct fbfam_stats *stats = current->fbfam_stats;
> +
> +	if (!stats)
> +		return -EFAULT;
> +
> +	if (refcount_dec_and_test(&stats->refc))
> +		kfree(stats);
> +
> +	return 0;
> +}
> +
> -- 
> 2.25.1
> 

Jann mentions some concerns about races, and I'd agree: this doesn't
feel right to me, but I've not had a chance to study it yet. I'm
concerned about the lifetime management of the stats vs the task
hierarchy.

-- 
Kees Cook
