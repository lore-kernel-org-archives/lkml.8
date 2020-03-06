Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5375AC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FBF20637
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCFS5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:57:51 -0500
Received: from mail.manjaro.org ([176.9.38.148]:41996 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgCFS5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:57:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 9ADA13C21A13;
        Fri,  6 Mar 2020 19:57:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tbmb0qDcjibI; Fri,  6 Mar 2020 19:57:47 +0100 (CET)
Subject: Re: [PATCH v4 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
To:     Heiko Stuebner <heiko@sntech.de>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>,
        Alexis Ballier <aballier@gentoo.org>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Nick Xie <nick@khadas.com>, Andy Yan <andy.yan@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vivek Unune <npcomplete13@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200304213023.689983-2-t.schramm@manjaro.org>
 <20200304213023.689983-3-t.schramm@manjaro.org> <6168222.Wuk326WHQK@phil>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <b30fef29-6667-9200-178b-4d0e9fc63c12@manjaro.org>
Date:   Fri, 6 Mar 2020 19:58:45 +0100
MIME-Version: 1.0
In-Reply-To: <6168222.Wuk326WHQK@phil>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

>> This commit adds initial dt support for the rk3399 based Pinebook Pro.
>>
>> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
>
> applied for 5.7
>

any chance you can squeeze in another small fix? Somewhere in the
process the vmcc and vqmmc supplies of the sdmmc controller were removed
in error. Those should be added to the sdmmc controller like this:

 &sdmmc {
        pinctrl-names = "default";
        pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
        sd-uhs-sdr104;
+       vmmc-supply = <&vcc3v0_sd>;
+       vqmmc-supply = <&vcc_sdio>;
        status = "okay";
 };

Thanks,

Tobias
