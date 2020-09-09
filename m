Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4DDC2BC11
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5963220EDD
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpuoPU5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIIDXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIIDXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:23:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F7C061573;
        Tue,  8 Sep 2020 20:23:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so1622614iop.13;
        Tue, 08 Sep 2020 20:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dohfYOPT1w8LaajeId5b+WZGeRkliT8iJzLJLSo5yz8=;
        b=IpuoPU5zFbVJz8YL5vL0yE/ow5m1KAitLB0F5X0O9xDjzkKmRLg9UbvvEMr5D2NNYH
         onarrFVKfShcNjVRxh6fosZ5HoUk0hXCYj+Q8GOq54vE5EIvWMIHOckp4zLDcY0RnA0H
         7prI2BMRhJWDoaLoEjTOlihc+8994MClUmm8xFfr4C+C2QhF78nNdqfHcxILo/18Hf2V
         0eYgzvy7nyVoOJNUq/GCqcw3F/4sS+zhbovzwTR5IOehzD6dtIlKnD5c/+JTuFj7BUIp
         PgUKr0uzoBk1T/hqEU4TKBwHf91yZ5C+eRpiTha9MOkXSn1KK963eyFd8t2CPwIMG8+D
         zGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dohfYOPT1w8LaajeId5b+WZGeRkliT8iJzLJLSo5yz8=;
        b=b52ebTxmFju8hT4z7ZBHwkEkaKw+7VpIC+SAtflXEkeiLkUpVFwvCKGjiuHhvEmuHO
         VNtU6OqCAtAGcD+/hp0kIfNDOe5rqJ0wxaDt1A24v36i4gU64cMSmXBdWuCF9O1Rxfwj
         xfzg/KHB4rIKxPG81iSN3CyX5ZkQbppX37q7rAK98Pz/hc4UlI4ccNQAvOphuMFh/i0M
         jKDYEIJnPXJHmqG5dgImnJg9bB3b0t1E0ShFfj5CVrAsKKysPfKPcvLzKqDxnlOQnuxU
         +qreDN6385hI1z+mjAVx1fSPLbpxpvc7s9kEc0KtDfTIP1KWp79Z4ANksyRWjVIVuxc4
         K2TA==
X-Gm-Message-State: AOAM533nH2YnA5ihvcsft6Dlg5AxXruZM0WMysTIYEG9D2I5a3ASeJ2m
        TFrR7IZmGPfk1jgHorpHDxMtVAU8Klzap2g9Uh8=
X-Google-Smtp-Source: ABdhPJxEXcPBee+a8a7mJsXSL+Kkq/mgwmlIklvqSzRVycluakfkknqbt4icBUfap4qzh9jWLq3nSAu04uemnh41MUg=
X-Received: by 2002:a05:6638:d0b:: with SMTP id q11mr2105403jaj.68.1599621824881;
 Tue, 08 Sep 2020 20:23:44 -0700 (PDT)
MIME-Version: 1.0
References: <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus> <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus> <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus> <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7> <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
 <20200612052853.nds4iycie6ldjnnr@vireshk-i7> <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
In-Reply-To: <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 8 Sep 2020 22:23:33 -0500
Message-ID: <CABb+yY3HDs219C8Wcc+CJRLukV4OvCKhqevU-9jN4bCU6SC3rQ@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 4:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Picking up the old thread again after and getting pinged by multiple
> colleagues about it (thanks!) reading through the history.
>
> On Fri, Jun 12, 2020 at 7:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 11-06-20, 19:34, Jassi Brar wrote:
> > > In the first post in this thread, Viresh lamented that mailbox
> > > introduces "a few ms" delay in the scheduler path.
> > > Your own tests show that is certainly not the case -- average is the
> > > same as proposed virtual channels 50-100us, the best case is 3us vs
> > > 53us for virtual channels.
> >
> > Hmmm, I am not sure where is the confusion here Jassi. There are two
> > things which are very very different from each other.
> >
> > - Time taken by the mailbox framework (and remote for acknowledging
> >   it) for completion of a single request, this can be 3us to 100s of
> >   us. This is clear for everyone. THIS IS NOT THE PROBLEM.
> >
> > - Delay introduced by few of such requests on the last one, i.e. 5
> >   normal requests followed by an important one (like DVFS), the last
> >   one needs to wait for the first 5 to finish first. THIS IS THE
> >   PROBLEM.
>
> Earlier, Jassi also commented "Linux does not provide real-time
> guarantees", which to me is what actually causes the issue here:
>
> Linux having timeouts when communicating to the firmware means
> that it relies on the hardware and firmware having real-time behavior
> even when not providing real-time guarantees to its processes.
>
The timeout used in SCMI is simply based on how long the Juno (?)
platform takes to reply in most cases.
Talking proper code-design, the timeout (if at all) shouldn't even be
a hardcoded value, but instead taken from the platform.

> When comparing the two usage models, it's clear that the minimum
> latency for a message delivery is always at least the time time
> to process an interrupt, plus at least one expensive MMIO read
> and one less expensive posted MMIO write for an Ack. If we
> have a doorbell plus out-of-band message, we need an extra
> DMA barrier and a read from coherent memory, both of which can
> be noticeable. As soon as messages are queued in the current
> model, the maximum latency increases by a potentially unbounded
> number of round-trips, while in the doorbell model that problem
> does not exist, so I agree that we need to handle both modes
> in the kernel deal with all existing hardware as well as firmware
> that requires low-latency communication.
>
From the test case Sudeep last shared, the scmi usage on mhu doesn't
not even hit any bottleneck ... the test "failed" because of the too
small hardcoded timeout value. Otherwise the current code actually
shows better numbers.
We need some synthetic tests to bring the limitation to the surface. I
agree that there may be such a test case, however fictitious. For that
reason, I am ok with the doorbell mode.

> The only questions that I see in need of being answered are:
>
> 1. Should the binding use just different "#mbox-cells" values or
>    also different "compatible" strings to tell that difference?
> 2. Should one driver try to handle both modes or should there
>    be two drivers?
>
> It sounds like Jassi strongly prefers separate drivers, which
> would make separate compatible strings the more practical
> approach. While the argument can be made that a single
> piece of hardware should only have one DT description,
> the counter-argument would be that the behavior described
> by the DT here is made up by both the hardware and the
> firmware behind it, and they are in fact different.
>
I totally agree with one compat-string for one hardware. However, as
you said, unlike other device classes, the mailbox driver runs the
sumtotal of hardware and the remote firmware behaviour. Also the
implementations wouldn't share much, so I think a separate file+dt
will be better.  But I wanna get rid of this toothache that flares up
every season, so whatever.

Cheers!
