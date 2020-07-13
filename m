Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473072089D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSeqsacE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGMWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgGMWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:25:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D0AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:25:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so11339252qtm.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHfgfv2mP6dp6kaJTVFYuFviBEEN6wpOON6T0JxtLVk=;
        b=cSeqsacEiX0VNBd7mC9bj3A8JzJZlyD3j4cmXLuYevvPoeKEk8W+U5HnPEomxpm5bo
         LRaqdmOo5RVCRntAP5RSqQ9O5u+EP+mswHCf4O+Kth2ygENQ1VWCkbAMFQ+01IILIQun
         O0GExOUmlRIqEf/OfFr3Ctc6cYjV3RMpNtbgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHfgfv2mP6dp6kaJTVFYuFviBEEN6wpOON6T0JxtLVk=;
        b=MT95qihyQL5FANcr421MckKhSzLcD0IxT5caCGg35+bR28aO14GEAC4AwboTOwa4si
         kym+jpRR9S9WCcJqlspLpzLxAI3fz+WExiRQiHdlpPHCOfvG/LvXL3OFYWxAUowwj4gW
         YJih6tTXfqhaFHjBahSdVIpdOPF+y8AWL4ep8kQuKvPWX9S+uUs+BXUEpAQY92tfRI9l
         D9vVROL1uQN914DpFPgr7XDmyT+NmEhIeB65moio33ufkachJe+ArH1mW8PFjACsEM+9
         fw7KQmO+aS1q7LbUApS92+olIaSGrS9y1EK8fN7ZDTBaNonehvBYFvV/JgV33QolflcC
         /TIg==
X-Gm-Message-State: AOAM532mMnqRIg6KCVJpMWt7FL0oXkJg4vKNpO/KBLC9MKeDJRhBu6IA
        c2oqItmIc5PWq3DNijuxjvunZupf4Kw=
X-Google-Smtp-Source: ABdhPJwJEQ6owRV0pVvewCU5NeDzFrOVzjGyUanPFZfFao5TpZZAKpqHV5TceXuSA/miqgyLaCup4A==
X-Received: by 2002:ac8:7a69:: with SMTP id w9mr1654919qtt.179.1594679111392;
        Mon, 13 Jul 2020 15:25:11 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id i22sm19052158qki.4.2020.07.13.15.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:25:11 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id t11so6601089qvk.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:25:11 -0700 (PDT)
X-Received: by 2002:a67:e046:: with SMTP id n6mr1294693vsl.6.1594678686784;
 Mon, 13 Jul 2020 15:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-2-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-2-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 15:17:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WcbEH2O+7xqCyDfrPR0+g+MpWWsgORNPepC=VrhOanFQ@mail.gmail.com>
Message-ID: <CAD=FV=WcbEH2O+7xqCyDfrPR0+g+MpWWsgORNPepC=VrhOanFQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] pinctrl: qcom: Remove irq_disable callback from
 msmgpio irqchip
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 2:32 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> The gpio can be marked for wakeup and drivers can invoke disable_irq()
> during suspend, in such cases unlazy approach will also disable at HW
> and such gpios will not wakeup device from suspend to RAM.
>
> Remove irq_disable callback to allow gpio interrupts to lazy disabled.
> The gpio interrupts will get disabled during irq_mask callback.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 13 -------------
>  1 file changed, 13 deletions(-)

While the code of this patch looks fairly correct to me (there's no
need to implement the irq_disable callback and we can just rely on the
masking), I'm slightly anxious about the description.  It almost feels
like you're somehow relying on the laziness to "fix" your issue here.
...but the laziness is supposed to just be an optimization.
Specifically if an interrupt happens to fire at any point in time
after a driver has called disable_irq() then it acts just like a
non-lazy disable.

Said another way, I think this is a valid thing for a driver to do and
it should get woken up if the irq fires in suspend:

disable_irq();
msleep(1000);
enable_irq_wake()

Specifically if an IRQ comes in during that sleep then it will be just
like you had a non-lazy IRQ.


So while I'm for this patch, I'd suggest a simpler description
(assuming my understanding is correct):

There is no reason to implement irq_disable() and irq_mask().  Let's just
use irq_mask() and let the rest of the core handle it.


Also: it feels really weird to me that you're getting rid of the
irq_disable() but keeping irq_enable().  That seems like asking for
trouble, though I'd have to do more research to see if I could figure
out exactly what might go wrong.  Could you remove your irq_enable()
too?


-Doug
