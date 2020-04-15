Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5CBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DF12078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442107AbgDOUlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438081AbgDOUlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:41:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7845720787;
        Wed, 15 Apr 2020 20:41:18 +0000 (UTC)
Date:   Wed, 15 Apr 2020 16:41:16 -0400
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
Message-ID: <20200415164116.40564f2c@gandalf.local.home>
In-Reply-To: <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
        <20200415085348.5511a5fe@gandalf.local.home>
        <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
        <20200415161424.584d07d3@gandalf.local.home>
        <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 13:17:53 -0700
John Stultz <john.stultz@linaro.org> wrote:

> > Hmm, isn't module code itself synchronized via RCU. Then having module code
> > being called without RCU "watching" could be dangerous?  
> 
> I'm not sure I'm following you here. Could you explain more?

So how does this code get registered to be called as a module? And if it is
registered, I'm guessing it needs to be unregistered too. How would that be
synchronized? Usually, calling synchronize_rcu() is done after
unregistering, but if that code is called without RCU watching, it is
possible synchronize_rcu() can finish before that code is released.

-- Steve
