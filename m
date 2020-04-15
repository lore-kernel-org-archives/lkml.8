Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED66C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2723020775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWWKA1MY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506338AbgDONVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:21:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34844 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506299AbgDONUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586956811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DHcpnN3zus8PcCwIyoMYplMbcGQehFR7QqBvWEqVsuE=;
        b=QWWKA1MYCpZa9GKAZBwXbNrcw/xrvTP34zZNDbmy0KsDaUm75iU8CHT7wuyPW3MRsu5uDu
        6kydBLjzlfqT6yO3xf+AhQnjN4MoLUZxPVRgQXiZm2Qv1Vm+yq78Mht3kVNEwgoHBSTHtQ
        4NU3UFPzigV9x7MmfY9PaUWH50BRXWg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-MOWm1LDHPSOBTSFyjSLRNg-1; Wed, 15 Apr 2020 09:20:09 -0400
X-MC-Unique: MOWm1LDHPSOBTSFyjSLRNg-1
Received: by mail-wm1-f70.google.com with SMTP id y1so5757816wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DHcpnN3zus8PcCwIyoMYplMbcGQehFR7QqBvWEqVsuE=;
        b=OgGFSvg4sAasHZ/mUbTg8ysDAkgZ3gQbs0Yq/oIRDA//xpyjr64ti9FwtqRPFXUq3r
         q6r412QZ3g4qdopQXL3dFMARczjvW07ob9WR8o/CQLvfVHFf/3ypRXRvGFwRRQ9aJWct
         QPB/ePmst0q5utURSvKA0ncOwET4WE5D4FcqJ1RowgZt6ukMuB6ZKFH5cw4SiQqIEBGF
         iFMbDr9EGnGAMmogUF8lEinOv2SfpQh3I8Yqhw4WqOPZ+ohbJf2xlck90FR/Qu1EjXKz
         UNZOqUSgxPHUtbS9+AmHyZZ0Pwdb7nTXcUWfmvdeG4T8EyDe+qsWDUeqAkf4P1cD+Y/a
         o4EA==
X-Gm-Message-State: AGi0PuaJrVL+Iuu0YrXeRb0XxOzL9rzcUwJh46HIxoaTo6fgqSC8FLqZ
        mxwwKAMjzax4cKLCp9fMlMY92rGkVMIbx4K3vEonAVJlqEQaKOZMCYEx9FBGPAQ7KHMZJPXZFCv
        nk+O+FWRc483XZyNoYnMAHSxf
X-Received: by 2002:a5d:474b:: with SMTP id o11mr27656759wrs.4.1586956808434;
        Wed, 15 Apr 2020 06:20:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypKSn9T6dmuCbbOinp1v8qsospGnxh8RPjaMA1dNhivu9LaFbSUyTIifqKD5tn1BMgnkckWn2w==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr27656722wrs.4.1586956808058;
        Wed, 15 Apr 2020 06:20:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id u30sm2973752wru.13.2020.04.15.06.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 06:20:07 -0700 (PDT)
Date:   Wed, 15 Apr 2020 15:20:04 +0200
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
Subject: Re: [PATCH 3/4] sched/deadline: Make DL capacity-aware
Message-ID: <20200415132004.GF9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-4-dietmar.eggemann@arm.com>
 <20200410125253.GE14300@localhost.localdomain>
 <f0e74500-77d7-a42c-410e-bc5d4d2ecdfb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e74500-77d7-a42c-410e-bc5d4d2ecdfb@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 11:39, Dietmar Eggemann wrote:
> On 10.04.20 14:52, Juri Lelli wrote:
> > Hi,
> > 
> > On 08/04/20 11:50, Dietmar Eggemann wrote:
> >> From: Luca Abeni <luca.abeni@santannapisa.it>
> 
> [...]
> 
> >> @@ -1623,10 +1624,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
> >>  	 * other hand, if it has a shorter deadline, we
> >>  	 * try to make it stay here, it might be important.
> >>  	 */
> >> -	if (unlikely(dl_task(curr)) &&
> >> -	    (curr->nr_cpus_allowed < 2 ||
> >> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> >> -	    (p->nr_cpus_allowed > 1)) {
> >> +	select_rq = unlikely(dl_task(curr)) &&
> >> +		    (curr->nr_cpus_allowed < 2 ||
> >> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> >> +		    p->nr_cpus_allowed > 1;
> >> +
> >> +	/*
> >> +	 * We take into account the capacity of the CPU to
> >> +	 * ensure it fits the requirement of the task.
> >> +	 */
> >> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> >> +		select_rq |= !dl_task_fits_capacity(p, cpu);
> > 
> > I'm thinking that, while dl_task_fits_capacity() works well when
> > selecting idle cpus, in this case we should consider the fact that curr
> > might be deadline as well and already consuming some of the rq capacity.
> > 
> > Do you think we should try to take that into account, maybe using
> > dl_rq->this_bw ?
> 
> So you're saying that cpudl_find(..., later_mask) could return 1 (w/
> best_cpu (cp->elements[0].cpu) in later_mask).
> 
> And that this best_cpu could be a non-fitting CPU for p.
> 
> This could happen if cp->free_cpus is empty (no idle CPUs) so we take
> cpudl_find()'s else path and in case p's deadline < cp->elements[0]
> deadline.
> 
> We could condition the 'return 1' on best_cpu fitting p.
> 
> But should we do this for cpudl_find(..., NULL) calls from
> check_preempt_equal_dl() as well or will this break GEDF?

So, even by not returning best_cpu, as above, if it doesn't fit p's bw
requirement, I think we would be breaking GEDF, which however doesn't
take asym capacities into account. OTOH, if we let p migrate to a cpu
that can't suit it, it will still be missing its deadlines (plus it
would be causing deadline misses on the task that was running on
best_cpu).

check_preempt_equal_dl() worries me less, as it is there to service
corner cases (hopefully not so frequent).

