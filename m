Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E714206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594147856;
	bh=q1dR/jTPZVK8xl37KWCnPKEDb2AOMCbqOvChW4D47CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RBuHecflei2HBTYJqTeIm+prvqXyW3kz+lNWf/iyY4QFcHC1lBt+Zh2ygTZCh/Y+e
	 F2C7NKYbjZuHl/jvCE9CLARqVvVTp36xPTEG4O42x9dfer3HYl+z/Tc0LCJbowM9aY
	 aXW3vGQzfPVS9RpOxDjnWbr+Nnpl+Gxdivkan2aE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGGSuz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:50:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36788 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgGGSuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:50:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id 17so193930wmo.1;
        Tue, 07 Jul 2020 11:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=m/t4PDWucGx9E7+lQRxXkI+ujQ2IZO1RtvREvMleNek=;
        b=XYeRo8UuqhamN5mxrIR+8yPg8YOy2sTA77fV1exURMx1f/eYvCpMashZ6MsTQuuxSq
         PHZJSmm52aColg3xteJFnkDJf/HgMR8rKdDO5uwJjQUl3+DmssxODEEUiBbj/hqw+oDH
         QlQgpqq7KITu7HjQZ/ogYmLgJjh8lH4ROPvzW/nfHBLLg8HEEZNGn1umScGjxw6H8E7Z
         C9uJVG3UtIQsKDk4QDdEYPIBuMEuehWbkYjNkRZf4AvMC7WBw+JnDKY9gf+OT0cr0Xrv
         VNRax9ytJOk+g1o5+ObsNcyq4uGDUri41NhY338KaaFDOMGTd8KVA+QNGEym3BHNkGd5
         iFhw==
X-Gm-Message-State: AOAM532YeTzozaK3JgBFKjDhy69Q02HaFCrToLi2I9r0a19YFQ77p2LN
        e3iQEYSrkgFqNpc39fkLEhc=
X-Google-Smtp-Source: ABdhPJyeYxQzWHl3HP96w4mkIZMaje9wIX3EMZDnNv2vf2IMnQnRi6Mcgqa62eD6LSqOcYGyqZ2I6A==
X-Received: by 2002:a7b:cc08:: with SMTP id f8mr5884261wmh.106.1594147852592;
        Tue, 07 Jul 2020 11:50:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id p25sm1909109wmg.39.2020.07.07.11.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 11:50:51 -0700 (PDT)
Date:   Tue, 7 Jul 2020 20:50:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: pwm: samsung: Do not require
 interrupts on Exynos SoCs
Message-ID: <20200707185049.GA4698@kozik-lap>
References: <20200702155149.12854-1-krzk@kernel.org>
 <20200706094157.kyag7p5df3vo54wx@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200706094157.kyag7p5df3vo54wx@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 11:41:57AM +0200, Uwe Kleine-König wrote:
> On Thu, Jul 02, 2020 at 05:51:42PM +0200, Krzysztof Kozlowski wrote:
> > The bindings required interrupts for all SoCs but actually only the PWM
> > timer clocksource (for S3C/S5P SoCs) was using them.  This PWM timer
> > clocksource driver is not used on Exynos SoCs thus the interrupts can be
> > marked as optional.
> > 
> > Reported-by: Alim Akhtar <alim.akhtar@samsung.com>
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> LGTM,
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I'd expect it is ok to let this patch go in via whatever way the other
> patches go. (But it's Thierry who has the authority here.)

This patch is independent so it can go either through PWM tree or DT
bindings.  Usually the latter, so Rob was picking it up.

Thanks for ack.

Best regards,
Krzysztof

