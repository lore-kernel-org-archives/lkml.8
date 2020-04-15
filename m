Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230402076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441992AbgDOUOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436830AbgDOUO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:14:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 458BB2076C;
        Wed, 15 Apr 2020 20:14:26 +0000 (UTC)
Date:   Wed, 15 Apr 2020 16:14:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415161424.584d07d3@gandalf.local.home>
In-Reply-To: <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
        <20200415085348.5511a5fe@gandalf.local.home>
        <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 12:56:52 -0700
John Stultz <john.stultz@linaro.org> wrote:

> I'm trying to enable the qcom rpmh driver
> (drivers/soc/qcom/rpmh-rsc.c) to be a module.  As I mentioned to Paul,
> it registers a cpu_pm notifier callback, which calls its
> __tcs_buffer_write() function. The trace in the __tcs_buffer_write()
> function was just converted to using rcuidle to address bugs seen when
> it was being called from idle.
> 
> > Currently, Thomas and Peter are working on removing trace events from
> > places that don't have RCU enabled, or at least cleaning up the context
> > switches from user to kernel to interrupt.  
> 
> So does that mean folks would most likely lean to trying to remove the
> tracepoint rather than reevaluating allowing the rcuidle call to be
> made from the module?
> 

No. The clean up is to try to make the switch from each context small, fast
and safe. But what you are describing is the switch to idle, which is a
different story and something that there's some talk about cleaning up, but
not at the same level. Especially if there's more complex code that is
happening with RCU watching.

Looking at the commit that keeps trace_*_rcuidle() code out:

  7ece55a4a3a04a ("trace: Don't declare trace_*_rcuidle functions in modules")

Which was added because the rcuidle variant called RCU code that was not
exported either. Which would have the same issue now as
rcu_irq_exit_irqson() is also not exported. Which would be needed.

Hmm, isn't module code itself synchronized via RCU. Then having module code
being called without RCU "watching" could be dangerous?

-- Steve
