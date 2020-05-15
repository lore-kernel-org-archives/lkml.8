Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675DC20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkUz75ZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgEOM1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:27:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33593 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgEOM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589545624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LHxON+zm8qaQR3nLCkYybXSni2zARj7r+zo8qqLlUr8=;
        b=VkUz75ZDHVW/3rgH3NE8rhND2k/tq6IagKqAuqvCtmq4ELeAIRkmUeDwdJ8cZieBn9AztR
        f89G0Va0fJ7Pmp+o7wCdg1G8bBE90KH6wAX2uvSSI90GOtv1amacvLFkm1TbsMPINDjvZd
        GNo3hxQ5WqJ/atnW7ug57wkULt+7OK0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-ZhyH4JloOL-j9XcZriVDFQ-1; Fri, 15 May 2020 08:27:03 -0400
X-MC-Unique: ZhyH4JloOL-j9XcZriVDFQ-1
Received: by mail-wm1-f70.google.com with SMTP id t82so833358wmf.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHxON+zm8qaQR3nLCkYybXSni2zARj7r+zo8qqLlUr8=;
        b=ZeGSJQXPWUUQ9wHYDG0IJAkmYvMSp/AAQsM7uobcYsaZh/B0yuPB1svVz0d5LBWAxe
         OGYf8Slh9rslhVKBCbFifx1whm9BEkdqPo9N6qagLzYrvRVTOEudNkHFCpf84Z61W6AR
         YNVbVFrrEVFqIekMXTQeA7Zyt2IgDupkJGRFGPc2sN/nuXfJsQHq4C1swv5ToKQsIQ2W
         Uax8aPKb2cI5RSD/EmOUXyTh5pRJPZEx5QUbPhnyegxcRditxBVfbJkcUcN9SMGlcPN6
         khd4ovApIS4YJFpY8sGZ9ffA2bpqa/pbVdhcXolucCoUIl2AL0fb/0Ey012vzq+UwEAh
         0CEQ==
X-Gm-Message-State: AOAM5327nMgMe0HHF6pzNSgXv1umZ2Y34m5sRDSZKJFkIIc3VQbS92OO
        8XDjt8wZlgGRdaaUsBBfJWlADpQRyScJetvZBzc27fZcoJurDiOmGvfmTVSoBQPlU8ChCeG3wbt
        zhRR5ZtwbNj8r2LSQUO7qyKed
X-Received: by 2002:a5d:4801:: with SMTP id l1mr3873931wrq.235.1589545621764;
        Fri, 15 May 2020 05:27:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzddImgFXcB/vjAIeGozqJ5RCjsfHeszbaNBGd/bi5/Y+6gBnXp/qilxd8Cd6N8TQ8qwK7Mng==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr3873908wrq.235.1589545621401;
        Fri, 15 May 2020 05:27:01 -0700 (PDT)
Received: from localhost.localdomain ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id b20sm3582480wme.9.2020.05.15.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 05:27:00 -0700 (PDT)
Date:   Fri, 15 May 2020 14:26:58 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] sched/deadline: Add dl_bw_capacity()
Message-ID: <20200515122658.GG10078@localhost.localdomain>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-4-dietmar.eggemann@arm.com>
 <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
 <20200506123738.GJ17381@localhost.localdomain>
 <d07a0517-b1bf-0879-575b-7933063c7597@arm.com>
 <20200511080122.GI264022@localhost.localdomain>
 <204d67f1-a21c-9d71-9b76-6f1a11c89092@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204d67f1-a21c-9d71-9b76-6f1a11c89092@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/20 14:39, Dietmar Eggemann wrote:
> On 11/05/2020 10:01, Juri Lelli wrote:
> > On 06/05/20 17:09, Dietmar Eggemann wrote:
> >> On 06/05/2020 14:37, Juri Lelli wrote:
> >>> On 06/05/20 12:54, Dietmar Eggemann wrote:
> >>>> On 27/04/2020 10:37, Dietmar Eggemann wrote:
> 
> [...]
> 
> >>> to say that we actually want to check new tasks bw requirement against
> >>> the available bandwidth of the particular CPU they happen to be running
> >>> (and will continue to run) when setscheduler is called.
> >>
> >> By 'available bandwidth of the particular CPU' you refer to
> >> '\Sum_{cpu_rq(i)->rd->span} CPU capacity', right?
> > 
> > No. I was referring to the single CPU capacity. The capacity of the CPU
> > where a task is running when setscheduler is called for it (and DL AC
> > performed). See below, maybe more clear why I wondered about this case..
> 
> OK, got it! I was just confused since I don't think that this patch
> introduced the issue.
> 
> Before the patch 'int cpus = dl_bw_cpus(task_cpu(p))' was used which
> returns the number of cpus on the (default) rd (n). So for a single CPU
> (1024) we use n*1024.
> 
> I wonder if a fix for that should be part of this patch-set?

Not really, I guess. As you said, the issue was there already. We can
fix both situations with a subsequent patch. I just realized that we
have a problem by reviewing this set, but not this set job to fix it.

While you are at changing this part, it might be good to put a comment
(XXX fix this, or something) about the issue, so that we don't forget.

> [...]
> 
> >> ...
> >> [  144.920102] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
> >> [  144.925607] sched_dl_overflow: [bash 1999] task_cpu(p)=3 cap=1338 cpus_ptr=3-5
> > 
> > So, here you are checking new task bw against 1338 which is 3*L
> > capacity. However, since load balance is disabled at this point for 3-5,
> > once admitted the task will only be able to run on CPU 3. Now, if more
> > tasks on CPU 3 are admitted the same way (up to 1338) I believe they
> > will start to experience deadline misses because only 446 will be
> > actually available to them until load balance is enabled below and they
> > are then free to migrate to CPUs 4 and 5.
> > 
> > Does it makes sense?
> 
> Yes, it does.
> 
> So my first idea was to only consider the CPU (i.e. its CPU capacity) in
> case we detect 'cpu_rq(cpu)->rd == def_root_domain'?
> 
> In case I re-enable load-balancing on cpuset '/', we can't make a task
> in cpuset 'B' DL since we hit this in __sched_setscheduler():
> 
> 4931           /*
> 4932            * Don't allow tasks with an affinity mask smaller than
> 4933            * the entire root_domain to become SCHED_DEADLINE.
> ...
> 4935            */
> 4936            if (!cpumask_subset(span, p->cpus_ptr) || ...
> 
> root@juno:~# echo 1 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
> root@juno:~# echo $$ > /sys/fs/cgroup/cpuset/B/tasks
> root@juno:~# chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$
> chrt: failed to set pid 2316's policy: Operation not permitted
> 
> So this task has to leave 'B' first I assume.

Right, because the span is back to contain all cpus (load balancing
enabled at root level), but tasks in 'B' still have affinity set to a
subset of them.

