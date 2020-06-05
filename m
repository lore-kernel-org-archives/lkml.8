Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBC3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2222074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkFNdaGS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEPnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgFEPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:43:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05314C08C5C2;
        Fri,  5 Jun 2020 08:43:07 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l6so10061134ilo.2;
        Fri, 05 Jun 2020 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2GB2U7+brpU97z7quDVcgXAtK4rM5dz6gG/Wy3Olog=;
        b=HkFNdaGSceLzbEKT8WldzvKrDeIBzoGGsKRPbyGQrKzhnWdYN2yeXulRIa/JJ8HUEr
         CFoSm/iRg7jQHZ2V/ngd+jE8nj9KOUxe5CNBw9JUkE1fHNfxD069FCGB4RfVCjEvNsWh
         PjSOLaP/dRj/yR6/NBAERl/1/3eo/0/lJw0A0OWZtSbdUB70ZfDMpbuT6zn7FIpi/B5Y
         lg1IaEvHJJ8TIW2pLpfA1H2ACK2cPLfo2Qg1f6e02cs88tId5vsuQ48t3JoACPMTtfVt
         64GxYPEisVuelP9nLvlZm2OafdGRadzYJ0Ndr+YJ/8WFcKHvGkXOMCW8tELOnijN5WhA
         dY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2GB2U7+brpU97z7quDVcgXAtK4rM5dz6gG/Wy3Olog=;
        b=U/30kHikC1glc75jrxj6htBiPEMcGNjoQ78Y17oQ42X0zwCuQw+REE5mZQNgjag4Wu
         NkgPJFQW6fhYP1cjAaGYtvfuI54slhy95I3NS72rXjwnmONZ2I9a00ilezP4lB8tcU4B
         MU1FlumbxYMpFsmxXo81gw0mLQPdNtV6nV2zPBbepvcHaaF2GB+LpxweD6qhhFiW3uTt
         ar1QNJ522faPaEXvhZKSV1LDq5rtNn00tCXax7yL9Ox+4J8V4oEe1gltU4CRhCeSM09g
         5oC1hjHvIV/w/pqv+v+8HADw/n/5Mkv4pkLzNfmvp4BddLMCqPCGU8et7fpr4wZSHiA5
         /o4g==
X-Gm-Message-State: AOAM5312vKoha9tk5tY01osRgLD4PaT+CUCEKv8rOuHTjbV/63JoxULt
        qvk3QrxwVkLrk9voY84xojjuVU7gmbvvenKtOqI=
X-Google-Smtp-Source: ABdhPJzJW5O3DzxX9JUEp0Fq7vO1ZexlwSsEZ5rkVUXSutg5q4mvTIgBUytu0r9dtgLLVLmvp7RCv3/Wi3VyOKOvz8I=
X-Received: by 2002:a92:5e52:: with SMTP id s79mr8217845ilb.33.1591371785844;
 Fri, 05 Jun 2020 08:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus> <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus> <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus> <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus> <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
In-Reply-To: <20200605085830.GA32372@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 5 Jun 2020 10:42:54 -0500
Message-ID: <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
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

On Fri, Jun 5, 2020 at 3:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > > > >>     bash-1526  [000]  1149.472553: scmi_xfer_begin:      transfer_id=1538 msg_id=6 protocol_id=21 seq=0 poll=0
> > > > >>      <idle>-0     [001]  1149.472733: scmi_xfer_begin:      transfer_id=1539 msg_id=7 protocol_id=19 seq=1 poll=1
> > > > >
> > > > Here another request is started before the first is finished.
> > >
> > > Ah, the prints are when the client requested. It is not when the mailbox
> > > started it. So this just indicates the beginning of the transfer from the
> > > client.
> > >
> > There maybe condition on a sensor read to finish within 1ms, but there
> > is no condition for the read to _start_ at this very moment (usually
> > there are sleeps in the path to sensor requests).
> >
>
> Again I wasn't clear. The trace logs are at the point just before calling
> mbox_send_messages. So any delay in sensor drivers won't get include. It
> is after the point sensor driver request to read the value and before we
> send the request via mailbox.
>
No, you were clear, I wasn't. Let me try again.

Since origin upto scmi_xfer, there can be many forms of sleep like
schedule/mutexlock etc.... think of some userspace triggering sensor
or dvfs operation. Linux does not provide real-time guarantees. Even
if remote (scmi) firmware guarantee RT response, it makes sense to
timeout a response only after the _request is on the bus_  and not
when you submit a request to the api (unless you serialise it).
IOW, start the timeout from  mbox_client.tx_prepare()  when the
message actually gets on the bus.


> > You have shared only 'bad' log without serialising access. Please
> > share log after serialising access to the channel and the 'good' log
> > with virtual channels.  That should put the topic to rest.
> >
>
> I didn't realise that, sorry for missing that earlier. Attached both
> now, thanks for asking.
>
Interesting logs !  The time taken to complete _successful_ requests
are arguably better in bad_trace ... there are many <10usec responses
in bad_trace, while the fastest response in good_trace is  53usec.
And the requests that 'fail/timeout' are purely the result of not
serialising them or checkout for timeout at wrong place as explained
above.

thanks.
