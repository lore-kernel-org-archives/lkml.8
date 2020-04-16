Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A763C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7ED206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAzFjLaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404660AbgDPBCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390560AbgDPBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:02:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772FC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:02:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g2so723989plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UQrhSEDM58XydjofCn22z7WL3fCANffkSo3mRa4+HQ=;
        b=HAzFjLaLrkIPyyIdYV+vho0vnJ9xStnAScdbk/jA7fimFxKZNF5bcGp0yFg9zBHJ26
         hqh8F6Yy4v/HfW4veL8mQigE2LgtdYUr9cPJfg+kh3YhTQIKjxv4dFIGmyfyooteMHJG
         z8bcArnqfMwu2/o9YvW7fzfaGHEJsxHCAL7XGy7pougtkTkL1udAwfE3MCWeDW7cNpVl
         xI5Iwida46XP1GT/yNaqg1GUQ9tCaipms4gU/tDWFAIbSS+t2zAv/3WSlo15v8Ot7tDS
         G3vrsQLIKLrv2zB3J/3hSUXfGlXLabT81TcFwbj998HyLGlidF4P4ZIxJwGZViUyvios
         2PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UQrhSEDM58XydjofCn22z7WL3fCANffkSo3mRa4+HQ=;
        b=c5IPIvI1hB/JDjL0h2zFTU4CKwRa682fCou+4vICmkEPi5tr4Bo9BaWr8dn5O9I7iz
         lSV1cp9I4s+mY+KFpMLL87B2s0GEyON//Vr3WAwROl1DbITQN1f9+0qEeFu4jgZoHnIJ
         T8ixDCBim2aZn4GWMefP5EodYgk6cocFo1PKfQtLAQury0ZbaTNNN7RHl2c5DPw6p43e
         0jCRyQVOtai0bvRCaetJhTdHv/qtKgd2W6IB/uJ9+rE8p7trXJx6aSj7wlpmDEZkm8WK
         Ix62FUyAia80+QBCmkEy1XWBC4aTLrjFMwYiQoK3lNrMqjoK6cTmosV3GHtAzrzDtBK7
         sBRg==
X-Gm-Message-State: AGi0PuZKpJRcfp2dhvAOdqLl7Wx1tI/Ja250+V02YE2xeUcdaecKlBL+
        B0kwQ0Bu0BVWCU/Ch39y6GSbCA==
X-Google-Smtp-Source: APiQypJeos+C/0GkWzwCb9fo26gxqG5e88azbaJINvDM05szttN5/IIFNzsJYJfIT0pPaqfrzkjASQ==
X-Received: by 2002:a17:902:507:: with SMTP id 7mr7564825plf.42.1586998962351;
        Wed, 15 Apr 2020 18:02:42 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o125sm13705278pgo.74.2020.04.15.18.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:02:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:02:58 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200416010258.GM20625@builder.lan>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415204827.24f2c548@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15 Apr 17:48 PDT 2020, Steven Rostedt wrote:

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
> 
> In any case, I think it is wrong that these callbacks are called
> without RCU watching. The _rcuidle() on that tracepoint should be
> removed, and we fix the code that gets there to ensure that RCU is
> enabled. I agree with Peter, that no module code should be executed
> without RCU watching.
> 

Forgive me, but how is this problem related to the fact that the code is
dynamically loaded, i.e. encapsulated in a module?

Per the example earlier in this thread, the thing we're worried about is
a use after free in the following scenario, right?

        cpu_pm_unregister_notifier(my_notifier);
	kfree(my_data);

But a driver implementing this snippet might do this regardless of being
builtin or module and afaict exiting probe() unsuccessfully or unbinding
the device would risk triggering this issue?

Regards,
Bjorn
