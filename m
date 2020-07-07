Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2172065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxAa+leS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGGMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgGGMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:50:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6492C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:50:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so49694179ljv.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SwgAW+EG6tvCZIqxu3/JdX2TBmPRZ3QJRu9pLXvW98=;
        b=IxAa+leSkBpoUh5Bq/NRPDMzIbc1ztNHK7Nt3NEW/4c5o/7sJR21qImZuPRUcTthg+
         MelICmihE9tq7OeoCBCxGvGU87PkJ+3NDd2CeIrZ2eQvKrts3wfxg7P+Zy+2SKtZAF1c
         pVjNDUTVxWkqk/LFvlBBHCLYetSAgkf7RQ3ZOBQQP64oJd4mXHwoN2jRLF4dzCm51/za
         w9hmt0b2U3ZkovysI0KP+7NFKtJzOEj2OZ+s5FK1XDpGj3/CjOwesQJGHTYVxVUa8C7j
         Zhgv1BsDH6wUwdwSAXGGypMbhKjoHNCAC67GrMOnYAc8d5jBQQBP4vE/5l2gLbu5QIRi
         ZVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SwgAW+EG6tvCZIqxu3/JdX2TBmPRZ3QJRu9pLXvW98=;
        b=hIYmcT7K1FCzsZJ4n83jaLI0dTF+1rSehpMgHy0lw+EwktG8gXMJJ29WX2ZELiP0tT
         QdGp1qLNSCajzfIGQ+9KqqPOkZm2fg/QHgvST/5uu5q7+2TOwvCeKLHb3CoZO3XkyefH
         s+5uHff2zwPqSCwAZiaQBeFL8v7/2T6aYQNcpMml3ugYpHod0hApkA2YVj7gYMid1lJN
         RevtYUsg8UFhlVZUAPQDEfuO01+0pw7QTHX5+Gln1u4mg7F2C7jLu1KFnpNt0RzfNKbh
         ea7bSidustv8Gx/AQ8ullnL8guD8a2i/K4ALDxG60pm8L1a4vd/kOEWb3kPzT9ZvGtGo
         xcyA==
X-Gm-Message-State: AOAM530UxpUVORh5XT0lgodW1nUM8n6W11mSztyY+p4Gi8c35CIGxor7
        wk8ZVEcraQ6B9DPKi1HlnGqRy5U+mBNnU68H6q5uxQ==
X-Google-Smtp-Source: ABdhPJwb40quVLTqVbxWUanPuFGtQykjLJsdQp6TTKdlw6gNizun/jdSZa0XI0eJCmX/F+MxnSVBrBxnftFaqvy1VKI=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr16143076ljg.100.1594126211220;
 Tue, 07 Jul 2020 05:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626211026.513520-1-furquan@google.com>
In-Reply-To: <20200626211026.513520-1-furquan@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:50:00 +0200
Message-ID: <CACRpkdZoTs1WHhmJtu37DW=7WhGtThD5Am46K9LwR10EAxqNwA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: amd: Honor IRQ trigger type requested by the caller
To:     Furquan Shaikh <furquan@google.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        akshu.agrawal@amd.com, adurbin@google.com,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:10 PM Furquan Shaikh <furquan@google.com> wrote:

> This change drops the override in `amd_gpio_irq_set_type()` that
> ignores the IRQ trigger type settings from the caller. The device
> driver (caller) is in a better position to identify the right trigger
> type for the device based on the usage as well as the information
> exposed by the BIOS. There are instances where the device driver might
> want to configure the trigger type differently in different modes. An
> example of this is gpio-keys driver which configures IRQ type as
> trigger on both edges (to identify assert and deassert events) when in
> S0 and reconfigures the trigger type using the information provided by
> the BIOS when going into suspend to ensure that the wake happens on
> the required edge.
>
> This override in `amd_gpio_irq_set_type()` prevents the caller from
> being able to reconfigure trigger type once it is set either based on
> ACPI information or the type used by the first caller for IRQ on a
> given GPIO line.
>
> Without this change, pen-insert gpio key (used by garaged stylus on a
> Chromebook) works fine in S0 (i.e. insert and eject events are
> correctly identified), however, BIOS configuration for wake on only
> pen eject i.e. only-rising edge or only-falling edge is not honored.
>
> With this change, it was verified that pen-insert gpio key behavior is
> correct in both S0 and for wakeup from S3.
>
> Signed-off-by: Furquan Shaikh <furquan@google.com>

Patch applied.

Yours,
Linus Walleij
