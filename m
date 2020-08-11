Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E562C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E6620756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3ZdlnlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHKUJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKUJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:09:16 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF57C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:09:16 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z12so966409uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6qJqVdc/uC0k/47tmN/6OGWwLLeKwWyMRmMGNyMuMes=;
        b=H3ZdlnlZZbMSAPEofrl6nm6YexFFLFIlxi1eqa1GptjaFwv/xFa49I/fUr0oFBROIv
         9aU6FfSZBMqZYb8nS74vVLPJYMrj7tE81Xq79ZWbCcCyu4RRn0sOk9D/yKEs59P3iJcR
         14Kbt+2OH5xfn8oZtuAkZoCLV21W+/GQ320Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qJqVdc/uC0k/47tmN/6OGWwLLeKwWyMRmMGNyMuMes=;
        b=NPpcRhLe0jdY9Dvt+jDrrMWQll9NS2LWnC4iLrcfDVmLBB6JI9lBTPMwycfe2j86Bq
         BiHzNPyy8UUmXUjmP1tTuRH2Jl/mzzE/GFvVrZzXIsnLDSRXaNAIvWkmWl1/d9ElTPOG
         iJ2O/jDlJz5jB7w9RHcss/Yj5LilLF+56ibXXyrsZasyq9itcwx5G9KJCX3y/58LoqDr
         IpmrSKDqvIvUcewEGnDlfmWV7NQsNF0IntgDHBc3n1Mc6yvn+AznA3MjHdXidvFpbp2c
         DWR75wlhmHGWAvgX0dg+5sw98haCEJoMfBGS4ZCK0XlLHqIyTitL43p3a2FuqbGD5KAj
         FS/g==
X-Gm-Message-State: AOAM5332rEyhpzrekR/N6gNlVyYWMj560ZT+6iTO3hhWStOEQNYMsp8s
        D3D5CZpGQznxiqpUAwLE6ZxFAR69eTg=
X-Google-Smtp-Source: ABdhPJzfR8i6cwOS4PeRxA5nX5BI5fZG7oQS9QrG9iiFXt1Di9TAndGOOhEEizZXStwZIIdm8bylbg==
X-Received: by 2002:a9f:29a5:: with SMTP id s34mr25782840uas.111.1597176554088;
        Tue, 11 Aug 2020 13:09:14 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id s5sm7280431vsk.10.2020.08.11.13.09.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 13:09:13 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id n25so6643497vsq.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:09:12 -0700 (PDT)
X-Received: by 2002:a05:6102:213a:: with SMTP id f26mr25614974vsg.6.1597176552506;
 Tue, 11 Aug 2020 13:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org> <1597058460-16211-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1597058460-16211-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 13:09:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XH3183sJiP68v_Ka2+b=rYb8Y=7G=RcdbxdsK+nzyW=g@mail.gmail.com>
Message-ID: <CAD=FV=XH3183sJiP68v_Ka2+b=rYb8Y=7G=RcdbxdsK+nzyW=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] genirq: Introduce irq_suspend_one() and
 irq_resume_one() callbacks
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

On Mon, Aug 10, 2020 at 4:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> From: Douglas Anderson <dianders@chromium.org>
>
> The "struct irq_chip" has two callbacks in it: irq_suspend() and
> irq_resume().  These two callbacks are interesting because sometimes
> an irq chip needs to know about suspend/resume, but they are a bit
> awkward because:
> 1. They are called once for the whole irq_chip, not once per IRQ.
>    It's passed data for one of the IRQs enabled on that chip.  That
>    means it's up to the irq_chip driver to aggregate.
> 2. They are only called if you're using "generic-chip", which not
>    everyone is.
> 3. The implementation uses syscore ops, which apparently have problems
>    with s2idle.
>
> Probably the old irq_suspend() and irq_resume() callbacks should be
> deprecated.
>
> Let's introcuce a nicer API that works for all irq_chip devices.  This

You grabbed my patch (which is great, thanks!) but forgot to address
Stephen's early feedback from <https://crrev.com/c/2321123>.
Specifically:

s/introcuce/introduce


> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -468,10 +468,16 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
>   * @irq_bus_sync_unlock:function to sync and unlock slow bus (i2c) chips
>   * @irq_cpu_online:    configure an interrupt source for a secondary CPU
>   * @irq_cpu_offline:   un-configure an interrupt source for a secondary CPU
> + * @irq_suspend_one:   called on an every irq to suspend it; called even if
> + *                     this IRQ is configured for wakeup

s/called on an/called on

> + * @irq_resume_one:    called on an every irq to resume it; called even if
> + *                     this IRQ is configured for wakeup

s/called on an/called on


-Doug
