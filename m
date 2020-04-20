Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B400EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917D02078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587398570;
	bh=koM17VsUIjN22KW0gYBGciditqoq/vpfeCTdStzZrDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=serHBILo1tmWJXAYIHL+dvDwXpdti3OH5yoSqiR2BkfENt7vo+Kq6uEuxJC/UaSdG
	 U6pTUyAKpg+sZZRsQXEdwa6oaLoupflhRCSzkarz1eCaEySnF9XdEqJkNyZyvX5Ud8
	 YLZf62C0Rk4W82iHPhTWrQosgRQzFGFJTRFuNSbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDTQCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:02:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTQCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:02:49 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C5220775;
        Mon, 20 Apr 2020 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587398568;
        bh=koM17VsUIjN22KW0gYBGciditqoq/vpfeCTdStzZrDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuQN31/97Tv3UOP/mqB4qg99JuUoeHH5P1zozM3N87TFBNq3UzcZatt1TrSTBYEUL
         QJXlLa73Ju7reDsInSH3lFrQ2LwFyDx1+FNZ0ldO6JB96ZF9QMs8Tidqiskt0BbMNJ
         fwdG+1XjHqGZHivHv7L3f8Y6alDwzeup21T1q/Iw=
Date:   Mon, 20 Apr 2020 18:02:46 +0200
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
Subject: Re: [patch 0/4] affine kernel threads to nohz_full= cpumask (v4)
Message-ID: <20200420160245.GA10024@lenoir>
References: <20200401121018.104226700@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401121018.104226700@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 09:10:18AM -0300, Marcelo Tosatti wrote:
> This is a kernel enhancement that configures the cpu affinity of kernel
> threads via kernel boot option nohz_full=.
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
> v2: use isolcpus= subcommand (Thomas Gleixner)
> 
> v3: s/MontaVista/Wind River/ on changelog (Chris Friesen)
>     documentation updates                 (Chris Friesen)
>     undeprecate isolcpus                  (Chris Friesen)
>     general cleanups                      (Frederic Weisbecker)
>     separate cpu_possible_mask kthread
>     mask change                           (Frederic Weisbecker)
> 
> v4: disable idle load balancing for nohz_full=
>     use nohz_full= option for kthread isolation (Frederic Weisbecker)
> 


Thanks for the patches. I'm applying them, I may add a few details
to the changelogs and stuff.
