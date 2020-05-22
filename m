Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA71207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUoCzPiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgEVDoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgEVDoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:44:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4F4C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:44:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 145so4525682pfw.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b9te6oLf3ZXULIfTnJCiCYesvc6Tdl5yFCs6fyx4feA=;
        b=EUoCzPiL6zC+w8TzN+sGpX+tndIFp0FqCMLv7ajsny6RxzqLSWVrCPOdN/W5ov5m/B
         4XAuCYCAkpXRWSTGVxGTpT+Hy5GKfo6XS0NYuAEpLkiG8HCZGbnYu2CWKrhh855y2aFs
         td4xnAliGHeAWA8iKp5/eclguorNNBRPgXgnTXtHesArM8ePNZK56LX8juJO7J1tLHrs
         vSzZJIOzm1KcmhXj79d+GP1sGiXvf21d85etyQ/l0jH8DFXk5rhCZcTuysWTSpgmgU81
         hSDp3dgmXqAU6KMxc6OrJCANclWwS4WttCYvRIlZnVFvfOK8Sff2oRjhJcA7L4Dq08tU
         ZhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9te6oLf3ZXULIfTnJCiCYesvc6Tdl5yFCs6fyx4feA=;
        b=HlGAYL6W2GkH5rhSFSfnNr6T3XAJcUnlKzLXM8UWIoSAF15d+e42i9b7cKmWo2nOB0
         2axrlcxHxd9u6hT2nedg4/+ff8c7rffXKfzCFZ7XajkHNx38ztgGvJWVNSOlaGSbyVmo
         vzO77MU21k8lqmpeKGIL0DEmGADBxUfnz5A9cUgb5jmk72IrSxHO8fL/Rfk5USIdBZkT
         Mj2Adwh+3d9iR0Sj+11QKKS0bvnDUJcFPG64VQks44VPI82Y6OsV8NlGhbY+k2+ksk+5
         5cWfByyxakdrBZ+5UCT9RT4HQpJL0VPyJAyp/fTA+GLWQtaV3Z05x745cygpK+yDsPZZ
         M/hw==
X-Gm-Message-State: AOAM530rp4XXUvM1h0mnUBJMbTp/Y8a6orz6GaWm4fXkU2Bp8dZasaKT
        FQ1BMrN6L8/StRl+qsZhj24=
X-Google-Smtp-Source: ABdhPJwbcKv0PDwy4QbYmS+14mQxcPngnE3Hj4Z/tgoBq0mtcIIA6/eZzSsU0ZZSVOzKgpq+74qEYw==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr1920708pfa.15.1590119054088;
        Thu, 21 May 2020 20:44:14 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id h17sm5692643pfr.25.2020.05.21.20.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 20:44:13 -0700 (PDT)
Date:   Fri, 22 May 2020 11:44:06 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200522034406.GC6339@aaronlu-desktop>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200521231426.GA246288@google.com>
 <20200522023556.GE140701@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522023556.GE140701@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:35:56PM -0400, Joel Fernandes wrote:
> Discussed a lot with Vineeth. Below is an improved version of the pick_task()
> similification.
> 
> It also handles the following "bug" in the existing code as well that Vineeth
> brought up in OSPM: Suppose 2 siblings of a core: rq 1 and rq 2.
> 
> In priority order (high to low), say we have the tasks:
> A - untagged  (rq 1)
> B - tagged    (rq 2)
> C - untagged  (rq 2)
> 
> Say, B and C are in the same scheduling class.
> 
> When the pick_next_task() loop runs, it looks at rq 1 and max is A, A is
> tenantively selected for rq 1. Then it looks at rq 2 and the class_pick is B.
> But that's not compatible with A. So rq 2 gets forced idle.
> 
> In reality, rq 2 could have run C instead of idle. The fix is to add C to the
> tag tree as Peter suggested in OSPM.

I like the idea of adding untagged task to the core tree.

> Updated diff below:
> 
> ---8<-----------------------
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 005d7f7323e2d..625377f393ed3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -182,9 +182,6 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
>  
>  	rq->core->core_task_seq++;
>  
> -	if (!p->core_cookie)
> -		return;
> -
>  	node = &rq->core_tree.rb_node;
>  	parent = *node;
>  
> @@ -215,7 +212,7 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
>  
>  void sched_core_add(struct rq *rq, struct task_struct *p)
>  {
> -	if (p->core_cookie && task_on_rq_queued(p))
> +	if (task_on_rq_queued(p))
>  		sched_core_enqueue(rq, p);
>  }

It appears there are other call sites of sched_core_enqueue() where
core_cookie is checked: cpu_cgroup_fork() and __sched_write_tag().
