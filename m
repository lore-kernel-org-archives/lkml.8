Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ED4C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6810206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDUOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:50:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A72206A1;
        Tue, 21 Apr 2020 14:50:03 +0000 (UTC)
Date:   Tue, 21 Apr 2020 10:50:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>
Subject: Re: [PATCH 2/2][v3] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200421105002.31de19ce@gandalf.local.home>
In-Reply-To: <5a99860cf66293db58a397d6248bcb2eee326776.1587464698.git.yu.c.chen@intel.com>
References: <cover.1587464698.git.yu.c.chen@intel.com>
        <5a99860cf66293db58a397d6248bcb2eee326776.1587464698.git.yu.c.chen@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 18:50:43 +0800
Chen Yu <yu.c.chen@intel.com> wrote:

> Introduce a new function put_prev_task_balance() to do the balance
> when necessary, and then put previous task back to the run queue.
> This function is extracted from pick_next_task() to prepare for
> future usage by other type of task picking logic.
> 
> No functional change.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> 

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
