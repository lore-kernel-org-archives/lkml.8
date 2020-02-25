Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358D4C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC324656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRm7Atxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBYDos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:44:48 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36935 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYDos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:44:48 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so682216pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 19:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKIwG2W+z0cryGHjYQGewymShZk7YQHTShR2retuQ1I=;
        b=jRm7AtxwnjKep/goXIg5XTWa2/32AFuCOhpGCTfEd8sLFgrK9hVpGj+KkZNynqvPTN
         LBgjaVSkCIfTc1F2TET0JWQec65b4QgAgNugn+LD0bTWH2phmUDhL1eF1D8kxGxN+9VO
         eDhV7g+MRyfs0T2HcTqEhASfHrc1dABKZx8ewx90TPx0C7ukjaEb23THARseb3Yn/cIF
         x6DpmgM1LduRD3O9DFjVYujA9SKU8rE00w00hH9qg1gA6GbznIxs1LIyHC/T6bm73qWL
         VEhprIM1vFqnKS+0uU5+8uwYaLKl5zROnnLjfQg5RKK4Pf+miq4xeRr5KvbjoVFlyL9H
         z+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKIwG2W+z0cryGHjYQGewymShZk7YQHTShR2retuQ1I=;
        b=OfwfMEpct9KjoAiam38AwCtNFtJkPpOJd5p912zxb8v9YrEf5rEoBfo0xjTMABw6BP
         ltSHgqVlpvX60HjBOME3WoZ0uLR0ylLcdfT/qZ3URCTRp95tcE46hS00WyMlym5rcSE0
         Ik5U8PueerTh9dVtHs2sru8Rx54TP6n1Z/rjsQlSLk3YFLMle+wk2ji0dSGzoFQXS4tf
         aAS0tLZhLSTBR7BZMbO0DThAJrNZ74PMEQzQozM9CFKz5eYqL41b/RQOVxuGFhyMQ5qt
         r0qUmYyed70+3yn+5kgESO1V9rwkJvbtW6ySrxdn4bI5BXqDJ+DPxWuopafH1CVfGmjL
         QkXg==
X-Gm-Message-State: APjAAAVDMY5iH+aS2IpicYKBx07UOSZBAExLVUKdi9MonC0SAEw69J1V
        MCeqBNOg+3e4faQWaKxzFZg=
X-Google-Smtp-Source: APXvYqwSxLhXZPyZ1rne8EW0Ux0HAaM30ydcFgWoHXA/Wnildgog998jELIoe+SbR7Pt7dFjV7ipWw==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr2843092pjn.113.1582602287660;
        Mon, 24 Feb 2020 19:44:47 -0800 (PST)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id h22sm5081758pgn.57.2020.02.24.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 19:44:46 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:44:38 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200225034438.GA617271@ziqianlu-desktop.localdomain>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 02:10:53PM +0800, Aubrey Li wrote:
> On Fri, Feb 14, 2020 at 2:37 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > On 2/12/20 3:07 PM, Julien Desfossez wrote:
> >
> > >>
> > >> Have you guys been able to make progress on the issues with I/O intensive workload?
> > >
> > > I finally have some results with the following branch:
> > > https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.5.y
> > >
> > >
> > > So the main conclusion is that for all the test cases we have studied,
> > > core scheduling performs better than nosmt ! This is different than what
> > > we tested a while back, so it's looking really good !
> >
> > Thanks for the data.  They look really encouraging.
> >
> > Aubrey is working on updating his patches so it will load balance
> > to the idle cores a bit better.  We are testing those and will post
> > the update soon.
> 
> I added a helper to check task and cpu cookie match, including the
> entire core idle case. The refined patchset updated at here:
> https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2
> 
> This branch also includes Tim's patchset. According to our testing
> result, the performance data looks on par with the previous version.
> A good news is, v5.4.y stability issue on our 8 numa node machine
> is gone on this v5.5.2 branch.

One problem I have when testing this branch: the weight of the croup
seems to be ignored.

On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
into another cgroup(cgB). cgA and cgB's cpusets are set to the same
socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
cpu.shares is set to 2(so consider cgB as noise workload and cgA as
the real workload).

I had expected cgA to occupy 8 cpus(with each cpu on a different core)
most of the time since it has way more weight than cgB, while cgB should
occupy almost no CPUs since:
 - when cgB's task is in the same CPU queue as cgA's task, then cgB's
   task is given very little CPU due to its small weight;
 - when cgB's task is in a CPU queue whose sibling's queue has cgA's
   task, cgB's task should be forced idle(again, due to its small weight).
 
But testing shows cgA occupies only 2 cpus during the entire run while
cgB enjoys the remaining 14 cpus. As a comparison, when coresched is off,
cgA can occupy 8 cpus during its run.

I haven't taken a look at the patches, but would like to raise the
problem first. My gut feeling is that, we didn't make the CPU's load
balanced.

P.S. it's not that I care about VM's performance, it's just easier to
test kernel stuff using a VM than on a bare metal. Its CPU setup might
seem weird, I just set it up to be the same as my host setup.
