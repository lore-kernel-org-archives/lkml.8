Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9EEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA292073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KmjOr7lG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHJHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgHJHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:31:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB82C061786
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:31:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so7147060wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4x9G4BKQPEodKbNbhS34JTOCfB7se7v0YDW0moilQvg=;
        b=KmjOr7lGhApH6KmO1rV2ur9Cq8V7cNEvM8FRBK312jsW9+HLFlI/uzKP10UPa5smUh
         MoOjclfPeo/4V+LP8l7LPZ68sn9H/heVE996XMzsiBINWGZfhnIE+3CJJd4WeacdBgBa
         kg4kjO9LHV4tvpX3bK4xbgbWcsXdIN4b3k/ISucIebTERr0TEg1H8+JuovkT6/2gBHWn
         HcWBMkGEy5oDrrBGqN9Haq1IlLCWfIWvZsDoy/7r1majuwzYvVqFwkiLFLJ3SeHEjEl+
         ENQHPT2cAjuLfipnQNOXfEHR9/QMK+2cPXur508C9BBp0SQIbaek9bsgdDPq4vL/m0il
         YJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4x9G4BKQPEodKbNbhS34JTOCfB7se7v0YDW0moilQvg=;
        b=I5zDxNSqDfx/tehjube62QUPbqOWXsgilaYyXRfCr7W1BxM0+JzUK2mAwC1vyYx0eq
         y5Si+MN4mEfGzlYehZ3yc05DxwOJ/tvnDoBKsQ+UJksM19VGjmOejus8zjsipZE0pn9g
         6gR8ZIx4R0ME+FDSMCJxidNe/jZXlxgEMwZ11j21plmHloJTJmzVbM6ox15LAm0Nx6G2
         6HoEjrBGCE7arVeqiSViEJQN//b1lMP3hq6V7ycT35LCkd152I7QPPDR+sxLLJ074Hok
         76Si0xYxQMsbf0iruf0Qd7DTQRG8MZ2qevQ3Yu+rLxyuKTm1NnGco1z1pdotCrQO6mj0
         vVQg==
X-Gm-Message-State: AOAM530PX8zgKRgR+rzwMR7sWeiJhAdbt21UugPx2R1wXt6gluHQqh/9
        pBKfQauGNR7M4im8PUxtxkgd1w==
X-Google-Smtp-Source: ABdhPJxExxrYLyu6qXhRPgZztXKPrU/zgJr51FhpKEO58wSzN65gPrJEPbrrE6QHLTBHtOvwIbO0TA==
X-Received: by 2002:adf:a351:: with SMTP id d17mr23056398wrb.111.1597044691012;
        Mon, 10 Aug 2020 00:31:31 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id z15sm20056653wrn.89.2020.08.10.00.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:31:30 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:31:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: Re: [PATCH 1/8] mfd: mt6358: refine interrupt code
Message-ID: <20200810073128.GC4411@dell>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-2-git-send-email-hsin-hsiung.wang@mediatek.com>
 <20200727154840.GY1850026@dell>
 <1596443379.31084.3.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1596443379.31084.3.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Aug 2020, Hsin-hsiung Wang wrote:

> Hi,
> 
> On Mon, 2020-07-27 at 16:48 +0100, Lee Jones wrote:
> > On Thu, 23 Jul 2020, Hsin-Hsiung Wang wrote:
> > 
> > > This patch refines the interrupt related code to support new chips.
> > 
> > Refines in what way?
> > 
> > What makes this better?
> > 
> 
> Thanks for the comment. I will add more information into comment message
> based on my below explanation.

Thanks.

> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > ---
> > >  drivers/mfd/mt6358-irq.c        | 65 ++++++++++++++++++++++++-----------------
> > >  include/linux/mfd/mt6358/core.h |  8 ++---
> > >  2 files changed, 41 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> > > index db734f2..4b094e5 100644
> > > --- a/drivers/mfd/mt6358-irq.c
> > > +++ b/drivers/mfd/mt6358-irq.c
> > > @@ -13,7 +13,9 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  
> > > -static struct irq_top_t mt6358_ints[] = {
> > > +#define MTK_PMIC_REG_WIDTH 16
> > > +
> > > +static const struct irq_top_t mt6358_ints[] = {
> > >  	MT6358_TOP_GEN(BUCK),
> > >  	MT6358_TOP_GEN(LDO),
> > >  	MT6358_TOP_GEN(PSC),
> > > @@ -24,6 +26,13 @@ static struct irq_top_t mt6358_ints[] = {
> > >  	MT6358_TOP_GEN(MISC),
> > >  };
> > >  
> > > +static struct pmic_irq_data mt6358_irqd = {
> > > +	.num_top = ARRAY_SIZE(mt6358_ints),
> > > +	.num_pmic_irqs = MT6358_IRQ_NR,
> > > +	.top_int_status_reg = MT6358_TOP_INT_STATUS0,
> > > +	.pmic_ints = mt6358_ints,
> > > +};
> > 
> > Dynamically assigned driver data is usually preferred.
> > 
> > Why have you gone static?
> > 
> 
> Do you consider the memory allocation?
> Below modification is to assign necessary data dynamically and the code
> will become longer with more chips if we assign every member of the
> structure.

[...]

Never mind.  On second glance, this should be fine.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
