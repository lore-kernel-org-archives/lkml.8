Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEFC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D512082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nyfrNejk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgAJK76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:59:58 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbgAJK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:59:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00AAxZTe081793;
        Fri, 10 Jan 2020 04:59:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578653975;
        bh=9+Ck3PRaRVIdp1krLVpCgf4FURcXnlnWOb8T6coy79M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nyfrNejkNB1FiPAWgbDHVtQ3iiC2/Jp8H1uiZfT+cRUg1ai0DpE4z38L1wvYHw6Hq
         8cWFwy/ozYcxI31BVErd34xjIXMOHvvUdkNWpstpTW72gan8oeLU1scsQrmutxpChP
         jalicy0DTy0H6D+m2wH6BzDJ/S8XBZFmMsJS2to4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00AAxZhE012420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jan 2020 04:59:35 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Jan 2020 04:59:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Jan 2020 04:59:35 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00AAxWRT044018;
        Fri, 10 Jan 2020 04:59:32 -0600
Subject: Re: [PATCH v2 00/14] Support more HDMI modes on RK3228/RK3328
To:     Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>
CC:     Zheng Yang <zhengyang@rock-chips.com>,
        <linux-rockchip@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200108210740.28769-1-jonas@kwiboo.se>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b159ee28-213e-35d2-6d09-516abc3358bb@ti.com>
Date:   Fri, 10 Jan 2020 16:31:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200108210740.28769-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/01/20 2:37 AM, Jonas Karlman wrote:
> This series make it possible to use more HDMI modes on RK3328,
> and presumably also on RK3228. It also prepares for a future YUV420 and
> 10-bit output series.
> 
> Part of this has been reworked from vendor BSP 4.4 kernel commits.
> 
> Patch 1-5 fixes issues and shortcomings in the inno hdmi phy driver.
> 
> Patch 6 prepares for use of high TMDS bit rates used with HDMI 2.0 and
> 10-bit output modes.
> 
> Patch 7-13 changes rk3228/rk3328 to use mode_valid functions suited for
> the inno hdmi phy instead of the dw-hdmi phy. These changes allows for
> more CEA modes to be usable, e.g. some 4K and fractal modes.
> 
> Patch 14 adds support for more pixel clock rates in order to support
> common DMT modes in addition to CEA modes.

Is it possible to split the series targeted for different subsystems or
is it required for all the patches to be merged together?

Thanks
Kishon
> 
> Note: I have only been able to build test RK322x related changes
> as I do not have any RK322x device to test on.
> 
> All modes, including fractal modes, has been tested with modetest on
> a RK3328 Rock64 device using e.g.
> 
>   modetest -M rockchip -s 39:3840x2160-29.97
> 
> Changes in v2:
>   - collect acked-by tag
>   - drop the limit resolution width to 3840 patch
> 
> This series is also available at [1] and the early work on YUV420 and
> 10-bit output is available at [2].
> 
> [1] https://github.com/Kwiboo/linux-rockchip/commits/next-20200108-inno-hdmi-phy
> [2] https://github.com/Kwiboo/linux-rockchip/commits/next-20200108-bus-format
> 
> Regards,
> Jonas
> 
> Algea Cao (1):
>   phy/rockchip: inno-hdmi: Support more pre-pll configuration
> 
> Huicong Xu (1):
>   phy/rockchip: inno-hdmi: force set_rate on power_on
> 
> Jonas Karlman (11):
>   phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
>   phy/rockchip: inno-hdmi: remove unused no_c from rk3328 recalc_rate
>   phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write
>   drm/rockchip: dw-hdmi: allow high tmds bit rates
>   drm/rockchip: dw-hdmi: require valid vpll clock rate on rk3228/rk3328
>   clk: rockchip: set parent rate for DCLK_VOP clock on rk3228
>   arm64: dts: rockchip: increase vop clock rate on rk3328
>   arm64: dts: rockchip: add vpll clock to hdmi node on rk3328
>   ARM: dts: rockchip: add vpll clock to hdmi node on rk3228
>   drm/rockchip: dw-hdmi: limit tmds to 340mhz on rk3228/rk3328
>   drm/rockchip: dw-hdmi: remove unused plat_data on rk3228/rk3328
> 
> Zheng Yang (1):
>   phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate
> 
>  arch/arm/boot/dts/rk322x.dtsi                 |   4 +-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |   6 +-
>  drivers/clk/rockchip/clk-rk3228.c             |   2 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  47 ++++++--
>  drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 110 ++++++++++++------
>  5 files changed, 120 insertions(+), 49 deletions(-)
> 
