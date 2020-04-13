Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCEC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:17:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA50820737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="d+Yd08Mh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA50820737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgDMHRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgDMHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:17:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A172C008651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:17:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so9066128wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bpjMW+GzYcPR9daW21i+rWw6xTJ7uzEt7yYYDWZye8=;
        b=d+Yd08MhDy3n8uPAj61nMpr6ym0sQVpFn9ynW2A0zRLpEMdwd/dsjtXGr3CvZmqP8x
         c/a6V17JRXiNYECZoGXbC4MAz73FGaWzN85B2hCki5r7INf5tJhtDs1r/ylqQAplwnob
         Gepqu5Eexv/gu+4QyOV6VbGL6spp+v/OC94z7OdhM8a2vqrnHphuzIKEBrg+ncZk7U0Q
         UeADtyYBuxTAURI5pSSYJMxyjJ5Ett033nAdFiZ4JAK8EoPAg6w29GeWBFMq+//HuOSp
         wGiOLsNGAuwxERm8Vx8kakGYf+UYJ91V71tqR8k1egAGH0foE/BXeOBpTurqvQv23lob
         1Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bpjMW+GzYcPR9daW21i+rWw6xTJ7uzEt7yYYDWZye8=;
        b=nqby0906A0XHhx1EvHa4+sna1yHvtQD7v8dybOg1N5d6Sc+w/jTn+SrcBW8twKW+Du
         UiaE6aDh7rIswW8kIu6YWawn0LNHFsYdBoUvyj68QOhgMbijPtFtgOjqlERakytux2cO
         HQGfqP4z94vfR1y/6x4QjeCn81g97hnRBM5DVgJMSKVTlnDzxaH3qJnHTcteaC13Xvfa
         2rSNg6E035lKDhuWwoZqXUxra521hqPHCWGM3b3TTJwlRzCm7Rc7aymwTEXRo8iGnjOA
         SyGmhNcGiZE/+TZoIQgkHnMWorr418JjsCoaI/aLJ6QowGoMsa0oFlKLnRQsVnj6DoUZ
         fNug==
X-Gm-Message-State: AGi0PuZpWc0lcp4SyVrqWGIEnWxxRbOYuw59qEmbx80a2vtnAK+t+nEn
        fovZWO1giZVVCMATAjA71EgQ4L0+MZF8SWT/a4uk
X-Google-Smtp-Source: APiQypI9nvk1IhbIpRM+ZnkxURJZCjtr6zR4g2ZnYcmJZqyKuoof/HH794rUfdXRFaYSW06NnIFLJmnuzBYyoAvb3mU=
X-Received: by 2002:a7b:c10d:: with SMTP id w13mr16952860wmi.78.1586762223184;
 Mon, 13 Apr 2020 00:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200403014609.71831-1-atish.patra@wdc.com> <20200411115919.32fc0455@why>
In-Reply-To: <20200411115919.32fc0455@why>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 13 Apr 2020 00:16:51 -0700
Message-ID: <CAOnJCUK=mvru3J_KrE0viazGTintbBJEPDT=kcUgpktKb5X3tQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix maximum priority threshold value
To:     Marc Zyngier <maz@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 3:59 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu,  2 Apr 2020 18:46:09 -0700
> Atish Patra <atish.patra@wdc.com> wrote:
>
> > As per the PLIC specification, maximum priority threshold value is 0x7
> > not 0xF. Even though it doesn't cause any error in qemu/hifive unleashed,
> > there may be some implementation which checks the upper bound resulting in
> > an illegal access.
> >
> > Fixes: ccbe80bad571 (irqchip/sifive-plic: Enable/Disable external
> >                    interrupts upon cpu online/offline)
>
> Small nit: please write the "Fixes:" tag as documented in
> process/submitting-patches.rst:
>
> Fixes: ccbe80bad571 ("irqchip/sifive-plic: Enable/Disable external interrupts upon cpu online/offline")
>
> (with quotes, and on a single line), as it otherwise breaks with the
> lore-scrapping tooling which a bunch of us are now using.
>

Ahh Sorry for that. I will keep that in mind. I broke it into two
lines fearing a checkpatch warning.
But I guess I unleashed a bigger monster unknowingly ;)

> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index c34fb3ae0ff8..d0a71febdadc 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -56,7 +56,7 @@
> >  #define     CONTEXT_THRESHOLD                0x00
> >  #define     CONTEXT_CLAIM            0x04
> >
> > -#define      PLIC_DISABLE_THRESHOLD          0xf
> > +#define      PLIC_DISABLE_THRESHOLD          0x7
> >  #define      PLIC_ENABLE_THRESHOLD           0
> >
> >  struct plic_priv {
>
> Queued for post -rc1.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
>


-- 
Regards,
Atish
