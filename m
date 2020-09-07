Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB54EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8214A206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbgIGRsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:48:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgIGMuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:50:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C2651045;
        Mon,  7 Sep 2020 05:49:59 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCD23F66E;
        Mon,  7 Sep 2020 05:49:58 -0700 (PDT)
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de> <20200528084614.0c949e8d@gandalf.local.home> <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de> <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org> <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de> <20200821110848.6c3183d1@oasis.local.home> <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org> <20200821170334.73b52fdd@oasis.local.home> <20200822123252.GQ1362448@hirez.programming.kicks-ass.net> <20200822194928.54ee4cb5@oasis.local.home> <20200907114140.GQ2674@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>, dave@stgolabs.net
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt context
In-reply-to: <20200907114140.GQ2674@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Sep 2020 13:49:53 +0100
Message-ID: <jhj1rjdycni.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/09/20 12:41, peterz@infradead.org wrote:
> So cenceptually there's the problem that idle must always be runnable,
> and the moment you boost it, it becomes subject to a different
> scheduling class.
>
> Imagine for example what happens when we boost it to RT and then have it
> be subject to throttling. What are we going to run when the idle task
> is no longer elegible to run.
>
> (it might all work out by accident, but ISTR we had a whole bunch of fun
> in the earlier days of RT due to things like that)

Doesn't that become a non-problem (conceptually) with proxy exec? In that
case the idle task remains forever runnable, it just runs with its own
scheduling context during the throttling window.

Not trying to sell PE as the Billy Mays-backed solution to all kernel
issues, but I think it's another thing for me to ponder on & play with.
