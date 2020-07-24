Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF09C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F1E206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGXOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgGXOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:50:57 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90481C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:50:57 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D2C746FA; Fri, 24 Jul 2020 16:50:54 +0200 (CEST)
Date:   Fri, 24 Jul 2020 16:50:53 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression on todays tip/master (commit 16f70beccf43)
Message-ID: <20200724145053.GV27672@8bytes.org>
References: <20200723133743.GA30716@8bytes.org>
 <871rl2xpar.fsf@nanos.tec.linutronix.de>
 <20200723145219.GP27672@8bytes.org>
 <20200724132802.GA640628@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724132802.GA640628@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 03:28:02PM +0200, Ingo Molnar wrote:
> Given that you are perf stress-testing the box, some recent perf 
> commit would be the primary suspect - before doing a full bisect you 
> might want to try current perf/core (2ac5413e5edc) and its upstream 
> base: v5.8-rc3, to narrow it down.
> 
> But in principle any other commit could be the cause as well, the 
> assert suggests memory corruption - I don't think we changed anything 
> in the signal code.

I tried to bisec, but it didn't yield something useful yet. The outcome
was commit

	commit 1abdfe706a579a702799fce465bceb9fb01d407c
	Author: Alex Belits <abelits@marvell.com>
	Date:   Thu Jun 25 18:34:41 2020 -0400

	    lib: Restrict cpumask_local_spread to houskeeping CPUs

But it looks totally unrelated to the backtrace I am seeing, and
reverting it didn't fix the problem.

Next thing is, I can reliable reproduce it with yesterdays tip/master
(commit 16f70beccf43), but did not see it with tip/master pulled today
(commit c02699cd25e8) yet.

To trigger it is sufficient to run the test_syscall_vdso_32 self-test in
a loop, ideally multiple $times, where $times > `nproc`. It usually
triggers withing the first 5 minutes in my test VMs. It turned out that
a running perf is not needed to trigger it.

Regards,

	Joerg
