Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58915C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E56208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 21:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="B30oNYxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBSVRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 16:17:38 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37354 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:17:38 -0500
Received: by mail-qv1-f68.google.com with SMTP id s6so891671qvq.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 13:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCLjz7M4YJwFs7aylU86Rq3g/Tn6Qld7njjmEffQ+9w=;
        b=B30oNYxMID8BCpKnJlWgSrTRh0rohUTCWEnk741T2bdHfmKFHjiroSydqVWkKIFa0e
         8IbYUgymNgXCPjY7CjI4AUsezYb/KyaCIwd1JYCmao1mFZnDF/MtJ47KheJkuc8TnWHL
         +eDymjoFPcROar3GqWPj5CPz6p+fai6L+Py8quvtYExkGogotqhUg0//LAm42RVxCnsF
         E5x/onDUjO0b7Ojat5Ldn0I26ei3Sehi4QV0XIjZSmCj4DDnSsFTr/jd99cRqIYLyF1e
         m1FsFZjitLAT9HN8beuSVsr9jewd3LwYKt1NqMzD44JLtlNscy4a/IeX0DDCleklDaFT
         qYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCLjz7M4YJwFs7aylU86Rq3g/Tn6Qld7njjmEffQ+9w=;
        b=GDeFq5RP/hU2h0e09nSdu7M63HD4pmlM2Ertah4syv1VmFoDm6JYD1KW7gZSAolKiJ
         0HIz4L082+xTDEDaEtrfUp4dB/5Bvz1f7dryQbqVMSajgvS83B3ykqz+ibbwEhTzbm79
         KshHZ9CgFXAxyceokpwAYpwSiBx+8EobAPhrI4MqI9eo8V04eKM8puyYrkdietQ4haJ/
         OVzGFdWrgcnivy41Yj611+k20u861Z4FnMnw+fQmjDMSgiHTe5vM3/05PcDVXfcXAx4A
         aywVoyddLCt6XVt8C41GXLUtkQkwN1b8PzylaimB9y1rHhj9+NkxiIBcv2w5sg2akkHT
         81dw==
X-Gm-Message-State: APjAAAVfmEKjtXhfDCnpTXdp+2lwfVE1R16RSJg4XhlR4/Go4jjg1paW
        fPEHWx9OSJ8aRtU/i3xisvfoBA==
X-Google-Smtp-Source: APXvYqxcQhvmiatpB59CTMpLACF33AgmJ+Snugdn47mV5KgKtow8LdlM3tXW9IDB+vJ91j/E6kwsdg==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr23246916qvb.122.1582147057433;
        Wed, 19 Feb 2020 13:17:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3bde])
        by smtp.gmail.com with ESMTPSA id n189sm493372qke.9.2020.02.19.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 13:17:36 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:17:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219211735.GD54486@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219195332.GE11847@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> > On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> > > On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > > > We have received regression reports from users whose workloads moved
> > > > into containers and subsequently encountered new latencies. For some
> > > > users these were a nuisance, but for some it meant missing their SLA
> > > > response times. We tracked those delays down to cgroup limits, which
> > > > inject direct reclaim stalls into the workload where previously all
> > > > reclaim was handled my kswapd.
> > > 
> > > I am curious why is this unexpected when the high limit is explicitly
> > > documented as a throttling mechanism.
> > 
> > Memory.high is supposed to curb aggressive growth using throttling
> > instead of OOM killing. However, if the workload has plenty of easily
> > reclaimable memory and just needs to recycle a couple of cache pages
> > to permit an allocation, there is no need to throttle the workload -
> > just as there wouldn't be any need to trigger the OOM killer.
> > 
> > So it's not unexpected, but it's unnecessarily heavy-handed: since
> > memory.high allows some flexibility around the target size, we can
> > move the routine reclaim activity (cache recycling) out of the main
> > execution stream of the workload, just like we do with kswapd. If that
> > cannot keep up, we can throttle and do direct reclaim.
> > 
> > It doesn't change the memory.high semantics, but it allows exploiting
> > the fact that we have SMP systems and can parallize the book keeping.
> 
> Thanks, this describes the problem much better and I believe this all
> belongs to the changelog.

Ok.

> > > > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > > > while keeping direct reclaim as a fallback. In our testing, this
> > > > eliminated all direct reclaim from the affected workload.
> > > 
> > > Who is accounted for all the work? Unless I am missing something this
> > > just gets hidden in the system activity and that might hurt the
> > > isolation. I do see how moving the work to a different context is
> > > desirable but this work has to be accounted properly when it is going to
> > > become a normal mode of operation (rather than a rare exception like the
> > > existing irq context handling).
> > 
> > Yes, the plan is to account it to the cgroup on whose behalf we're
> > doing the work.
> 
> OK, great, because honestly I am not really sure we can merge this work
> without that being handled, I am afraid. We've had similar attempts
> - mostly to parallelize work on behalf of the process (e.g. address space
> tear down) - and the proper accounting was always the main obstacle so we
> really need to handle this problem for other reasons. This doesn't sound
> very different. And your example of a workload not meeting SLAs just
> shows that the amount of the work required for the high limit reclaim
> can be non-trivial. Somebody has to do that work and we cannot simply
> allow everybody else to pay for that.
>
> > The problem is that we have a general lack of usable CPU control right
> > now - see Rik's work on this: https://lkml.org/lkml/2019/8/21/1208.
> > For workloads that are contended on CPU, we cannot enable the CPU
> > controller because the scheduling latencies are too high. And for
> > workloads that aren't CPU contended, well, it doesn't really matter
> > where the reclaim cycles are accounted to.
> > 
> > Once we have the CPU controller up to speed, we can add annotations
> > like these to account stretches of execution to specific
> > cgroups. There just isn't much point to do it before we can actually
> > enable CPU control on the real workloads where it would matter.
> > 
> > [ This is generally work in process: for example, if you isolate
> >   workloads with memory.low, kswapd cpu time isn't accounted to the
> >   cgroup that causes it. Swap IO issued by kswapd isn't accounted to
> >   the group that is getting swapped.
> 
> Well, kswapd is a system activity and as such it is acceptable that it
> is accounted to the system. But in this case we are talking about a
> memcg configuration which influences all other workloads by stealing CPU
> cycles from them 

From a user perspective this isn't a meaningful distinction.

If I partition my memory among containers and one cgroup is acting
out, I would want the culprit to be charged for the cpu cycles the
reclaim is causing. Whether I divide my machine up using memory.low or
using memory.max doesn't really matter: I'm choosing between the two
based on a *memory policy* I want to implement - work-conserving vs
non-conserving. I shouldn't have to worry about the kernel tracking
CPU cycles properly in the respective implementations of these knobs.

So kswapd is very much a cgroup-attributable activity, *especially* if
I'm using memory.low to delineate different memory domains.

> without much throttling on the consumer side - especially when the
> memory is reclaimable without a lot of sleeping or contention on
> locks etc.

The limiting factor on the consumer side is IO. Reading a page is way
more costly than reclaiming it, which is why we built our isolation
stack starting with memory and IO control and are only now getting to
working on proper CPU isolation.

> I am absolutely aware that we will never achieve a perfect isolation due
> to all sorts of shared data structures, lock contention and what not but
> this patch alone just allows spill over to unaccounted work way too
> easily IMHO.

I understand your concern about CPU cycles escaping, and I share
it. My point is that this patch isn't adding a problem that isn't
already there, nor is it that much of a practical concern at the time
of this writing given the state of CPU isolation in general.
