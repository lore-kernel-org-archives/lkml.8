Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CAC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1B220736
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 18:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCVSDq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 14:03:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43536 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgCVSDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 14:03:46 -0400
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jG4wk-0007rU-0k; Sun, 22 Mar 2020 19:03:38 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Caesar Wang <wxt@rock-chips.com>,
        kever.yang@rock-chips.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date:   Sun, 22 Mar 2020 19:03:35 +0100
Message-ID: <48029127.kezn7BFppT@diego>
In-Reply-To: <1a6f0ba0-c49c-c547-1252-eed404655f43@gmail.com>
References: <20200322140046.5824-1-jbx6244@gmail.com> <48a91cc1-7751-4df0-a2cd-940eb829fa16@gmail.com> <1a6f0ba0-c49c-c547-1252-eed404655f43@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 22. März 2020, 17:14:54 CET schrieb Johan Jonker:
> Hi,
> 
> Why is 'pd_tcpc0, pd_tcpc1' grouped under 'pd_vio' instead of VD_LOGIC?

^^
You'll need to add Rockchip-people for that - I've done that now ;-)



> On 3/22/20 4:45 PM, Johan Jonker wrote:
> > Hi,
> > 
> > The RK3399 TRM uses both
> > 
> > 'pd_tcpc0, pd_tcpc1'
> > 
> > as
> > 
> > 'pd_tcpd0, pd_tcpd1'.
> > 
> > What should we use here?

We should probably just fix the nodename as you did.
- For one tcpD seems to be appearing way more often than tcpC
- and of course the header is part of the binding itself, so that shouldn't
  change without a really good reason


Heiko

> > 
> > Thanks.
> > 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> index 8aac201f0..3dc8fe620 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -1087,12 +1087,12 @@
> >>  					pm_qos = <&qos_isp1_m0>,
> >>  						 <&qos_isp1_m1>;
> >>  				};
> >> -				pd_tcpc0@RK3399_PD_TCPC0 {
> >> +				pd_tcpc0@RK3399_PD_TCPD0 {
> >>  					reg = <RK3399_PD_TCPD0>;
> >>  					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> >>  						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
> >>  				};
> >> -				pd_tcpc1@RK3399_PD_TCPC1 {
> >> +				pd_tcpc1@RK3399_PD_TCPD1 {
> >>  					reg = <RK3399_PD_TCPD1>;
> >>  					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> >>  						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> > 
> 
> 




