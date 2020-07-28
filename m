Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1194FC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D622070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tG4rNdPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgG1WXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgG1WXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:23:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B42C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:23:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so20368170qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wMDzveqXMcU7qz1vEvMmj5Kh0jEuVD57A0b/vJIJrw=;
        b=tG4rNdPI8R5LdMMO8xwPde56cVxcwd5fZAw2kzauifqgPFPeBuZ9hEyUHhD85W8bcI
         M1T/PlI64ZhklmxrEyELMjberZDJ4KzNnazmhwE09VlAAj0XK22zP/a/RK+PvrSp+Dnw
         /kkHshyydV5SLhk3KWYkA4xDfl/IEjoYJ5GkZ4EoshWFgVSVIYnqm32wkBDc1LGr7m0N
         HgzWw9A3e0iQmRej8ZPgpGbNn9sSZ2XIGEd3opB1tb8IvxSd7SFVVhcpRuKxcTXFy7C+
         nDujLhiAkU2NKuhnqQJRM1pocRepvEnfkf/zdOdHFkbxcH1jSPE5wsMu/GvGsW2QmqB5
         Cq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wMDzveqXMcU7qz1vEvMmj5Kh0jEuVD57A0b/vJIJrw=;
        b=OH9iufyVn/sMmMq7wKzIQqkBmQmoEDhRKN1689cB0maFyN+si3jvxjiSW8NYxlcOf7
         0I6teUOgRRITfMERmxE1hPPIl3eik/xxFLDk920ecbXXcRHGs/47ez73fRYogaoo06yb
         /Yu1pCklKsnaVJAeTGSevxfNYpyDca3k+ugy+buG13uoyzaBt4R4RuyS/9eQXBIcvojD
         xWmY44vHVRHGqGJvcpOVj5AGLhGwBKpiZDn5/jBngM62mUqjhouA8uNw3buMazZObci6
         rYzdKa4vLeVnqHkYtGTO4gsF9wvEIQuZuV62vZWzamkLVUmo4OgLZQR2oZLW0OiGoFKF
         GnnQ==
X-Gm-Message-State: AOAM533ALyChpbpEFHenU3uesQ3Vvcvax/bf4tZENXYA79ByLw0M1Y3n
        HRN23VNE9XB1UzAVbTWZRrhXBHAdwD6d2VO8t4Mg8A==
X-Google-Smtp-Source: ABdhPJzBuFDwbTuAKAxLAKDoRVzjoMzJAgky0l1xUfwlCP1+u+1EBHu/d0wQurDqGyYI3vgcw/PLrAXzP60vhB16MLo=
X-Received: by 2002:a05:620a:4ca:: with SMTP id 10mr27297992qks.306.1595975012973;
 Tue, 28 Jul 2020 15:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <1595927918-19845-1-git-send-email-grzegorz.jaszczyk@linaro.org>
 <1595927918-19845-4-git-send-email-grzegorz.jaszczyk@linaro.org> <1ae8b42d0e7a09caf01197b11cea2fff@kernel.org>
In-Reply-To: <1ae8b42d0e7a09caf01197b11cea2fff@kernel.org>
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Date:   Wed, 29 Jul 2020 00:23:22 +0200
Message-ID: <CAMxfBF7uaFMhGDTmVjZiAEiUxNFSBnh-qcEz3rSDhFTkWkrLkw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] irqchip/irq-pruss-intc: Add logic for handling
 reserved interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        "Anna, Suman" <s-anna@ti.com>, robh+dt@kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, david@lechnology.com,
        "Mills, William" <wmills@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

On Tue, 28 Jul 2020 at 18:37, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-07-28 10:18, Grzegorz Jaszczyk wrote:
> > From: Suman Anna <s-anna@ti.com>
> >
> > The PRUSS INTC has a fixed number of output interrupt lines that are
> > connected to a number of processors or other PRUSS instances or other
> > devices (like DMA) on the SoC. The output interrupt lines 2 through 9
> > are usually connected to the main Arm host processor and are referred
> > to as host interrupts 0 through 7 from ARM/MPU perspective.
> >
> > All of these 8 host interrupts are not always exclusively connected
> > to the Arm interrupt controller. Some SoCs have some interrupt lines
> > not connected to the Arm interrupt controller at all, while a few
> > others
> > have the interrupt lines connected to multiple processors in which they
> > need to be partitioned as per SoC integration needs. For example,
> > AM437x
> > and 66AK2G SoCs have 2 PRUSS instances each and have the host interrupt
> > 5
> > connected to the other PRUSS, while AM335x has host interrupt 0 shared
> > between MPU and TSC_ADC and host interrupts 6 & 7 shared between MPU
> > and
> > a DMA controller.
> >
> > Add logic to the PRUSS INTC driver to ignore both these shared and
> > invalid interrupts.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> > ---
> > v3->v4:
> > - Due to changes in DT bindings which converts irqs-reserved
> >   property from uint8-array to bitmask requested by Rob introduce
> >   relevant changes in the driver.
> > - Merge the irqs-reserved and irqs-shared to one property since they
> >   can be handled by one logic (relevant change was introduced to DT
> >   binding).
>
> This isn't what I asked for in my initial review.
>
> I repeatedly asked for the *handling* to be common, not for the
> properties to be merged. I don't mind either way, but I understood
> there were two properties for a good reason. Has this reason gone?

Yes, I am aware that you've asked for common handling. Nevertheless
due to this change the usage of irqs-shared had to change. Previously
Suman's intention was to always skip the irqs-reserved, while allowing
to try getting interrupts even from irqs-shared list but in case of
failure (during platform_get_irq_byname) it wasn't treated as an
error.
In other words: in the previous approach if the interrupt from
irqs-shared was present in DT interrupts property it was treated as a
valid resource. If the irqs-shared interrupt wasn't present in DT
interrupts property it was skipped (similar to the irqs-reserved
case).

Now after your request for handling both in a common way the
interpretation of irqs-shared had to change. Therefore there's no need
to have seperate property for them. Now it is simpler: if some
interrupt is present in irqs-reserved it will be skipped.

>
> Anyway, I'll come back to it once I start reviewing the series
> again.
>

Ok, thank you,
Grzegorz
