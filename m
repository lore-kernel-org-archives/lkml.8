Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27D4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E8E2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036210;
	bh=w5OJz1765mdFH4/Uo4Yx+dMsFICrfjR1unWrEPeY9ro=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Ypv7w6vUGTKDjMRPdCMtQtuvEG+sHgUG9sqGu8mM6rPz58AxfPH/G9WUWCBzrRIFa
	 PLiDw+uhp9wjSKj5CeoiB0V1aQnzTMk6FLP6zcGMSFpFk26j0ydi7GGZ5XM7Y1RZ+a
	 Mndh2Nejy9ZKS70XXbaKQesUGz9UowRlSMSNwj90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgCLSD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgCLSD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:03:29 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DCC620663;
        Thu, 12 Mar 2020 18:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584036208;
        bh=w5OJz1765mdFH4/Uo4Yx+dMsFICrfjR1unWrEPeY9ro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fihPR0qNPve9gBwdyknFivzRqYTRZmUL1oZTZtBerw1K2z6xhzA1yql3cZ/p2hjwq
         Kw42S+fHWFkwtHxBUfdhwDEIEvrmU1dvsQewTiZXLsF/YqOhRlrWt+3na1X2bbLaLo
         4/kE1+957TaOxMbFLY4w+kJLR3gRJP0O3TkaVh+M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5980835226D0; Thu, 12 Mar 2020 11:03:28 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:03:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: Re: [PATCH kcsan 27/32] kcsan: Add option to allow watcher
 interruptions
Message-ID: <20200312180328.GA4772@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
 <20200309190420.6100-27-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309190420.6100-27-paulmck@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> From: Marco Elver <elver@google.com>
> 
> Add option to allow interrupts while a watchpoint is set up. This can be
> enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> parameter 'kcsan.interrupt_watcher=1'.
> 
> Note that, currently not all safe per-CPU access primitives and patterns
> are accounted for, which could result in false positives. For example,
> asm-generic/percpu.h uses plain operations, which by default are
> instrumented. On interrupts and subsequent accesses to the same
> variable, KCSAN would currently report a data race with this option.
> 
> Therefore, this option should currently remain disabled by default, but
> may be enabled for specific test scenarios.
> 
> To avoid new warnings, changes all uses of smp_processor_id() to use the
> raw version (as already done in kcsan_found_watchpoint()). The exact SMP
> processor id is for informational purposes in the report, and
> correctness is not affected.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

And I get silent hangs that bisect to this patch when running the
following rcutorture command, run in the kernel source tree on a
12-hardware-thread laptop:

bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --duration 10 --kconfig "CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y" --configs TREE03

It works fine on some (but not all) of the other rcutorture test
scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common thread
is that these are the TREE scenarios are all PREEMPT=y.  So are RUDE01,
SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
on Tree RCU, and thus have far less interrupt activity and the like.
Given that it is an interrupt-related feature being added by this commit,
this seems like expected (mis)behavior.

Can you reproduce this?  If not, are there any diagnostics I can add to
my testing?  Or a diagnostic patch I could apply?

							Thanx, Paul
