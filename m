Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B24C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F4720409
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgB2XzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:55:23 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55408 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgB2XzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:55:22 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8Bx1-0004s7-QY; Sun, 01 Mar 2020 00:55:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: arm: fix Rockchip Kylin board bindings
Date:   Sun, 01 Mar 2020 00:55:19 +0100
Message-ID: <21505688.DxWBmkEV5j@phil>
In-Reply-To: <5d47cf5f-9ac4-cff4-340b-a2518a508738@gmail.com>
References: <20200228061436.13506-1-jbx6244@gmail.com> <73b41bd1-01e9-6af8-afc8-b1a96614d026@arm.com> <5d47cf5f-9ac4-cff4-340b-a2518a508738@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Freitag, 28. Februar 2020, 13:50:11 CET schrieb Johan Jonker:
> On 2/28/20 1:35 PM, Robin Murphy wrote:
> > On 28/02/2020 6:14 am, Johan Jonker wrote:
> >> A test with the command below gives this error:
> >>
> >> arch/arm/boot/dts/rk3036-kylin.dt.yaml: /: compatible:
> >> ['rockchip,rk3036-kylin', 'rockchip,rk3036']
> >> is not valid under any of the given schemas
> >>
> >> Fix this error by changing 'rockchip,kylin-rk3036' to
> >> 'rockchip,rk3036-kylin' in rockchip.yaml.
> > 
> 
> 
> > Although I can guess, it might be worth a note to explain why it's the
> > binding rather than the DTS that gets changed here.
> 
> Hi Robin,
> 
> My guess is that given a look at the other boards the processor name
> comes first and then the board name, so I changed it in rockchip.yaml.
> But maybe Heiko can better explain what the naming consensus in the past
> was.


I think what Robin meant was that there should be an explanation in the
commit message on why you change the binding and not the board.

Normally the dt-binding is the authoritative part, so boards should follow
the binding, but in the kylin-case the compatible from the .dts is used fr
years in the field now, so you're correct to fix the binding, as otherwise
we would break old users.

So just add a paragraph to the commit message with the above ;-)

Heiko


