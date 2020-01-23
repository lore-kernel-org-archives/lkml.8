Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB40C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F64C24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj15zwE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgAWNCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:02:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38608 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:02:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id l35so1268334pje.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bWB6ONkrT4WgWO4GSee5Bs4kxW688nuEU9Jrsivajs=;
        b=cj15zwE2L+LsB3Pok/kWy1UJUW3Nev9f/JDrLWnnKhnzn/mGek2Gs2OMBkG/caj1Zp
         BDuPozbl5U14q/wGz9Mbwkydb3P751tr5PWr89W5JkUe1VVv0QSWC5pEt6mDTcvmWK1g
         fVc/6+FXMdGeXFWL8khum5toRJ2dEzuKBiMZuUyq55iL03rdg4fYnhf5fkbWh5jJ9ldD
         bG9+E22yE8jDSDkiqM69UlbG0TaHxAuLAm8sM1QDAS6OCrTq8ONEeNiFlCPMjp046E+i
         FUkQRIusYeVsYJeMbegvmdDgNuE39wBn+RS0vb7azWTrzZgzLnvSXFVT+3PVW0RKCsN9
         yHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bWB6ONkrT4WgWO4GSee5Bs4kxW688nuEU9Jrsivajs=;
        b=PaMnFm/eFx5WorJoXL0BgL3HQ8nkdmwBlMvgLGdolubhFBpd8y61/FpecX7CRXPMiN
         uZh29oD3U7MqodsB1xXc/GqccuC7xICYoZxXHKXpqNj+QOOgFaWghBQNku8S5eLf13gL
         mr9wsGZZCQslFbsluzcfYj+mLMQJJKjea/0xhZhMOkRYLvvMdmkrri0FDABRiSzedVpn
         00zZXAQeFaIESr3EhtQbUmGHuedzQ08ssvFhzH6EAr4WHi9wGh494TNoG0vUezHtbzsC
         uwXtPICZQIwOf6BXoMo4pDfMWeC17LgvGgHDF+980lrBXvZ9gjdeWLZ7s+PeMcEFOm/9
         t27w==
X-Gm-Message-State: APjAAAXFuWFXyONUcwIXNjLNuGYDnkEahnhXZr6Zw85EKEu2BTIYvgYa
        y6iaTrHoofKdRwtuWV1bUpwL
X-Google-Smtp-Source: APXvYqzaXk2eAZRdxNDIM7/2E3DX1Jx+K2rhwL79it4MYq+uh5USkxF+qD+8KI2641f8Rzy2Gv8Gzw==
X-Received: by 2002:a17:902:9691:: with SMTP id n17mr16555805plp.304.1579784519567;
        Thu, 23 Jan 2020 05:01:59 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id g22sm3015074pgk.85.2020.01.23.05.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 05:01:58 -0800 (PST)
Date:   Thu, 23 Jan 2020 18:31:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/16] bus: mhi: core: Add support for ringing
 channel/event ring doorbells
Message-ID: <20200123130151.GD8937@mani>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-6-manivannan.sadhasivam@linaro.org>
 <CAK8P3a2pZEdsAi6YQ5z3YD=zD1iZLu+WPirhwmxeZ33k7sjkeg@mail.gmail.com>
 <20200123120050.GB8937@mani>
 <CAK8P3a1ACFdUdEywEQRAJ=HRYOp+0Y051ffNgAgqvSgjOEGyMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1ACFdUdEywEQRAJ=HRYOp+0Y051ffNgAgqvSgjOEGyMA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 01:44:32PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 23, 2020 at 1:01 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > On Thu, Jan 23, 2020 at 12:39:06PM +0100, Arnd Bergmann wrote:
> > > On Thu, Jan 23, 2020 at 12:19 PM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > > +int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
> > > > +                             void __iomem *base, u32 offset, u32 *out)
> > > > +{
> > > > +       u32 tmp = readl_relaxed(base + offset);
> > > ....
> > > > +void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
> > > > +                  u32 offset, u32 val)
> > > > +{
> > > > +       writel_relaxed(val, base + offset);
> > >
> > > Please avoid using _relaxed accessors by default, and use the regular
> > > ones instead. There are a number of things that can go wrong with
> > > the relaxed version, so ideally each caller should have a comment
> > > explaining why this instance is safe without the barriers and why it
> > > matters to not have it.
> > >
> > > If there are performance critical callers of mhi_read_reg/mhi_write_reg,
> > > you could add mhi_read_reg_relaxed/mhi_write_reg_relaxed for those
> > > and apply the same rules there.
> > >
> > > Usually most mmio accesses are only needed for reconfiguration or
> > > other slow paths.
> > >
> >
> > Fair point. I'll defer to readl/writel APIs and I also need to add
> > le32_to_cpu/cpu_to_le32 to them.
> 
> What do you need the byteswap for? All of the above already
> assume that the registers are little-endian.
> 

I thought the readl/writel are native endian... Now I read the macro
definitions once again and looks like these APIs are LE for all archs...
So it is not needed. Sorry for the confusion.

Thanks,
Mani

>        Arnd
