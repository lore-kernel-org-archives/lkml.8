Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F09C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D873F206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEC+fdhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgCXQvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:51:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23982 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbgCXQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585068665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C9gMDFB2HJVjkxFZiVND++RiRLHVYSLveb/P83c2txc=;
        b=VEC+fdhPY3NLUkRend7ahE8cppIcmc0zKoMALKwffIr0T1YuiQce7GUMsbKwJ2TsecmWtR
        ek3mU0bO6myJXrH4uoRkkDDFqQ4K1nSc26fX9jsmKAaMQC4cn7K1Zz9WDvBmIqIfTXTSgj
        dkxGNKm0g3G2/NgiHZUjyYhBaGmq6xQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-oN5UDPahNBivlkgZxvvcjQ-1; Tue, 24 Mar 2020 12:51:00 -0400
X-MC-Unique: oN5UDPahNBivlkgZxvvcjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9805801E5C;
        Tue, 24 Mar 2020 16:50:58 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-9.gru2.redhat.com [10.97.116.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2EDE5C1B2;
        Tue, 24 Mar 2020 16:50:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 61FDC4198B3C; Tue, 24 Mar 2020 13:50:36 -0300 (-03)
Date:   Tue, 24 Mar 2020 13:50:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200324165036.GC28165@fuller.cnet>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <f40c828e-5168-bd08-69b8-f7a54fd53f42@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f40c828e-5168-bd08-69b8-f7a54fd53f42@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:56:26AM -0600, Chris Friesen wrote:
> I hadn't been keeping up with all the changes to the "isolcpus" boot arg.
> Given how it's been extended, I agree that it seems the logical place to
> deal with this.  Patch seems okay to me, but I've got a couple of nits in
> the message portion.
> 
> If I want to specify both no_kthreads and managed_irq it then something like
> "isolcpus=managed_irq,no_kthreads,2-16" would work?

Yes.

> On 3/24/2020 9:20 AM, Marcelo Tosatti wrote:
> > 
> > This is a kernel enhancement to configure the cpu affinity of kernel
> > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> 
> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt
> says that "isolcpus" is deprecated.  Are we un-deprecating it?  Or is it
> only really deprecated for the "domain" option?

I don't think its deprecated (see the recent inclusion of managed_irq,
and the suggestion from Thomas to extend it).

Will send another patch to remove that sentence.

> > When this option is specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime (see
> 
> I think you're missing the rest of the sentence here.

Right.

> > Note-1: this is based off on Wind River's patch at
> > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > 
> > Difference being that this patch is limited to modifying
> > kernel thread cpumask: Behaviour of other threads can
> > be controlled via cgroups or sched_setaffinity.
> > 
> > Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> > https://lwn.net/Articles/565932/ with the only difference being
> > the kernel parameter changed from kthread to kthread_cpus.
> 
> Wind River, not MontaVista.  I know all us embedded linux folks look the
> same...

Doh^2.

> 
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> > 
> > v2: use isolcpus= subcommand (Thomas Gleixner)
> > 
> >   Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
> >   include/linux/cpumask.h                         |    5 +++++
> >   include/linux/sched/isolation.h                 |    1 +
> >   init/main.c                                     |    1 +
> >   kernel/cpu.c                                    |   13 +++++++++++++
> >   kernel/kthread.c                                |    4 ++--
> >   kernel/sched/isolation.c                        |    6 ++++++
> >   7 files changed, 36 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index c07815d230bc..7318e3057383 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1959,6 +1959,14 @@
> >   			  the CPU affinity syscalls or cpuset.
> >   			  <cpu number> begins at 0 and the maximum value is
> >   			  "number of CPUs in system - 1".
> > +			  When using cpusets, use the isolcpus option no_kthreads
> > +			  to avoid creation of kernel threads on isolated CPUs.
> > +
> > +			no_kthreads
> > +			  Adjust the CPU affinity mask of unbound kernel threads to
> > +			  not contain CPUs on the isolated list. This complements
> > +			  the isolation provided by the cpusets mechanism described
> > +			  above.
> 
> It also complements the "managed_irq" option below.  In many cases I'd
> expect the same set of CPUs to be isolated from both irqs and kernel
> threads.
> 
> 
> Chris

Agree, will fix in -v3.

