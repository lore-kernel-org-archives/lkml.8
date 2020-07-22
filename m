Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4132C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B445E24895
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbgGVTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:21:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47772 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbgGVTV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:21:57 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyKJN-0005VY-W2; Wed, 22 Jul 2020 21:21:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add PCIe for RockPI N10
Date:   Wed, 22 Jul 2020 21:21:52 +0200
Message-ID: <3418931.F1eFr0XNtI@phil>
In-Reply-To: <CAMty3ZDkvRGn6a54ryVFNJOwm+X6YXW-TxSjO+kC9o2kshRxtg@mail.gmail.com>
References: <20200720110230.367985-1-jagan@amarulasolutions.com> <20200720110230.367985-3-jagan@amarulasolutions.com> <CAMty3ZDkvRGn6a54ryVFNJOwm+X6YXW-TxSjO+kC9o2kshRxtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 22. Juli 2020, 20:51:07 CEST schrieb Jagan Teki:
> Hi Heiko,
> 
> On Mon, Jul 20, 2020 at 4:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > This patch adds support to enable PCIe for RockPI N10.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../dts/rockchip/rk3399pro-vmarc-som.dtsi     | 41 ++++++++++++++++++-
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > index ebccc4a153a2..b415b8a16c78 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> > @@ -11,6 +11,19 @@
> >
> >  / {
> >         compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
> > +
> > +
> 
> Sorry for this extra space, let me know so that I can resend next version.

I fixed that up when applying the series.

Heiko


