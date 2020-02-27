Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C404C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7012469A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="LwZJ5hvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgB0MuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:50:15 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45388 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgB0MuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:50:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so2105232qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 04:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/pCx60f/1X+9oiLWtdCr7slRVvciDKJGzX506kGhKA=;
        b=LwZJ5hvMkch1yo5ly172o7GJ3mfainNjJJKqHYsyqJ2MSPmvQnLSjknp31jnre3Ema
         1FUB9Tef3NCtRijJuv9eFIoeetxVNKLwMWAJBDQVp46vYR2nLb8T/5gzw6xZc3TWEzzo
         aDoDQV65wdYVhTygc0oRW+ctO9RbCHUwfFlxd8mbUxnldyd90iPPcsHHN9LEXURzD+Bd
         4A58qRoJNQrHoYHUxFysgDEityuGQQVtrnQt/dAaNpSvwaM6omm5Oyk7vd9jXJhW23jD
         2BKJgPA7rfl6RdxiivWiiA6tQiPXyQIoXHWk919tGT2rNBcQLL89YyEXXEhwilHkkHU0
         /U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/pCx60f/1X+9oiLWtdCr7slRVvciDKJGzX506kGhKA=;
        b=KkvWVBIB1r7JL6moHBrtIHC3zrnkM9boefTYMiSGAvoH4gcW1ivNXfnt5ux1omDXAz
         ooGiGpBWIburUMq/8DjnGxx+ecbgqqWaaDD7UulwDAJC9H1YlWnR711yz7mN2zhDKATZ
         XpOp5HIE99y6Wi7KFosEyTWAA2Hikdi4xyqybSVYgbaqi/ZT53sPzQ5Z5CkDMKPbg0Gx
         eHYLYKiT2JYbL7aFC6iTGj4ahDug4rKIpHNd6VOxOAOz78BKRGfZQLo2MgecY7vu04bg
         pRn++9IoAScXJitrQnGNnyX29pPXOcqGvh0sJXcG/4lOhmGfTynJDNtwg4lJf+aWiefb
         oSew==
X-Gm-Message-State: APjAAAWd8nq2XhLwopjnZhl6/opZG91ojrB8sk9WVyLflrt8DqGW7FSM
        g02GdHKX7nxzmUYflK3mvGIM5A==
X-Google-Smtp-Source: APXvYqx0U3vFZWg/sKNGxZUUnusjqiG2GsAOVxX0+YLX9k71Ov4hCfuLa99A8LZxIzOfIXy6PmyhWA==
X-Received: by 2002:ac8:7103:: with SMTP id z3mr4958280qto.172.1582807813193;
        Thu, 27 Feb 2020 04:50:13 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id v82sm3040358qka.51.2020.02.27.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 04:50:12 -0800 (PST)
Date:   Thu, 27 Feb 2020 07:50:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200227125011.GB39625@cmpxchg.org>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <20200226222642.GB30206@cmpxchg.org>
 <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 04:12:23PM -0800, Yang Shi wrote:
> On 2/26/20 2:26 PM, Johannes Weiner wrote:
> > So we should be able to fully resolve this problem inside the kernel,
> > without going through userspace, by accounting CPU cycles used by the
> > background reclaim worker to the cgroup that is being reclaimed.
> 
> Actually I'm wondering if we really need account CPU cycles used by
> background reclaimer or not. For our usecase (this may be not general), the
> purpose of background reclaimer is to avoid latency sensitive workloads get
> into direct relcaim (avoid the stall from direct relcaim). In fact it just
> "steal" CPU cycles from lower priority or best-effort workloads to guarantee
> latency sensitive workloads behave well. If the "stolen" CPU cycles are
> accounted, it means the latency sensitive workloads would get throttled from
> somewhere else later, i.e. by CPU share.

That doesn't sound right.

"Not accounting" isn't an option. If we don't annotate the reclaim
work, the cycles will go to the root cgroup. That means that the
latency-sensitive workload can steal cycles from the low-pri job, yes,
but also that the low-pri job can steal from the high-pri one.

Say your two workloads on the system are a web server and a compile
job and the CPU shares are allocated 80:20. The compile job will cause
most of the reclaim. If the reclaim cycles can escape to the root
cgroup, the compile job will effectively consume more than 20 shares
and the low-pri job will get less than 80.

But let's say we executed all background reclaim in the low-pri group,
to allow the high-pri group to steal cycles from the low-pri group,
but not the other way round. Again an 80:20 CPU distribution. Now the
reclaim work competes with the compile job over a very small share of
CPU. The reclaim work that the high priority job is relying on is
running at low priority. That means that the compile job can cause the
web server to go into direct reclaim. That's a priority inversion.

> We definitely don't want to the background reclaimer eat all CPU cycles. So,
> the whole background reclaimer is opt in stuff. The higher level cluster
> management and administration components make sure the cgroups are setup
> correctly, i.e. enable for specific cgroups, setup watermark properly, etc.
> 
> Of course, this may be not universal and may be just fine for some specific
> configurations or usecases.

Yes, I suspect it works for you because you set up watermarks on the
high-pri job but not on the background jobs, thus making sure only
high-pri jobs can steal cycles from the rest of the system.

However, we do want low-pri jobs to have background reclaim as well. A
compile job may not be latency-sensitive, but it still benefits from a
throughput POV when the reclaim work runs concurrently. And if there
are idle CPU cycles available that the high-pri work isn't using right
now, it would be wasteful not to make use of them.

So yes, I can see how such an accounting loophole can be handy. By
letting reclaim CPU cycles sneak out of containment, you can kind of
use it for high-pri jobs. Or rather *one* high-pri job, because more
than one becomes unsafe again, where one can steal a large number of
cycles from others at the same priority.

But it's more universally useful to properly account CPU cycles that
are actually consumed by a cgroup, to that cgroup, and then reflect
the additional CPU explicitly in the CPU weight configuration. That
way you can safely have background reclaim on jobs of all priorities.
