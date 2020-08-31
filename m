Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA002C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A568A2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598862692;
	bh=Y31qLhzOdm0QS1k1AaucABODVmh6t8hYuU8gVesZH10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E0wyDpj28bPx5LrlRa8jVXXdvsi7rnB2o+1q7D2UMb4LHgjzwLA2V4KzXZXuc8nJm
	 yAvGknaw3RLat+F4q9+rAd/HcP84BhVr3xnHRohVPJMFFSFmBTxyN2W7oTuh7cpPGn
	 lh8Gp+DUXBVMjmDmV+iYr1mtxcQ29DMEgt34JztA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHaIbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 04:31:31 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43196 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgHaIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 04:31:28 -0400
Received: by mail-ej1-f67.google.com with SMTP id m22so7302843eje.10;
        Mon, 31 Aug 2020 01:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8c8PT+GX2bdj4Es9cku2hg+l1WawbuG/Qnvn+DarqU=;
        b=srYh+chfqEqOFiiup/4HDw5LqErEERrIt+bYeGKL8QkkRmYEmSdVKuKHoypnBikqPZ
         Oy+sn98nWOTDut33YDk+lJ830xxTnClmr/Td0215HqHAPuOdPHFYs2F1T115STV4fQWe
         TQwiEyFXYeymYfsXGYsKu9wDT7QlzB7GaIM4JukDfcO/c1CbdkcOi76HsFJGdTPu7bMx
         FvaYvPpbRC6Xp4/QJbK1mNDzy8AXt7zkXST2CHug66LGrzzniqYz9h1gbTSKZASdnac1
         d61r4TJGjfJznlZOc6aA3lhz/UmM5tDXqyBsQI7m3ZMhwaGBc7CE9VCNu32kF/4YBuoY
         5gow==
X-Gm-Message-State: AOAM530WCZ7nJM/nQshvUXxHPZ+jkqrlO7mz0xvhqk5xgl+wHLFLIPVx
        sWfNKul0DiRXbzgfRknKBXI=
X-Google-Smtp-Source: ABdhPJz7Onk9KEruHrJQU0MEdyIWElLR9/8+aU3k59m6nJC8T34rrg/1FhfXtV9j8V8Vp+1IL4ozAQ==
X-Received: by 2002:a17:906:b09a:: with SMTP id x26mr116036ejy.162.1598862685674;
        Mon, 31 Aug 2020 01:31:25 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id z18sm1172814ejw.94.2020.08.31.01.31.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 01:31:25 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:31:22 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [RFT 3/4] ARM: dts: exynos: Move CMU assigned ISP clocks to
 buses in Exynos3250
Message-ID: <20200831083122.GA12874@kozik-lap>
References: <20200829172532.29358-1-krzk@kernel.org>
 <CGME20200829172553eucas1p1b62ad1cac6e0eea1dbb4669f09949419@eucas1p1.samsung.com>
 <20200829172532.29358-3-krzk@kernel.org>
 <6ed67a82-0f29-7384-203d-dcb2e58c5a8d@samsung.com>
 <20200831081906.GA11513@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200831081906.GA11513@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:19:06AM +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 31, 2020 at 10:11:02AM +0200, Marek Szyprowski wrote:
> > Hi Krzysztof,
> > 
> > On 29.08.2020 19:25, Krzysztof Kozlowski wrote:
> > > Commit 52005dece527 ("ARM: dts: Add assigned clock parents to CMU node
> > > for exynos3250") added assigned clocks under Clock Management Unit to
> > > fix hangs when accessing ISP registers.
> > >
> > > This is not the place for it as CMU does not have a required "clocks"
> > > property:
> > >
> > >    arch/arm/boot/dts/exynos3250-artik5-eval.dt.yaml: clock-controller@10030000: 'clocks' is a dependency of 'assigned-clocks'
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > >
> > > ---
> > >
> > > Not tested and I wonder whether actually correct. For example, what will
> > > happen if devfreq (exynos-bus) is not built in?
> > >
> > > Could someone verify it?
> > 
> > Sorry, but this patch is not correct. Those clocks has noting with 
> > bus-freq. The assigned clocks property should stay where it is. Maybe 
> > one need to fix the schemas for dts verification. Those clocks has to be 
> > set (and so generic clock framework does) according to the assigned 
> > clocks properties once the clock controller is instantiated.
> > 
> > The only alternative would be to add exynos-subcmu variant to properly 
> > link CMU with the ISP power domain, but assuming that there is no Exynos 
> > 3250 ISP driver in mainline (and probably never will be), it is safe to 
> > keep those clocks sourced from 24MHz crystal.
> 
> Thanks for the clarification.  Another solution to silence the warning
> could be to add a "clocks" property for FIN_PLL, although the driver
> actually does not take it.
> 
> This is the only remaining dtschema check warning on Exynos3250 so it
> would be nice to at least silence it. My goal is to have all them
> schema-correct, or as close as possible (for Exynos4 the camera node is
> a trouble).

BTW, if you have some time, it would be awesome if you could test all
the series (on Exynos3250 obviously with this patch reverted):
https://github.com/krzk/linux/tree/for-next/dts-exynos-schema-cleanups

The Exynos5 cleanup is ongoing, so there will be more patches. But
Exynos3 and Exynos4 I finished.

Best regards,
Krzysztof

