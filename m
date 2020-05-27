Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B768C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E43A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yPtc2Wor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgE0RGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgE0RGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:06:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2BBC03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:06:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h9so9564780qtj.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Lhu2ZcEcwwrOR37CL1brFOzPiOBufKSZIC4FQQB508=;
        b=yPtc2Wor4aOKqJgM9mCqbJiYDKwPnGCFGYXNxj12SXW369UtlgQZGLVdXV30NwYzZO
         xOPRn6AmKsb53FSpNBpXSjdR7FkAeWtZQfeFNThPDTZ/zYr+b0vRman0zIjoUfQoW5qZ
         xIHzSEuTDr68Xsyul5g7SSQnsI9O8JPUFz/TkKbNQ6fsO4MZ5Bt+HVOsqzKnZ7XF1L5l
         BexiMBwU9qQeCUB+L9tgJGedJHoQwuRNZso/rQIerZHTtzLdBZUdqde0hGTbv4aQxgO6
         HAUaM1GCCknfDzepc8ifaHScr+mr2SbwKX0HYEQRZMyuMN9DVgeK5trZQbWZQrU5o+A8
         N6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Lhu2ZcEcwwrOR37CL1brFOzPiOBufKSZIC4FQQB508=;
        b=auqNrYD2O0e4ndo+8PLkiHO6fSs15737NrN343wkDV6MzFLzK5FaqeROgMjLKzOR/P
         aEssvhQ/mlPyrdyG7xi3j6EDNemsOJ7OYt4PVyRMsSqsu6WqWL2pVPd/Dr50z2ZT9+RW
         E2D+y56HzbErejgr7SqnlIVzVGcfV8NEWpJU0F4iBKiOWwmbmlaCDynP3bA2vI1aZ1TV
         EGga1VlIvgekiABBOKKd1lDECSW3IVBW07Q9633JRhz8e0f8M0a31+EYpImoDnhbnRYm
         /gzWdgvILO3s7KWlMwT7aQYSn+EPjTTdcJ9qv2rPppD3qOagIRmM/+2/9x74VfyzyYu3
         y5xA==
X-Gm-Message-State: AOAM530tBq4qUkc28ey2PeZSG1yzBjUgpyS1euLHjPvCWlCc6AxKJw2T
        6HxU1n6KWQ6grKcZxUz1xTnz+M0///CQCzGf0umivw==
X-Google-Smtp-Source: ABdhPJxROTeFQEz0Kn+FsZBDkx+YaHV9yORoWcoDONnKZ1wtXCH8knWZXCjA6zt9CuIPkUvqUfwQCzIFXddHejoBTyI=
X-Received: by 2002:ac8:718d:: with SMTP id w13mr5369489qto.131.1590599197938;
 Wed, 27 May 2020 10:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200527161743.15972-1-brgl@bgdev.pl> <58fca7418c8d18392562aaad2c3a6634@kernel.org>
In-Reply-To: <58fca7418c8d18392562aaad2c3a6634@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 May 2020 19:06:26 +0200
Message-ID: <CAMpxmJVPB2+hD8mZ+Bo9=UVEist7BSJrZej5O9_9a_SmWyTanA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/irq-mtk-sysirq: drop unnecessary spinlock
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 maj 2020 o 18:38 Marc Zyngier <maz@kernel.org> napisa=C5=82(a)=
:
>
> Sight... Do you realize that these two locks do not protect the same
> thing at all? One protects the interrupt data, and the other protects
> the MMIO register which is shared between multiple interrupts, and
> on which the driver performs a RMW.
>
> Thanks to the removal of this spinlock, two irq_set_type() can execute
> in parallel and silently corrupt the register. Not exactly an
> improvement.
>

Eek I missed the fact that the internal lock is tied to the chip, not
the interrupt. In that case I'll convert this spinlock to a raw one.

Bart
