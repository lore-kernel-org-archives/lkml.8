Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23385C43465
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A76722D74
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="lCF8wWCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgHFKFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729329AbgHFKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:03:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8405DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:03:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so9089793wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=thuOgRWoJSiXngrkHFGbsfIZnwU9NmhVSVR+aT5YyLw=;
        b=lCF8wWCdtHQ1JKy3lTUKeRzzyNy+K3JW90qj/IlVPjRfOQlOxbA+UXeqL+QHNuQRnJ
         n1IKMrr3WuuM1MkpRgJqLAnXcyp0VH770JBULV7Rl91JXR/LEJ896bEiBL12gCzNBh0c
         TX/kHE3hgNEHK1Xxgl8BRvjHywdd1T3Gg3vjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=thuOgRWoJSiXngrkHFGbsfIZnwU9NmhVSVR+aT5YyLw=;
        b=Zp48Nhyxp4DiwIP2S0hrEG4T6GIAirsKghRTKzz9p3bQMdeE7hYUgxfA9tCL4Rywwp
         HM7iBDPcbTNMgjYOTz8ZF970AarajTN3mnutn3oG5i4/quAEuKuM8CABxgYmBL90Ava7
         jHchQ1/WqAbfZw478YQ2n4WAOQlWEkXuj2TE+vhrG3f/gwSTa95MMg289vuc4QeejobZ
         x2kX2rNnRAKoolUB1wXxPK8ItT5KH+0ZrBsN2vFpbpFES3nxZnrC78A/4LqDWrc9vR/I
         6EfY0eRGIPfWEJ6LslHrpNulkriKS5kzoHakKB7S2yy53hiigaP0wmuZQMWsqUtsILj4
         tVtA==
X-Gm-Message-State: AOAM532Iclv17Bo6ZQAO5Np7JLfdPn7V6ZRy9/mHOZ6lDJD3pB9EKgya
        HMGXLY6gT957r9/wq5zBPNvpWpAl6A0lT+jfUdxRV5vE
X-Google-Smtp-Source: ABdhPJznltzdnGyCEoPwpkVl+9eHUBy3alTyIccH2CkEp4L4g9FFW3B8jV+SXjH43rvLm6rnvAFqPSmiLgu/aik4sxE=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr7543291wmh.4.1596708200991;
 Thu, 06 Aug 2020 03:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200805110052.2655487-1-daniel@0x0f.com> <20200805110052.2655487-3-daniel@0x0f.com>
 <a2ac8875d67ce7afe1b28f01683e0c9d@kernel.org>
In-Reply-To: <a2ac8875d67ce7afe1b28f01683e0c9d@kernel.org>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Thu, 6 Aug 2020 19:03:10 +0900
Message-ID: <CAFr9PXmzZmHWv+DWppaXOih9p5pJK=3JYCCC+-XrnQ+S7sV+fw@mail.gmail.com>
Subject: Re: [PATCH 2/3] irqchip: mstar: msc313-intc interrupt controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        tglx@linutronix.de, jason@lakedaemon.net,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Willy Tarreau <w@1wt.eu>,
        mark-pk.tsai@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, 6 Aug 2020 at 01:26, Marc Zyngier <maz@kernel.org> wrote:
> > +struct msc313_intc {
> > +     struct irq_domain *domain;
> > +     void __iomem *base;
> > +     struct irq_chip irqchip;
>
> Why do you need to embed the irq_chip on a per-controller basis?

Current chips have 1 instance of each type of controller but some of the
newer ones seem to have an extra copy of the non-FIQ version with different
offset to the GIC.

> > +};
> > +
> > +static void msc313_intc_maskunmask(struct msc313_intc *intc, int
> > hwirq, bool mask)
> > +{
> > +     int regoff =3D REGOFF(hwirq);
> > +     void __iomem *addr =3D intc->base + REGOFF_MASK + regoff;
> > +     u16 bit =3D IRQBIT(hwirq);
> > +     u16 reg =3D readw_relaxed(addr);
> > +
> > +     if (mask)
> > +             reg |=3D bit;
> > +     else
> > +             reg &=3D ~bit;
> > +
> > +     writew_relaxed(reg, addr);
>
> RMW on a shared MMIO register. Not going to end well. This is valid
> for all the callbacks, I believe.

Do you have any suggestions on how to resolve that? It seems usually
an interrupt controller has set and clear registers to get around this.
Would defining a spinlock at the top of the driver and using that around
the read and modify sequences be good enough?

> > +
> > +     if (flow_type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_LEVEL_HIGH))
> > +             reg &=3D ~bit;
> > +     else
> > +             reg |=3D bit;
>
> I don't follow grasp the logic here. What happens on EDGE_BOTH, for
> example?

To be honest I don't quite remember. I'll check and rewrite this.

> This driver has a massive feeling of d=C3=A9ja-vu. It is almost
> a copy of the one posted at [1], which I reviewed early
> this week. The issues are the exact same, and I'm 98%
> sure this is the same IP block used by two SoC vendors.

This would make a lot of sense considering MediaTek bought MStar
for their TV SoCs. The weirdness with only using 16 bits in a register
suggests they've inherited the shared ARM/8051 bus that the MStar
chips have. Thanks for the tip off.

Cheers,

Daniel
