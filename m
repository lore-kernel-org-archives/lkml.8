Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91889C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F0F2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585241564;
	bh=2G4ysWt8UU1fD4eqylVATl6MWP61iPD641BVzKBSHos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mmkIxVCU9LgtKb5c74qqUUOOjNzG8XXn02Wspm9/OXo8g3j10lcDiuCrAJlg0W5Fm
	 gWH0gXC/+QG227DoxmGvZxKsXiISt/jY4ZFTX5ZudJ6LisPnWwuZUr0Y+ZK0IkPyrH
	 qZqQfRSAyVPL0Lgc4vEaN/lsDlqCD2QVDuj85D1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbgCZQwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgCZQwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:52:43 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23C0C20719;
        Thu, 26 Mar 2020 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585241562;
        bh=2G4ysWt8UU1fD4eqylVATl6MWP61iPD641BVzKBSHos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NEtNSQ23qndX+CxYerr0NutiGyJtfydmqBwDEjNcoYWuvG3U07qF1TXPQG28EL2sq
         UScR3sgJ5A1MvImx950FEVoqaPQTyCl3xyZWnvtr3xOrGp2WoZpNrZUIbbE8CgfSU+
         4CtagKo0V1t3EuqrNBuRfp4HPxtfZbhfexYefPEs=
Date:   Thu, 26 Mar 2020 17:52:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chris Friesen <chris.friesen@windriver.com>,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200326165239.GD3946@lenoir>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de>
 <20200324152016.GA25422@fuller.cnet>
 <20200325002956.GC20223@lenoir>
 <20200325114736.GA17165@fuller.cnet>
 <20200326162002.GA3946@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326162002.GA3946@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 05:20:05PM +0100, Frederic Weisbecker wrote:
> On Wed, Mar 25, 2020 at 08:47:36AM -0300, Marcelo Tosatti wrote:
> > 
> > Hi Frederic,
> > 
> > On Wed, Mar 25, 2020 at 01:30:00AM +0100, Frederic Weisbecker wrote:
> > > On Tue, Mar 24, 2020 at 12:20:16PM -0300, Marcelo Tosatti wrote:
> > > > 
> > > > This is a kernel enhancement to configure the cpu affinity of kernel
> > > > threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> > > > 
> > > > When this option is specified, the cpumask is immediately applied upon
> > > > thread launch. This does not affect kernel threads that specify cpu
> > > > and node.
> > > > 
> > > > This allows CPU isolation (that is not allowing certain threads
> > > > to execute on certain CPUs) without using the isolcpus=domain parameter,
> > > > making it possible to enable load balancing on such CPUs
> > > > during runtime (see
> > > > 
> > > > Note-1: this is based off on Wind River's patch at
> > > > https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> > > > 
> > > > Difference being that this patch is limited to modifying
> > > > kernel thread cpumask: Behaviour of other threads can
> > > > be controlled via cgroups or sched_setaffinity.
> > > > 
> > > > Note-2: MontaVista's patch was based off Christoph Lameter's patch at
> > > > https://lwn.net/Articles/565932/ with the only difference being
> > > > the kernel parameter changed from kthread to kthread_cpus.
> > > > 
> > > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > I'm wondering, why do you need such a boot shift at all when you
> > > can actually affine kthreads on runtime?
> > 
> > New, unbound kernel threads inherit the cpumask of kthreadd.
> > 
> > Therefore there is a race between kernel thread creation 
> > and affine.
> > 
> > If you know of a solution to that problem, that can be used instead.
> 
> Well, you could first set the affinity of kthreadd and only then the affinity
> of the others. But I can still imagine some tiny races with fork().

Ah forget that, I missed the part in kthread_create_on_node().

Thanks.
