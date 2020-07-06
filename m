Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F109C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F334C206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i8AoOce2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGFVhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:37:23 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB080C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 14:37:22 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id f11so2050856uao.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IhQtauBFGwHx8ZByHdSAFoarIEwWxbNNteM8SgQLyg=;
        b=i8AoOce2VysOfXS2qbFb7pSjCfDFiu0zZeN+6cl6eNyihFvfHe+8lZw6ZGXrmZed6h
         ueHTpGwM551qJDJDfM4xIk2S7UxXTnCv/ydiEku+rNBbcx5fo0gskdwzNzEdtEMQgKW8
         3N8T1vrgyNphnkRpkR9tol3fj72/1wlLJ4HvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IhQtauBFGwHx8ZByHdSAFoarIEwWxbNNteM8SgQLyg=;
        b=BMDXYyzqIjRX0pHWqh2WBmBCn3/rOlR6IV0g3nWr2W7Dvt2oxz9ZIzZFbwuOS9IN5u
         vAEREYwlvHzkH5m9lvV+hnXCnNeCxet1ZxIi9HAWFjzwYc/WPEFBcetcLpjjPrhev+8Z
         Ud0+qtozEjzpmadK32vxEGxI3dJsWGcJhynFqNZaSf5ABbWQP40Mq/DYeljK9XZBn3ED
         h0EEA+S7JjzbjWCzE/FkTotFI5zd6XXzHHbL7esRCT+GTfMJpg++0K6TBjYaFlYlOIX+
         AnHPQZFdNN6XmcDJToNnJ9YhmMdP1hqNgkK5BQdcUF665z8ZvcmfO5hmhFwaltvkL1UX
         vmDw==
X-Gm-Message-State: AOAM530OLcja19HEpOTNtHpY90Ksw3sdawHIwFtcnxo2b1LzgAVUgchi
        uCtCfOZ0Jq6L8Za3OxNlhLTsSzg7S/I=
X-Google-Smtp-Source: ABdhPJwCuqU+7evNc3LTMiX+MghxWhJMpmguKBFuU34+bEjA4wwnfx4BYIGtFV5qzancniAYKse0Vg==
X-Received: by 2002:ab0:7858:: with SMTP id y24mr19079386uaq.89.1594071441503;
        Mon, 06 Jul 2020 14:37:21 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id n17sm5261160uao.14.2020.07.06.14.37.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 14:37:20 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id h18so6568585uao.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 14:37:19 -0700 (PDT)
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr33204909uay.22.1594071438979;
 Mon, 06 Jul 2020 14:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
 <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com> <CAD=FV=WYBAJB_nWxUAAVgV26e4CTzJeizZtxpwus6REi3j2meA@mail.gmail.com>
 <20200630072221.GA13332@willie-the-truck>
In-Reply-To: <20200630072221.GA13332@willie-the-truck>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jul 2020 14:37:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UmKLqP3tqNco=cKvdf5hOTChAp5h_3C5Q5mYKQptDDJw@mail.gmail.com>
Message-ID: <CAD=FV=UmKLqP3tqNco=cKvdf5hOTChAp5h_3C5Q5mYKQptDDJw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
To:     Will Deacon <will@kernel.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 30, 2020 at 12:22 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 29, 2020 at 02:20:11PM -0700, Doug Anderson wrote:
> > On Sat, May 16, 2020 at 1:20 AM liwei (GF) <liwei391@huawei.com> wrote:
> > > On 2020/5/14 8:34, Doug Anderson wrote:
> > > > On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
> > > >>
> > > >> This patch set is to fix several issues of single-step debugging
> > > >> in kgdb/kdb on arm64.
> > > >>
> > > >> It seems that these issues have been shelved a very long time,
> > > >> but i still hope to solve them, as the single-step debugging
> > > >> is an useful feature.
> > > >>
> > > >> Note:
> > > >> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
> > > >> https://www.spinics.net/lists/arm-kernel/msg803741.html
> > > >>
> > > >> Wei Li (4):
> > > >>   arm64: kgdb: Fix single-step exception handling oops
> > > >>   arm64: Extract kprobes_save_local_irqflag() and
> > > >>     kprobes_restore_local_irqflag()
> > > >>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
> > > >>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
> > > >>
> > > >>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
> > > >>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
> > > >>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
> > > >>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
> > > >>  4 files changed, 48 insertions(+), 30 deletions(-)
> > > >
> > > > Just an overall note that I'm very happy that you posted this patch
> > > > series!  It's always been a thorn in my side that stepping and
> > > > breakpoints were so broken on arm64 and I'm really excited that you're
> > > > fixing them.  Now I'll have to get in the habit of using kgdb for more
> > > > than just debugging crashes and maybe I can use it more for exploring
> > > > how functions work more.  :-)
> > > > > I'll also note that with your patch series I'm even seeing the "call"
> > > > feature of gdb working now.  That has always been terribly broken for
> > > > me.
> > > >
> > > Thanks for reviewing and testing this series.
> > > Enjoy exploring the kernel with kgdb/kdb! :-)
> >
> > I'm curious to know if you plan another spin.  The feedback you
> > received was fairly minor so it hopefully shouldn't be too hard.  I'd
> > very much like to get your patches landed and I'd be happy to try to
> > address the feedback and spin them myself if you're no longer
> > available for it.
>
> I'd welcome some feedback on the proposal I sent out at the end of last
> week:
>
> https://lore.kernel.org/r/20200626095551.GA9312@willie-the-truck
>
> which looks to solve some (all?) of these issues

Actually, I'm pretty sure that patch #1 of Wei Li's patch series would
still be needed.  Would you object to landing it now just to get one
patch outta the way?

https://lkml.kernel.org/r/20200509214159.19680-2-liwei391@huawei.com


> slightly differently,
> because it turns out we need to perform some low-level surgery for
> preempt-rt *anyway*...
>
> I'm particularly keen to hear any thoughts concerning the reschedule on
> return to EL1 after handling an interrupt that hit during a step.

Thanks for the pointer!  Unfortunately this is yet another area that
I'm keenly interested in it working but pretty much clueless about how
this whole area of the system works.  :-|

My first question, though, is why would we want interrupts enabled
while we're single stepping?  If you're trying to get the processor to
just step one instruction forward you don't really want a bunch of
IRQs going off in the middle of it, do you?  While in kgdb and
debugging the kernel I would assume that a single step would run the
very least amount of code that it could (other than debugger code).
In general every time I exit kgdb (and re-start running the kernel
normally) I sorta assume that there's a chance that something in the
system will hit a timeout (maybe it's talking to external hardware
that will give up or something).  If I'm stepping through code I just
want that little bit of code I'm running to move forward and the rest
of the kernel to stand still.  If I want the rest of the kernel to
proceed I guess I'd set a breakpoint and then say "continue".

It seemed like with Wei Li's patch that we were closing holes and
being more consistent about keeping interrupts disabled when stepping
and I liked that.  Maybe if we made it so that taking interrupts
didn't break everything then it would be _OK_ to let them fire, but if
I had a choice I'd rather they didn't.

...of course, I'm looking at all this from the point of view of kgdb.
I don't know nearly enough about how other parts of the kernel use
single step to comment much on what would be best for them.


Did what I said make sense at all, or was it gibberish?  ...or not
gibberish but not what you were looking for?


-Doug
