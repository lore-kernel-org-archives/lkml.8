Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A25BC47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A29D208DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEBGap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 02:30:45 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43516 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgEBGao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 02:30:44 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id E87D720034;
        Sat,  2 May 2020 08:30:37 +0200 (CEST)
Date:   Sat, 2 May 2020 08:30:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dillon min <dillon.minfei@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, thierry.reding@gmail.com
Subject: Re: [PATCH 1/4] add dts node for drm panel driver ili9341 add dts
 i2c3 for stmpe touch add dts spi5 for gyro & ili9341
Message-ID: <20200502063036.GA9204@ravnborg.org>
References: <1588239802-11442-1-git-send-email-dillon.minfei@gmail.com>
 <33f928e7-3fde-99a2-b84d-d74a2d3f1186@st.com>
 <CAL9mu0+AqO69+rEcH=HVWRhDLbqDO52-Cjxt-PAZmg6=7QtpvQ@mail.gmail.com>
 <40bdf88c-fbc2-564c-1aec-38318bab5e61@st.com>
 <CAL9mu0KRPPrTUWggs2dQWPGjkyubUMpYx=3JzOpwTPQPHjsGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL9mu0KRPPrTUWggs2dQWPGjkyubUMpYx=3JzOpwTPQPHjsGhw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ULXz4hXy c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=bnXyCQR6rJ-qSE-LuncA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dillon min

> > okay, thanks alexandre, i will go through these docs. currently i'm on may
> day holiday,  will be back at  next wensday.
> after go back to work. i will separate this patch to five part with 9
> patchs , should be more clear
> 
> dts releated
>     1,  ARM: dts: stm32: Add i2c3 node for stm32f429
>     2,  ARM: dts: stm32: Add drm panel ili9341 nodes connect to ldtc
> support for stm32f429-disco board
>     3,  ARM: dts: stm32: Add stmpe811 touch screen support for
> stm32f429-disco board
>     4,  ARM: dts: stm32: Add l3gd20 gyroscope sensor support for
> stm32f429-disco board
> 
> clk releated
>     1, clk: stm32: Fix ltdc loading hang in set clk rate, pll_hw set to
> clks[PLL_VCO_SAI] but not clks[PLL_SAI]
>     2, clk: stm32: Add CLK_IGNORE_UNUSED flags for ltdc, make sure ltdc clk
> not be released after system startup
> 
> spi releated
>     1, spi: stm32: Add transfer mode SPI_SIMPLE_RX, SPI_3WIRE_RX support
> for stm32f4
> 
> drm releated
>     1, drm/panel: Add panel driver ilitek-ili9341
> 
> doc releated
>      1, dt-bindings: display: panel: Add binding document for Ilitek Ili9341

Patch separation looks good.
Please cc: me on both the binding and the panel patches.
The binding must be in DT Schema format (.yaml).
See a lot of examples in drm-misc-next for inspiration.

Looks forward to see/review your submission.

	Sam
