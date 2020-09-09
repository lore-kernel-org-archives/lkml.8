Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEFDC10DAA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E032087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599639446;
	bh=1EUSZ3NaoPvKOJ+tyBXhXy9hp4/Q8xBii75g3yTrdxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7djXeQJr4zlqxJUhpTl8rQH1vn7dl/J5g/b/uyj/6wfeQGB6d5ZdTbyz/fbXeoW8
	 HWTVdaTjfEfizqD86ECqQ8bzXf6cttTIxFQq+fB3T9Ih2EJ4oMzV1eUlJb/Dhhv8Cu
	 utGJ4BHfKLXQGKT50H1WwksRLM0QQBRsj1wezte4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgIIIRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:17:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34791 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgIIIRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:17:21 -0400
Received: by mail-ed1-f65.google.com with SMTP id q21so1747230edv.1;
        Wed, 09 Sep 2020 01:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7OpTxvqddGdtoZyyM0TB6Dwd1d1h5eHAlbtTkynXxLQ=;
        b=qYfBYiHevTuiwAX0gp82vQHbmhXUkNjdrpEIK9UVM7/7WbboU5ha+PaBcte9zG1SVA
         aqcycKohwIHEfRq10UvDBvIJzIQl8s1NsDoz4glwYZdZmitarELpVJWFnd9qWqMf3hbH
         Z8QocqyYLxtpZy9Cd8N//5rWALc2SOJ2Poq7kxZZSYzi/p1sn5c0dMre/3J8E3nR+Wci
         cJOGKuUDBx7hs+iOrvF74i9W2d4YE2iDtphTa5FEYSLih182k375oV3NAfyFcWavLJxX
         PVQloG/MD8kdQLJTbbPXEbgvnciWps4AXmhD+9AampobpZKQfjgtR1s0zWbURttgYStn
         RB8w==
X-Gm-Message-State: AOAM5332efZs2FZ4via3aqVC21KpK80UrQjAbc06Fo7Z9+v6tuuw913i
        UpbFWX9wmjfwqUT5PSBTVOwaggXTob0=
X-Google-Smtp-Source: ABdhPJz0SecHFx4uuzCes0o22Yc31zkBd304YBMEI8PTDYfXEpeZtc1D/GDccaXGm5ScYU8J2q5cyw==
X-Received: by 2002:aa7:c308:: with SMTP id l8mr2838807edq.361.1599639439245;
        Wed, 09 Sep 2020 01:17:19 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id h10sm1286313ejt.93.2020.09.09.01.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 01:17:18 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:17:16 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: Correct interrupt flags in examples
Message-ID: <20200909081716.GA11775@kozik-lap>
References: <20200908145900.4423-1-krzk@kernel.org>
 <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ea2a75a873b6291962f6b6a7949e9d185187911.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 06:30:44AM +0000, Vaittinen, Matti wrote:
> 
> On Tue, 2020-09-08 at 16:59 +0200, Krzysztof Kozlowski wrote:
> > GPIO_ACTIVE_x flags are not correct in the context of interrupt
> > flags.
> > These are simple defines so they could be used in DTS but they will
> > not
> > have the same meaning:
> > 1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
> > 2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING
> > 
> > Correct the interrupt flags, assuming the author of the code wanted
> > some
> > logical behavior behind the name "ACTIVE_xxx", this is:
> >   ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> For BD70528:
> Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> > ---
> >  Documentation/devicetree/bindings/mfd/act8945a.txt          | 2 +-
> >  Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml    | 3 ++-
> >  Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt | 2 +-
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd70528-
> > pmic.txt b/Documentation/devicetree/bindings/mfd/rohm,bd70528-
> > pmic.txt
> > index c3c02ce73cde..386eec06cf08 100644
> > --- a/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > +++ b/Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> > @@ -39,7 +39,7 @@ pmic: pmic@4b {
> >  	compatible = "rohm,bd70528";
> >  	reg = <0x4b>;
> >  	interrupt-parent = <&gpio1>;
> > -	interrupts = <29 GPIO_ACTIVE_LOW>;
> > +	interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
> 
> This is how it should have been from the beginning :) Thanks!

I start to wonder now. It seems some boards do not configure a pull up
there, so IRQ_TYPE_LEVEL_LOW is wrong - causes the line to stay in low
state.  But actually this maybe is a problem of missing pull up, not the
IRQ flag?

Best regards,
Krzysztof

