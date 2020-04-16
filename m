Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C656C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9922076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgDPBZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgDPBY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:24:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1FB72076D;
        Thu, 16 Apr 2020 01:24:56 +0000 (UTC)
Date:   Wed, 15 Apr 2020 21:24:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415212455.28f22041@oasis.local.home>
In-Reply-To: <20200416010258.GM20625@builder.lan>
References: <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
        <20200415161424.584d07d3@gandalf.local.home>
        <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
        <20200415164116.40564f2c@gandalf.local.home>
        <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
        <20200415174918.154a86d0@gandalf.local.home>
        <20200415220459.GE17661@paulmck-ThinkPad-P72>
        <20200415185121.381a4bc3@gandalf.local.home>
        <CALAqxLX2UDQ7=dvzMoP6g-rYzw9dBebrynMfo4Gnv=SzaqhE=g@mail.gmail.com>
        <20200415204827.24f2c548@oasis.local.home>
        <20200416010258.GM20625@builder.lan>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 18:02:58 -0700
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> Forgive me, but how is this problem related to the fact that the code is
> dynamically loaded, i.e. encapsulated in a module?

It's not.

> 
> Per the example earlier in this thread, the thing we're worried about is
> a use after free in the following scenario, right?
> 
>         cpu_pm_unregister_notifier(my_notifier);
> 	kfree(my_data);
> 
> But a driver implementing this snippet might do this regardless of being
> builtin or module and afaict exiting probe() unsuccessfully or unbinding
> the device would risk triggering this issue?

I know my email was confusing. I was talking about a bug that does not
exist. (There is no bug!)

The reason is that rcu is enabled during the call to the notifiers. The
above assumes that the my_data usage in the notifier callback is
surrounded by rcu_read_lock() (otherwise it's broken regardless of this
code or not). The above unregister will call synchronize_rcu() after it
removes the notifier which will guarantee that the rcu_read_lock()
critical sections would be completed. Then the kfree(my_data) can free
my_data with no possible users.

-- Steve
