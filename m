Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48EDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9292620679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjXvDmBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgFOOju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730665AbgFOOjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:39:49 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A68C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:39:48 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id u15so3979496vkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEeXvFEwQXQ2y1eWlGB8T8Xdt9cee0AQhh/eHPPAS7A=;
        b=IjXvDmBNK5eFh5/xjjshicx5i0C0eryt36PZLb6YWSCQUQbzhvG1iR7GQQNXMe6GMg
         QETkfdn5LSARucFRdaAqF9OtFB+jgMVp55JCfmlpdbnwKJXbddu6Vgm1rUVIPBOtV7nv
         jLtitgQgqLA7qf1vzt6Eys8MG767Vc5x0+oJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEeXvFEwQXQ2y1eWlGB8T8Xdt9cee0AQhh/eHPPAS7A=;
        b=XbrEXPow08DbTtfnFNX5Lu7Hq3eXw0TrbrH3w1M9p/DKr5qJtIYfouqvrh8MPKjoxG
         ExmX1i4pr8knjDoXnFAzI5zGt7FEErnGQb7q/wJPxw+8BUjSI+jLrybbJxMlPl6uQUxa
         8ts17UoFQTWK+gIU0AV2QQufz7xnZet17JLp8r1qyABd7HEPiPLaMlnbhxVCv8AP4I4k
         d+j/mfbeyPL4uoviTuTg2BCTsyGGkAXSQfDMqTtMVufExECMUnnPp+uwNLmM0aY11ON1
         J/3kN2+5ssb9jwp7ihcpqnItUoJPD+uawndxRjLlmuvpYF+5YR0EDiAmJ24k9k9QRds5
         Fo3w==
X-Gm-Message-State: AOAM530KV2RebxqMR5QKnkdAEa1adiMfLFsQGT29dAiBXvvFm1BvYOUg
        Ld9siqgEVUgMoZdN/iFZ65bbPTaJ9BU=
X-Google-Smtp-Source: ABdhPJwELxkZBBkvX9LKKkbh9M4dNzlc661K5iHIIh8zBe2IBpZ4D3jhjJhZr4dTaD76JqrDYpLmNA==
X-Received: by 2002:a1f:ab0f:: with SMTP id u15mr17773919vke.99.1592231987131;
        Mon, 15 Jun 2020 07:39:47 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id y141sm996308vkd.4.2020.06.15.07.39.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:39:46 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id j13so9495939vsn.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:39:45 -0700 (PDT)
X-Received: by 2002:a67:1703:: with SMTP id 3mr20641752vsx.169.1592231985028;
 Mon, 15 Jun 2020 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200609082015.1.Ife398994e5a0a6830e4d4a16306ef36e0144e7ba@changeid>
 <20200615143237.519F3C433C8@smtp.codeaurora.org>
In-Reply-To: <20200615143237.519F3C433C8@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 07:39:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaexjLaaZJSxndTEi6KCFaPWW=sUt6hjy9=0Qn68kH1g@mail.gmail.com>
Message-ID: <CAD=FV=VaexjLaaZJSxndTEi6KCFaPWW=sUt6hjy9=0Qn68kH1g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Wait until copy complete is actually done before completing
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     kuabhs@google.com, Rakesh Pillai <pillair@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath10k@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 15, 2020 at 7:32 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > On wcn3990 we have "per_ce_irq = true".  That makes the
> > ath10k_ce_interrupt_summary() function always return 0xfff. The
> > ath10k_ce_per_engine_service_any() function will see this and think
> > that _all_ copy engines have an interrupt.  Without checking, the
> > ath10k_ce_per_engine_service() assumes that if it's called that the
> > "copy complete" (cc) interrupt fired.  This combination seems bad.
> >
> > Let's add a check to make sure that the "copy complete" interrupt
> > actually fired in ath10k_ce_per_engine_service().
> >
> > This might fix a hard-to-reproduce failure where it appears that the
> > copy complete handlers run before the copy is really complete.
> > Specifically a symptom was that we were seeing this on a Qualcomm
> > sc7180 board:
> >   arm-smmu 15000000.iommu: Unhandled context fault:
> >   fsr=0x402, iova=0x7fdd45780, fsynr=0x30003, cbfrsynra=0xc1, cb=10
> >
> > Even on platforms that don't have wcn3990 this still seems like it
> > would be a sane thing to do.  Specifically the current IRQ handler
> > comments indicate that there might be other misc interrupt sources
> > firing that need to be cleared.  If one of those sources was the one
> > that caused the IRQ handler to be called it would also be important to
> > double-check that the interrupt we cared about actually fired.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> ath10k firmwares work very differently, on what hardware and firmware did you
> test this? I'll add that information to the commit log.

I am running on a Qualcomm sc7180 SoC.

> --
> https://patchwork.kernel.org/patch/11595887/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
