Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2262068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598877393;
	bh=kArTAMCnRklLSjboZvy3ishXpCwt8hGzMmtpI02TPmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2bUgwLqNm6od7b23brdgm5bT1kQlUYBVnuS9yf93VObxiQtsEujcEu5BXYCfSBi9J
	 Q4GhGIaXfJOaSyvY4NEhZbNDkKxl/Q1757psicnwPAm3uzsuBc47R3hju62D0HsVIv
	 mLEtmeW49WmuDb6gocKwsx9w4CyIT6CLqIyoKO9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgHaMg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:36:28 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:41746 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgHaMen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:34:43 -0400
Received: by mail-ej1-f67.google.com with SMTP id b17so8230906ejq.8;
        Mon, 31 Aug 2020 05:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZ0CJ8Hc1sn63t+kbr2ePS/jsX1/ElRjSGgnzflGJ5c=;
        b=cax9ChphkFYojvYUDC/EZeJX3Eu+ApEmKaXerOY8HA4jHHTplGcr0dJpYSLBYIM/f5
         LI4ja2TxT8v22w5y9dcNEwdXpRAL37FxINKwP3lrzlBKgVGSk8dQHGp+x5TKbWwsk6AW
         hyMTlgiCVp6+r34FihOoBFQEEfR6nj0CV7SkYViTzVSXa+nfegvCM4k4uvpofARnl+pw
         SAg7YXyEkhYSP83WmSWCWh1sbYuUmp5/Bru6LBtbIP7vcLoz4G13hqzDpBdlLpA1JLjw
         lpNSBZ42ePVGAwNOCJ+JjHzWcX4eX7Zf4uHrV6UOiaTQ6ZkJmCrmuZH9Rct1FJN2TzCU
         TmdQ==
X-Gm-Message-State: AOAM531f4tyj4A217hThUmoyRDYp4qgXijVH2kaCzIez888FMkuE2eIW
        vVyo0E5N1C3Y9NEy+sMEusU=
X-Google-Smtp-Source: ABdhPJwHQ+kbuB17V3EV8bJwx6CZ9YUlL7K7t8FmVxpql1tXRrhoh31zM7AD8jShfHwOzEmNhb7SKA==
X-Received: by 2002:a17:906:edc4:: with SMTP id sb4mr956998ejb.144.1598877280585;
        Mon, 31 Aug 2020 05:34:40 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y14sm1576652eje.10.2020.08.31.05.34.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 05:34:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:34:36 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 04/10] dt-bindings: mfd: syscon: Document Samsung Exynos
 compatibles
Message-ID: <20200831123436.GA27700@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
 <CGME20200829142536eucas1p12c539f1cd45195adef96f8b752778fcf@eucas1p1.samsung.com>
 <20200829142501.31478-4-krzk@kernel.org>
 <8b0a42a3-e014-c2ed-7403-021f9a476fc8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8b0a42a3-e014-c2ed-7403-021f9a476fc8@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:30:52PM +0200, Sylwester Nawrocki wrote:
> On 29.08.2020 16:24, Krzysztof Kozlowski wrote:
> > Samsung Exynos SoCs use syscon for system registers so document its
> > compatibles.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 049ec2ffc7f9..0f21943dea28 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -40,6 +40,10 @@ properties:
> >                - allwinner,sun50i-a64-system-controller
> >                - microchip,sparx5-cpu-syscon
> >                - mstar,msc313-pmsleep
> > +              - samsung,exynos3-sysreg
> > +              - samsung,exynos4-sysreg
> > +              - samsung,exynos5-sysreg
> > +              - samsung,exynos5433-sysreg
> 
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Do you also have a patch updating Documentation/devicetree/
> bindings/arm/samsung/sysreg.yaml with new compatibles?

Good point. This file should be probably dropped as everything is
documented in syscon.

Best regards,
Krzysztof
