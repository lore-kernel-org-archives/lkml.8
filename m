Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDA624699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgB1PPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:15:44 -0500
Received: from gloria.sntech.de ([185.11.138.130]:39050 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgB1PPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:15:43 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j7hMM-0006eU-6O; Fri, 28 Feb 2020 16:15:26 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        anarsoul@gmail.com, enric.balletbo@collabora.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for Pinebook Pro
Date:   Fri, 28 Feb 2020 16:15:25 +0100
Message-ID: <3144691.gaQQKPV42P@diego>
In-Reply-To: <37190f26-48aa-dcad-d4b1-8a534ba1360e@manjaro.org>
References: <20200227180630.166982-1-t.schramm@manjaro.org> <12370413.gKdrHkWbHd@diego> <37190f26-48aa-dcad-d4b1-8a534ba1360e@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

Am Freitag, 28. Februar 2020, 15:57:10 CET schrieb Tobias Schramm:
> thanks for the review. I'll implement the changes and send a v2.
> 
> >> +	 * of wakeup sources without disabling the whole key
> > Also can you explain the problem a bit? If there is a deficit in the input
> > subsystem regarding wakeup events, dt is normally not the place to work
> > around things [we're supposed to be OS independent]
> 
> The issue is that some users wanted to be able to control the wakeup
> functionality of the keys separately via sysfs. That does not seem to be
> possible when combining both keys into one gpio-keys node. A more
> detailed explanation of the issue can be found at [1].

ok ... but that is really strange, because looking at gpio-keys.c I see
it checking the individual button wakeup-property before setting
the irq-wake in gpio_keys_enable_wakeup() .

Ah, but I guess manually disabling/enabling wakeup via sysfs only
works for the whole device and all wakeup buttons.

In general this sounds more like a gpio-keys deficit, but in the end
we can keep the separate gpio-key nodes here, they don't violate any
dt-bindings ;-) .


Heiko


