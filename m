Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CD62084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mSKyl9af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392165AbgEZWb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392147AbgEZWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:31:56 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E5DC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:31:56 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id z3so5428851vka.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckz1HWIdA+GeBHYGwYLo/GIj/g4b9/qO/o+PE8uBfTw=;
        b=mSKyl9afG+AI75BH50jjFZFiYhq+55dqFJlrBbY1ht9pp1eVhphwZj7SoTUyoMT+Xv
         qOrQLS4inTCKGGLEsiCNbxZTEotV6b8yBrBo59G9qFyinjoJhcuUM8l9R32BbDxKVDo4
         to52RwV5hWrdBjWXsBi8FW75t9ptGJemD0zhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckz1HWIdA+GeBHYGwYLo/GIj/g4b9/qO/o+PE8uBfTw=;
        b=OW1dDIHBjazSpYKwOpTHkYeKu8TCS1tjF71QROja2ZsuGjerJCdEpM4oMBjGDJxinM
         JjHr5TpYGHqyvFM3/OSh9QTHQ4PMzzlmldYHhuIUbNdqPHUBLf1elLxtCVPNXWPV+Ib5
         YMlDFQ9JcMzgMeSRMFYoJiEoBEFrD9vCGkTgM+bpRH8OYqGOg6fJgF2Daul1O2hQDZar
         jQo4X+AAv+onKmvaM19oSgbTU0S7VVbcHPUaKRId8M0pnL0CJs0Ro1ej8olZRnxWU6xN
         ta3NtB/CKXeKhcyxS5lDby6BzGyTQuvJYd9qA6fDKDVaU/QEVdVeyA7WrSEnqe/zzylv
         Tx+Q==
X-Gm-Message-State: AOAM530+ppfldgoGdRn19JGTeIPvMzZuf5wDjCkXJ2vbueHnoPcfXaxk
        +/4uzf5axg7Yy4t2zujP4p6E0qu+USI=
X-Google-Smtp-Source: ABdhPJwTiyJ5Jzzk/XPGar64XTKZEtYjP/eGZfDR+c5bLUpXVv2NNna7rW3N1VUfoA8JtuDtsVHtBA==
X-Received: by 2002:a1f:e843:: with SMTP id f64mr3034012vkh.80.1590532314042;
        Tue, 26 May 2020 15:31:54 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id k5sm113088vkk.10.2020.05.26.15.31.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:31:53 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id q10so365601vka.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:31:52 -0700 (PDT)
X-Received: by 2002:a05:6122:11bc:: with SMTP id y28mr2833141vkn.75.1590532312433;
 Tue, 26 May 2020 15:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org> <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org> <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org> <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
 <CAD=FV=XW7GymV_pr_0SvUPWwL6WnPhqMq-crq-RbR_us3-ShNA@mail.gmail.com>
 <9864496c-b066-3fe8-5608-bd9af69663f4@linaro.org> <CAD=FV=UbZPQ74COXJbOikq9Wcx1UvtuMuMA+nqkx44uySoqggg@mail.gmail.com>
 <99f07eaa-d072-f391-098e-e6f7a50a1960@linaro.org> <CAD=FV=W+UES1f3reMhvPPUho5FbaZXdU-2jkRaPcbBEzDWT+WQ@mail.gmail.com>
 <9ecb5790-47fe-583b-6fc3-8f4f3ce7860e@linaro.org> <CAD=FV=XbbUkeSwvcverBS8t6BCHuw3UT0_KYfx9LFGqmZyY2hA@mail.gmail.com>
 <871dd2c1-4b16-f883-b8c5-806a0df1edf8@linaro.org>
In-Reply-To: <871dd2c1-4b16-f883-b8c5-806a0df1edf8@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 May 2020 15:31:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UCwUO5aKrUj7e+v6Bpkh_O+wuSXD5tJHdGOfaVTL0t1w@mail.gmail.com>
Message-ID: <CAD=FV=UCwUO5aKrUj7e+v6Bpkh_O+wuSXD5tJHdGOfaVTL0t1w@mail.gmail.com>
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 22, 2020 at 4:18 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> On 21/05/2020 22:28, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, May 21, 2020 at 8:56 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >> On 21/05/2020 16:10, Doug Anderson wrote:
> >>>> On 20/05/2020 23:48, Doug Anderson wrote:
> >>>>>> Is this only applicable for corrected address space?
> >>>>> I guess I was proposing a two dts-node / two drive approach here.
> >>>>>
> >>>>> dts node #1:just covers the memory range for accessing the FEC-corrected data
> >>>>> driver #1: read-only and reads the FEC-corrected data
> >>>>>
> >>>>> dts node #2: covers the memory range that's_not_  the FEC-corrected
> >>>>> memory range.
> >>>>> driver #2: read-write.  reading reads uncorrected data
> >>>>>
> >>>>> Does that seem sane?
> >>>> I see your point but it does not make sense to have two node for same thing.
> >>> OK, so that sounds as if we want to go with the proposal where we
> >>> "deprecate the old driver and/or bindings and say that there really
> >>> should just be one node and one driver".
> >>>
> >>> Would this be acceptable to you?
> >>>
> >>> 1. Officially mark the old bindings as deprecated.
> >>
> >> Possibly Yes for some reasons below!
> >>
> >>>
> >>> 2. Leave the old driver there to support the old deprecated bindings,
> >>> at least until everyone can be transferred over.  There seem to be
> >>> quite a few existing users of "qcom,qfprom" and we're supposed to make
> >>> an attempt at keeping the old device trees working, at least for a
> >>> little while.  Once everyone is transferred over we could decide to
> >>> delete the old driver.
> >> we could consider "qcom,qfrom" to be only passing corrected address
> >> space. Till we transition users to new bindings!
> >>
> >>>
> >> Yes.
> >>
> >>> 3. We will have a totally new driver here.
> >> No, we should still be using the same driver. But the exiting driver
> >> seems to incorrect and is need of fixing.
> >>
> >> Having a look at the memory map for old SoCs like msm8996 and msm8916
> >> shows that memory map that was passed to qfprom driver is corrected
> >> address space. Writes will not obviously work!
> >>
> >> This should also be true with sdm845 or sc7180
> >>
> >> That needs to be fixed first!
> >
> > OK, so to summarize:
> >
>
> > 1. We will have one driver: "drivers/nvmem/qfprom.c"
>
> Yes, we should one driver for this because we are dealing with exactly
> same IP.
>
> >
> > 2. If the driver detects that its reg is pointing to the corrected
> > address space then it should operate in read-only mode.  Maybe it can
> > do this based on the compatible string being just "qcom,qfprom" or
> > maybe it can do this based on the size of the "reg".
>
> I found out that there is a version register at offset of 0x6000 which
> can give MAJOR, MINOR and STEP numbers.
>
> So we could still potentially continue using "qcom,qfprom"

OK, sounds good.  I think it's still good practice to include both the
SoC specific and the generic.  Even if the driver never does anything
with the SoC-specific compatible string it doesn't hurt to have it
there.  Thus, we'd want:

compatible = "qcom,msm8996-qfprom", "qcom,qfprom"

The driver itself would never need to refer to the SoC-specific name
but that does give us more flexibility.


> The address space can be split into 3 resources, which is inline with
> Specs as well
>
> 1. Raw address space ("raw")
> 2. Configuration address space ("conf" or "core")
> 3. Corrected address space ("corrected")

Sure, this is OK with me then.  Originally Ravi had 3 ranges but then
he was (in the driver) treating it as one range.  As long as the
driver truly treats it as 3 ranges I have no problem doing it like
this.

In general, over the years, there has been a push to keep
implementation details out of the dts and rely more on the "of_match"
table to add SoC-specific details.  This becomes really important when
1 year down the road you realize that you need one more random
property or address range to fix some bug and then you need to figure
out how to try to keep old "dts" files compatible.  It's not a
hard-and-fast rule, though.


> Exiting qfprom entries or read-only qfprom  will have "corrected"
> address space which can be the only resource provided by device tree
> entries.
> Other two entries("raw" and "conf") are optional.
>
> qfprom: qfprom@780000 {
>          compatible = "qcom,qfprom";
>         reg = <0 0x00780000 0 0x8ff>,
>                 <0 0x00782000 0 0x100>,
>                 <0 0x00784000 0 0x8ff>;
>         reg-names = "raw", "conf", "corrected";
>
>         vcc-supply = <&vreg_xyz>;
>
>         clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
>         clock-names = "secclk";
>
>         assigned-clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
>          assigned-clock-rates = <19200000>;
>
>         qcom,fuse-blow-frequency = <4800000>
>
>          #address-cells = <1>;
>          #size-cells = <1>;
>
>         qusb2p_hstx_trim: hstx-trim-primary@25b {
>                 reg = <0x25b 0x1>;
>                 bits = <1 3>;
>         };
> };
>
> Regarding clk rate setting, the default rate can be set using
> assigned-clock-rates property, however the blow frequency can go as new
> binding.
> regarding voltage range for regulator, it should come as part of board
> specific voltage regulator node. In worst case we can discuss on adding
> new bindings for allowing specific range.

I'd up to you (and Rob H, who probably will wait for the next rev of
the binding before chiming in) but the "qcom,fuse-blow-frequency" is
the type of property that feels better in the driver and achieved from
the of_match table.  Then you don't need to worry about adding it to
the bindings.  Voltage (if needed) would be similar, but I would hope
we don't need it.


> for Older SoCs: we still continue to use old style with just one
> resource corresponding to corrected by default.
>
> qfprom: qfprom@784000 {
>          compatible = "qcom,qfprom";
>          reg = <0 0x00784000 0 0x8ff>;
>          #address-cells = <1>;
>          #size-cells = <1>;
>
>          qusb2p_hstx_trim: hstx-trim-primary@1eb {
>                  reg = <0x1eb 0x1>;
>                  bits = <1 4>;
>          };
>
>          qusb2s_hstx_trim: hstx-trim-secondary@1eb {
>                  reg = <0x1eb 0x2>;
>                  bits = <6 4>;
>          };
> };
>
>
> I see the patch as adding write support to qfprom, rather than adding
> new driver or new SoC support.
>
> This in summary should give us good direction for this patch!
>
> Correct me if I miss understood something here!

Sounds sane to me.


-Doug
