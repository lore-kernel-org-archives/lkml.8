Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F90208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJJKZYxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2FU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2FU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:20:58 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FD6C08C5C6;
        Thu, 28 May 2020 22:20:58 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s18so1062971ioe.2;
        Thu, 28 May 2020 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FRaDrc5qz+mseHMlNzBSOFhiGghRU0iO/EhV7LPJuU=;
        b=GJJKZYxVHCH5bW6x56Yo74MnId1xrFUUc3UmH5g2M3qAivCM+RQe+swZImGjpdAVCq
         UFypP91Hgfqr6oZmZeyreJuS5DJt5K8rjKKFAlv/rrRBJMb2tUZSS2nWM3ruFje090JD
         yZpgK9TXj6kM0Zl+HLtz6/jSz7Q7zM8DrsqzMVWvAk2HUUddsjZcITd6urhR+GVyP+yT
         KorOBXnhTWxaR2V2gg68Qx97OwbvdCYe3WLoRirK2ajf/W3hhGQ2HEZ3tlPeTIfDm0Bw
         aPlvv0fE6k9ioEvtiA3h0Y8ArRTs8iiVJ1Ybw1Ki1BVhW3LrMegngwHZvS65+sp2Tjmm
         FBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FRaDrc5qz+mseHMlNzBSOFhiGghRU0iO/EhV7LPJuU=;
        b=ufdFKj78n+rCYkLHkPL17SXC2zSjzZyCnmKEOFyPBnBEGJNw9M0NhQW3tXcW1PC6tk
         1nBbooccZbxy6TDwdOqrPvzGJ/fU6gThKVJpzcQ5oq0G8fQKt/rD4jd4gE1HCmw5k4ei
         s1LbUKd/Ekl6lStjI86+BOW/ZA+0nHo8NaWnxN5LLqaw3O+r8MKFEIcAUeHWar3LUKte
         yo0DHvWRkxXre1xVcy+2R3MmDoCdQ2odHOimiOokzGiPvtrKO2Lx7m2K++tpXjEtfCYU
         4S8nzYdL//TvNcHXxMmGCMlw0qH7zsgZho1NbJvnldTk+N6kaRxM1fM2MSyJNwltk0yX
         W2YQ==
X-Gm-Message-State: AOAM532FuDcKt10WzuspdIlZiBITq4MeePBGImy/fby/ZQhBxicc9+PF
        xYwHrizBi9UtRAfZURNgx8rtVYpYDMhfZNy3XrI=
X-Google-Smtp-Source: ABdhPJwpLR9vQ2rVi/CapN4MpHNoVLQqwn3WAX5tBeoFVkwdP02qpFUGDn7gL7fN/jnoCUUHYsZqZrKhBwcWmJBctSA=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr5045727iov.80.1590729657804;
 Thu, 28 May 2020 22:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
In-Reply-To: <20200528192005.GA494874@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 29 May 2020 00:20:46 -0500
Message-ID: <CABb+yY3KKpDHTsTBescW_rXmqmLzJh-Ogaotk2n=nYRkfHy2cg@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 2:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, May 15, 2020 at 10:47:38AM +0530, Viresh Kumar wrote:
> > From: Sudeep Holla <sudeep.holla@arm.com>
> >
> > Hi Rob, Arnd and Jassi,
> >
> > This stuff has been doing rounds on the mailing list since several years
> > now with no agreed conclusion by all the parties. And here is another
> > attempt to get some feedback from everyone involved to close this once
> > and for ever. Your comments will very much be appreciated.
> >
> > The ARM MHU is defined here in the TRM [1] for your reference, which
> > states following:
> >
> >       "The MHU drives the signal using a 32-bit register, with all 32
> >       bits logically ORed together. The MHU provides a set of
> >       registers to enable software to set, clear, and check the status
> >       of each of the bits of this register independently.  The use of
> >       32 bits for each interrupt line enables software to provide more
> >       information about the source of the interrupt. For example, each
> >       bit of the register can be associated with a type of event that
> >       can contribute to raising the interrupt."
> >
> > On few other platforms, like qcom, similar doorbell mechanism is present
> > with separate interrupt for each of the bits (that's how I understood
> > it), while in case of ARM MHU, there is a single interrupt line for all
> > the 32 bits. Also in case of ARM MHU, these registers and interrupts
> > have 3 copies for different priority levels, i.e. low priority
> > non-secure, high priority non-secure and secure channels.
> >
> > For ARM MHU, both the dt bindings and the Linux driver support 3
> > channels for the different priorities right now and support sending a 32
> > bit data on every transfer in a locked fashion, i.e. only one transfer
> > can be done at once and the other have to wait for it to finish first.
> >
> > Here are the point of view of the parties involved on this subject:
> >
> > Jassi's viewpoint:
> >
> > - Virtualization of channels should be discouraged in software based on
> >   specific usecases of the application. This may invite other mailbox
> >   driver authors to ask for doing virtualization in their drivers.
> >
> > - In mailbox's terminology, every channel is equivalent to a signal,
> >   since there is only one signal generated here by the MHU, there should
> >   be only one channel per priority level.
> >
> > - The clients should send data (of just setting 1 bit or many in the 32
> >   bit word) using the existing mechanism as the delays due to
> >   serialization shouldn't be significant anyway.
> >
> > - The driver supports 90% of the users with the current implementation
> >   and it shouldn't be extended to support doorbell and implement two
> >   different modes by changing value of #mbox-cells field in bindings.
> >
> > Sudeep (ARM) and myself as well to some extent:
> >
> > - The hardware gives us the capability to write the register in
> >   parallel, i.e. we can write 0x800 and 0x400 together without any
> >   software locks, and so these 32 bits should be considered as separate
> >   channel even if only one interrupt is issued by the hardware finally.
> >   This shouldn't be called as virtualization of the channels, as the
> >   hardware supports this (as clearly mentioned in the TRM) and it takes
> >   care of handling the signal properly.
> >
> > - With serialization, if we use only one channel as today at every
> >   priority, if there are 5 requests to send signal to the receiver and
> >   the dvfs request is the last one in queue (which may be called from
> >   scheduler's hot path with fast switching), it unnecessarily needs to
> >   wait for the first four transfers to finish due to the software
> >   locking imposed by the mailbox framework. This adds additional delay,
> >   maybe of few ms only, which isn't required by the hardware but just by
> >   the software and few ms can be important in scheduler's hotpath.
> >
> > - With the current approach it isn't possible to assign different bits
> >   (or doorbell numbers) to clients from DT and the only way of doing
> >   that without adding new bindings is by extending #mbox-cells to accept
> >   a value of 2 as done in this patch.
> >
> > Jassi and Sudeep, I hope I was able to represent both the view points
> > properly here. Please correct me if I have made a mistake here.
> >
> > This is it. It would be nice to get the views of everyone now on this
> > and how should this be handled.
>
> I am perfectly fine with adding another cell which seems appropriate
> here. You can have 5 cells for all I care if that makes sense for
> the h/w. That has nothing to do with the Linux design. Whether Linux
> requires serializing mailbox accesses is a separate issue. On that side,
> it seems silly to not allow driving the h/w in the most efficient way
> possible.
>
The fact that all these bits are backed by one physical signal makes
the firmware implement its own mux-demux'ing scheme. So the choice was
between demux and single signal at a time. Had there been one signal
per bit, the implementation would have definitely been 'efficient'.

And the first platform the driver was developed on, required message
passing over the registers. So now my approach is to make do with what
we have...unless it shows in numbers.

Anyways, if it comes to that, I'd rather a separate "doorbell' driver
than a driver working in two s/w modes.

Thanks.
