Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98995C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 723A320737
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMC/qWTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgDPCSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731031AbgDPCSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:18:04 -0400
Received: from mail-oo1-xc43.google.com (mail-yw1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D12C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:18:04 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g14so338736ooa.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQ31clhLZb3VXpySOphZmzfjZTGe/r/2/PRRcbkZITI=;
        b=nMC/qWTktNUMDXE45p0WHAv3qQ2luZCbAsFW6wl4sjF9gcgJ2G0R1JMPV+jsMydNRD
         TgG00U1QJCed8qep3C0HhtJUBBm9jXAAWCH4+6f+n4MvVZi0CFKVUxhx8w4aEtQn2gnl
         mV39d+E0efQh4qKgDRPWlFW+FpJgq1suZWlAUlBbsHVw7Gnfzv0Z8GHkrxtDnYte1cWX
         eSV+BKQjR8jLSML/UZAbJe1mjGtohQPot93lIc8u4s3pCYUQtlR/bobRukMR0zq9BJz3
         IHZGlD/NXR0f73j71Pwl0LZFjYjx7I0yvCjfbngCyuxYISAiPP+YyhEhsZ8UCTNdLKx3
         /rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ31clhLZb3VXpySOphZmzfjZTGe/r/2/PRRcbkZITI=;
        b=gcmuAF4EgVmdpV2mNHbM8az2RJvaeVu5isrQrsOwFQAJIS5Zjvhd8EiIm3VHzxFc3B
         a117iI93Zy3jP0DDZoJzhsZOyNova8E5/stHgS43jrP3F58dLYZqLpIU1PvVAn6TWyB8
         zCdZ1+JRd61cbCArgdTy/c4lS6D2yQczpAxziLYDNg9cM/zkFjaidFZF7jccLov8+t7T
         Rs6lyequo4InhGEdTIq6dtXZzYWAZopx1AFdAFDtay1XtyBafBVy9wi2S8TjaalsWS4h
         hPZSNzkbTH70JGv8GWYiHutUZioeZ91hYdIXAc82z66+FE679p5Agg05Ne3IHzRM+mxh
         TUcw==
X-Gm-Message-State: AGi0PuYsdc+wPfz5Yf+QRrnRnJWAtBUsvjLj7z03/864nqxFcDkJCx1n
        vbLqpWp5zfg4HrINT1kD7FLOXh7ag4+AupJMuxYlxQ==
X-Google-Smtp-Source: APiQypJYFbdoctpq7gPgdilZR2mhzYaNNUpeyPOmIFI5tHwJzxXJHkshSlEFWLWaHPMYKeLP9csZ0IQAm1NqTgesAfI=
X-Received: by 2002:a4a:4c8d:: with SMTP id a135mr24835704oob.36.1587003483373;
 Wed, 15 Apr 2020 19:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home> <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home> <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home> <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home> <20200415220459.GE17661@paulmck-ThinkPad-P72>
 <20200415185121.381a4bc3@gandalf.local.home> <CALAqxLX2UDQ7=dvzMoP6g-rYzw9dBebrynMfo4Gnv=SzaqhE=g@mail.gmail.com>
 <20200415204827.24f2c548@oasis.local.home>
In-Reply-To: <20200415204827.24f2c548@oasis.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 19:17:52 -0700
Message-ID: <CALAqxLVdRp4Kc4rV2m9huQVRszdkgjRW09ghh3n2EA1ods-U3Q@mail.gmail.com>
Subject: Re: On trace_*_rcuidle functions in modules
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 5:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Apr 2020 17:06:24 -0700
> John Stultz <john.stultz@linaro.org> wrote:
>
> > So you're saying the recent change to move to using trace_*_rcuidle()
> > was unnecessary?
> >
> > Or is there a different notifier then cpu_pm_register_notifier() that
> > the driver should be using (that one seems to be using
> > atomic_notifier_chain_register())?
>
> From looking at the trace event in __tcs_buffer_write() in
> drivers/soc/qcom/rpmh-rsc.c, the _rcuidle() was added by:
>
> efde2659b0fe8 ("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh")
>
> Which shows a backtrace dump of:
>
>      Call trace:
>       dump_backtrace+0x0/0x174
>       show_stack+0x20/0x2c
>       dump_stack+0xc8/0x124
>       lockdep_rcu_suspicious+0xe4/0x104
>       __tcs_buffer_write+0x230/0x2d0
>       rpmh_rsc_write_ctrl_data+0x210/0x270
>       rpmh_flush+0x84/0x24c
>       rpmh_domain_power_off+0x78/0x98
>       _genpd_power_off+0x40/0xc0
>       genpd_power_off+0x168/0x208
>       genpd_power_off+0x1e0/0x208
>       genpd_power_off+0x1e0/0x208
>       genpd_runtime_suspend+0x1ac/0x220
>       __rpm_callback+0x70/0xfc
>       rpm_callback+0x34/0x8c
>       rpm_suspend+0x218/0x4a4
>       __pm_runtime_suspend+0x88/0xac
>       psci_enter_domain_idle_state+0x3c/0xb4
>       cpuidle_enter_state+0xb8/0x284
>       cpuidle_enter+0x38/0x4c
>       call_cpuidle+0x3c/0x68
>       do_idle+0x194/0x260
>       cpu_startup_entry+0x24/0x28
>       secondary_start_kernel+0x150/0x15c
>
>
> There's no notifier that calls this. This is called by the rpm_callback
> logic. Perhaps that callback will require a call to rcu_irq_enter()
> before calling the callback.

Yea. Sorry, its extra confusing as the call stack there includes
patches who's equivalents are only now in -next (I myself managed to
confuse what was upstream vs in -next in this thread and suddenly
couldn't find the code I had described - apologies).

See:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/soc/qcom/rpmh-rsc.c?h=next-20200415#n795

> In any case, I think it is wrong that these callbacks are called
> without RCU watching. The _rcuidle() on that tracepoint should be
> removed, and we fix the code that gets there to ensure that RCU is
> enabled. I agree with Peter, that no module code should be executed
> without RCU watching.

For sanity sake, it seems like the rule should be we avoid driver code
executing without RCU watching. The fact of if it's a loadable module
or not is super subtle, and likely that more folks will trip over it.

But ok. I'll follow around to understand if the commit efde2659b0fe8
("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh") is
actually necessary and see what would be needed to revert it.

thanks
-john
