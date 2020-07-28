Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC1AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37E1C206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjxDG1Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgG1OtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbgG1Os7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:48:59 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770EBC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:48:59 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 4so4142004vsf.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=240RUtdc08bBCjS0T5ABRYM5kPew5EtFraMIJ4mwkAU=;
        b=FjxDG1XpayNcd4EmXIjEfVT6GArnbrZGwdT6C+WsUm6JuJjLk7qxvLB1XoXAIw5Eap
         YLSQ+yBEXlmtkEviS04Z9Vwd0lQe+xMOhO/yE7b45SZ77tPDJGctmvm8yzVd+tTmPIF2
         AXvUj9cUMgB9HJhAlDpg5AevYDXkD6kFXFdjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=240RUtdc08bBCjS0T5ABRYM5kPew5EtFraMIJ4mwkAU=;
        b=UXJvogM3Y/gALnzjtsS2TluOj96/VqGNywCv1y2HfNeytPnLLyweDgFS1n61qazfXc
         pqZZJm1IZncK6Nzw0hB9shsbo9eXQA/x/bnjzhv115nXMzNEMD8JQsn/kM35v8f5gryG
         /BY5Uw8w8VSzOgqwabR8YyjlUQ5qqeVq56a6jAVeAcx+mEBKXE9uTn/O49/qtZztrYWn
         It/HbzHnJRLFWZpehNptszO2GirtLXE1R1KN4mZFkXb+5sVDyqt4v1JEIEItjASE2Xvw
         DQaoG2r2xwksGmukVyWsbDQJYYoWpRj6jBEe+gziPqlMTRaUK3l7FDqZLJ815nvzJTv+
         tnmQ==
X-Gm-Message-State: AOAM5331M35VAdEyWlIURDPjn2hPIPUcDgThjURGu8r9DbNc/3yg5E6i
        abOY1HBxG2BWF2HEh+NcFzlbUL4S+H4=
X-Google-Smtp-Source: ABdhPJzZZQRYGv8LffOojx+W9G5s61tgmN9jbPvzi3c8YI1dL0SEsYLKVRKC3RRbmZlLpdsg67EYpg==
X-Received: by 2002:a67:fd53:: with SMTP id g19mr21532221vsr.187.1595947737853;
        Tue, 28 Jul 2020 07:48:57 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id k12sm3128728vsb.10.2020.07.28.07.48.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 07:48:56 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id 4so4141918vsf.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:48:56 -0700 (PDT)
X-Received: by 2002:a67:69c1:: with SMTP id e184mr21296483vsc.119.1595947735977;
 Tue, 28 Jul 2020 07:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200724211711.810009-1-sboyd@kernel.org> <fb6fbaa9-63d9-e747-906c-335c8be934f3@linaro.org>
In-Reply-To: <fb6fbaa9-63d9-e747-906c-335c8be934f3@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 28 Jul 2020 07:48:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNw45=NGm9Qj4_Kyq9oQMF6zFaaWz33dfqqDC0A-fF+Q@mail.gmail.com>
Message-ID: <CAD=FV=XNw45=NGm9Qj4_Kyq9oQMF6zFaaWz33dfqqDC0A-fF+Q@mail.gmail.com>
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 26, 2020 at 2:44 AM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Stephen,
>
> On 7/25/20 12:17 AM, Stephen Boyd wrote:
> > From: Stephen Boyd <swboyd@chromium.org>
> >
> > The busy loop in rpmh_rsc_send_data() is written with the assumption
> > that the udelay will be preempted by the tcs_tx_done() irq handler when
> > the TCS slots are all full. This doesn't hold true when the calling
> > thread is an irqthread and the tcs_tx_done() irq is also an irqthread.
> > That's because kernel irqthreads are SCHED_FIFO and thus need to
> > voluntarily give up priority by calling into the scheduler so that other
> > threads can run.
> >
> > I see RCU stalls when I boot with irqthreads on the kernel commandline
> > because the modem remoteproc driver is trying to send an rpmh async
> > message from an irqthread that needs to give up the CPU for the rpmh
> > irqthread to run and clear out tcs slots.
> >
> >  rcu: INFO: rcu_preempt self-detected stall on CPU
> >  rcu:     0-....: (1 GPs behind) idle=402/1/0x4000000000000002 softirq=2108/2109 fqs=4920
> >   (t=21016 jiffies g=2933 q=590)
> >  Task dump for CPU 0:
> >  irq/11-smp2p    R  running task        0   148      2 0x00000028
> >  Call trace:
> >   dump_backtrace+0x0/0x154
> >   show_stack+0x20/0x2c
> >   sched_show_task+0xfc/0x108
> >   dump_cpu_task+0x44/0x50
> >   rcu_dump_cpu_stacks+0xa4/0xf8
> >   rcu_sched_clock_irq+0x7dc/0xaa8
> >   update_process_times+0x30/0x54
> >   tick_sched_handle+0x50/0x64
> >   tick_sched_timer+0x4c/0x8c
> >   __hrtimer_run_queues+0x21c/0x36c
> >   hrtimer_interrupt+0xf0/0x22c
> >   arch_timer_handler_phys+0x40/0x50
> >   handle_percpu_devid_irq+0x114/0x25c
> >   __handle_domain_irq+0x84/0xc4
> >   gic_handle_irq+0xd0/0x178
> >   el1_irq+0xbc/0x180
> >   save_return_addr+0x18/0x28
> >   return_address+0x54/0x88
> >   preempt_count_sub+0x40/0x88
> >   _raw_spin_unlock_irqrestore+0x4c/0x6c
> >   ___ratelimit+0xd0/0x128
> >   rpmh_rsc_send_data+0x24c/0x378
> >   __rpmh_write+0x1b0/0x208
> >   rpmh_write_async+0x90/0xbc
> >   rpmhpd_send_corner+0x60/0x8c
> >   rpmhpd_aggregate_corner+0x8c/0x124
> >   rpmhpd_set_performance_state+0x8c/0xbc
> >   _genpd_set_performance_state+0xdc/0x1b8
> >   dev_pm_genpd_set_performance_state+0xb8/0xf8
> >   q6v5_pds_disable+0x34/0x60 [qcom_q6v5_mss]
> >   qcom_msa_handover+0x38/0x44 [qcom_q6v5_mss]
> >   q6v5_handover_interrupt+0x24/0x3c [qcom_q6v5]
> >   handle_nested_irq+0xd0/0x138
> >   qcom_smp2p_intr+0x188/0x200
> >   irq_thread_fn+0x2c/0x70
> >   irq_thread+0xfc/0x14c
> >   kthread+0x11c/0x12c
> >   ret_from_fork+0x10/0x18
> >
> > This busy loop naturally lends itself to using a wait queue so that each
> > thread that tries to send a message will sleep waiting on the waitqueue
> > and only be woken up when a free slot is available. This should make
> > things more predictable too because the scheduler will be able to sleep
> > tasks that are waiting on a free tcs instead of the busy loop we
> > currently have today.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Maulik Shah <mkshah@codeaurora.org>
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Changes in v2:
> >  * Document tcs_wait
> >  * Move wake_up() outside of the spinlock
> >  * Document claim_tcs_for_req()
> >
> >  drivers/soc/qcom/rpmh-internal.h |   4 ++
> >  drivers/soc/qcom/rpmh-rsc.c      | 115 +++++++++++++++----------------
> >  2 files changed, 58 insertions(+), 61 deletions(-)
>
> This also fixes an issue related to TCS busy, seen with Venus driver
> with these [1] patches applied.
>
> Tested-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>
> --
> regards,
> Stan
>
> [1] https://lkml.org/lkml/2020/7/23/394

It worries me that you say that this fixes any issues for you.
Specifically I don't see how this could fix anything except:

1. Fix the problem with irqthreads, which is how Stephen originally found this.

2. Fix things to be a little more efficient.

3. Avoid the small handful of messages that show up during normal
usage that look like:

  TCS Busy, retrying RPMH message send: addr=...

I'm guessing you're referring to #3.  Is that correct?

If so, you might want to double-check to confirm that you aren't
totally spamming the RPMh bus with your patch series.  I found that
when I was seeing a lot of "TCS Busy, retrying RPMH message send"
spammed to the console that it was a sign that the code was being
really inefficient.

Specifically the code to add interconnect bandwidth and OPP to the SPI
drivers would run at "runtime_suspend" and "runtime_resume".  For our
SPI drivers this meant that they were running after every single
transfer, and they were quite slow.  If your code is doing similar
then you probably have a problem.

The problem was fixed by adding an autosuspend delay.

References (from linuxnext):

8592eb959ad4 spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms
cfdab2cd85ec spi: spi-geni-qcom: Set an autosuspend delay of 250 ms


Also if your code is adjusting its clock rate too frequently it can
now trigger similar problems.  References:

2124331411a1 spi: spi-qcom-qspi: Avoid clock setting if not needed
5f219524ec6e spi: spi-geni-qcom: Set the clock properly at runtime resume
68890e20942b spi: spi-geni-qcom: Avoid clock setting if not needed


-Doug
