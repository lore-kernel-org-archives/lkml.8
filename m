Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C62C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA21820823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIrhYQ/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFEGbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:31:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C0C08C5C2;
        Thu,  4 Jun 2020 23:31:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id o5so9046758iow.8;
        Thu, 04 Jun 2020 23:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AwDhq08cjD5JqZTeO0Y9UdSU2XkQsUbpJ8EXCL/HMHE=;
        b=hIrhYQ/Ib+LMc/lM8TkkboBA43CJMvk8zLm4ZNrhrhhPe44AThnqI1MtOmXnBLUo6b
         W91iiSy/AvYKOUOfr5GNwDxO1RwGoglhDLE+fWDlIP53CSNTE0YwTQxk+1wK2sTtzLR8
         Krxss4eKSQo8FWkgEAaXX8heaJnqfCIJNY7rVT2Wt9GpTGcz5L5Q4yMgkHr84bdLs8gu
         gNOz6oy6QOtm6JuIVM2hBvCf6+8hrK2mNd2SMrY74C24UAzF9z85HCwp4pb7r+/rmyUW
         1XDRD+nIE8Ik1NuLKByDtAHKujMdUKMsNwylY39JqoW5nGa6gkn8lylg5AeirjcRmRAw
         QjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AwDhq08cjD5JqZTeO0Y9UdSU2XkQsUbpJ8EXCL/HMHE=;
        b=l6XpFN5oxMkld0/HjgriP9cc9Zo4io9SPkHITPWPTdh4PbBzh0qQEegnetmo+CWMS7
         V4AJkHL6rktbaNUemDxlcF/LlPUhHmJI6fEE/FFoh/KK93Nm/HkrS3qcl7GOxk425zhH
         kRxOkoLbMW2t1u+5BzLg+MfufpFT1u/6Jo5cVAVWklbwZRbtt+A58HdrRSLmST268eBy
         Ud1K7qtnWy6CYHUT8L1uxAZ9fJuZ4v0t6g3zvq4mM0DJhyKzyZOkhSvX6fOLxGzLhDZM
         tj198RvoH6hN9w0eHOPzhRQLJOD1iCSqHzVqLO5XXjAZoUIM3Lpunqh8ytxCUJs8eLuL
         hP4w==
X-Gm-Message-State: AOAM531zzADrY2wI5Xt3BPL+sVQPb2pMB9yzIvBEGqRdFPMxQGL6QdOt
        LW0KCedQLgnoUrTlJKXH+Dg9jptkJIRH6pxxOg0=
X-Google-Smtp-Source: ABdhPJwfxG2xuH353FOlKdoATjIRdV+1mkAMbDgGbPrRb2tsKonvfuPWxT4EOWzLvMycv3HDOoS7PqnFNKbNhrJLhKI=
X-Received: by 2002:a5d:8958:: with SMTP id b24mr7266854iot.53.1591338665743;
 Thu, 04 Jun 2020 23:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus> <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus> <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus> <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
In-Reply-To: <20200605045645.GD12397@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 5 Jun 2020 01:30:54 -0500
Message-ID: <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Jun 4, 2020 at 11:56 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

>
> > >>     bash-1526  [000]  1149.472553: scmi_xfer_begin:      transfer_id=1538 msg_id=6 protocol_id=21 seq=0 poll=0
> > >>      <idle>-0     [001]  1149.472733: scmi_xfer_begin:      transfer_id=1539 msg_id=7 protocol_id=19 seq=1 poll=1
> > >
> > Here another request is started before the first is finished.
>
> Ah, the prints are when the client requested. It is not when the mailbox
> started it. So this just indicates the beginning of the transfer from the
> client.
>
There maybe condition on a sensor read to finish within 1ms, but there
is no condition for the read to _start_ at this very moment (usually
there are sleeps in the path to sensor requests).

> > If you want this to work you have to serialise access to the single
> > physical channel and/or run the remote firmware in asynchronous mode -
> > that is, the firmware ack the bit as soon as it sees and starts
> > working in the background, so that we return in ~3usec always, while
> > the data returns whenever it is ready.
>
> Yes it does that for few requests like DVFS while it uses synchronous
> mode for few others. While ideally I agree everything in asynchronous
> most is better, I don't know there may be reasons for such design.
>
The reason is that, if the firmware works asynchronously, every call
would return in ~3usec and you won't think you need virtual channels.

You have shared only 'bad' log without serialising access. Please
share log after serialising access to the channel and the 'good' log
with virtual channels.  That should put the topic to rest.

thanks.
