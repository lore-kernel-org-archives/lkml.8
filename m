Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B19C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0285221924
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODR/DB+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgDQPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:08:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgDQPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587136115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YqfH2tuUhx4MypWhBY8HubmNqOx1ZV8YE9kd2MnuJzc=;
        b=ODR/DB+n4yT1a/Ndy0u7/ovV4EvnwsdG1Hi5ZaW2XsLEC/DVZ9qR4hWm2nVwSMbAlA2hGm
        +BP2Xj+O6thAaP3Ik50VXH21VKZLPMQqSgk1n3VanHTD4jr0FtBNfNGtAmRy6UsLZSHRKR
        hSnsTtmCwnAGPIkUWn6COWKj2YtZzWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ye6sOoP9MNixWq-uZjp1Qw-1; Fri, 17 Apr 2020 11:08:34 -0400
X-MC-Unique: ye6sOoP9MNixWq-uZjp1Qw-1
Received: by mail-wm1-f70.google.com with SMTP id y1so1110428wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqfH2tuUhx4MypWhBY8HubmNqOx1ZV8YE9kd2MnuJzc=;
        b=V3Y3NVFYKNa9wvPZ2EOgVOIJVVXVkj5i29Nt5ud3aqR7pzFGJOJj4INc0AF9NFC8pW
         EgNx5OkMRVNMbHYomLVEDY3mA/rULU+VWBdhLG2rbHXn59hAiXpoVXr0dDn5OWucRGUN
         2z/licS35mhV91xI2Y489GWzAB0m8g/d2UCXkqklkQJpOPLGB2tH+VBFsLuxqS/4HVb9
         aEdlwo+0VKYQhlzUvxeEhRhunogeE+C9aumGF/1gTbch6vr2JptRjYKfd0hZuvCRxoVO
         L534FQxjqETLqRnlLn22HlFMlmmN49s6WcV9uUaNcO0AlVjzLKa4BUfZ81w780uf+b2u
         gMOQ==
X-Gm-Message-State: AGi0PubYmzUveAc25TP5+FTnhJSuxbgt/KV32BAoa5lPQR7p5Hp9cAfT
        8njDIhP8PjymDG4EsUYh7HE6LsXQ/BtImUHHitRHX3yuGjN64C2CDyT1uKM7yE9fLkIHZl0G6wZ
        gNh1uleRxRfra1+5AVyRzqBwK
X-Received: by 2002:adf:8b45:: with SMTP id v5mr4723634wra.175.1587136112535;
        Fri, 17 Apr 2020 08:08:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypITpbGERYSOqn0nRYDvyV9U4ds1jvrBYZvrLO/HQZiZOCDrHAxk4Jao8PsBr6fnretvhDQ8zw==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr4723561wra.175.1587136111698;
        Fri, 17 Apr 2020 08:08:31 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id e5sm33289823wru.92.2020.04.17.08.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:08:30 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:08:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200417150828.GS9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
 <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
 <20200417121945.GM9767@localhost.localdomain>
 <8734b37e-5602-79dc-c7a8-c41fd9eb86b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734b37e-5602-79dc-c7a8-c41fd9eb86b5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/20 16:55, Dietmar Eggemann wrote:
> On 17.04.20 14:19, Juri Lelli wrote:
> > On 09/04/20 19:29, Dietmar Eggemann wrote:
> 
> [...]
> 
> >> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
> >> with the help of an extra per-cpu cpumask we could just
> > 
> > Hummm, I like the idea, but
> > 
> >> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
> >>
> >> dl_bw_cpus(int i) {
> > 
> > This works if calls are always local to the rd we are interested into
> > (argument 'i' isn't used). Are we always doing that?
> 
> I thought so. The existing dl_bw_cpus(int i) implementation already
> assumes this by using:
> 
>     struct root_domain *rd = cpu_rq(i)->rd;

Hummm, can't dl_task_can_attach() call it with a dest_cpu different from
this_cpu?

Current implementation uses 'i' argument to get to the right root_domain
(e.g., when moving tasks between execlusive set).

>     ...
> 
>     for_each_cpu_and(i, rd->span, cpu_active_mask)
> 
> Or did you refer to something else here?
> 
> And the patch would not introduce new places in which we call
> dl_bw_cpus(). It will just replace some with a dl_bw_capacity() call.
> 
> >>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
> >>     ...
> >>     cpumask_and(cpus, rd->span, cpu_active_mask);
> >>
> >>     return cpumask_weight(cpus);
> >> }
> >>
> >> and
> >>
> >> dl_bw_capacity(int i) {
> >>
> >>     struct cpumask *cpus = this_cpu_cpumask_var_ptr(dl_bw_mask);
> >>     ...
> >>     cpumask_and(cpus, rd->span, cpu_active_mask);
> >>     if (cpumask_equal(cpus, rd->span))
> >>         return rd->sum_cpu_capacity;
> > 
> > What if capacities change between invocations (with the same span)?
> > Can that happen?
> 
> The CPU capacity should only change during initial bring-up. On
> asymmetric CPU capacity systems we have to re-create the Sched Domain
> (SD) topology after CPUfreq becomes available.
> 
> After the initial build and this first rebuild of the SD topology, the
> CPU capacity should be stable.
> 
> Everything which might follow afterwards (starting EAS, exclusive
> cpusets or CPU hp) will not change the CPU capacity.
> 
> Obviously, if you defer loading CPUfreq driver after you started DL
> scheduling you can break things. But this is not considered a valid
> environment here.

OK. Makes sense.

