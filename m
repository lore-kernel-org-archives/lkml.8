Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7193BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411DE20774
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585616233;
	bh=VNArk9mbI7nB1oDebeUww+gaGD3+wPzNeXYWHy+szRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J8JM5+zn0Xh8ogDirjm0bDHtIzb9Ttw5Wq2A3UAm1j/AYWB8kvNkfGUy/MQWXUi4W
	 7Wqf0f+P0Q1iAwiy4ZUC972vu6ppDuanLHhCo+FZPdQgcAMmk8yWTKMt/L8GFQDaqW
	 7B7nmPqSp4/DyeTDB+pv/E21idhO2SgZZc4at4qE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgCaA5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgCaA5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:57:11 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354A620748;
        Tue, 31 Mar 2020 00:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585616230;
        bh=VNArk9mbI7nB1oDebeUww+gaGD3+wPzNeXYWHy+szRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odGVGQYa8b8U0StrSZ35mCrzvRdR11nzUuYq98W9wLUus9pD1hmHV2ae5RznmEmOD
         5bNNfwvj8+o3sUbXVlMHbHiHcif3o2JhPCpkFsgXqGQmgOfaGJMeFs8TySIou5GFNv
         l+XE3mLYhsAkMdh+c3oNNkKrq/EpuxJ43UcnSq4Q=
Date:   Tue, 31 Mar 2020 02:57:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Chris Friesen <chris.friesen@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [patch 2/3] isolcpus: affine kernel threads to specified cpumask
Message-ID: <20200331005706.GA24647@lenoir>
References: <20200328152117.881555226@redhat.com>
 <20200328152503.225876188@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328152503.225876188@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:21:19PM -0300, Marcelo Tosatti wrote:
> This is a kernel enhancement to configure the cpu affinity of kernel threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> 
> When this option is specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
> 
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus=domain parameter,
> making it possible to enable load balancing on such CPUs
> during runtime (see kernel-parameters.txt).
> 
> Note-1: this is based off on Wind River's patch at
> https://github.com/starlingx-staging/stx-integ/blob/master/kernel/kernel-std/centos/patches/affine-compute-kernel-threads.patch
> 
> Difference being that this patch is limited to modifying
> kernel thread cpumask: Behaviour of other threads can
> be controlled via cgroups or sched_setaffinity.
> 
> Note-2: Wind River's patch was based off Christoph Lameter's patch at
> https://lwn.net/Articles/565932/ with the only difference being
> the kernel parameter changed from kthread to kthread_cpus.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    8 ++++++++
>  include/linux/sched/isolation.h                 |    1 +
>  kernel/kthread.c                                |    6 ++++--
>  kernel/sched/isolation.c                        |    6 ++++++
>  4 files changed, 19 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> ===================================================================
> --- linux-2.6.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-2.6/Documentation/admin-guide/kernel-parameters.txt
> @@ -1959,6 +1959,14 @@
>  			  the CPU affinity syscalls or cpuset.
>  			  <cpu number> begins at 0 and the maximum value is
>  			  "number of CPUs in system - 1".
> +			  When using cpusets, use the isolcpus option "kthread"
> +			  to avoid creation of kernel threads on isolated CPUs.
> +
> +			kthread
> +			  Adjust the CPU affinity mask of unbound kernel threads to
> +			  not contain CPUs on the isolated list. This complements
> +			  the isolation provided by the cpusets mechanism described
> +			  above and by managed_irq option.

So, what about what I suggested with having "unbound" instead, which
includes all the CPU-unbound work?

 HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED

(and yes your suggestion of including HK_FLAG_SCHED is good).

Because I don't see the point of exposing kthread isolation alone as an ABI
so far.

Later I suspect I'll turn all these flags into a single HK_FLAG_UNBOUND.

Thanks.
