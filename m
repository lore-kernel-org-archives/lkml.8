Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10C2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CBFB206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yArUZlug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbgGaMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733299AbgGaMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:32:13 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:32:13 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b2so3430210qvp.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgQA4sgoGYvD/Uf9j6zkKwcrUzZ+kjVzPsEd9qktWI0=;
        b=yArUZlugRa5RtNwex9gt6KlGV/LzD6XhTdRsHx+m1p29ABbu+mPaW7hGxX+Ek3OLlK
         Si/I0ihYLl9x1JgR6oOG/t+Tjgvvrtu3iTBi7894DnYH142AfKqegLhzWX0OyiooVNR3
         mzN9mRQIrQmPMCkl9dtxLlcsQZohjn2N0imuhNcDjc7Jm2Nvm4sLrash23s1Uac8E+n/
         ZVvbHpNTpPcPXTuN1+vn+XbYOO6G5ThGMX/sW/gYQJ4MTLkne4wbr+9PH8DtvPt4lfze
         dSiM+B4aAq4oJhKJiGStGxuGBT25yHDUuBm1ft7xHs0XvpMGwBjk/qBOnfWBHgLEeKaN
         MRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgQA4sgoGYvD/Uf9j6zkKwcrUzZ+kjVzPsEd9qktWI0=;
        b=miop0ydLOMzhnlnWq6db3vVzWveOGqyVvJQ3g1lbyQe85Vu7HQaPuyqEGbOxXj4Xow
         foRpb09l4qDiyXM2Fl5mIRQPdRAphP4tP0PLk6hN5wTpb4g6aJ1n2D6otzTDFhHzVWQg
         huOQ1irtx4XanjZsoDaG/NE9Gvv8N8SLx7gU2xjKYB5JrsS3npv4k9u/Ks/Q4tnwe6S1
         WkvvbPi2eaoYMEkeoRRYDx3VgaPD8TCVwQvgOfxitmx1PFfG1RI2pLJs3UZvzEA8QL44
         z2cCbKu0SCpFYrfJI8yGTeTGOolGRVcTJDU21sSmKGM49LIJnGHBMA7tN7XWdgDVadN1
         Q2iA==
X-Gm-Message-State: AOAM530M/i93WYqnzsM+XPGi+0P4BCoiSVrCdJLk/MJxHm1DgGjpdJIH
        QT6Q5yfxMrsPEycESUBzl8vTD4igIa6IDI7a4X7iqA==
X-Google-Smtp-Source: ABdhPJwA/Ade66bad0qB4t8nKvutT0zN/4+AR2s7p6M5ohcTnlPbZ3JWMGZuT5x4DWm3k6zmybs78WYMYeh+sVHLiLo=
X-Received: by 2002:a0c:f189:: with SMTP id m9mr3692284qvl.152.1596198732095;
 Fri, 31 Jul 2020 05:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <1595927918-19845-1-git-send-email-grzegorz.jaszczyk@linaro.org>
 <1595927918-19845-6-git-send-email-grzegorz.jaszczyk@linaro.org> <015909fa-794c-c938-d944-897985475d20@lechnology.com>
In-Reply-To: <015909fa-794c-c938-d944-897985475d20@lechnology.com>
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Date:   Fri, 31 Jul 2020 14:32:01 +0200
Message-ID: <CAMxfBF6UrB7ppTrKpsCiczQv2Xyk9_Up3tF9eDGT6+DmKegQ_w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] irqchip/irq-pruss-intc: Add support for ICSSG INTC
 on K3 SoCs
To:     David Lechner <david@lechnology.com>, Marc Zyngier <maz@kernel.org>
Cc:     tglx@linutronix.de, jason@lakedaemon.net,
        "Anna, Suman" <s-anna@ti.com>, robh+dt@kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Mills, William" <wmills@ti.com>,
        "Bajjuri, Praneeth" <praneeth@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 at 21:28, David Lechner <david@lechnology.com> wrote:
>
> On 7/28/20 4:18 AM, Grzegorz Jaszczyk wrote:
> > From: Suman Anna <s-anna@ti.com>
> >
> > The K3 AM65x and J721E SoCs have the next generation of the PRU-ICSS IP,
> > commonly called ICSSG. The PRUSS INTC present within the ICSSG supports
> > more System Events (160 vs 64), more Interrupt Channels and Host Interrupts
> > (20 vs 10) compared to the previous generation PRUSS INTC instances. The
> > first 2 and the last 10 of these host interrupt lines are used by the
> > PRU and other auxiliary cores and sub-modules within the ICSSG, with 8
> > host interrupts connected to MPU. The host interrupts 5, 6, 7 are also
> > connected to the other ICSSG instances within the SoC and can be
> > partitioned as per system integration through the board dts files.
> >
> > Enhance the PRUSS INTC driver to add support for this ICSSG INTC
> > instance.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> > ---
>
> There is not much left in this patch. Might as well squash this into
> "irqchip/irq-pruss-intc: Add a PRUSS irqchip driver for PRUSS interrupts".

This is what was suggested in v3. IMO even for commit log it is worth
keeping it as a separate patch but if Marc wants to see it squashed,
no problem I will do that.

Best regards,
Grzegorz
