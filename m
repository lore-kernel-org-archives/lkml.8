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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13FC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9329222C2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwfDnlzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgBYFcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:32:51 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41045 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:32:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so12613014ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKkx1X/e5sB97GVRPhowxWG7e+dPRqlRnrmsrrt7vdE=;
        b=OwfDnlzhojgQBWiuDwt4ChvG0XKbep1x8F+zDvRMV1LVafYtVGi1pzBAl1mxWjIFNQ
         tA6iMWg1Slo/yprDPQYl171gMBWbhDO89C5DDkHtgRonPGG+KHGuUBPnXibsRzdMcU0X
         GwANAjb9qL/IV5s8CK+gfkg3iM3osRG/dgEmF5Y8XBnjsuI41G0J1YJHRA4zU8poh7qD
         XVfr9VgCTOYXoMd0tZiEt4LODYLTh+KcpVAFS1StQZ4NQXI/0cnppeOkJiDfusXmHFZ8
         kyOhMKNAY3jhe8bnpRkg86+2tXo7CUAr8gZc3qUeb1FZl/Zzq2yhwa1Bja+GfmjM30ny
         i5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKkx1X/e5sB97GVRPhowxWG7e+dPRqlRnrmsrrt7vdE=;
        b=hi41C+984sZIQmFrLGYsgm4xTs0nqOqvjpxTMPn4f9xN40Rii6HPanSXOaCL+qBJX4
         b7Kbgb46XQDj4BBXqQ+6UJP+k6jK4gRMagzcelIEbm4c/SViesEJckMODGcj5Ej3UNDz
         11rAJnY4mqle/i9lQgmyr58ek3kgDTgIMwlQbqZzEtc9kdPQIT2hkzqC7A9B/VY10NFT
         leoeeCihsbeG51rFKbk3coEQYHV/wNptNoW6CY11bzAQ3H5+I8ACW1oT7wz1/l9Bwyp7
         bS920pCmSbaMd+s/FvmrqysbsRVqcKQlESKzmpIPFtsNgQs5KwcfBpaXK75TFqcLL+TY
         fTqw==
X-Gm-Message-State: APjAAAXzbrlzAT/eMosmFjOtg4tedNoWyEphET8xSK8GoxAgJnDmPCC9
        H8cjNjfIAM3PlvqsS/5vBe6ki9OfmPq5pH3ySrw=
X-Google-Smtp-Source: APXvYqwDMyg7UFRV3O0lKiEF7KcRs0CGl1w77cNtsJiJXqOBRHB3nDs4Fo71O8pbkj/DModRlhEp5BPUpL4PbratyeM=
X-Received: by 2002:a2e:978d:: with SMTP id y13mr31952462lji.103.1582608767787;
 Mon, 24 Feb 2020 21:32:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
In-Reply-To: <20200225034438.GA617271@ziqianlu-desktop.localdomain>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 25 Feb 2020 13:32:35 +0800
Message-ID: <CAERHkrs_WX=gS0sQ2Wg_SZuAcf_qhKfT05co0uYgaQk8cFj0ag@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Aaron Lu <aaron.lwe@gmail.com>
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
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:44 AM Aaron Lu <aaron.lwe@gmail.com> wrote:
>
> On Fri, Feb 14, 2020 at 02:10:53PM +0800, Aubrey Li wrote:
> > On Fri, Feb 14, 2020 at 2:37 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > >
> > > On 2/12/20 3:07 PM, Julien Desfossez wrote:
> > >
> > > >>
> > > >> Have you guys been able to make progress on the issues with I/O intensive workload?
> > > >
> > > > I finally have some results with the following branch:
> > > > https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.5.y
> > > >
> > > >
> > > > So the main conclusion is that for all the test cases we have studied,
> > > > core scheduling performs better than nosmt ! This is different than what
> > > > we tested a while back, so it's looking really good !
> > >
> > > Thanks for the data.  They look really encouraging.
> > >
> > > Aubrey is working on updating his patches so it will load balance
> > > to the idle cores a bit better.  We are testing those and will post
> > > the update soon.
> >
> > I added a helper to check task and cpu cookie match, including the
> > entire core idle case. The refined patchset updated at here:
> > https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2
> >
> > This branch also includes Tim's patchset. According to our testing
> > result, the performance data looks on par with the previous version.
> > A good news is, v5.4.y stability issue on our 8 numa node machine
> > is gone on this v5.5.2 branch.
>
> One problem I have when testing this branch: the weight of the croup
> seems to be ignored.
>
> On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> the real workload).
>
> I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> most of the time since it has way more weight than cgB, while cgB should
> occupy almost no CPUs since:
>  - when cgB's task is in the same CPU queue as cgA's task, then cgB's
>    task is given very little CPU due to its small weight;
>  - when cgB's task is in a CPU queue whose sibling's queue has cgA's
>    task, cgB's task should be forced idle(again, due to its small weight).
>
> But testing shows cgA occupies only 2 cpus during the entire run while
> cgB enjoys the remaining 14 cpus. As a comparison, when coresched is off,
> cgA can occupy 8 cpus during its run.
>
> I haven't taken a look at the patches, but would like to raise the
> problem first. My gut feeling is that, we didn't make the CPU's load
> balanced.
>
> P.S. it's not that I care about VM's performance, it's just easier to
> test kernel stuff using a VM than on a bare metal. Its CPU setup might
> seem weird, I just set it up to be the same as my host setup.

Aaron - did you test this before? In other words, if you reset repo to your
last commit:

- 5bd3c80 sched/fair : Wake up forced idle siblings if needed

Does the problem remain? Just want to check if this is a regression
 introduced by the subsequent patchset.

Thanks,
-Aubrey
