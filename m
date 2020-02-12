Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EC9C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A321734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="YEaK57cW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgBLXHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:07:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45666 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:07:12 -0500
Received: by mail-qt1-f196.google.com with SMTP id d9so2963207qte.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qvuj5lbokKOhJStNgAdx/szkl5GXujkV5PkgBEKybTw=;
        b=YEaK57cWoveFj/43gBIuh8hAwajMowa5iBw0i0l1ZPydRpKpFo5iiiCp8oBufPHVEC
         Dot64KQZK5IAac+K7K8TbGmXDgK2LyQRdRCXZCwtGIv5t2L5bHNJCaOGJqPx6t3xtgw4
         Ykfes9qBRBL9iqUs9aCslYwdJk0QsHS4fl+8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qvuj5lbokKOhJStNgAdx/szkl5GXujkV5PkgBEKybTw=;
        b=oIPjkf0lsx+LVyc5SneUXeWwvCnQYub+CubBMq/RNdBNe4lZ7aBjEoP9N9ncLtabpT
         ifI4aDNKvFqAWpzlAOFpVX7EBqFcyvOihMk1MN7QdG0n/7gBdkCmtWNoMhyCRO/4NVG6
         xONoCQu4knvPr4UoqpxO2nuBrmw/yBDZgyAMKh1Duqn1pH9y0SAEZxzBPO+VIBVzzRe3
         gDfPWxKxaqbnl95377LocFq9aUwK9oc3pLs28cYTiZBCivPovj1r2LKsHR2qMsOGqEh5
         aoKbBvgJ9Uic5ESSigPi49z0OnkizxFHw3d/IoJPjHAl02YvLrPiQmUnajm6/cKB8R78
         bvSA==
X-Gm-Message-State: APjAAAWOjHp55qBbOXGXLrRy/Puy42guOMFgYvUhZm8Sz+wHi+lXgaBQ
        LJwFrHyWRUTUH2umKGHRTHh4vQ==
X-Google-Smtp-Source: APXvYqziKglMxYF7uy5S+aeh5wOdDD90jmWtGu0bz3kcmGjacaG3sz9ZPzA0iriwyRLpOwkzGvgdgQ==
X-Received: by 2002:ac8:318c:: with SMTP id h12mr9361735qte.231.1581548830592;
        Wed, 12 Feb 2020 15:07:10 -0800 (PST)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id v2sm356500qto.73.2020.02.12.15.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 15:07:09 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:07:05 -0500
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200212230705.GA25315@sinkpad>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Feb-2020 04:28:18 PM, Tim Chen wrote:
> On 1/14/20 7:40 AM, Vineeth Remanan Pillai wrote:
> > On Mon, Jan 13, 2020 at 8:12 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > 
> >> I also encountered kernel panic with the v4 code when taking cpu offline or online
> >> when core scheduler is running.  I've refreshed the previous patch, along
> >> with 3 other patches to fix problems related to CPU online/offline.
> >>
> >> As a side effect of the fix, each core can now operate in core-scheduling
> >> mode or non core-scheduling mode, depending on how many online SMT threads it has.
> >>
> >> Vineet, are you guys planning to refresh v4 and update it to v5?  Aubrey posted
> >> a port to the latest kernel earlier.
> >>
> > Thanks for the updated patch Tim.
> > 
> > We have been testing with v4 rebased on 5.4.8 as RC kernels had given us
> > trouble in the past. v5 is due soon and we are planning to release v5 when
> > 5.5 comes out. As of now, v5 has your crash fixes and Aubrey's changes
> > related to load balancing. We are investigating a performance issue with
> > high overcommit io intensive workload and also we are trying to see if
> > we can add synchronization during VMEXITs so that a guest vm cannot run
> > run alongside with host kernel. We also need to think about the userland
> > interface for corescheduling in preparation for upstreaming work.
> > 
> 
> Vineet,
> 
> Have you guys been able to make progress on the issues with I/O intensive workload?

I finally have some results with the following branch:
https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.5.y

We tested the following classes of workloads in VMs (all vcpus in the
same cgroup/tag):
- linpack (pure CPU work)
- sysbench TPC-C (MySQL benchmark, good mix of CPU/net/disk)
  with/without noise VMs around
- FIO randrw VM with/without noise VMs around

Our "noise VMs" are 1-vcpu VMs running a simple workload that wakes up
every 30 seconds, sends a couple of metrics over a VPN and go back to
sleep. They use between 0% and 30% of CPU on the host all the time,
nothing sustained just ups and downs.

# linpack
3x 12-vcpus pinned on a 36 hwthreads NUMA node (with smt on):
- core scheduling manages to perform slightly better than the baseline
  by up to 20% in some cases !
- with nosmt (so 2:1 overcommit) the performance drop by 24%

# sysbench TPC-C
1x 12-vcpus MySQL server on each NUMA node, 48 client threads (running
on a different server):
- without noise: no performance difference between the 3 configurations
- with 96 noise VMs on each NUMA node:
  - Performance drops by 54% with core scheduling
  - Performance drops by 75% with nosmt
We write at about 130MB/s on disk with that test.

# FIO randrw 50%, 1 thread, libaio, bs=128k, iodepth=32
1x 12-vcpus FIO VM, usually only require up to 100% CPU overall (data
thread and all vcpus summed), we read and write at about 350MB/s
alone:
 - coresched drops 5%
 - nosmt drops 1%

1:1 vcpus vs hardware thread on the NUMA node (filled with noise VMs):
 - coresched drops 7%
 - nosmt drops 22%

3:1 ratio:
 - coresched drops 16%
 - nosmt drops 22%

5:1 ratio:
 - coresched drops 51%
 - nosmt drops 61%

So the main conclusion is that for all the test cases we have studied,
core scheduling performs better than nosmt ! This is different than what
we tested a while back, so it's looking really good !

Now I am looking for confirmation from others. Dario did you have time
to re-run your test suite against that same branch ?

After that, our next step is to trash all that with adding VMEXIT
synchronization points ;-)

Thanks,

Julien
