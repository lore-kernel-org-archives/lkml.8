Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38323C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BC2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nLRO8G6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgENLvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgENLvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:51:05 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1A3C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:51:05 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id g22so643313oop.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmu4YBAvToliFfVDxWezHK86Ml4PH9h8T7/JXeAmCJ4=;
        b=nLRO8G6FIBf9L+JTs57c/5HLTs2IGDh6RfDLTrlqsfZ4Y5xnO3QIRXBsY8O3mbds5W
         aMzUhZ7DRuDa08RO1VMFv5matROJEvlY0AHZj6nB6XBeM9ddd7pRekdkOnKVsyGA1+zv
         QSE9mRl1UjVeLqFTlTGMylOpBSQddi4BhUpdF5nh5vv6+yVMpq9Nx1B3hppV5rGL8CGR
         5smct6dgZDV1FUPAUmiuxCkCJZS2FlPb3zQuIJeu4iWRTrk27GyzNEWlBzMCJqRGIH/l
         KWBjujikL4fqPR0FIkQdi0uKIBAw6CdPIrdDhLzMs6oj1Q3npjB5Oa4jN1mQmFm7RT0O
         c+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmu4YBAvToliFfVDxWezHK86Ml4PH9h8T7/JXeAmCJ4=;
        b=J3pJzYyTDtGWrP9DqkevLX/ERcXhrh+CRBKI97PaMc19tDR1DHPhghktYpVyJYbeO3
         LQ3T+cl+//acQC/Rn0JNK8xv6CFzBGe/VMyNQQOuJEPuXSy4t68OlF+SlWMsmu3HozN0
         ZLFMzcnDdvmcHC8R0LlHmpoeNzi9KaIkRQe3j4b0dUuYfqe8Iafii9+SVgR+HKGS2NsZ
         fhMaGqNO/pHIaL3C6jwvk0W0SWUlY3xtwedS6X3mhQtZOC+/5u5odryJ6wbOXgGk5wSY
         X+XBwr5gcW9JwyDsptWie3LZO8hZd4DQ4X/hP/09UmEeeeuAJQLMKsBDXAhz/dxS5hym
         Lhbw==
X-Gm-Message-State: AOAM532nUx/j8AXzh4fpzgfR21qNTkwEyEQkLEKM/mLG4VDEQFEwWDxu
        mOol04TMlekU4jfZwwaiwtpbbXuiRiRFtpTokZ8dCw==
X-Google-Smtp-Source: ABdhPJwi768XB+CazWxT5hYz1aNguKPDsIEcNgh+EmH5hm/Rc5enKl91gVcVBT3HBzucHTUyzTL+pmJixYK3SgaRBdU=
X-Received: by 2002:a4a:b4c1:: with SMTP id g1mr3275917ooo.58.1589457064720;
 Thu, 14 May 2020 04:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
 <20200508204200.13481-5-sumit.semwal@linaro.org> <20200511104922.GD8216@sirena.org.uk>
In-Reply-To: <20200511104922.GD8216@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 14 May 2020 17:20:53 +0530
Message-ID: <CAO_48GHXNYT7KT+7U_TNT5GtensREckKEVhD3nBTriaAePAr=A@mail.gmail.com>
Subject: Re: [v2 4/4] regulator: qcom: labibb: Add SC interrupt handling
To:     Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        Nisha Kumari <nishakumari@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Thanks for the review comments.

On Mon, 11 May 2020 at 16:19, Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, May 09, 2020 at 02:12:00AM +0530, Sumit Semwal wrote:
>
> > +static irqreturn_t labibb_sc_err_handler(int irq, void *_reg)
> > +{
> > +     int ret, count;
> > +     u16 reg;
> > +     u8 sc_err_mask;
> > +     unsigned int val;
> > +     struct labibb_regulator *labibb_reg = (struct labibb_regulator *)_reg;
> > +     bool in_sc_err, reg_en, scp_done = false;
> > +
> > +     if (irq == labibb_reg->sc_irq)
> > +             reg = labibb_reg->base + REG_LABIBB_STATUS1;
> > +     else
> > +             return IRQ_HANDLED;
>
> Why would we be registering the interrupt handler when it's not valid?
Agreed, will correct.

Best,
Sumit.
