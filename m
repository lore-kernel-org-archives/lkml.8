Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2320621D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgIHJPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:15:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48151 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgIHJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:15:10 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M6lxY-1kBjgz37L4-008Knt; Tue, 08 Sep 2020 11:15:07 +0200
Received: by mail-qv1-f45.google.com with SMTP id x7so7432928qvi.5;
        Tue, 08 Sep 2020 02:15:07 -0700 (PDT)
X-Gm-Message-State: AOAM530opmyjede38hMRDl+SUsCPKb7auww47KBAi8mH2DnXp48QbMzq
        XWA17IfhmbMxUWaIx8p4dgh8XlU8BRcSyGFpqV0=
X-Google-Smtp-Source: ABdhPJxiIPQ4rYzhI3bjSajviknmTbSrxISdggfeTRQMiIpfh+gJ5HSuqCYNegDej0bFDzfD2DGGUM33xRM7fZma9o0=
X-Received: by 2002:a05:6214:292:: with SMTP id l18mr21604723qvv.11.1599556506523;
 Tue, 08 Sep 2020 02:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus> <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus> <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus> <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7> <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com> <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
In-Reply-To: <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 8 Sep 2020 11:14:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
Message-ID: <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Pj+TK/lZmEq6SlGsUgOKxX976PuX6gpAL3UhVnh9oujev2xOMzE
 qoFI/4EBXRHFgZXzNV4673J0JNfq3VtaayF6LFM8CWi4Ar1eu7e/RNG2YMO/Xl/69ugrPJA
 vhZW+eEDf/ul5natKsRPEc/kpHa/u4PpjdXG+7Xlm/sd53MxuLuUW1NaJkHDmBbS0pBawbB
 I9iA59nUWbJaHQtbyZjlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nnAR7mDHdkQ=:Le21OA5CpNQSemtemONpw2
 IvU71jskXAqWUXRApmxjn+iQ/kYkEGwe6AgTweoPzHtddqmLEtfag2ZkFw4dllyxLuw1q3g6a
 tg9g1xoU7PF8Z5FM2uFgatU/mphxk5PO2pwaRJUnTIv170oNt2Mtx7XpwzJjbdGewHOz729P/
 5v6BTZX/ML/P8iYDk1JFTEvpg5pqBx+7z8aV2SgpQ0/v+8xYUSuBFkwlpF1svi+Yy7CiUfX8O
 fQLMS5BSLPfBYcC9/66wKPsbzDzyXGadsSLBCZo7fw/Darf4zxr/0OP2SKdA3h8sfwxO82TA2
 oEiVAYJfcM8DUZ623eDCz0zph5FmeJRoADijGGBFYNAAmO/kyKwNko6gxi50FBwKdwgWMqnq7
 xwXR87TqdfTagbk0WJNezTQy34ySHULDvYWiX6+iklDDO3bKDK7uuVGHnFl1r3indV9R7CWrB
 offxHVXhpXetardH6U3lB4psKz/OWtIb+gFJVzxDuDluWzbR51XcfUd4XK69HpYpPjVadgtHs
 aPyaSlYzBlPKBXUrdf5dOphQ+rq+G8GNI2YXnDlpVipS5r7HW5qF5jQCftJ7vmWMiqo2vQfB/
 awXbmqsUXXyHHk8CYlv/ccCLohmifD/8SYzzn2elcvNNCq+XmSyTcQTp2oJO2M0k6Sq2DkSHj
 sqF12tAwicuUG+u7Ah5vL4AG8zcJWa/gyjQ6xCHP6nopaDbWRVfJkD4ZAAMSMBXWEcsFxNTis
 pm6+PsIbfvlbP/fASKf5flYsi2sMHOS3IaZzqXQN5UCuRzHELQqZjdMK03F5ONPSIFvaUhZwL
 2ntsJSm5OKXs3+WnWuSZRzC3VXrio3guIt/oDGPUh2IqSGyvo5cUdsbWPCo/+QaP3YZGGL/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Picking up the old thread again after and getting pinged by multiple
colleagues about it (thanks!) reading through the history.

On Fri, Jun 12, 2020 at 7:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-06-20, 19:34, Jassi Brar wrote:
> > In the first post in this thread, Viresh lamented that mailbox
> > introduces "a few ms" delay in the scheduler path.
> > Your own tests show that is certainly not the case -- average is the
> > same as proposed virtual channels 50-100us, the best case is 3us vs
> > 53us for virtual channels.
>
> Hmmm, I am not sure where is the confusion here Jassi. There are two
> things which are very very different from each other.
>
> - Time taken by the mailbox framework (and remote for acknowledging
>   it) for completion of a single request, this can be 3us to 100s of
>   us. This is clear for everyone. THIS IS NOT THE PROBLEM.
>
> - Delay introduced by few of such requests on the last one, i.e. 5
>   normal requests followed by an important one (like DVFS), the last
>   one needs to wait for the first 5 to finish first. THIS IS THE
>   PROBLEM.

Earlier, Jassi also commented "Linux does not provide real-time
guarantees", which to me is what actually causes the issue here:

Linux having timeouts when communicating to the firmware means
that it relies on the hardware and firmware having real-time behavior
even when not providing real-time guarantees to its processes.

When comparing the two usage models, it's clear that the minimum
latency for a message delivery is always at least the time time
to process an interrupt, plus at least one expensive MMIO read
and one less expensive posted MMIO write for an Ack. If we
have a doorbell plus out-of-band message, we need an extra
DMA barrier and a read from coherent memory, both of which can
be noticeable. As soon as messages are queued in the current
model, the maximum latency increases by a potentially unbounded
number of round-trips, while in the doorbell model that problem
does not exist, so I agree that we need to handle both modes
in the kernel deal with all existing hardware as well as firmware
that requires low-latency communication.

It also sounds like that debate is already settled because there
are platforms using both modes, and in the kernel we usually
end up supporting the platforms that our users have, whether
we think it's a good idea or not.

The only questions that I see in need of being answered are:

1. Should the binding use just different "#mbox-cells" values or
   also different "compatible" strings to tell that difference?
2. Should one driver try to handle both modes or should there
   be two drivers?

It sounds like Jassi strongly prefers separate drivers, which
would make separate compatible strings the more practical
approach. While the argument can be made that a single
piece of hardware should only have one DT description,
the counter-argument would be that the behavior described
by the DT here is made up by both the hardware and the
firmware behind it, and they are in fact different.

       Arnd
