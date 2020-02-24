Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D758C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4792080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 16:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1N5AkiHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbgBXQZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 11:25:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33345 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgBXQZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 11:25:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id h4so9216908qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 08:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUMUmLOvkv6pPNlHDF8kM42BV4WHL66yxh+KM5/nX8I=;
        b=1N5AkiHKfhDXsBrzKCV3BoRiUdQG0XqvYla3VfjZtARWF5rQ7Ppy1AOTWMmueU1io0
         cbT3C6pXQ6ErXcSI9u7bv3tKP8Fk7N7KUbhYWYs9up2eJ7/PEY+xYU83+EjNJQLxt+Ft
         NgnhabZuJKO1X0jCWGuJuKKjfi7PhyrxpSjbFdvjyWNXDGuwxbCWKYHjHgKMFZMEyraO
         4b15lebYS60PtKpJofVESrCGeTPGFGCiuNBHiQKqnNGp8UhRnbWspymfBmOwQaLWQ+jH
         clF2NukP3JGV8bkO93HLdEIZA6YKUGRXaNVy9Yte2Teor4ddInPH/kVH1RwdE7eSUfni
         TQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUMUmLOvkv6pPNlHDF8kM42BV4WHL66yxh+KM5/nX8I=;
        b=NwPMT77ACGSj55+ecVvSnlz9lF6ZU2gqnla4SjcgxaonlxlKZ+uW4G/FN/vk3DJ4L2
         yBfitnOH/ZZdaf5LEfi+OllxALhqEtUbQPHMxvxYzRw2N+l9WBUamgC0Pc7zb//BPeJ9
         ve+UpCf52bDmR6zYGuC4efvRgmyuABn8yAaRB4NywRVBEvUs0HNYqG9PCefKk1Hi8L33
         BalU1xFZ4b1CzlQbvttev/zMjolSQZnXJGlyA89UIE8PViXHLakHTwIZZp/88uxzqK1K
         mV1NNqAdeDCPC8+RBkLE+eLQ/3fGmbLkfsTt8/aTIb89LpAtzkbajE3za8xrGz5moCj5
         txbg==
X-Gm-Message-State: APjAAAV9Oq+8bTdBqX7+/NtzwBBvCRBd618/KtbqjZx8S56wWeEDkOP6
        RmeqfCUTMvxhpL4ChJLmjScqYQ==
X-Google-Smtp-Source: APXvYqy0yCGZ2oK3HLCnMmkgHwIorn7PRWYW/CQHk0T5DcddYYXAXfBFQUJ+b4qHx25IUcIBwhArbw==
X-Received: by 2002:a05:620a:1130:: with SMTP id p16mr52503069qkk.415.1582561517856;
        Mon, 24 Feb 2020 08:25:17 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:e64b])
        by smtp.gmail.com with ESMTPSA id z13sm6257299qtu.53.2020.02.24.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:25:17 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:25:16 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] psi: move PF_MEMSTALL into psi specific psi_flags
Message-ID: <20200224162516.GA1674@cmpxchg.org>
References: <20200222144647.10120-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222144647.10120-1-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yafang,

On Sat, Feb 22, 2020 at 09:46:47AM -0500, Yafang Shao wrote:
> The task->flags is a 32-bits flag, in which 31 bits have already been
> consumed. So it is hardly to introduce other new per process flag.
> As there's a psi specific flag psi_flags, we'd better move the psi specific
> per process flag PF_MEMSTALL into it.

Currently, psi_flags is used only for debugging:

	if (((task->psi_flags & set) ||
	     (task->psi_flags & clear) != clear) &&
	    !psi_bug) {
		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
				task->pid, task->comm, cpu,
				task->psi_flags, clear, set);
		psi_bug = 1;
	}

	task->psi_flags &= ~clear;
	task->psi_flags |= set;

While this has caught a few bugs while the code was new, I'm planning
on moving it to a CONFIG option that is only enabled in debug builds.

If you need the room in task->flags, can you please make the memstall
state a single bit in task_struct instead? AFAICS there is still space
in this section:

	/* Force alignment to the next boundary: */
	unsigned			:0;

	/* Unserialized, strictly 'current' */

	...

#ifdef CONFIG_PSI
	unsigned			in_memstall:1;
#endif

It would also avoid the mixed-bit masking headache:

> @@ -17,11 +17,21 @@ enum psi_task_count {
>  	NR_PSI_TASK_COUNTS = 3,
>  };
>  
> -/* Task state bitmasks */
> +/*
> + * Task state bitmasks:
> + * These flags are stored in the lower PSI_TSK_BITS bits of
> + * task->psi_flags, and the higher bits are set with per process flag which
> + * persists across sleeps.
> + */
> +#define PSI_TSK_STATE_BITS 16
> +#define PSI_TSK_STATE_MASK ((1 << PSI_TSK_STATE_BITS) - 1)
>  #define TSK_IOWAIT	(1 << NR_IOWAIT)
>  #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
>  #define TSK_RUNNING	(1 << NR_RUNNING)
>  
> +/* Stalled due to lack of memory, that's per process flag. */
> +#define PSI_PF_MEMSTALL (1 << PSI_TSK_STATE_BITS)
> +
>  /* Resources that workloads could be stalled on */
>  enum psi_res {
>  	PSI_IO,
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f314790cb527..2d4c04d35d9b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1025,7 +1025,11 @@ struct task_struct {
>  
>  	struct task_io_accounting	ioac;
>  #ifdef CONFIG_PSI
> -	/* Pressure stall state */
> +	/*
> +	 * Pressure stall state:
> +	 * Bits 0 ~ PSI_TSK_STATE_BITS-1: PSI task states
> +	 * Bits PSI_TSK_STATE_BITS ~ 31: Per process flags
> +	 */
>  	unsigned int			psi_flags;
>  #endif
>  #ifdef CONFIG_TASK_XACCT

Thanks
