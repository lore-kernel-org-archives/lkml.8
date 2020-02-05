Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42741C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D540218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgBEO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgBEO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:28:54 -0500
Received: from oasis.local.home (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5600E20702;
        Wed,  5 Feb 2020 14:28:52 +0000 (UTC)
Date:   Wed, 5 Feb 2020 09:28:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205092847.0b650972@oasis.local.home>
In-Reply-To: <20200205141915.GA194021@google.com>
References: <20200205104929.313040579@goodmis.org>
        <20200205105113.283672584@goodmis.org>
        <20200205063349.4c3df2c0@oasis.local.home>
        <20200205141915.GA194021@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Feb 2020 09:19:15 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> Could you paste the stack here when RCU is not watching? In trace event code
> IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
> code can be called from idle loop. Should we doing the same here as well?

Unfortunately I lost the stack trace. And the last time we tried to use
rcu_enter_irqs_on() for ftrace, we couldn't find a way to do this
properly. Ftrace is much more invasive then going into idle. The
problem is that ftrace traces RCU itself, and calling
"rcu_enter_irqs_on()" in pretty much any place in the RCU code caused
lots of bugs ;-)

This is why we have the schedule_on_each_cpu(ftrace_sync) hack.

-- Steve
