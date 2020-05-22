Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB37C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15A520757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="nbAF/rad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgEVGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbgEVGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:44:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EEEC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:44:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so8762398wmu.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=srP7ViQWuk8gYrSzlJDDpsMNMVGdXtKx3PJIsQqVsew=;
        b=nbAF/radFKg0JTqXnE60JqYHZmDYODGWY9hlBRKa3BF61ZyleZAkXggKz+J7ogsZpD
         e+AtBBBKCPDKG+LWj7WK3f9WcMpXJ1zYT6YLanVLiXHPqLELMDgeWoMqdvMc8Fo8SFHl
         EcMKDH1XlCBUMJgHg0GVbc8NOd4TC60Nw1lTWRjI4mW5cF0l+GTUxmpyKuY2/lN2atWH
         thSjwkNjqjgBRwlUxwB0U+CZzwJZhloDed2QvumgFwdufRUbRU3MPDZBC30vqiHrBHhc
         cDZZwgBUp0gHGpwEuDa5KQO09URDpsxTBs9CPIE4XV7VUYAbl4B8huYRUKuLvr10QlSH
         90ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=srP7ViQWuk8gYrSzlJDDpsMNMVGdXtKx3PJIsQqVsew=;
        b=V8hz7gPCO562r85YkX8yBlEpZOMxOx4G96XXxQRuHxh5eAYNgnM0qJaxK1fhef8TR1
         6Ak8AnsSFlV8ICsWrKPmzO0NmFNqJ1tb9om7FWWOnlZFZK7Lqe0HaDilekA1pzWjjDdN
         til5lhhXuMAJCLNFuyRZ9KLExhDtdC5yfXVvj3AIXsrDbkrL+lPYRdfhEzJSvqRFKFjP
         5OAA8sPy5LX2iDEMFsVmJZ8S92XdSHOHIdpFp7u5omeyhhESiWcTRZsr6kwxXDR4v9iz
         L9EB8/4XBmiqBAHsgx1jS5FlL/Dy2tja0K7WDUYOYzlOqE+VfE8tspcYP07X3LTgCLlQ
         jSBA==
X-Gm-Message-State: AOAM53001JUa+FnFXfSDjS4OVmagAVf6JPnbDup/C20J5s3WkAO3Uf7i
        Sq19DZaYpjwpmgUAspiQKW+sEyuBFpKKUEzZW8Dl9g==
X-Google-Smtp-Source: ABdhPJwYvmQAKNAdEtDF2lkuLPxuXrswdEf7MIonLNzRUZnJkpxeElIXQrYUopv0xM1XZE6wayG1r0Tgl/UL0dMyLlY=
X-Received: by 2002:a1c:7410:: with SMTP id p16mr12607532wmc.134.1590129852604;
 Thu, 21 May 2020 23:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091441.94843-2-anup.patel@wdc.com> <mhng-724b2ebd-3b41-4b3e-8685-26860402e663@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-724b2ebd-3b41-4b3e-8685-26860402e663@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 22 May 2020 12:14:00 +0530
Message-ID: <CAAhSdy1X=4veB_3XDbrtVMc2KkZip-7bdaet9JqO3fGik4Oo1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 3:36 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 18 May 2020 02:14:39 PDT (-0700), Anup Patel wrote:
> > For multiple PLIC instances, each PLIC can only target a subset of
> > CPUs which is represented by "lmask" in the "struct plic_priv".
> >
> > Currently, the default irq affinity for each PLIC interrupt is all
> > online CPUs which is illegal value for default irq affinity when we
> > have multiple PLIC instances. To fix this, we now set "lmask" as the
> > default irq affinity in for each interrupt in plic_irqdomain_map().
> >
> > Fixes: f1ad1133b18f ("irqchip/sifive-plic: Add support for multiple PLICs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 822e074c0600..9f7f8ce88c00 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -176,9 +176,12 @@ static struct irq_chip plic_chip = {
> >  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >                             irq_hw_number_t hwirq)
> >  {
> > +     struct plic_priv *priv = d->host_data;
> > +
> >       irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> >                           handle_fasteoi_irq, NULL, NULL);
>
> If you're going to re-spin this, d->host_data could be priv here.

The controller's private data is named "host_data" for "struct irq_domain"
in Linux irq subsystem hence the usage.

>
> >       irq_set_noprobe(irq);
> > +     irq_set_affinity(irq, &priv->lmask);
> >       return 0;
> >  }
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks,
Anup
