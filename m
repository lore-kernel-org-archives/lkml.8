Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92ABC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F2B206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598948394;
	bh=nlTjzcTguTfrzCTXIUOPN/HlzyEFA6DAUkpPteDfSFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mAofSG3DbNcpP/mJBqBoNTlCYL5E3QuqLqPoY/ePcDJ/6MallLwAP4Tn1zZvQg9q6
	 Q8qrG1XO0Rt2i3HVqtMX5/NNjs33UYOQMMs8Lv3/2viU6XLNBV1LcuKokInJEQ+bsi
	 7usm634fN/bKZSCpI8x54dsz+0OR4p5kOeR4W5mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIAITx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgIAITv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:19:51 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1F12098B;
        Tue,  1 Sep 2020 08:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598948391;
        bh=nlTjzcTguTfrzCTXIUOPN/HlzyEFA6DAUkpPteDfSFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QmcfH1LT6XD0PZHu9wSVLSQjTtyskWxy1+HOl7O1K/jRXTNCcXz0lZtOzgIjo7kwo
         it2UBojqsZy9No5C2hoJ9590MLKXUQztkcX0VFo+N+IQZSPzPlHjaGDx62g05DflKy
         VpQcGHLWJ4Hrje1pCLRhehbSLuJyufAx6+xzmePQ=
Received: by mail-ed1-f47.google.com with SMTP id l17so565369edq.12;
        Tue, 01 Sep 2020 01:19:50 -0700 (PDT)
X-Gm-Message-State: AOAM530ofbh8qqYQOvnkoQWuO6k7Ld9xxhkDqthEqLo3x1S8zzyWtVWI
        u6aZA5GDOVekPr9CHHC5ZUOowv6+xkTKOkpzHrs=
X-Google-Smtp-Source: ABdhPJzJWtDRO06V6iyD2YgKfVKZZxVA5CsrCMB9GkqU+xNVzliLbn6VCQZSEDIEKY+4PicwivC9FlnBexNjLYV1/Jw=
X-Received: by 2002:a05:6402:515:: with SMTP id m21mr765717edv.348.1598948389218;
 Tue, 01 Sep 2020 01:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200901075417.22481-1-krzk@kernel.org> <CGME20200901075518eucas1p252ef2b85cf5e1a83d88f8de2dd4a8196@eucas1p2.samsung.com>
 <20200901075417.22481-12-krzk@kernel.org> <800d8fa8-7fd4-6221-f8be-ef422e5642d9@samsung.com>
 <CAJKOXPd+Mr0c7ype1KTseBc2=qx0NNKKj5Ku0w0HBOgjEsGvKg@mail.gmail.com>
In-Reply-To: <CAJKOXPd+Mr0c7ype1KTseBc2=qx0NNKKj5Ku0w0HBOgjEsGvKg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 1 Sep 2020 10:19:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfKnzsRA3D8b3z=iG4oD6P+M7Q7YMVbrOAmLTiNgZ5mXA@mail.gmail.com>
Message-ID: <CAJKOXPfKnzsRA3D8b3z=iG4oD6P+M7Q7YMVbrOAmLTiNgZ5mXA@mail.gmail.com>
Subject: Re: [PATCH 11/13] ARM: dts: exynos: Silence SATA PHY warning in
 Exynos5250 Arndale
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 at 10:17, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 1 Sep 2020 at 10:13, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > Hi Krzysztof,
> >
> > On 01.09.2020 09:54, Krzysztof Kozlowski wrote:
> > > The SATA PHY in Exynos5250 SoCs has two interfaces and two device nodes:
> > > 1. sata-phy@12170000
> > > 2. i2c-9/i2c@38
> > >
> > > The first node represents the actual SATA PHY device with phy-cells.
> > > The second represents additional I2C interface, needed by the driver
> > > to communicate with the SATA PHY device.  It is not a PHY-provider in
> > > the terms of dtschema so rename it to silence dtbs_check warning:
> > >
> > >    arch/arm/boot/dts/exynos5250-arndale.dt.yaml: sata-phy@38: '#phy-cells' is a required property
> > >      From schema: lib/python3.6/site-packages/dtschema/schemas/phy/phy-provider.yaml
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >   arch/arm/boot/dts/exynos5250-arndale.dts | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> > > index f2bcce167b2d..3c401c82905c 100644
> > > --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> > > +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> > > @@ -544,7 +544,7 @@
> > >       samsung,i2c-max-bus-freq = <40000>;
> > >       samsung,i2c-slave-addr = <0x38>;
> > >
> > > -     sata_phy_i2c: sata-phy@38 {
> > > +     sata_phy_i2c: sata-phy-i2c@38 {
> > >               compatible = "samsung,exynos-sataphy-i2c";
> > >               reg = <0x38>;
> > >       };
> >
> > I'm not against the rename, but frankly, the above node and all i2c
> > parameters should be moved to exynos5250.dtsi. This is a SoC internal
> > things (the same way as hdmiphy in exynos4.dtsi), so the board dts
> > should only contain information like status = "enabled" for i2c_8 and
> > hdmi_i2c_phy nodes. No need to duplicate it here and in smdk5250.dts.
>
> Good point, the I2C bus used here is an internal part of SoC.
>
> I will squash these two changes into a new one. Thanks for the review!

While at it, I wonder about the samsung,i2c-slave-addr property. Is it
really needed? Are there multiple masters on this bus?

Best regards,
Krzysztof
