Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D8C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A732072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151375;
	bh=2RtfrIJb5ZRLOqfhHZZM9Tv1Uch+g6P3YOoBgzDYitg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wMtJFgI7aXwvszt7Gsnti7MCYN8Bp/HtMFab3mlrz4XFby75BQVlNvaoQl4r8slgr
	 AI3vnf6teLDyTVXx05Emi5aAdlXjGsUsabjHXACtuKj2eaKXuxMpzf1XTx+zZJGi+K
	 X7neyKHJ8Y6rEYlN3D1ljm9fVinWWsDVhfckp/1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgICQmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:42:53 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37965 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgICQmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:42:50 -0400
Received: by mail-il1-f194.google.com with SMTP id w3so3306208ilh.5;
        Thu, 03 Sep 2020 09:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3N9AevB6RmnRGPj8FDy4IK+19+ZllXrOBzHdsEB5tpA=;
        b=hsWu47SC5TEPEXUNd0Z7gjFGdiTbrGjFh4ciIKN1wrg4NyEl39Vs0LZ7x/28GePsaI
         D4vlp7tqbA5pmFgLrK7HUprKwoClcVWUj7Bty1pbLv4NBs6eESNGcsarKzN5oZuvsJko
         uTjI0qUYKXL0vBd2NJie8BPZ3SPj5A3G1j9O5mchINqX8a8UOItrihOa38QAwLh2/YOC
         hgjNHDVAfdv4fI03r2Na2iWT0fd6ftggSQowj8QSe47FQnTjjzuTSMZVXgnBDGIDVW1N
         tpee9UJ1Sj1Hr5cfqmjO0Grnno5BJi4y9VTmxd7OGmA8sBRMDWbcgldm1beU6T0lGB+O
         IHLg==
X-Gm-Message-State: AOAM531riI9NohBy5TzU17MR0nP8svLv5bpjva7ziEkBOP6MUQ3qKpS/
        JFzaGsyGKUUS00xAfsjTSg==
X-Google-Smtp-Source: ABdhPJxRAYyjUZiXDXO4KvACDThXQaoxGDmQVYPWjjr53PXDSj6UE7VQ2ryTEL5P37If/VKc8+Se/A==
X-Received: by 2002:a92:6606:: with SMTP id a6mr3867837ilc.128.1599151368926;
        Thu, 03 Sep 2020 09:42:48 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w26sm1755180ili.34.2020.09.03.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:42:48 -0700 (PDT)
Received: (nullmailer pid 2924734 invoked by uid 1000);
        Thu, 03 Sep 2020 16:42:46 -0000
Date:   Thu, 3 Sep 2020 10:42:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, David Airlie <airlied@linux.ie>,
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
        alsa-devel@alsa-project.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH 03/10] dt-bindings: timer: exynos4210-mct: Use
 unevaluatedProperties
Message-ID: <20200903164246.GA2924432@bogus>
References: <20200829142501.31478-1-krzk@kernel.org>
 <20200829142501.31478-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829142501.31478-3-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 04:24:54PM +0200, Krzysztof Kozlowski wrote:
> Additional properties actually might appear (e.g. clocks) so use
> unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: timer@101c0000:
>     'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. See https://lore.kernel.org/r/CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com/
