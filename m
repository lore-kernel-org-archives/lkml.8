Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37317C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1B9207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRs5hd/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEKIBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:01:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49192 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbgEKIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589184088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p4xy/gFUAuwiSRnEJ/0Zyb9V6KmjnNYS+I/N0r7gbyo=;
        b=IRs5hd/gwLvjv0t2XXUd+rPxQlxvAjfl0qEVYFqFNnanDJj1meq1wP0mkB5q7i9eVvm/9Y
        M5y9/mqXbqn78Uz0DBUOXsCJ7y7rdJ3DFtzhDBwr/WgC63wmNS40OluPLo1C9cpHbZ3v2n
        F8hv8VmVDck6FNMcsCx6IuAxPiTTWd8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-7U-PuGQLOKOHm-DsJ7HoAw-1; Mon, 11 May 2020 04:01:27 -0400
X-MC-Unique: 7U-PuGQLOKOHm-DsJ7HoAw-1
Received: by mail-wr1-f70.google.com with SMTP id y7so4841421wrd.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 01:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4xy/gFUAuwiSRnEJ/0Zyb9V6KmjnNYS+I/N0r7gbyo=;
        b=fHj87fP4xxJkA3fd9WMoi+5haEkP1ae1i5cUKN+FAXQzw2ufWJr3o2t5HH5Z/m6p0h
         XCvZYS0PiljJb5arFZ7Cqg4qvipQirdF7Qe09f5zky8WFfreZXrdoXyRlO6QJusOnzIg
         UdBCKPdh+jH+2YUcwX6q5uvnK+78W7IEI7WiKhUi+ydH05c1sSI/k1PBDGtsbYq3Hulo
         VAzE9Cn5ql0Pnbar8hK/XNyeKevLNCcm8y6YZIBAJXGm2tvwa1nZ/zIHyOb4ghN9Q8F+
         y4oNbZTKpKbWVKyiF/cTG4PHGCR/h9PQN5mhZAGAZcXZLQer7+mHkYCJslEnCvH4+htk
         Cj8w==
X-Gm-Message-State: AGi0PuZ4nly8x3qYSJtjK56etoaJJDiq1vGdVEKBDofhKNlfDJF9H5a6
        TvcSuFvTiPdP/HdrqQZJv+XJ3H+uY0USZRx9eL4jPOHJAuNyzn24tCvn3hEx/DWJ44Y7yFbPUDa
        uVNuO9SkNTFyXUWRP4lU2IjV7
X-Received: by 2002:a7b:c399:: with SMTP id s25mr29022667wmj.169.1589184085594;
        Mon, 11 May 2020 01:01:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJi7KgElDznJi8RYRILtoK90//JU/fTYzSqy/uMCTx2LhklfS/ESIFkO3EoCNpQjm4FX9zGfw==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr29022632wmj.169.1589184085258;
        Mon, 11 May 2020 01:01:25 -0700 (PDT)
Received: from localhost.localdomain ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id x5sm17344688wro.12.2020.05.11.01.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 01:01:24 -0700 (PDT)
Date:   Mon, 11 May 2020 10:01:22 +0200
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
Message-ID: <20200511080122.GI264022@localhost.localdomain>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-4-dietmar.eggemann@arm.com>
 <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
 <20200506123738.GJ17381@localhost.localdomain>
 <d07a0517-b1bf-0879-575b-7933063c7597@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d07a0517-b1bf-0879-575b-7933063c7597@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 17:09, Dietmar Eggemann wrote:
> On 06/05/2020 14:37, Juri Lelli wrote:
> > On 06/05/20 12:54, Dietmar Eggemann wrote:
> >> On 27/04/2020 10:37, Dietmar Eggemann wrote:
> 
> [...]
> 
> >> There is an issue w/ excl. cpusets and cpuset.sched_load_balance=0. The
> >> latter is needed to demonstrate the problem since DL task affinity can't
> >> be altered.
> >>
> >> A CPU in such a cpuset has its rq attached to def_root_domain which does
> >> not have its 'sum_cpu_capacity' properly set.
> > 
> > Hummm, but if sched_load_balance is disabled it means that we've now got
> > a subset of CPUs which (from a DL AC pow) are partitioned. So, I'd tend
> 
> Yes, the CPUs of the cpuset w/ cpuset.sched_load_balance=0 (cpuset B in
> the example).
> 
> > to say that we actually want to check new tasks bw requirement against
> > the available bandwidth of the particular CPU they happen to be running
> > (and will continue to run) when setscheduler is called.
> 
> By 'available bandwidth of the particular CPU' you refer to
> '\Sum_{cpu_rq(i)->rd->span} CPU capacity', right?

No. I was referring to the single CPU capacity. The capacity of the CPU
where a task is running when setscheduler is called for it (and DL AC
performed). See below, maybe more clear why I wondered about this case..

> This is what this fix tries to achieve. Regardless whether cpu_rq(i)->rd
> is a 'real' rd or the def_root_domain, dl_bw_capacity() will now always
> return '\Sum_{cpu_rq(i)->rd->span} CPU capacity'
> 
> > If then load balance is enabled again, AC check we did above should
> > still be valid for all tasks admitted in the meantime, no?
>  
> Example (w/ this fix) on Juno [L b b L L L], capacity_orig_of(L)=446 :
> 
> mkdir /sys/fs/cgroup/cpuset/A
> echo 0 > /sys/fs/cgroup/cpuset/A/cpuset.mems
> echo 1 > /sys/fs/cgroup/cpuset/A/cpuset.cpu_exclusive
> echo 0-2 > /sys/fs/cgroup/cpuset/A/cpuset.cpus
> 
> mkdir /sys/fs/cgroup/cpuset/B
> echo 0 > /sys/fs/cgroup/cpuset/B/cpuset.mems
> echo 1 > /sys/fs/cgroup/cpuset/B/cpuset.cpu_exclusive
> echo 3-5 > /sys/fs/cgroup/cpuset/B/cpuset.cpus
> 
> echo 0 > /sys/fs/cgroup/cpuset/B/cpuset.sched_load_balance
> echo 0 > /sys/fs/cgroup/cpuset/cpuset.sched_load_balance
> 
> echo $$ > /sys/fs/cgroup/cpuset/B/tasks
> chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$
> 
> ...
> [  144.920102] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
> [  144.925607] sched_dl_overflow: [bash 1999] task_cpu(p)=3 cap=1338 cpus_ptr=3-5

So, here you are checking new task bw against 1338 which is 3*L
capacity. However, since load balance is disabled at this point for 3-5,
once admitted the task will only be able to run on CPU 3. Now, if more
tasks on CPU 3 are admitted the same way (up to 1338) I believe they
will start to experience deadline misses because only 446 will be
actually available to them until load balance is enabled below and they
are then free to migrate to CPUs 4 and 5.

Does it makes sense?

> [  144.932841] __dl_bw_capacity CPU3 rd->span=3-5 return 1338
> ...
> 
> echo 1 > /sys/fs/cgroup/cpuset/B/cpuset.sched_load_balance
> 
> echo $$ > /sys/fs/cgroup/cpuset/B/tasks
> chrt -d --sched-runtime 8000 --sched-period 16000 -p 0 $$
> 
> ...
> [  254.367982] __dl_bw_capacity CPU5 rd->span=3-5 return 1338
> [  254.373487] sched_dl_overflow: [bash 2052] task_cpu(p)=5 cap=1338 cpus_ptr=3-5
> [  254.380721] __dl_bw_capacity CPU5 rd->span=3-5 return 1338
> ...
> 
> Regardless of 'B/cpuset.sched_load_balance'
> '\Sum_{cpu_rq(i)->rd->span} CPU capacity' stays 1338 (3*446)
> 
> So IMHO, DL AC check stays intact.
> 

