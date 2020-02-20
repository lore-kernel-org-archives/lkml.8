Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C4CC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E57207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o44XTonv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgBTOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:49:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33466 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:49:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id y6so4553981lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDrnC3G0nhD9XUh8HdAqTDhyCn7anOqZtWlj+5/sqOU=;
        b=o44XTonvPj8TqzWB5/O7E1a47DtYcY27Mygp8ulMUaMbOKngMzCywkQ07bfi/mrWQe
         +zUADYPkkXeR1NzTDTy7i2VwaURKISiLQ09e/J6nMjh7O+UT7tNiR0dW7TSox+qQ1v+6
         PfRhb8tVtv95k5Ip1gtfADO3s38S6YOq7djSndPbC88Uiv0UqGYifWHnzs+o+zYXJLdU
         PwvbloIeHGjOtVnrdRosQ1MSPqriu8C295dnMJMDR4rBwaduDXA+0DPFrt2cr6bJp0Hp
         n07GPHOz01BDpk9NOZ1R9plSzL798uM4TPd/jkYOxg9BHSH+ba4Ojo//6p16tSbdnmoV
         zK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDrnC3G0nhD9XUh8HdAqTDhyCn7anOqZtWlj+5/sqOU=;
        b=q4MgruI7ZfNEqkg4jpXsfixZhCBIxtRWJTBLYHJsXqyJjIrsZg4qU7Nn2wZNvHKCAL
         bxsS0M9ebWqPR2sy6QR5cY5m5ViyL+0+xJFAepM2MfbWXwiULaqksP1vDZqh8po+0lEn
         yhR2H69LgirNav/Y0dUIHmGXmq4SvZ77d+39hV2RYbzxozcjljKasH+cKvKITzfc2z8c
         +nIKwtxIXxe5F9ed6PwbARUzmuM4VoMMhq6KGkZ3f4AZhJJY+g8kuHKU/rbVHxni7LrM
         syjB9j4u2D/cCAqfH1cHZbtfPiS6re6s1or+AXy6yzeF3JARUbQ166l2MNBmlP1IK/CJ
         gCXA==
X-Gm-Message-State: APjAAAX3mliIjrlRSWIf9LVaHCdDuJR1c/F4tEokJqvKJlmYWTLZojRV
        nVwZocR+vsZ/cBV7pN/qdkMiRqMuEwRqJ1a/wMHRJQ==
X-Google-Smtp-Source: APXvYqzzqCxX1uyxL0uXWVPvoyRs+YablM3SNrsygOhN/ynfhMm2fs9IWZW1Ss+54Lpjmhlt8cvARkWaEwlJ4LRV/pA=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr17846575ljo.99.1582210168460;
 Thu, 20 Feb 2020 06:49:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <0570d4c790f89fa070835fbaa4a106ec07ae6b76.1581478324.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <0570d4c790f89fa070835fbaa4a106ec07ae6b76.1581478324.git.afzal.mohd.ma@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Feb 2020 15:49:17 +0100
Message-ID: <CACRpkdaevKJHkcbsnVXWPcP05Tt=vvdUXRhhoZDceM4o9R2p=Q@mail.gmail.com>
Subject: Re: [PATCH 18/18] genirq: Remove setup_irq() and remove_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>,
        Brian Masney <masneyb@onstation.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 9:06 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> Now that all the users of setup_irq() & remove_irq() has been replaced
> by request_irq() & free_irq() respectively, delete them.
>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

Nice, cutting down and simplifying core code.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
