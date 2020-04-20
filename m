Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21DC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D16206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgDTRnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:43:47 -0400
Received: from foss.arm.com ([217.140.110.172]:52850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgDTRnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:43:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE4A231B;
        Mon, 20 Apr 2020 10:43:44 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F603F73D;
        Mon, 20 Apr 2020 10:43:43 -0700 (PDT)
References: <cover.1587393807.git.yu.c.chen@intel.com> <34d7c9496b77c928fcbe6085213115bd4d48d5a2.1587393807.git.yu.c.chen@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2][v2] sched: Make newidle_balance() static again
In-reply-to: <34d7c9496b77c928fcbe6085213115bd4d48d5a2.1587393807.git.yu.c.chen@intel.com>
Date:   Mon, 20 Apr 2020 18:43:37 +0100
Message-ID: <jhjzhb6kq7q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/04/20 16:01, Chen Yu wrote:
> After Commit 6e2df0581f56 ("sched: Fix pick_next_task() vs 'change'
> pattern race"), there is no need to expose newidle_balance() as it
> is only used within fair.c file. Change this function back to static again.
>
> No functional change.
>

That derelict 'idle_balance()' is a funny one.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v2: Rename the remaining idle_balance() to newidle_balance()
>     to fix an compile error when CONFIG_SMP is not set.
