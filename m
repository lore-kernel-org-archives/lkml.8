Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2152EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFFB2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633116AbgDNU1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633098AbgDNU1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:27:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE5D2074D;
        Tue, 14 Apr 2020 20:27:44 +0000 (UTC)
Date:   Tue, 14 Apr 2020 16:27:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200414162742.0ef4d9ee@gandalf.local.home>
In-Reply-To: <jhjh7xlvqqe.mognet@arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
        <jhjh7xlvqqe.mognet@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 19:58:49 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> To move this forward, I would suggest renaming the current cpumask_any_*()
> into cpumask_first_*(), and THEN introduce the new pseudo-random
> ones. People are then free to hand-fix specific locations if it makes sense
> there, like you're doing for RT.

Or leave "cpumask_any()" as is, and create a new "cpumask_random()" for
this purpose.

-- Steve
