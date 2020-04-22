Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141DC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CEA214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDVQq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgDVQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:46:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 043142098B;
        Wed, 22 Apr 2020 16:46:52 +0000 (UTC)
Date:   Wed, 22 Apr 2020 12:46:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200422124651.6199790d@gandalf.local.home>
In-Reply-To: <20200422164030.GA17661@paulmck-ThinkPad-P72>
References: <20200422112719.826676174@infradead.org>
        <20200422112831.266499893@infradead.org>
        <20200422131138.GL17661@paulmck-ThinkPad-P72>
        <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
        <20200422155006.GR17661@paulmck-ThinkPad-P72>
        <20200422123331.30b00018@gandalf.local.home>
        <20200422164030.GA17661@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 09:40:30 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Not saying it is not insane, mind you!  ;-)

I sometimes wonder about your sanity ;-)

-- Steve
