Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33195C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0919C206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405051AbgDPAso convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404980AbgDPAsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:48:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0960206A2;
        Thu, 16 Apr 2020 00:48:29 +0000 (UTC)
Date:   Wed, 15 Apr 2020 20:48:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415204827.24f2c548@oasis.local.home>
In-Reply-To: <CALAqxLX2UDQ7=dvzMoP6g-rYzw9dBebrynMfo4Gnv=SzaqhE=g@mail.gmail.com>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
        <20200415085348.5511a5fe@gandalf.local.home>
        <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
        <20200415161424.584d07d3@gandalf.local.home>
        <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
        <20200415164116.40564f2c@gandalf.local.home>
        <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
        <20200415174918.154a86d0@gandalf.local.home>
        <20200415220459.GE17661@paulmck-ThinkPad-P72>
        <20200415185121.381a4bc3@gandalf.local.home>
        <CALAqxLX2UDQ7=dvzMoP6g-rYzw9dBebrynMfo4Gnv=SzaqhE=g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 17:06:24 -0700
John Stultz <john.stultz@linaro.org> wrote:

> So you're saying the recent change to move to using trace_*_rcuidle()
> was unnecessary?
> 
> Or is there a different notifier then cpu_pm_register_notifier() that
> the driver should be using (that one seems to be using
> atomic_notifier_chain_register())?

From looking at the trace event in __tcs_buffer_write() in
drivers/soc/qcom/rpmh-rsc.c, the _rcuidle() was added by:

efde2659b0fe8 ("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh")

Which shows a backtrace dump of:

     Call trace:
      dump_backtrace+0x0/0x174
      show_stack+0x20/0x2c
      dump_stack+0xc8/0x124
      lockdep_rcu_suspicious+0xe4/0x104
      __tcs_buffer_write+0x230/0x2d0
      rpmh_rsc_write_ctrl_data+0x210/0x270
      rpmh_flush+0x84/0x24c
      rpmh_domain_power_off+0x78/0x98
      _genpd_power_off+0x40/0xc0
      genpd_power_off+0x168/0x208
      genpd_power_off+0x1e0/0x208
      genpd_power_off+0x1e0/0x208
      genpd_runtime_suspend+0x1ac/0x220
      __rpm_callback+0x70/0xfc
      rpm_callback+0x34/0x8c
      rpm_suspend+0x218/0x4a4
      __pm_runtime_suspend+0x88/0xac
      psci_enter_domain_idle_state+0x3c/0xb4
      cpuidle_enter_state+0xb8/0x284
      cpuidle_enter+0x38/0x4c
      call_cpuidle+0x3c/0x68
      do_idle+0x194/0x260
      cpu_startup_entry+0x24/0x28
      secondary_start_kernel+0x150/0x15c


There's no notifier that calls this. This is called by the rpm_callback
logic. Perhaps that callback will require a call to rcu_irq_enter()
before calling the callback.

In any case, I think it is wrong that these callbacks are called
without RCU watching. The _rcuidle() on that tracepoint should be
removed, and we fix the code that gets there to ensure that RCU is
enabled. I agree with Peter, that no module code should be executed
without RCU watching.

-- Steve

