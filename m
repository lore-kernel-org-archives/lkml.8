Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD8C52D3C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wi/3efLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388599AbgB0OKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:10:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387824AbgB0OKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582812644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LZ0QiDJEaGm3PH4IWVMaXUJcPr6Lbv7azjZX9tPipaU=;
        b=Wi/3efLtaofX9s922Hn4KoM/K+mAWbFTi2VeBEudsGaeamTWvVIM824Sro3g03ab2/Vkw5
        F0uqnzOuwqARr6SygCTAh3eIm7EJp5sI1W8FO9DdMHAPm5fbN+eOzTHakCGuo2vMASouZp
        2KjXCUIdaDBr5BrzGuPVkkoyxnJJQIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-DAFCO7fUNf6Gky0461lJOQ-1; Thu, 27 Feb 2020 09:10:41 -0500
X-MC-Unique: DAFCO7fUNf6Gky0461lJOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3021800D54;
        Thu, 27 Feb 2020 14:10:37 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B5708C090;
        Thu, 27 Feb 2020 14:10:35 +0000 (UTC)
Date:   Thu, 27 Feb 2020 09:10:33 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Aaron Lu <aaron.lwe@gmail.com>
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
Message-ID: <20200227141032.GA30178@pauld.bos.csb>
References: <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
 <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain>
 <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <20200227020432.GA628749@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227020432.GA628749@ziqianlu-desktop.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Thu, Feb 27, 2020 at 10:04:32AM +0800 Aaron Lu wrote:
> On Tue, Feb 25, 2020 at 03:51:37PM -0500, Vineeth Remanan Pillai wrote:
> > On a 2sockets/16cores/32threads VM, I grouped 8 sysbench(cpu mode)
> > > threads into one cgroup(cgA) and another 16 sysbench(cpu mode) threads
> > > into another cgroup(cgB). cgA and cgB's cpusets are set to the same
> > > socket's 8 cores/16 CPUs and cgA's cpu.shares is set to 10240 while cgB's
> > > cpu.shares is set to 2(so consider cgB as noise workload and cgA as
> > > the real workload).
> > >
> > > I had expected cgA to occupy 8 cpus(with each cpu on a different core)
> > 
> > The expected behaviour could also be that 8 processes share 4 cores and
> > 8 hw threads right? This is what we are seeing mostly
> 
> I expect the 8 cgA tasks to spread on each core, instead of occupying
> 4 cores/8 hw threads. If they stay on 4 cores/8 hw threads, than on the
> core level, these cores' load would be much higher than other cores
> which are running cgB's tasks, this doesn't look right to me.
> 

I don't think that's a valid assumption, at least since the load balancer rework.

The scheduler will be looking much more at the number of running task versus
the group weight. So in this case 2 running tasks, 2 siblings at the core level
will look fine. There will be no reason to migrate. 

> I think the end result should be: each core has two tasks queued, one
> cgA task and one cgB task(to maintain load balance on the core level).
> The two tasks are queued on different hw thread, with cgA's task runs
> most of the time on one thread and cgB's task being forced idle most
> of the time on the other thread.
> 

With the core scheduler that does not seem to be a desired outcome. I think
grouping the 8 cgA tasks on the 8 cpus of 4 cores seems right. 



Cheers,
Phil

-- 

