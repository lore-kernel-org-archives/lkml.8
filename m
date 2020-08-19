Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE97C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A9B207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHSUJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:09:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50522 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSUJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:09:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 19B801A04AE;
        Wed, 19 Aug 2020 22:09:20 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0CC681A02B3;
        Wed, 19 Aug 2020 22:09:20 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id EB6AC20328;
        Wed, 19 Aug 2020 22:09:19 +0200 (CEST)
Date:   Wed, 19 Aug 2020 23:09:19 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 09/17] arm64: dts: Remove imx-hdmimix-reset header file
Message-ID: <20200819200919.jck4j6gcuogw3z4h@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
 <1597406966-13740-10-git-send-email-abel.vesa@nxp.com>
 <CAA+hA=R+zVeVEX_DcsTWD0FtaEHdeyapa4gR-_8Y=yzZD3ku1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+hA=R+zVeVEX_DcsTWD0FtaEHdeyapa4gR-_8Y=yzZD3ku1w@mail.gmail.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-17 15:51:13, Dong Aisheng wrote:
> On Fri, Aug 14, 2020 at 8:13 PM Abel Vesa <abel.vesa@nxp.com> wrote:
> >
> > The hdmi BLK_CTRL ids have been moved to imx8mp-reset.h
> >
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> 
> The change seems do not comply with the patch title?
> 

Will fix it in the next version.

> Regards
> Aisheng
> 
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index 9de2aa1..daa1769 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <dt-bindings/clock/imx8mp-clock.h>
> > +#include <dt-bindings/reset/imx8mp-reset.h>
> >  #include <dt-bindings/gpio/gpio.h>
> >  #include <dt-bindings/input/input.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > --
> > 2.7.4
> >
