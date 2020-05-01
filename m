Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F8C47259
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE37C216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 23:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgEAXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 19:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:35:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF055208C3;
        Fri,  1 May 2020 23:35:03 +0000 (UTC)
Date:   Fri, 1 May 2020 19:35:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 01/18] notifier: Fix broken error handling pattern
Message-ID: <20200501193502.7c9b2b10@oasis.local.home>
In-Reply-To: <20200501202943.837409514@infradead.org>
References: <20200501202849.647891881@infradead.org>
        <20200501202943.837409514@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 May 2020 22:28:50 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> The current notifiers have the following error handling pattern all
> over the place:
> 
> 	int err, nr;
> 
> 	err = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
> 	if (err & NOTIFIER_STOP_MASK)
> 		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)
> 
> And aside from the endless repetition thereof, it is broken. Consider
> blocking notifiers; both calls take and drop the rwsem, this means
> that the notifier list can change in between the two calls, making @nr
> meaningless.
> 
> Fix this by replacing all the __foo_notifier_call_chain() functions
> with foo_notifier_call_chain_robust() that embeds the above pattern,
> but ensures it is inside a single lock region.
> 
> Note: I switched atomic_notifier_call_chain_robust() to use
>       the spinlock, since RCU cannot provide the guarantee
>       required for the recovery.
> 
> Note: software_resume() error handling was broken afaict.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/notifier.h           |   15 +--
>  kernel/cpu_pm.c                    |   48 ++++--------
>  kernel/notifier.c                  |  144 ++++++++++++++++++++++---------------
>  kernel/power/hibernate.c           |   26 +++---
>  kernel/power/main.c                |    8 +-
>  kernel/power/power.h               |    3 
>  kernel/power/suspend.c             |   14 +--
>  kernel/power/user.c                |   14 +--
>  tools/power/pm-graph/sleepgraph.py |    2 
>  9 files changed, 141 insertions(+), 133 deletions(-)
> 

This looks like something that can go in outside this series.

-- Steve
