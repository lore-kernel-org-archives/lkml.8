Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D00C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB72206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598955176;
	bh=MGKnqLB1Ou22tvMwPIOerrs+OgaBk6N/30NyXTiKcuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dtr3VTWwRE67artimDo2su0NKTemCdEBNHIq4g8TBcIHEO15ZQj/fEdzYoopA4JY5
	 XV6r90t1tL3rfUdHWm9l/1I7aqNIOx/8pw+uJMABqpSRaLoVY/OFpGNCvjLI8JAd5R
	 6VL30cEzzLo8w9TaVItQQlqVKPu2sznz0pxx3zuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIAKMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:12:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45004 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:12:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so839547wrs.11;
        Tue, 01 Sep 2020 03:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=giRtIzkTWnj/UGp/V4sDByGnQWeXY4LNtuNjTm7i638=;
        b=tIF3akDDi9JlIxSblDTP2OIbFpuVer05B1L0aL+123HXdzYZ88MJZb8obhD6xuZDYB
         Aiwtyo+bG3rz76xhSrZDxaGBhCmcg9TPuW0U1Qq8ZyJ6HjjlobU/t5KhaTTf9yK07SgV
         ZGb+WKKUqoBxpqvTd8kkFfdnGxfM/y+FW5zqjuZXvHtgM1eLM5oue6ihzONhq7wec/0g
         57MemXZUAtu+MrVHB12TRhEfBouA6KOo+OQq+mX/TGNRlLgtqdCb+pK2OKJJ9Bs91u2R
         5Af9fhJ9fLGipeG7xD+U3ER9V0wV9FxxxxQP2qFqhvU6SsvIWwsxYuWrIhWoHhLU1fZS
         4nqw==
X-Gm-Message-State: AOAM533ZWgaJUSNHKBx2gRVp1opVz23WtcX6SNB00R6UbHXDCMOghFwx
        vsa2z6A4gtkee4QB09w47Oo=
X-Google-Smtp-Source: ABdhPJwK8OxvCf+LETTT3Ik4h2RI46o1x9bZbn8w3PgBgHR26b8+DSaVMTksnsrFbuik4iajwXifkA==
X-Received: by 2002:adf:9ed1:: with SMTP id b17mr1049306wrf.227.1598955170218;
        Tue, 01 Sep 2020 03:12:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id h5sm2534234wrc.45.2020.09.01.03.12.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Sep 2020 03:12:49 -0700 (PDT)
Date:   Tue, 1 Sep 2020 12:12:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 07/10] arm64: dts: exynos: Replace deprecated "gpios"
 i2c-gpio property in Exynos5433
Message-ID: <20200901101246.GC23793@kozik-lap>
References: <20200829142501.31478-1-krzk@kernel.org>
 <20200829142501.31478-7-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-7-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 04:24:58PM +0200, Krzysztof Kozlowski wrote:
> "gpios" property is deprecated.  Update the Exynos5433 DTS to fix
> dtbs_checks warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: i2c-gpio-0: 'sda-gpios' is a required property
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: i2c-gpio-0: 'scl-gpios' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 4 ++--

Applied.

Best regards,
Krzysztof

