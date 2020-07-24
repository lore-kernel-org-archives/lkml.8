Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD49C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24C7206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXPfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXPfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:35:41 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F4C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 08:35:41 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5067D6FA; Fri, 24 Jul 2020 17:35:38 +0200 (CEST)
Date:   Fri, 24 Jul 2020 17:35:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200724153536.GX27672@8bytes.org>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
 <20200723145219.GP27672@8bytes.org>
 <20200724132802.GA640628@gmail.com>
 <20200724145053.GV27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724145053.GV27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:50:53PM +0200, Joerg Roedel wrote:
> Next thing is, I can reliable reproduce it with yesterdays tip/master
> (commit 16f70beccf43), but did not see it with tip/master pulled today
> (commit c02699cd25e8) yet.

Next bisection try ended with this log:

# bad: [16f70beccf43f9eb481ff8485974bc00ab2267d8] Merge branch 'core/debugobjects'
# good: [ba47d845d715a010f7b51f6f89bae32845e6acb7] Linux 5.8-rc6
git bisect start '16f70beccf43' 'v5.8-rc6'
# good: [e9c8c19545f31ec817507ee11884356799f14917] Merge branch 'perf/core'
git bisect good e9c8c19545f31ec817507ee11884356799f14917
# bad: [8e62572d2c29e1c484f5d4e7c016793209de2efb] Merge branch 'linus'
git bisect bad 8e62572d2c29e1c484f5d4e7c016793209de2efb
# good: [c085fb8774671e83f6199a8e838fbc0e57094029] perf/x86/intel/lbr: Support XSAVES for arch LBR read
git bisect good c085fb8774671e83f6199a8e838fbc0e57094029
# good: [220dbf4aaa5b574f67ce23fa4d7b0104515bc60e] Merge branch 'WIP.core/headers'
git bisect good 220dbf4aaa5b574f67ce23fa4d7b0104515bc60e
# bad: [9d246053a69196c7c27068870e9b4b66ac536f68] sched: Add a tracepoint to track rq->nr_running
git bisect bad 9d246053a69196c7c27068870e9b4b66ac536f68
# bad: [46609ce227039fd192e0ecc7d940bed587fd2c78] sched/uclamp: Protect uclamp fast path code with static key
git bisect bad 46609ce227039fd192e0ecc7d940bed587fd2c78
# bad: [85c2ce9104eb93517db2037699471c517e81f9b4] sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64 bytes for GCC-4.9
git bisect bad 85c2ce9104eb93517db2037699471c517e81f9b4
# bad: [faa2fd7cbad4609d06d7904c0a80cf2f8cd23678] Merge branch 'sched/urgent'
git bisect bad faa2fd7cbad4609d06d7904c0a80cf2f8cd23678
# first bad commit: [faa2fd7cbad4609d06d7904c0a80cf2f8cd23678] Merge branch 'sched/urgent'

So it ends at a merge commit. I am not going to debug this further as it
is no longer reproducible with todays tip/master. It probably was just a
bug in a conflict resolution when merging branches or something like
that.

Regards,

	Joerg
