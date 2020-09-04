Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40C9208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 21:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgIDVXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 17:23:36 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56938 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgIDVXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:23:35 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kEJB4-00015W-HH; Fri, 04 Sep 2020 23:23:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Tom Cubie <tom@radxa.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 0/3] extcon: Add Type-C Virtual PD
Date:   Fri, 04 Sep 2020 23:23:21 +0200
Message-ID: <6955091.ERBjKZ0CLf@diego>
In-Reply-To: <20200904191830.387296-1-jagan@amarulasolutions.com>
References: <20200904191830.387296-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

Am Freitag, 4. September 2020, 21:18:27 CEST schrieb Jagan Teki:
> USB Type-C protocol supports various modes of operations
> includes PD, USB3, and Altmode. If the platform design
> supports a Type-C connector then configuring these modes
> can be done via enumeration.
> 
> However, there are some platforms that design these modes
> of operations as separate protocol connectors like design
> Display Port from on-chip USB3 controller. So accessing
> Type-C Altmode Display Port via onboard Display Port 
> connector instead of a Type-C connector.
>  
> These kinds of platforms require an explicit extcon driver
> in order to handle Power Delivery and Port Detection.
> 
> This series support this Type-C Virtual PD and enable the
> same in ROCK Pi 4C SBC.
> 
> Any inputs?

I tend to disagree on the design via an extcon.

That the Rockchip rk3399 currently carries that extcon thingy is unfortunate
and only works for ChromeOS devices based on the rk3399.

The kernel now has a real type-c framework so we should not extend this
extcon hack any further, because that will make it even harder to roll back
later. Also simply because other Rockchip boards currently can't really make
use of type-c due to this, as they use the fsusb302 phys directly connected.

ChromeOS actually spend some time to make the cros-ec pd part of the type-c
framework if I remember correctly, so a viable battle plan would be to:

(1) move the Rockchip type-c phy driver to actually be part of the type-c
    framework, with the extcon being a deprecated fallback for old DTs.
(2) implement your gpio-altmode as part of the type-c framework
    (which may even already exist)


In short, please don't extend the rk3399 type-c extcon hack.

Thanks
Heiko




