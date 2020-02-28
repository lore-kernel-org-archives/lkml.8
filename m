Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D908BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37C12469B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLXOOXtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgB1Cye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:54:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55911 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgB1Cye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:54:34 -0500
Received: by mail-pj1-f67.google.com with SMTP id a18so639630pjs.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 18:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XKoYXksDrflEVWxx489gzRo7OdqlZb9D0qCiQZUBdvI=;
        b=NLXOOXtP24zTmGIZU+y3WhhXRlNVs4Yea2dlBh55x7RSbWQIQqovzQJcGQzPdyRK7v
         kBCktxWgY5TxsvyRCt1ol0t+jSMWJ/1OVjsGHzWsYbkxpc585F2myxuy8wVu4c7hZB7c
         5RuF3ZA4IzsRyH17ChwA8MT1ap+Au9pxncjiFUpT8lXMTYZWzHd1CPd0gkElkGIHRiZG
         i7g9et6mZaK/4Y4wNBBMAIqt4PjrSluvzS89w5p+5pEE2ds96lTqqVhIjp1Z0QSNtS0K
         U83E4G2UnBhJLwATZ/Yf22irKO/gwYOMBYs1ghcrZTzpmJ1PFn6G6jBoZ5MWfehA6APo
         hBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKoYXksDrflEVWxx489gzRo7OdqlZb9D0qCiQZUBdvI=;
        b=BxEuuMWbjEK6+6EG5+rfYtxzwgc3UhH6sbSORq5wlO8nH45E0mj9K+V5o0jzQdeCAN
         wb/B++q2It4OteNw72bGFtj07tvNP2Z9EVMNr2OwS+7aEmqLRKdi7oqQpRIoP9TsyR8O
         Red6HFNPFVFRgcG6svGSmZ9I/Tj8jNy+otllhONBR4m6nbk6l81Zxx/4i3P8NL6m1xqA
         0xdZBLUxyDWdrft4VPj+XRw740sBgXzYwmJHj52U5hYTXjt4LKpnAJbteg0j31V2qnv2
         g5J45qZemOJ8OQqqcLCZ9gQXvOfuGdoPYJ0DwmgfGGUJBbE9lB8FQPqLStW9E02fd+fr
         1pWw==
X-Gm-Message-State: APjAAAVDhqpq5ebGBABe2FzwWk9+Q+LjUbgtMr/K0O97x6SqFR+uh3Rj
        ouDI1Z+5hd0+BvIBUQHoxw8=
X-Google-Smtp-Source: APXvYqykwYQ+TDBNEHvZ+RAP91zJiQkJQNM+2Ew+mMoUbxD11tOOSldrr62NaA1CxlnPZV08wBaCZw==
X-Received: by 2002:a17:90a:a406:: with SMTP id y6mr2295163pjp.115.1582858472455;
        Thu, 27 Feb 2020 18:54:32 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id e28sm8273973pgn.21.2020.02.27.18.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 18:54:31 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:54:05 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200228025405.GA634650@ziqianlu-desktop.localdomain>
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain>
 <20200227141032.GA30178@pauld.bos.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227141032.GA30178@pauld.bos.csb>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 09:10:33AM -0500, Phil Auld wrote:
> Hi Aaron,
> 
> On Thu, Feb 27, 2020 at 10:04:32AM +0800 Aaron Lu wrote:
> > On Tue, Feb 25, 2020 at 03:51:37PM -0500, Vineeth Remanan Pillai wrote:
> > > On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> > > > threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> > > > into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> > > > socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> > > > cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> > > > the real workload).
> > > >
> > > > I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> > > 
> > > The expected behaviour could also be that 8 processes share 4 cores and
> > > 8 hw threads right? This is what we are seeing mostly
> > 
> > I expect the 8 cgA tasks to spread on each core, instead of occupying
> > 4 cores/8 hw threads. If they stay on 4 cores/8 hw threads, than on the
> > core level, these cores' load would be much higher than other cores
> > which are running cgB's tasks, this doesn't look right to me.
> > 
> 
> I don't think that's a valid assumption, at least since the load balancer rework.
> 
> The scheduler will be looking much more at the number of running task versus
> the group weight. So in this case 2 running tasks, 2 siblings at the core level
> will look fine. There will be no reason to migrate. 

In the absence of core scheduling, I agree there is no reason to migrate
since no matter how to migrate, the end result is one high-weight task
sharing a core with another (high or low weight) task. But with core
scheduling, things can be different: if the high weight tasks are
spread among cores, then these high weight tasks can enjoy the core
alone(by force idling its sibling) and get better performance.

I'm thinking to use core scheduling to protect main workload's
performance in a colocated environment, similar to the realtime use
case described here:
https://lwn.net/Articles/799454/

I'll quote the relevant part here:
"
But core scheduling can force sibling CPUs to go idle when a realtime
process is running on the core, thus preventing this kind of
interference. That opens the door to enabling SMT whenever a core has no
realtime work, but effectively disabling it when realtime constraints
apply, getting the best of both worlds. 
"

Using cpuset for the main workload to only allow its task run on one HT
of each core might also solve this, but I had hoped not to need use
cpuset as that can add complexity in deployment.

> > I think the end result should be: each core has two tasks queued, one
> > cgA task and one cgB task(to maintain load balance on the core level).
> > The two tasks are queued on different hw thread, with cgA's task runs
> > most of the time on one thread and cgB's task being forced idle most
> > of the time on the other thread.
> > 
> 
> With the core scheduler that does not seem to be a desired outcome. I think
> grouping the 8 cgA tasks on the 8 cpus of 4 cores seems right. 
> 

When the core wide weight is somewhat balanced, yes I definitely agree.
But when core wide weight mismatch a lot, I'm not so sure since if these
high weight task is spread among cores, with the feature of core
scheduling, these high weight tasks can get better performance. So this
appeared to me like a question of: is it desirable to protect/enhance
high weight task performance in the presence of core scheduling?
