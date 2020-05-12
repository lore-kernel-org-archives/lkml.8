Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060E9C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D995D20753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 12:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXp5LWlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgELMfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729693AbgELMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 08:35:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA49C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:35:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u20so3138948ljo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 05:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4+869pZRfZJGBIoOGq9mbn83yXJ+3UvweYCO0bpzAwU=;
        b=UXp5LWlOcqJH4Otgcn6q2A/q237JlCum+6BEJUbhK3WCudK1bkbQ749omybmNu/3GT
         144x3LhV8t+xWMxbIoPgDMj+X3EI033ppEuEJhGDane5FEBqRYnOfLaVGLMsxYZvffi8
         jl/3Mg4YWPlQowpVgZTm6stKpaLrns46uAFa8Mmq/asfIME0nHcs+9Zzez6daQdqXZ+q
         MvqfSVB/ERfLsc/7464D8pTh8/uX3asXjb5DRGj/wmQFWpsdg3WeX7ex2JBAHeCQZ8mi
         4phPCqUEkxDkgK59hWRd+l+E1LKLDdKILaREvTtkahvakxfN6ei+ZK7ZpUW3Qelm+UQH
         ZQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4+869pZRfZJGBIoOGq9mbn83yXJ+3UvweYCO0bpzAwU=;
        b=Q2uJ0D3PnbpY5s391TqXiPg80ODJBhp8dKLpQEMEUwMvFXHrHbt61zqwXh1BRUl8gm
         HfgvYzbOJzxdIJRI5yMRy3CWm5/3xnBHyYyHJXHsSW2mIBRiMmEJX1npEm/3s9fA0mHi
         qn7iJWZd2Tk+4d+5ABu03Rk63YM4010t2dCO60fRWLk5j+SyS68zWVqPG+9FRf8cUIzw
         0cyNMZS/pHZOuvhnXFRheEfMnYeXj60nVX/rXSlDwxgjCK5VCV8C5Fs8emMYBS+kTqyv
         Q5x15o1sgmPEiA+QdpwttKAzkYIDQthCh3pzZBElX34QuEmYA3ksct9KoOlqSq/xquaO
         ZO6A==
X-Gm-Message-State: AOAM530ddY3Au+4HnjJeUnaicMyYNfeP9nQ4lka3dT/YfaMXFk2CnnED
        3f37MKcfyZk8d26lFdVS9SnQLPdlpWKHJGcf1hLJEg==
X-Google-Smtp-Source: ABdhPJwyAmzC6q+bZTHJQiILGIOYXc53TsNeXcXr1K8tekap2deRZGY7SbCRt6J66veik8VTCp6tr6H0vjULsNvGn30=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr12693709ljg.99.1589286928448;
 Tue, 12 May 2020 05:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200501224042.141366-1-helgaas@kernel.org>
In-Reply-To: <20200501224042.141366-1-helgaas@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 14:35:17 +0200
Message-ID: <CACRpkdbkPX3cX9VDoGx9LMLPgDFxwVbWQuKuaSyED5Nek0ATRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: Check for platform_get_irq() failure consistently
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Aman Sharma <amanharitsh123@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 12:41 AM Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> All callers of platform_get_irq() and related functions interpret a
> negative return value as an error.  A few also interpret zero as an error.
>
> platform_get_irq() should return either a negative error number or a valid
> non-zero IRQ, so there's no need to check for zero.
>
> This series:
>
>   - Extends the platform_get_irq() function comment to say it returns a
>     non-zero IRQ number or a negative error number.
>
>   - Adds a WARN() if platform_get_irq() ever *does* return zero (this would
>     be a bug in the underlying arch code, and most callers are not prepared
>     for this).
>
>   - Updates drivers/pci/ to check consistently using "irq < 0".
>
> This is based on Aman's series [1].  I propose to merge this via the PCI
> tree, given acks from Greg and Thomas.
>
> [1] https://lore.kernel.org/r/cover.1583952275.git.amanharitsh123@gmail.com

Makes sense to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

for the series.

Yours,
Linus Walleij
