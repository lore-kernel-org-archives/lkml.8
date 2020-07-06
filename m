Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D128C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E379206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594077171;
	bh=VQ2p/gXFzFG/0c9yHkxxTh4LZNRe5aVYFhXCqI1LUYQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zdQtyBRtwFR/DZQfplxJBoTlBb4bO4G6zRPwAFoPZfz8exK7IW2ZuG/eAWlqDEIae
	 IhmXQirfCZ9yxf3mr0byKYuu2TvUDmhqh6yqHlxLRiQnJgK4+Z95jORhbthPnLUrOV
	 lCVDshn3Ynp+olZy7JHx2uYrr1tngY4SGNM+FvkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGFXMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGFXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:12:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD920205CB;
        Mon,  6 Jul 2020 23:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594077168;
        bh=VQ2p/gXFzFG/0c9yHkxxTh4LZNRe5aVYFhXCqI1LUYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RSH3R5WGKGHbsyko78vY7flozXR1pG0oVgVIJ+ouWEYRI9BGu0U6GNKIrXOMVxabO
         IPBJXC4iQhLMhIEn3yfBUHKVvbOXOCo6aXWqBXVvNcYUP3ASQLIDBzHzjhDX6OeVyp
         RIRALLRxvRtudI3sL9wF03W1rMGB2qssBkfWvxpI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 960513522637; Mon,  6 Jul 2020 16:12:48 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:12:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [kernel/smp] 5408b78b7a: BUG:KASAN:out-of-bounds_in_c
Message-ID: <20200706231248.GQ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200705082603.GX3874@shao2-debian>
 <20200705173703.GR9247@paulmck-ThinkPad-P72>
 <20200706184941.GA1651@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706184941.GA1651@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 02:49:41PM -0400, Qian Cai wrote:
> On Sun, Jul 05, 2020 at 10:37:03AM -0700, Paul E. McKenney wrote:
> > Good catch, but someone beat you to it.  This commit contains the fix:
> > 
> > 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")
> 
> Well, I can still reproduce this on next-20200706 which contains the said fix.
> 
> CSD_LOCK_WAIT_DEBUG=n

Indeed you can, good catch, and thank you!

There was a csd_lock_record(csd) that instead needed to be
csd_lock_record(NULL).  A fix is in progress.

							Thanx, Paul

> commit 0504bc41a62c4a42b9316244da7208feca7295cb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Tue Jun 30 13:22:54 2020 -0700
> 
>     kernel/smp: Provide CSD lock timeout diagnostics
> 
>     This commit causes csd_lock_wait() to emit diagnostics when a CPU fails
>     to respond quickly enough to one of the smp_call_function() family of
>     function calls.  These diagnostics include NMI stack traces, and so the
>     exclusion of idle CPUs is also removed.  These diagnostics are enabled
>     by a new CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.
> 
>     This commit was inspired by an earlier patch by Josef Bacik.
> 
>     [ paulmck: Avoid 64-bit divides per kernel test robot feedback. ]
>     [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
>     Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
>     Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> [19929.567055][    T0] BUG: KASAN: out-of-bounds in flush_smp_call_function_queue+0x65f/0x7c0
> csd_lock_record at kernel/smp.c:119
> (inlined by) flush_smp_call_function_queue at kernel/smp.c:395
> [19929.575391][    T0] Read of size 8 at addr ffffc900320879b8 by task swapper/35/0
> [19929.582845][    T0] 
> [19929.585060][    T0] CPU: 35 PID: 0 Comm: swapper/35 Tainted: G           O      5.8.0-rc3-next-20200706 #1
> [19929.594784][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> [19929.604072][    T0] Call Trace:
> [19929.607253][    T0]  dump_stack+0x9d/0xe0
> [19929.611304][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
> [19929.617355][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
> [19929.623415][    T0]  print_address_description.constprop.8.cold.9+0x56/0x4fc
> [19929.630521][    T0]  ? log_store.cold.32+0x11/0x11
> [19929.635353][    T0]  ? lock_downgrade+0x720/0x720
> [19929.640097][    T0]  ? nr_iowait_cpu+0x78/0xf0
> [19929.644576][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
> [19929.650625][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
> [19929.656674][    T0]  kasan_report.cold.10+0x37/0x7c
> [19929.661587][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
> [19929.667647][    T0]  flush_smp_call_function_queue+0x65f/0x7c0
> [19929.673535][    T0]  flush_smp_call_function_from_idle+0x41/0x71
> [19929.679598][    T0]  do_idle+0x2d6/0x4f0
> [19929.683557][    T0]  ? arch_cpu_idle_exit+0x40/0x40
> [19929.688480][    T0]  cpu_startup_entry+0x14/0x16
> [19929.693143][    T0]  secondary_startup_64+0xb6/0xc0
> [19929.698059][    T0] 
> [19929.700270][    T0] 
> [19929.702476][    T0] Memory state around the buggy address:
> [19929.708007][    T0]  ffffc90032087880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [19929.715986][    T0]  ffffc90032087900: 00 00 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00
> [19929.723963][    T0] >ffffc90032087980: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
> [19929.731940][    T0]                                            ^
> [19929.737999][    T0]  ffffc90032087a00: 00 00 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00
> [19929.745982][    T0]  ffffc90032087a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
