Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C7C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F03206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586454988;
	bh=PqnGA18fbjWJ6jPpaALQpwlsOsX9WtYIEa3CMbgDX8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R3/tUeYn4HBB8fvjP4z4yEzohbX/BG3u6GUjdsEiA9qnz8d2hqZ7azFkSk4ZFXitK
	 7tSfTwCQoA2hocJ9b8txDUuxJ7nY2r6Jh5Adc8zubggjt3QKt18G3mS7TrMsfDSUYf
	 7D5CdytUoWUdLS2ywwNOII9I+08PniP1gwBZ3jvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIR40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:56:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33321 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIR40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:56:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id v7so4942725qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gLm9c9BJkp5q7ogvl1hMr79wf7+tg3z7449OZ6CG6E=;
        b=ILYODuX/tzwdF6uf10NHw7hbDVVLkx9CmAELs+PDiqL69d15eWKafKTOfqRmWwIYZ5
         aT77ZTYREnawvoIWlZ40rT1ijMKmQcVS4nwccdviNA6AEK03pDSo0Wj0WxwrvNDeIdF9
         YIeOFG50we74b24N5a2pao9P/XSzEdzZQQDprsWp3GrrmpuBBg5MCGual2uW0TBG2G2f
         GKcg7v/PvP9KIPjg47HXxWPj+3wAFOBXf3uhfZEnki6wg1Lz/l6Q2o3Eh8ktGKbTtoqH
         RD3gEdZ7jIAuw3Pfx09z2r6B8+a0uWmd/ng86sW412ejhGb8NYONUAfoyPbDKWKglNJu
         8Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3gLm9c9BJkp5q7ogvl1hMr79wf7+tg3z7449OZ6CG6E=;
        b=iV2bIb0MJUSk1Ej7mxMwwi5pSEWaiTCja2kHFOK0ZbdvLLY+ie4WH5L5OB56rk9vA+
         pFeNlmjiqsKXAoj9fAlvaPrtV8RaZC41amE/8n/YGHedmwwFzyhjgqvZe8uz1JQhnxlK
         s1aDvFaavtHj/Z4Hf1SFCgigxWUvOnOCotyLTZkXhHyMxSc4R1mZSOkbvyCydUnu89oi
         GDCALj7ioekyJlhR/3cqAqbUU6hcgZb3cMVGm16BF+vQKk3N5bAwDfrep9+fG59aJucW
         qzw3VO/sxCPgwybNGOfZ2fZyUNklwv4Saaj05+qbAP1mnfs1TVydrKQ4a4Pc5uOE8H71
         IHxw==
X-Gm-Message-State: AGi0Puat6wI24fsQnCWR7Fqz/KVH8dL6Ybwn3Qc8xTjwlyNIrRdAfVBk
        jJmAi16hWOSdiFZToxxVD54=
X-Google-Smtp-Source: APiQypLyh1A1Qit1zcPSU8vU7ck8R3gN7tFBFmpJPUwAevwsJim1Wa63V+WOIast3+Fm1q73SjQQVw==
X-Received: by 2002:a37:e312:: with SMTP id y18mr1060332qki.243.1586454983739;
        Thu, 09 Apr 2020 10:56:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::74a8])
        by smtp.gmail.com with ESMTPSA id 207sm22546620qkf.69.2020.04.09.10.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 10:56:23 -0700 (PDT)
Date:   Thu, 9 Apr 2020 13:56:21 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409175621.GA37608@mtj.thefacebook.com>
References: <20200409154413.GK3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409154413.GK3818@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mel.

On Thu, Apr 09, 2020 at 04:44:13PM +0100, Mel Gorman wrote:
> Commit 9a9e97b2f1f2 ("cgroup: Add memory barriers to plug
> cgroup_rstat_updated() race window") introduced two full memory
> barriers to close a race. The one in cgroup_rstat_updated can be
> called at a high frequency from the scheduler from update_curr ->
> cgroup_account_cputime. The patch has no cc's, acks or reviews so I'm
> not sure how closely this was looked at. cgroup_rstat_updated shows up
> in profiles of netperf UDP_STREAM accounting for about 1% of overhead

Oops, that's pretty high.

> which doesn't sound a lot but that's about the same weight as some of
> the critical network paths. I have three questions about the patch
> 
> 1. Why were full barriers used?

Given

   A    C
  ---  ---
   B    D

the code is trying to guarantee that either B sees C or D sees A, so it does
need full ordering.

> 2. Why was it important that the data race be closed when the inaccuracy
>    is temporary?

There was a pending patchset which converted memcg to use rstat and the
conversion included the event counters which needed to be synchronous (e.g.
for things like oom kill counts). The patchset didn't make it through due to
the percpu memory overhead at the time. The memory overhead issue can be
resolved now but in the meantime memcg got improved in a different way which
made the rstat conversion not immediately necessary, so it fell through the
cracks. In retrospect, this patch shouldn't have been committed on its own or
at least the synchronous and pure state update paths should have been
separate.

> 3. Why is it called from the context of update_curr()?

It's just being callled from the path which udpates sched statistics.

> For 1, the use of a full barrier seems unnecessary when it appears that
> you could have used a read barrier and a write barrier. The following
> patch drops the profile overhead to 0.1%

I'm not sure this is correct but that's kinda irrelevant.

> For 2, the changelog says the barriers are necessary because "we plan to use
> rstat to track counters which need to be accurate". That is a bit vague.
> Under what circumstances is a transient inaccuracy a serious enough
> problem to justify additional barriers in the scheduler?

Hope this is explained now.

> For 3, update_curr() is called from a lot of places, some of which are
> quite hot -- e.g. task enqueue/dequeue. This is necessary information from
> the runqueue needs to be preserved. However, it's less clear that the cpu
> accounting information needs to be up to date on this granularity although
> it might be related to question 2. Why was the delta_exec not similarly
> accumulated in cpuacct_change() and defer the hierarchical update to
> be called from somewhere like entity_tick()? It would need tracking the
> CPU time at the last update as delta_exec would be lost so it's not very
> trivial but it does not look like it would be overly complicated.

Most likely historic. The code has been there for a long time and the only
recent changes were plumbing around them. Nothing in cpuacct needs to be
per-scheduling-event accurate, so yeah, for the longer term, it'd be a good
idea to move them out of hot path.

For now, I'll revert the patch. Nothing in tree needs that right now. If the
need for synchronous counting comes back later, I'll make that a separate
path.

Thanks.

-- 
tejun
