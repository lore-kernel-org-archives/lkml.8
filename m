Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BD4C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA70520718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHKBwjvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgAWXAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:00:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32814 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgAWXAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:00:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so259595lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nS7ocb5jumTWRAIkSgB97xnkdSH5hp40IMpcRwtHcbY=;
        b=QHKBwjvIIEDpjKu390N/gc1f9Q6gVEAklPmkY+Ok83BmjLFPgsYimIPaB7w1N5KOuB
         XmXHjgtDrWaV/cu4fniFp9KuQKOAKHB3BEC222MdEkfvQhSskR8IVqks1DjwMdbuZaG6
         5ceBFph6PeI4oRJXdzPwLHMoChv0YMYyEP4vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nS7ocb5jumTWRAIkSgB97xnkdSH5hp40IMpcRwtHcbY=;
        b=XNWQw+bwUXtj4yCAQdtR/WeSuH4wN8VFgtOxZWzsYeetmrdLSd7IU+KuxCbahQumF3
         MHsNL5v0jSiyagm6IiuZ1zFFWC1VJwxEcEYJIsMlF78uaY6dDz53H6/U4zJL23Ybm9R/
         f3IIyEamjYh8v/ijCnwb2SK22/P2ES/ItOkZNbIsFRYyO1oOLzJJP8Orp06Td7HKaRpM
         k+meWHweqG7Gpjs95a9D17oNZTvCx0re+kku2lYMpRpMyveHEFpJJPkt5bym3lBMUcTd
         EMK9QNWsRxAS9N2Yz+jKOVJkA4JEfZkJl/Mz5UzN/XZVvr3ci5OZfUuLnW44rKLy/Sv6
         1egw==
X-Gm-Message-State: APjAAAXlWVCmOsPvzsncZooF+87WBVArkP7RTgG7UEOMTH5Ei5HBsZFD
        QW5c26OxCVsUNym5kDPUexGEItSB7dY=
X-Google-Smtp-Source: APXvYqzWIV1y70IxuAh2D2D18R2dEvVs29qvhR/xi2+SzuHlXaDcF8TUeIZ88oaw58W0oG32HHhgNw==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr402199ljg.151.1579820404185;
        Thu, 23 Jan 2020 15:00:04 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k25sm1987404lji.42.2020.01.23.15.00.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 15:00:03 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id v201so3559821lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:00:03 -0800 (PST)
X-Received: by 2002:a19:e011:: with SMTP id x17mr44398lfg.59.1579820402396;
 Thu, 23 Jan 2020 15:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
In-Reply-To: <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 14:59:25 -0800
X-Gmail-Original-Message-ID: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
Message-ID: <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 12:59 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Thu, Jan 23, 2020 at 10:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Evan,
> >
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > > This is not yet debugged fully and as this is happening on MSI-X I'm not
> > > really convinced yet that your 'torn write' theory holds.
> >
> > can you please apply the debug patch below and run your test. When the
> > failure happens, stop the tracer and collect the trace.
> >
> > Another question. Did you ever try to change the affinity of that
> > interrupt without hotplug rapidly while the device makes traffic? If
> > not, it would be interesting whether this leads to a failure as well.
>
> Thanks for the patch. Looks pretty familiar :)
> I ran into issues where trace_printks on offlined cores seem to
> disappear. I even made sure the cores were back online when I
> collected the trace. So your logs might not be useful. Known issue
> with the tracer?
>
> I figured I'd share my own debug chicken scratch, in case you could
> glean anything from it. The LOG entries print out timestamps (divide
> by 1000000) that you can match up back to earlier in the log (ie so
> the last XHCI MSI change occurred at 74.032501, the last interrupt
> came in at 74.032405). Forgive the mess.
>
> I also tried changing the affinity rapidly without CPU hotplug, but
> didn't see the issue, at least not in the few minutes I waited
> (normally repros easily within 1 minute). An interesting datapoint.

One additional datapoint. The intel guys suggested enabling
CONFIG_IRQ_REMAP, which does seem to eliminate the issue for me. I'm
still hoping there's a smaller fix so I don't have to add all that in.
-Evan
