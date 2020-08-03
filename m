Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF72C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882B92076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ml+4cPKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgHCV6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:58:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE744C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:58:02 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y8so13780324vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHgUICdi9xK+5WmgsC8O+1KkScVXRPzwwp8CUGby/X0=;
        b=ml+4cPKmiKL+peX9skOC2i9Q69Hus93rCzCmmb7P/4Dl8nUjNtTy+US4rB+PzvHc91
         9MYptvwCJdifuqbfAddJLN62QZvtY/0gcB3JMDimUQccc2zpT2C0+EbDYVABI58h//ea
         quqkVFAxyHvUn6xjm2GhcyTFbSsMYjbIYt4Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHgUICdi9xK+5WmgsC8O+1KkScVXRPzwwp8CUGby/X0=;
        b=H3voaxGOgiY83IMCtkeS2rs02k4NPirKgfavAilIub6qCcICztNAPKR17TgfSXKmX6
         3OJT0eykWDtLkawFievGkR2busfPuqq3Ly6besM/t+FeC07weZo4O2ARRPxrIaqzyohk
         Qf4/vdLNdsKvOEDs91GuDmYMiNzHFVgPWwahQdg/MRIUOBkqDmwxbzppV50nRTLBHsq1
         R87gbwYu5AQ5BIsOsL+nrdCgqOVAvVnAzbqvbjVOPPjaVtYTZxC+pY94OoJK6f/aXNvv
         iok3GIJqXdquQ5z1UqFQBXgkharDyovPRwV6T5K4PdntDj94BhDcRwiOfjqMh0CVYbg4
         QwHw==
X-Gm-Message-State: AOAM532gEDCTZTq4MWK05v7y4Qqp13wt8endQiYQY7eWSywd7c+Dg/iC
        o6HYZbOYeVEff+L9aUmLE+5JxE0EeDk=
X-Google-Smtp-Source: ABdhPJyuFnAItE0dMYXFeHMZpmv3Rjzm2Y/JoXSZ5tj1awMNtDtqyn/NOpq9gdEpQ5bl+lXCUTCdwg==
X-Received: by 2002:a67:e9d6:: with SMTP id q22mr11084201vso.232.1596491881599;
        Mon, 03 Aug 2020 14:58:01 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id n20sm950622vsr.6.2020.08.03.14.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 14:58:00 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id d20so1862653ual.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:57:59 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr12794962uan.121.1596491878639;
 Mon, 03 Aug 2020 14:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
 <CANcMJZC-kAc1kqqNhfd9wvFS4ans8t7cpAfNVZbybA4W6x5-KQ@mail.gmail.com>
In-Reply-To: <CANcMJZC-kAc1kqqNhfd9wvFS4ans8t7cpAfNVZbybA4W6x5-KQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Aug 2020 14:57:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WNY8vR4ip2w47rf7rnBmtenEXtjXstj8PWNaXjCN3ZXQ@mail.gmail.com>
Message-ID: <CAD=FV=WNY8vR4ip2w47rf7rnBmtenEXtjXstj8PWNaXjCN3ZXQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: qcom: Handle broken/missing PDC dual edge
 IRQs on sc7180
To:     John Stultz <john.stultz@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Aug 3, 2020 at 2:06 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Jul 14, 2020 at 8:08 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Depending on how you look at it, you can either say that:
> > a) There is a PDC hardware issue (with the specific IP rev that exists
> >    on sc7180) that causes the PDC not to work properly when configured
> >    to handle dual edges.
> > b) The dual edge feature of the PDC hardware was only added in later
> >    HW revisions and thus isn't in all hardware.
> >
> > Regardless of how you look at it, let's work around the lack of dual
> > edge support by only ever letting our parent see requests for single
> > edge interrupts on affected hardware.
> >
> > NOTE: it's possible that a driver requesting a dual edge interrupt
> > might get several edges coalesced into a single IRQ.  For instance if
> > a line starts low and then goes high and low again, the driver that
> > requested the IRQ is not guaranteed to be called twice.  However, it
> > is guaranteed that once the driver's interrupt handler starts running
> > its first instruction that any new edges coming in will cause the
> > interrupt to fire again.  This is relatively commonplace for dual-edge
> > gpio interrupts (many gpio controllers require software to emulate
> > dual edge with single edge) so client drivers should be setup to
> > handle it.
> >
> > Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Just as a heads up. I started seeing boot failures (crashes really
> early before we get serial output) with db845c when testing with the
> android-mainline tree that pulled v5.8 in.

Even before earlycon?  Ick.  For me earlycon comes up way before
pinctrl and I thought that, by design, earlycon came up so dang early
that you could debug almost anything with it.

To confirm, I could even drop into earlycon_kgdb (which starts later
than earlycon), then set a breakpoint on msm_pinctrl_probe() and I'd
hit my breakpoint.  Enabling earlycon should be super easy these
days--just add the "earlycon" command line parameter and the kernel
seems to do the rest of the magic based on the "stdout-path".  I guess
if your bootloader doesn't cooperate and leave the system in an OK
state then you'll be in bad shape, but otherwise it should be nice...

NOTE: if you have earlycon and this is still causing crashes before
earlycon starts, the only things I can think of are side effects of
this patch.  Could it have made your kernel just a little too big and
now you're overflowing some hard limit of the bootloader?  Maybe
you're hitting a ccache bug and using some stale garbage (don't laugh,
this happened to me the other year)?  Maybe there's a pointer bug and
this moves addresses just enough to make it cause havoc?


> I did some quick bisection and came down to this patch, and sure
> enough things boot again with this patch reverted.
>
> In my testing earlier today with v5.8 (+ just a few patches for db845c
> support), I didn't see this failure, but the configs in use are
> different there.
>
> I'll try to spend a bit of time to understand exactly what is failing,
> but if you have any initial suggestions for things to try, I'd
> appreciate it.

So on SDM845 we aren't setting "wakeirq_dual_edge_errata", right?
It's possible that you also need it, but I didn't have an SDM845
device in front of me to test with--I only have remote access to one.
...but in any case, the fact that SDM845 doesn't have
"wakeirq_dual_edge_errata" set should eliminate a bunch of code.

Once you eliminate that there's almost nothing left of this patch.
You could try commenting out:

irq_set_handler_locked(d, handle_fasteoi_irq);

...and see if that helps?

NOTE: I just tried putting kernel 5.8 on my sdm845-cheza device.  It
booted up without crashing...  I'm probably not using the same config
you are, but at least it appears that sdm845 isn't totally broken or
anything...

-Doug
