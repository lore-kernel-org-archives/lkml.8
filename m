Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4231C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65E722229
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594741827;
	bh=dxJUnMXvB4odeEfdBSmsxd+T874x4fggJmg2N6TTRvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tuIpegxSbJ6VCczeWp13hDKiAUsGhMC9VHaGBYOrSMWzIFT6FwZ4KsRjHIJaVeqGn
	 S7EWFAQ4ErjbFlLEqllQRS00FKYRVbXwKpJj+8/PCQGiWt8u++C1JcWauh0f1ZsTz0
	 KYyq/zwVUvG1z3pbufqnahtldqAFXNLg0RLTFZ9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGNPu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:50:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43217 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgGNPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:50:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id j4so22647116wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UNjTjNj7nBrxc1O4cT43g/Jb9uDjM/8ow+jG2V3JdU=;
        b=YfJeUlJPjkfvg0k4vb3iE8VOj75IGsDtw1gSKprJS4fHfHgo6Sr3Hyz/Mwc+W4yg4C
         bpQnt1BZL9oDHG5g62mul6jnnUbvLPMi8pIum8msPnyYvIO6YnpcKAGp+LN8l/sj/SOh
         vZQXNPG12kYtb4QNHGTIRVJd1N1MDGKWpMxHeZAQZuGRPwQFK/S80BjQ4Yob5WMVZcJ1
         hPJ5082rsaDHX7nNsF/hopLFOiqSJho+bTqdwQ8Na7l8UViWv0V8Mzl5xgd0x10s7Gqg
         qeHzaUE33O1n9jkJpIlrJaz71GfKPHubSXfks3zz5yw6mbdURYhwAcH4YivFidIuKDa7
         i8bg==
X-Gm-Message-State: AOAM530BbN0iUT8F5Jh+pQPta6s0h3dleXvfaDGxU8DTRBAFpTliOU/0
        xRKk01zFCLy72WFHb6hss1Y=
X-Google-Smtp-Source: ABdhPJzkKuBEXARsKEFK+BNNFviqFhl02Embfs0hF4rMtyp2khXl4hcBMRqZxUzNHjwX/hgn6kxA4A==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr6660872wrp.96.1594741819457;
        Tue, 14 Jul 2020 08:50:19 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id k14sm29563410wrn.76.2020.07.14.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 08:50:18 -0700 (PDT)
Date:   Tue, 14 Jul 2020 17:50:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200714155017.GQ24642@dhcp22.suse.cz>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
 <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
 <20200714084123.GG24642@dhcp22.suse.cz>
 <CALvZod6kw++JnZnyYVg4-u2vNQ7SLMFh3qKG1xu7_AahdmXhdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6kw++JnZnyYVg4-u2vNQ7SLMFh3qKG1xu7_AahdmXhdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-07-20 08:32:09, Shakeel Butt wrote:
> On Tue, Jul 14, 2020 at 1:41 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 10-07-20 12:19:37, Shakeel Butt wrote:
> > > On Fri, Jul 10, 2020 at 11:42 AM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Fri, Jul 10, 2020 at 07:12:22AM -0700, Shakeel Butt wrote:
> > > > > On Fri, Jul 10, 2020 at 5:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> > > > > > > Memory.high limit is implemented in a way such that the kernel
> > > > > > > penalizes all threads which are allocating a memory over the limit.
> > > > > > > Forcing all threads into the synchronous reclaim and adding some
> > > > > > > artificial delays allows to slow down the memory consumption and
> > > > > > > potentially give some time for userspace oom handlers/resource control
> > > > > > > agents to react.
> > > > > > >
> > > > > > > It works nicely if the memory usage is hitting the limit from below,
> > > > > > > however it works sub-optimal if a user adjusts memory.high to a value
> > > > > > > way below the current memory usage. It basically forces all workload
> > > > > > > threads (doing any memory allocations) into the synchronous reclaim
> > > > > > > and sleep. This makes the workload completely unresponsive for
> > > > > > > a long period of time and can also lead to a system-wide contention on
> > > > > > > lru locks. It can happen even if the workload is not actually tight on
> > > > > > > memory and has, for example, a ton of cold pagecache.
> > > > > > >
> > > > > > > In the current implementation writing to memory.high causes an atomic
> > > > > > > update of page counter's high value followed by an attempt to reclaim
> > > > > > > enough memory to fit into the new limit. To fix the problem described
> > > > > > > above, all we need is to change the order of execution: try to push
> > > > > > > the memory usage under the limit first, and only then set the new
> > > > > > > high limit.
> > > > > >
> > > > > > Shakeel would this help with your pro-active reclaim usecase? It would
> > > > > > require to reset the high limit right after the reclaim returns which is
> > > > > > quite ugly but it would at least not require a completely new interface.
> > > > > > You would simply do
> > > > > >         high = current - to_reclaim
> > > > > >         echo $high > memory.high
> > > > > >         echo infinity > memory.high # To prevent direct reclaim
> > > > > >                                     # allocation stalls
> > > > > >
> > > > >
> > > > > This will reduce the chance of stalls but the interface is still
> > > > > non-delegatable i.e. applications can not change their own memory.high
> > > > > for the use-cases like application controlled proactive reclaim and
> > > > > uswapd.
> > > >
> > > > Can you, please, elaborate a bit more on this? I didn't understand
> > > > why.
> > > >
> > >
> > > Sure. Do we want memory.high a CFTYPE_NS_DELEGATABLE type file? I
> > > don't think so otherwise any job on a system can change their
> > > memory.high and can adversely impact the isolation and memory
> > > scheduling of the system.
> >
> > Is this really the case? There should always be a parent cgroup that
> > overrides the setting.
> 
> Can you explain a bit more? I don't see any requirement of having a
> layer of cgroup between root and the job cgroup. Internally we
> schedule jobs as top level cgroups. There do exist jobs which are a
> combination of other jobs and there we do use an additional layer of
> cgroup (similar to pods running multiple containers in kubernetes).
> Surely we can add a layer for all the jobs but it comes with an
> overhead and at scale that overhead is not negligible.

What I've had in mind is that if you want to delegate then you have an
option to add a layer where you pre define restrictions/guanratees so
that the delegated cgroup under that hierarchy cannot runaway. So
configuring high limit in a delegated cgroup should be reasonably safe.

> > Also you can always set the hard limit if you do
> > not want to add another layer of cgroup in the hierarchy before
> > delegation. Or am I missing something?
> >
> 
> Yes, we can set memory.max though it has different oom semantics and
> not really a replacement for memory.high.

Right but you can define a safe cap this way and leave the high
watermark for the delegated cgroup.
-- 
Michal Hocko
SUSE Labs
