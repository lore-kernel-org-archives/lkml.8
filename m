Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82494C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F0420842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgLTHTqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgCaTuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:50:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38777 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgCaTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:50:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so23293677ljh.5;
        Tue, 31 Mar 2020 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=X256ALwK5y07kseIZ6IR1HB5ThpSSuN2SFQNhjFvy0E=;
        b=ZgLTHTqLQ4cgNG/+c5jZkvDccdqSN0bOVAuoPDGOfNKVrsD6RXGajLVSY5WXytSsiR
         BUnkmWiqT20BpsHIjY0msUWB5RywR0/ts0548l0fcNiSEtchz8r3sqQG4vW8jTtpY7vX
         E9LOJnkfWBR6Gs8c2mNdD1uZbCDs26EAJL1vBBDHme2HHBZpWiuqtTtSIE6YogCVk3fn
         KZofGL8JdFhSUrbl2H1yIZ4TRY9FJu52UvDaOVqByshWmbmlxm2IQvB2aqU1vQNZa2VQ
         btuZpcdF6coy8RLyh2Yf7PKAsFSOq+Z6mhzzMOos6v8P1fDLJX/Ql2nRFft886DPI4CU
         S41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X256ALwK5y07kseIZ6IR1HB5ThpSSuN2SFQNhjFvy0E=;
        b=FVl2zxGXZoiGG4BDXYlaVHH5EKl/8MjzLo7GM+vVhrttlWhRdkQQJN0DFTAjKr6Agb
         w1otK/01hUfk1X33paz5G1IxrY57HqWa4Vh/mH2j+Xi0JfhRO7QSZ/6gdaFvuxBVVmWm
         iYkXPs1PQIrVN8fm+0ZT4eUKwLWRSI0yESeZLU3mQzJrhxJq9Vh64QGw6EvG0lbVoovg
         EZLFcnZhuqxPiyN5mQ5hQ8iuYsD9zprI9fhDB7DeBc41ftGcDTqILEvMFTRbxYVfEzdn
         YTZXkp+/vh6tWiJqPPXDAZE9pzOWuOdhhCYRFvBu0qt1JXSYPsERIQdVjGH6qiOUWJof
         DEBw==
X-Gm-Message-State: AGi0PuZh4uU4Qz6yMHCoa+ep0LnPn2Y5ULx+7s5OFZ0HKT2Qx7M5Rc8a
        KAQcp/4OvDexbW+ePg0AhYk=
X-Google-Smtp-Source: APiQypIkX62G++r/IinoOQmvz0Wce1CkF4mtiU3Y6aDWipfkDEXstwXUqy+bH2vDScHB5Pjp4MGk2w==
X-Received: by 2002:a2e:96c4:: with SMTP id d4mr3383250ljj.19.1585684221896;
        Tue, 31 Mar 2020 12:50:21 -0700 (PDT)
Received: from pablo-laptop ([2a02:a315:5445:5300:a576:7878:f185:517a])
        by smtp.googlemail.com with ESMTPSA id o21sm9242407ljg.71.2020.03.31.12.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:50:21 -0700 (PDT)
Message-ID: <8a77ca985214cb0058e4defe4dcaa27a79eafacc.camel@gmail.com>
Subject: Re: [PATCH 2/2] ARM: DTS: Add devicetree file for the Galaxy S2
From:   =?UTF-8?Q?Pawe=C5=82?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Stenkin Evgeniy <stenkinevgeniy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 31 Mar 2020 21:50:19 +0200
In-Reply-To: <da888000-52b6-b0c6-76ac-8fc535d07a5d@samsung.com>
References: <20200312153411.13535-1-paul@crapouillou.net>
         <20200312153411.13535-2-paul@crapouillou.net> <20200313090011.GB7416@pi3>
         <CGME20200318142549eucas1p1793027850923ebad20b4691cba676671@eucas1p1.samsung.com>
         <D6.31.03891.A6F227E5@epmailinsp8.samsung.com>
         <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
         <X7728Q.UX8A28S31JO92@crapouillou.net>
         <6ca59c1b-2676-e69d-e4eb-4667a81d155f@samsung.com>
         <d9fe575926342b355f76e1f38fef62f0d7d38075.camel@gmail.com>
         <da888000-52b6-b0c6-76ac-8fc535d07a5d@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 21:29 +0200, Marek Szyprowski wrote:
> Hi
> 
> On 2020-03-31 17:29, Paweł Chmiel wrote:
> > On Tue, 2020-03-31 at 15:55 +0200, Marek Szyprowski wrote:
> > > Hi Paul,
> > > 
> > > On 2020-03-31 15:09, Paul Cercueil wrote:
> > > > Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > > 
> > > > Hi Marek,
> > > > 
> > > > Le mar. 31 mars 2020 à 7:36, Marek Szyprowski
> > > > <m.szyprowski@samsung.com> a écrit :
> > > > > Hi Paul,
> > > > > 
> > > > > On 2020-03-18 15:25, Paul Cercueil wrote:
> > > > > > > >    +    };
> > > > > > > >    +
> > > > > > > >    +    tsp_reg: regulator-1 {
> > > > > > > >    +        compatible = "regulator-fixed";
> > > > > > > >    +        regulator-name = "TSP_FIXED_VOLTAGES";
> > > > > > > >    +        regulator-min-microvolt = <3300000>;
> > > > > > > >    +        regulator-max-microvolt = <3300000>;
> > > > > > > >    +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
> > > > > > > >    +        startup-delay-us = <70000>;
> > > > > > > >    +        enable-active-high;
> > > > > > > >    +        regulator-boot-on;
> > > > > > > >    +        regulator-always-on;
> > > > > > >   always-on and boot-on should not be needed. You have a consumer
> > > > > > > for this
> > > > > > >   regulator.
> > > > > >   About this: the touchscreen driver does not use a regulator, so I
> > > > > >   believe that's why these properties were here.
> > > > > > 
> > > > > >   I sent patches upstream to address the issue:
> > > > > >   https://protect2.fireeye.com/url?k=e8aedc29-b53072b3-e8af5766-0cc47a336fae-759579fd576d8382&u=https://lkml.org/lkml/2020/3/15/94
> > > > > > 
> > > > > > 
> > > > > >   I believe this means I cannot merge the i9100 devicetree until it is
> > > > > >   acked.
> > > > > One more information - similar change has been already posted, but it
> > > > > looks it got lost then: https://patchwork.kernel.org/patch/10550903/
> > > > I was aware of this patch, but didn't know it was sent upstream.
> > > > 
> > > > This other patch uses two regulators, vdd/avdd but doesn't give any
> > > > reason why.
> > > > 
> > > I've checked the UniversalC210 schematic, which uses the same
> > > touchscreen chip. There are 2 supplies to the touchscreen chip: 2.8V VDD
> > > and 3.3V AVDD. Both are enabled by the same GPIO pin though. There is
> > > however no reset GPIO pin there.
> > Hi
> > Don't remember now how it worked on Galaxy S1, but it looks like it has
> > the same setup - two regulators enabled by one GPIO pin.
> 
> It is quite common for the regulators to share the enable GPIO line, so 
> this is not an issue. Regulator framework supports such configuration 
> for ages. I'm curious about the reset GPIO line, which were made 
> mandatory for the regulators control in your patch. I didn't find it on 
> any schematic of the devices with this touch screen, but I don't have a 
> schematic of the Galaxy S1. IMHO the reset signal is simply derived from 
> the supply regulators with some simple circuit, but I don't have 
> schematic of that part.
Hi
Regarding this change - it was suggested during review of v1 version of
those patches. It's first reply here 
https://patchwork.kernel.org/patch/10524007/

> 
> Best regards

