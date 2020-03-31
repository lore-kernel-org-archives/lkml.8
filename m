Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E7EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152B320BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6iR0Ax8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgCaPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:30:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33252 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgCaPaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:30:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id x200so10508415lff.0;
        Tue, 31 Mar 2020 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xWWQQMjnoOXj+s35rdwO3AKWUNgB5UP2RN102SZyf9M=;
        b=n6iR0Ax8nI25kt13ZeGCsBvnzPWCNcQh25Y3upu8+faElg1UmeSUZvzyCrEobwnxwc
         gVNVJMeJVkjTnoRkX4CJnvEJrV5P1NW4deeOfm9g0Nercdv7CYLH2hH8ny2ka87gesHx
         oyxIlVkIQuVkmpz7Tc/HGKF1aNxOjdpCvGTO1KhDoc0zeQuX/SOzgZ/pfeRUVUzuRBsp
         XpFEKvQf+En0EZlW9iwD/63G2LR5zEzozv6vJ0Hy/LjskoC+GbEHzEV/d1aTUQgQQ9JP
         cnMtBYNuvuGC9QJ2dMRo9w3h5iQSX3UHfPwiWqcWYzdtVloTd6TanNL1PTGtFWZycgcU
         N+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xWWQQMjnoOXj+s35rdwO3AKWUNgB5UP2RN102SZyf9M=;
        b=lXZOiUrA++XH+UWlD6ZzUIxye9eSbbFP+am29rqe6/a8TcVek7+PQvVt8xPPgFe/kR
         FL4GihVeE4ZgkC63LjdjqN46GLWHf/DbcwpHqWjiwyTr5Gj77Cgm0OY/U5XSD9kQexCQ
         encPqh3RtazqVhLRLJYrCvBL9rg87jeEJ3kh/k6qeFVUdfeuBmeiPKTQutJGzYJlF2Bx
         RakKW4yxbdJqKA8n7h+L6M3m6Zzuy2wxuAmETUpDy/8DOuuTGKsAMNXHy+GjHQ9nzBo8
         IM1ht1SUvIk8W672BhYAftcQZjzbrHpYbFlN3S6ijlgnU/2BMLUcUmFfJExh1xtZQFvE
         veAg==
X-Gm-Message-State: AGi0PuY6mXRToWL07eEt6V2MvtXo2RcnxlEt4eEoKd3pxXxiVx2Z2B/k
        ZgLTttC8gxG9p1G+I2XeZHU=
X-Google-Smtp-Source: APiQypLmVLtT8c3Ae8yFJGreZRae3ELGPZCOey9sa+nDWvoHUeTggKwcWmX/TR05X/+9guBOCeUrhg==
X-Received: by 2002:ac2:4113:: with SMTP id b19mr2153946lfi.70.1585668599197;
        Tue, 31 Mar 2020 08:29:59 -0700 (PDT)
Received: from pablo-laptop ([2a02:a315:5445:5300:c0c9:238d:e5e0:ede5])
        by smtp.googlemail.com with ESMTPSA id j125sm8827924lfj.38.2020.03.31.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:29:58 -0700 (PDT)
Message-ID: <d9fe575926342b355f76e1f38fef62f0d7d38075.camel@gmail.com>
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
Date:   Tue, 31 Mar 2020 17:29:56 +0200
In-Reply-To: <6ca59c1b-2676-e69d-e4eb-4667a81d155f@samsung.com>
References: <20200312153411.13535-1-paul@crapouillou.net>
         <20200312153411.13535-2-paul@crapouillou.net> <20200313090011.GB7416@pi3>
         <CGME20200318142549eucas1p1793027850923ebad20b4691cba676671@eucas1p1.samsung.com>
         <D6.31.03891.A6F227E5@epmailinsp8.samsung.com>
         <6c549058-00f9-8526-a272-48c538166ccf@samsung.com>
         <X7728Q.UX8A28S31JO92@crapouillou.net>
         <6ca59c1b-2676-e69d-e4eb-4667a81d155f@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-31 at 15:55 +0200, Marek Szyprowski wrote:
> Hi Paul,
> 
> On 2020-03-31 15:09, Paul Cercueil wrote:
> > Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > 
> > Hi Marek,
> > 
> > Le mar. 31 mars 2020 à 7:36, Marek Szyprowski 
> > <m.szyprowski@samsung.com> a écrit :
> > > Hi Paul,
> > > 
> > > On 2020-03-18 15:25, Paul Cercueil wrote:
> > > > > >   +    };
> > > > > >   +
> > > > > >   +    tsp_reg: regulator-1 {
> > > > > >   +        compatible = "regulator-fixed";
> > > > > >   +        regulator-name = "TSP_FIXED_VOLTAGES";
> > > > > >   +        regulator-min-microvolt = <3300000>;
> > > > > >   +        regulator-max-microvolt = <3300000>;
> > > > > >   +        gpio = <&gpl0 3 GPIO_ACTIVE_HIGH>;
> > > > > >   +        startup-delay-us = <70000>;
> > > > > >   +        enable-active-high;
> > > > > >   +        regulator-boot-on;
> > > > > >   +        regulator-always-on;
> > > > > 
> > > > >  always-on and boot-on should not be needed. You have a consumer 
> > > > > for this
> > > > >  regulator.
> > > > 
> > > >  About this: the touchscreen driver does not use a regulator, so I
> > > >  believe that's why these properties were here.
> > > > 
> > > >  I sent patches upstream to address the issue:
> > > >  https://protect2.fireeye.com/url?k=e8aedc29-b53072b3-e8af5766-0cc47a336fae-759579fd576d8382&u=https://lkml.org/lkml/2020/3/15/94 
> > > > 
> > > > 
> > > >  I believe this means I cannot merge the i9100 devicetree until it is
> > > >  acked.
> > > 
> > > One more information - similar change has been already posted, but it
> > > looks it got lost then: https://patchwork.kernel.org/patch/10550903/
> > 
> > I was aware of this patch, but didn't know it was sent upstream.
> > 
> > This other patch uses two regulators, vdd/avdd but doesn't give any 
> > reason why.
> > 
> I've checked the UniversalC210 schematic, which uses the same 
> touchscreen chip. There are 2 supplies to the touchscreen chip: 2.8V VDD 
> and 3.3V AVDD. Both are enabled by the same GPIO pin though. There is 
> however no reset GPIO pin there.
Hi
Don't remember now how it worked on Galaxy S1, but it looks like it has
the same setup - two regulators enabled by one GPIO pin.
> 
> > Paweł, is that really needed?
> > 
> Best regards

