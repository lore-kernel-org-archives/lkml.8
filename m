Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686DCC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427D92074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NCdIJS3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgDUHrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUHrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:47:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE0C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:47:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so14078496ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OeY1D5X0JTe+X4nNccsTmfIHAJbVoZEYQTxgNeqW028=;
        b=NCdIJS3I3tyMbQF5olMC+eUV6oQEQKyGdY9AXUQLfpzFEDXi6k5GMbZK/iNrkE/LFj
         MHjHx8MCqFEjTe3OpSCjvgjswdR/xfdxAqaaktflmnX6Q3uE5egmYuO+Pe4lXlkWCjFw
         sthcMkuVk0Fb7zK9/r6LjPM8k98RNebHHT69pVnq6068yJgGfd3wmKbHpEuGQzpMDH+L
         N6Q5w96ta8azjJdeXVIYLRGqS2Q+QZVinSjajx/yZMgrmUhg+kRF0JTSF7QXI2BcwAI/
         kRQ+vo5H1vhvrUu/wAXPwh/JBDtfAftYF3eLMdM/E4hPhZ89+WEy1cekgin+66XU6Kw+
         puTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OeY1D5X0JTe+X4nNccsTmfIHAJbVoZEYQTxgNeqW028=;
        b=GcFiZ3c8zh7bo9Tl7goUHGLWjYLeLthGrlrNMqhYmNxekN6+4fawGxlkrqGkJQ26v6
         /e1E9tP7kaGL8FksU5bYkoPSPwsdKXlBs3RcBFlYwn3r2yRsaHCobxeSBj67UWZxmpSS
         hTZiUZId24ztHBWKuSBlV/V1DGXR7oHq8UGeLRAn0OTSgydkZYIbY+Dje7ewE2xpZqHi
         aBd4dxZMv6g5hrmaZheXoq2WPXQSALUHeP3bQ+gzdwI022FVL9gF79+JXb66P6YFRcCv
         Nf3oXBlMTrs/MI9FgqFRg8jfV8+wuxpeYe2fusvP/JYy9yjSSI9duqVm6JRwKvZDSzCv
         61kw==
X-Gm-Message-State: AGi0Puav4Tx622oll1TnLbrO1YK/fRwkPfjcV+kdHvXY+/kI/OBIaYGa
        uTRH5zjS0IK31JiHI6NxErm6ut3TgYCpMlXmakWOfg==
X-Google-Smtp-Source: APiQypK8Fgiv9fuxZ96YyuvwHZijN8BQ7LGwA3Vk2+rHhZNpoJL5ML+jbbE9xAFzb+UsDPsxi8UytpkHJxDB0QJRJng=
X-Received: by 2002:a05:6602:199:: with SMTP id m25mr19489799ioo.13.1587455238413;
 Tue, 21 Apr 2020 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200417080549.23751-1-brgl@bgdev.pl> <20200417080549.23751-2-brgl@bgdev.pl>
 <CAHp75Vf_kBfb_oLB2Dp48iYiDgs2k_RgzpudTvQMoxNYGMz3TA@mail.gmail.com>
In-Reply-To: <CAHp75Vf_kBfb_oLB2Dp48iYiDgs2k_RgzpudTvQMoxNYGMz3TA@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Apr 2020 09:47:07 +0200
Message-ID: <CAMRc=MdopCtsB23bk058iHd2LGqecqot1nAsi5S8x72U4wiGCg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] irq: make irq_domain_reset_irq_data() available
 even for non-V2 users
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 17 kwi 2020 o 12:50 Andy Shevchenko <andy.shevchenko@gmail.com> napisa=
=C5=82(a):
>
> On Fri, Apr 17, 2020 at 11:13 AM Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > irq_domain_reset_irq_data() doesn't modify the parent data, so it can b=
e
> > made available even if irq domain hierarchy is not being built. We'll
> > subsequently use it in irq_sim code.
>
>
> > @@ -475,7 +476,6 @@ extern int __irq_domain_alloc_irqs(struct irq_domai=
n *domain, int irq_base,
> >  extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_ir=
qs);
> >  extern int irq_domain_activate_irq(struct irq_data *irq_data, bool ear=
ly);
> >  extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
> > -
> >  static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
> >                         unsigned int nr_irqs, int node, void *arg)
> >  {
>
> Seems extra hunk slipped to the patch.
>
> --
> With Best Regards,
> Andy Shevchenko

Indeed, I'll wait for more reviews though before resending.

Bart
