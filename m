Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE2AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7472072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYwVgd+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgFDPQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgFDPQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:16:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A07C08C5C0;
        Thu,  4 Jun 2020 08:16:07 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 9so6373296ilg.12;
        Thu, 04 Jun 2020 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gW26R0vM23ZVhp5EkFY+DM5yLwT6rLNr2QwfDIqp1n4=;
        b=RYwVgd+j9KPLF9NUSd1qBwfZ4icLAyg/dwmp8FX8QiRKJOlt3STT8RbzrYK175CCHQ
         RSh9pZ/FYM1fqgCJ1nFMUNEbZsI/fpTXwtYbnVuWJ7dL68R4s+V29exjTMUIug1EZ5LR
         m8kfEfy/jMtegOUVpyIsUV3v+wM3Fq4AqXr3i/Y+vFrVwNnZ7Td3BRGAPOc3OsVQ/erD
         A+KPrB9zEEaALS7697QcUj4pL0O77wTpn4CCqwTutj7KXBPSQ1Zp6ZNS2qCGDBUHRKe9
         GYUnnQl7+oKUgSaHmx/sLoCPZ2dsMxM2AnrgXwTSByUS4z7EMlD82O6FaMu/lP7d+RAY
         wsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gW26R0vM23ZVhp5EkFY+DM5yLwT6rLNr2QwfDIqp1n4=;
        b=ulBr6loKpv7rkgSS6Ktp8kcfTTH3SqE9gzEfhqLNUzpXOUaSuhdI7USvdcmkN6xGD9
         36EX7J/XyAd1XVQ5KOhCrmvqL/W+RG5O9fXvFvRstFNzCXn9gS/oCyvukVn4unZxszW5
         33OTSJGL+OTNqjanANz4UDMAFDBEszf5Qh6WNR0rUhZG3v2Hp/16I9P1uVDlGm0NwC5X
         Dbi6i+h9JX7GNc9WPH8foxGr5KGoeFvjrFhoFxrxDZsFawBHZDro1v5Mhq3mQL9ajl6Z
         jswd6KAwxGxyzbOiIfIkeiW3JR0KaVAOqolG61GAOIAYRnCu8bm9ilxDzNN3mWDbjPaU
         bfsA==
X-Gm-Message-State: AOAM532O0SJkXIOlFjyQ6WOaYIDIZQyWXLPUgs+JDMpgeN6/wOutTmVa
        +Hiv+W3egtcmMBj50SspHipKIPxVhThN4TcJF5tCkk5T
X-Google-Smtp-Source: ABdhPJxGc4aao4tyLTwDiA0mZ3IqY3wcj+6JqBiEaQXtb+7pstTH5tHQsDwP26lBnnXFiCS73vjzHbplDTkM0oy8WKY=
X-Received: by 2002:a05:6e02:1242:: with SMTP id j2mr4343170ilq.303.1591283767234;
 Thu, 04 Jun 2020 08:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus> <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus> <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus>
In-Reply-To: <20200604092052.GD8814@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 4 Jun 2020 10:15:55 -0500
Message-ID: <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
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

On Thu, Jun 4, 2020 at 4:20 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jun 03, 2020 at 01:32:42PM -0500, Jassi Brar wrote:
> > On Wed, Jun 3, 2020 at 1:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Fri, May 29, 2020 at 09:37:58AM +0530, Viresh Kumar wrote:
> > > > On 28-05-20, 13:20, Rob Herring wrote:
> > > > > Whether Linux
> > > > > requires serializing mailbox accesses is a separate issue. On that side,
> > > > > it seems silly to not allow driving the h/w in the most efficient way
> > > > > possible.
> > > >
> > > > That's exactly what we are trying to say. The hardware allows us to
> > > > write all 32 bits in parallel, without any hardware issues, why
> > > > shouldn't we do that ? The delay (which Sudeep will find out, he is
> > > > facing issues with hardware access because of lockdown right now)
> > >
> > > OK, I was able to access the setup today. I couldn't reach a point
> > > where I can do measurements as the system just became unusable with
> > > one physical channel instead of 2 virtual channels as in my patches.
> > >
> > > My test was simple. Switch to schedutil and read sensors periodically
> > > via sysfs.
> > >
> > >  arm-scmi firmware:scmi: message for 1 is not expected!
> > >
> > This sounds like you are not serialising requests on a shared channel.
> > Can you please also share the patch?
>
> OK, I did try with a small patch initially and then realised we must hit
> issue with mainline as is. Tried and the behaviour is exact same. All
> I did is removed my patches and use bit[0] as the signal. It doesn't
> matter as writes to the register are now serialised. Oh, the above
> message comes when OS times out in advance while firmware continues to
> process the old request and respond.
>
> The trace I sent gives much better view of what's going on.
>
BTW, you didn't even share 'good' vs 'bad' log for me to actually see
if the api lacks.

Let us look closely ...

 >>    bash-1019  [005]  1149.452340: scmi_xfer_begin:
transfer_id=1537 msg_id=7 protocol_id=19 seq=0 poll=1
 >>    bash-1019  [005]  1149.452407: scmi_xfer_end:
transfer_id=1537 msg_id=7 protocol_id=19 seq=0 status=0
>
This round trip took  67usecs.  (log shows some at even 3usecs)
That includes mailbox api overhead, memcpy and the time taken by
remote to respond.
So the api is definitely capable of much faster transfers than you require.

>>     bash-1526  [000]  1149.472553: scmi_xfer_begin:      transfer_id=1538 msg_id=6 protocol_id=21 seq=0 poll=0
>>      <idle>-0     [001]  1149.472733: scmi_xfer_begin:      transfer_id=1539 msg_id=7 protocol_id=19 seq=1 poll=1
>
Here another request is started before the first is finished.
If you want this to work you have to serialise access to the single
physical channel and/or run the remote firmware in asynchronous mode -
that is, the firmware ack the bit as soon as it sees and starts
working in the background, so that we return in ~3usec always, while
the data returns whenever it is ready.  Again, I don't have the code
or the 'good' run log to compare.

PS: I feel it is probably less effort for me to simply let the patch
through, than use my reiki powers to imagine how your test code and
firmware looks like.
