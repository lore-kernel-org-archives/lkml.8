Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7320320714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv1z89sY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbgCaLur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:50:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20820 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730334AbgCaLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585655445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rSn99Jf2Yhqj1O2XI4gkMZw531juCWPbfOI9Kxk2+Q=;
        b=Lv1z89sYKHM6KVR4CVvGkoN5wOLa+B9aTmfoi6aci//DqV76T7z/jGs0UWE+OwXsaUJ+jc
        xVbdcuMQ/8H2xh/TdUkLk4n/MIfjHhZsrnad2ELMEe7oD78tHugfgG51cvnRL7tgv8zaRD
        Wxn49hxKNm8+zbyeT+C8tlz/eC6Zbh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-lqV69-6ZN0Cq0oOUF3eelA-1; Tue, 31 Mar 2020 07:50:41 -0400
X-MC-Unique: lqV69-6ZN0Cq0oOUF3eelA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA19118CA243;
        Tue, 31 Mar 2020 11:50:39 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F8319756;
        Tue, 31 Mar 2020 11:50:39 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 85183418CC02; Tue, 31 Mar 2020 08:50:14 -0300 (-03)
Date:   Tue, 31 Mar 2020 08:50:14 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/3] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200331115014.GA2182@fuller.cnet>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.225876188@redhat.com>
 <20200331005706.GA24647@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331005706.GA24647@lenoir>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 02:57:08AM +0200, Frederic Weisbecker wrote:
> On Sat, Mar 28, 2020 at 12:21:19PM -0300, Marcelo Tosatti wrote:
> > This is a kernel enhancement to configure the cpu affinity of kernel threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > 
> > When this option is specified, the cpumask is immediately applied upon
> > thread launch. This does not affect kernel threads that specify cpu
> > and node.
> > 
> > This allows CPU isolation (that is not allowing certain threads
> > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > making it possible to enable load balancing on such CPUs
> > during runtime (see kernel-parameters.txt).
> > 
> > Note-1: this is based off on Wind River's patch at
> > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > 
> > Difference being that this patch is limited to modifying
> > kernel thread cpumask: Behaviour of other threads can
> > be controlled via cgroups or sched_setaffinity.
> > 
> > Note-2: Wind River's patch was based off Christoph Lameter's patch at
> > https://lwn.net/Articles/565932/ with the only difference being
> > the kernel parameter changed from kthread to kthread_cpus.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
> >  include/linux/sched/isolation.h                 |    1 +
> >  kernel/kthread.c                                |    6 ++++--
> >  kernel/sched/isolation.c                        |    6 ++++++
> >  4 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> > +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1959,6 +1959,14 @@
> >  			  the CPU affinity syscalls or cpuset.
> >  			  <cpu number> begins at 0 and the maximum value is
> >  			  "number of CPUs in system - 1".
> > +			  When using cpusets, use the isolcpus option "kthread"
> > +			  to avoid creation of kernel threads on isolated CPUs.
> > +
> > +			kthread
> > +			  Adjust the CPU affinity mask of unbound kernel threads to
> > +			  not contain CPUs on the isolated list. This complements
> > +			  the isolation provided by the cpusets mechanism described
> > +			  above and by managed_irq option.

Hi Frederic,

> So, what about what I suggested with having "unbound" instead, which
> includes all the CPU-unbound work?
> 
>  HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED

After more thought, it would share certain flags with nohz_full=, which
seemed confusing.

> (and yes your suggestion of including HK_FLAG_SCHED is good).
> 
> Because I don't see the point of exposing kthread isolation alone as an ABI
> so far.
> 
> Later I suspect I'll turn all these flags into a single HK_FLAG_UNBOUND.

How about keeping the flags separate, and then on top of that do
an "unbound" flag (less typing needed).

This would allow users to combine the individual flags (again, useful
for debugging) while at the same time having an option which groups
all the others?

