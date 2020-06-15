Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3573BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160642063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3A4uLXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730917AbgFOPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbgFOPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:02:16 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FEFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:02:15 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id x14so2218531uao.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrvvsAEP4GTcir2Zy4zr3JBpHk31E0joGe1xHbcm+mg=;
        b=H3A4uLXQWE02D9hYonsJYD+dAcZKqOzS19HfKOalhkBF4qwfzczgYQl1W0V8OQsYXD
         95VWw7nAcce5a/v3X1xmaJEUAxd0JQhaKynN57OA1tKKU6N1LhVNw3fYE7ZH0++G+pva
         EdI1a+96k5CQcCD5Of6MAu9qR7pjeDAfI0yPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrvvsAEP4GTcir2Zy4zr3JBpHk31E0joGe1xHbcm+mg=;
        b=UwiQ7N4zOnZC+3WOQdOdvf1y5mRcrIDrlm850zncHpr7TGmO03wKFpnftURGBGLfTY
         sruH3Xe+ShDqxpBVWw2RQPD3GnL34xVSg11LJ/VKID5IunyafGDdXpDM+nrKei1qpAXS
         m3woYsjDuJXhL4dDcOh4duvt7RCsNhT/f8n22Rz152vSWAgBniYiukmtonLb5RBGIqMV
         HmROhht3e09Kv9+3ey6I6cmQkNJHB0Z7w2IswlzGxU2O7SdiUEXcKsTeTsWzOVmfBL7r
         rkOGYogOaJMXEtspXE6t+WFLJkBvB7rJyKgtb0AbwIwO43qZaNFdBigzshkWuzh8J01V
         F7Sw==
X-Gm-Message-State: AOAM530n9a25xjoh0nGu5am+0PSDpo5XdCk2LfYvchKtj9g1iks8vYzq
        y5LYt2eN9ZJpLwO20l+4r6e+vkLFN74=
X-Google-Smtp-Source: ABdhPJxQgxHjFH4v2OK6EcEiB93DGsFBNHcv2em1yOxgryn+evvIHpMoy2P1YAq5o3kzuwLUPAICQA==
X-Received: by 2002:ab0:186d:: with SMTP id j45mr20082578uag.104.1592233334752;
        Mon, 15 Jun 2020 08:02:14 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id g10sm1911130vsa.2.2020.06.15.08.02.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:02:14 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id l10so9514662vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:02:14 -0700 (PDT)
X-Received: by 2002:a67:8881:: with SMTP id k123mr19565964vsd.198.1592233331996;
 Mon, 15 Jun 2020 08:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200609082015.1.Ife398994e5a0a6830e4d4a16306ef36e0144e7ba@changeid>
 <20200615143237.519F3C433C8@smtp.codeaurora.org> <CAD=FV=VaexjLaaZJSxndTEi6KCFaPWW=sUt6hjy9=0Qn68kH1g@mail.gmail.com>
 <87zh94idik.fsf@codeaurora.org>
In-Reply-To: <87zh94idik.fsf@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 08:02:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XfUHD=vw-mvQsdHcn=zhB9-mD6ivrM93jkfHdgb+odiA@mail.gmail.com>
Message-ID: <CAD=FV=XfUHD=vw-mvQsdHcn=zhB9-mD6ivrM93jkfHdgb+odiA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Wait until copy complete is actually done before completing
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ath10k@lists.infradead.org,
        Rakesh Pillai <pillair@codeaurora.org>,
        netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, kuabhs@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 15, 2020 at 7:56 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Doug Anderson <dianders@chromium.org> writes:
>
> > On Mon, Jun 15, 2020 at 7:32 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Douglas Anderson <dianders@chromium.org> wrote:
> >>
> >> > On wcn3990 we have "per_ce_irq = true".  That makes the
> >> > ath10k_ce_interrupt_summary() function always return 0xfff. The
> >> > ath10k_ce_per_engine_service_any() function will see this and think
> >> > that _all_ copy engines have an interrupt.  Without checking, the
> >> > ath10k_ce_per_engine_service() assumes that if it's called that the
> >> > "copy complete" (cc) interrupt fired.  This combination seems bad.
> >> >
> >> > Let's add a check to make sure that the "copy complete" interrupt
> >> > actually fired in ath10k_ce_per_engine_service().
> >> >
> >> > This might fix a hard-to-reproduce failure where it appears that the
> >> > copy complete handlers run before the copy is really complete.
> >> > Specifically a symptom was that we were seeing this on a Qualcomm
> >> > sc7180 board:
> >> >   arm-smmu 15000000.iommu: Unhandled context fault:
> >> >   fsr=0x402, iova=0x7fdd45780, fsynr=0x30003, cbfrsynra=0xc1, cb=10
> >> >
> >> > Even on platforms that don't have wcn3990 this still seems like it
> >> > would be a sane thing to do.  Specifically the current IRQ handler
> >> > comments indicate that there might be other misc interrupt sources
> >> > firing that need to be cleared.  If one of those sources was the one
> >> > that caused the IRQ handler to be called it would also be important to
> >> > double-check that the interrupt we cared about actually fired.
> >> >
> >> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> >>
> >> ath10k firmwares work very differently, on what hardware and firmware did you
> >> test this? I'll add that information to the commit log.
> >
> > I am running on a Qualcomm sc7180 SoC.
>
> Sorry, I was unclear, I meant the ath10k hardware :) I guess WCN3990 but
> what firmware version?

Ah, sorry!  Yes, it appears to be wcn3990 based on my device tree:

$ git grep -A2 wifi -- arch/arm64/boot/dts/qcom/sc7180.dtsi

wifi: wifi@18800000 {
        compatible = "qcom,wcn3990-wifi";
        reg = <0 0x18800000 0 0x800000>;
        reg-names = "membase";

Firmware isn't final yet, but currently my boot log shows:

qmi fw_version 0x322a01ea
fw_build_timestamp 2020-05-20 03:47
QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1

-Doug
