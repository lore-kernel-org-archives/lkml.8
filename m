Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B455E20679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595894028;
	bh=203hMgE6K9RIifS64M041Kv8rErCEe8+fB8jf0jJX8U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=SbahmB5uzLuWvqVuOgVWMy8gU468dlZqwLAgDR9IlngaYN6OD4ePx4KQlydjZdfaH
	 ZkyVQohd9/fGy8sNULYtwqhTz/5Ndmyi1DtAm60dRgbdf+Eo67P/V3REWm5Oi3XhRj
	 LJSEPNV96pHWrRNzjwUprn+ont0kUNzQXwATTP5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgG0Xxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:53:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgG0Xxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:53:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C466C20679;
        Mon, 27 Jul 2020 23:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595894023;
        bh=203hMgE6K9RIifS64M041Kv8rErCEe8+fB8jf0jJX8U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NdFjnh9SDApq5FVBZggS1cUozQF9mej3TwEyaHh1d4v1rRPN2h4T6q1m/NlH6amGG
         eLTYAvh5W2mYdEy7mchBvBQcH5IvLDaQU8beXFYZBZ8AolKjlaZLJo91ZBZOSClSMG
         CcmDsqi55uNEXa99c5vO5U2ffSO5s3gS5oFbnE0M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A603835231D2; Mon, 27 Jul 2020 16:53:43 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:53:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: Re: [PATCH smp 0/2] Provide CSD lock timeout diagnostics
Message-ID: <20200727235343.GA30963@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200709235436.GA20922@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235436.GA20922@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is version 2 of a sneak preview of a series providing diagnostics
to help track down problems that would result in excessive csd_unlock()
latencies:

1.	Add source and destination CPUs to __call_single_data.
	I freely admit that I found the union declaration a
	bit confusing!

2.	Provide CSD lock timeout diagnostics.

3.	Add "static" to a local variable.

Changes since v1:

o	Fix stack-out-of-bounds read in csd_lock_record located by syzbot.

o	Fix KASAN-detected use-after-free issue reported by Qian Cai.

o	Fix botched nr_cpu_ids comparison reported by Dan Carpenter.

o	Fix numerous issues reported by Peter Zijlstra, including
	annoying CPP macros, #ifdef consolidation, another use-after-free
	issue, memory-ordering/comment issues, {} code-style issues.

	This now has no effect unless CONFIG_CSD_LOCK_WAIT_DEBUG=y.
	It also uses NSEC_PER_MSEC instead of cubing 1000.
	Times are now printed in nanoseconds instead of decimal seconds.
	Switched to C-language Classic Comment style.
	Moved to x-mas tree variable-declaration order from alphabetic.
	Avoided two prints via "CPU-1".

o	This version still "handles" 32-bit VDSO build errors by
	prohibiting CONFIG_CSD_LOCK_WAIT_DEBUG=y in 32-bit builds.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/smp.h       |    3 +
 include/linux/smp_types.h |    3 +
 kernel/smp.c              |  136 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug         |   11 +++
 4 files changed, 152 insertions(+), 1 deletion(-)
