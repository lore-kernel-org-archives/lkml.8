Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DEDC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB04021973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505367AbgDPKqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505324AbgDPKiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:38:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E029C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:38:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jP1uG-00044F-53; Thu, 16 Apr 2020 12:38:04 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jP1uF-0002qS-5f; Thu, 16 Apr 2020 12:38:03 +0200
Date:   Thu, 16 Apr 2020 12:38:03 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200416103803.eifgth77wi44pejc@pengutronix.de>
References: <1587019158-12143-1-git-send-email-Anson.Huang@nxp.com>
 <20200416093932.2mkcyv4rs6v6a24a@pengutronix.de>
 <DB3PR0402MB391613C2B53CEE067E1C7EC7F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB391613C2B53CEE067E1C7EC7F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:35:43 up 153 days,  1:54, 168 users,  load average: 0.25, 0.26,
 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-04-16 09:48, Anson Huang wrote:
> Hi, Marco
> 
> > Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> > json-schema
> > 
> > Hi Anson,
> > 
> > On 20-04-16 14:39, Anson Huang wrote:
> > 
> > ...
> > 
> > > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > new file mode 100644
> > > index 0000000..1c6e600
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > @@ -0,0 +1,66 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetr
> > ee.org%2Fschemas%2Fclock%2Fimx6q-clock.yaml%23&amp;data=02%7C01%
> > 7Canson.huang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C6
> > 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&
> > amp;sdata=Iw1CkVBMqw3m6sox6C3khcMy0BHNCQ9v2k72q3CM6Xs%3D&a
> > mp;reserved=0
> > > +$schema:
> > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetr
> > ee.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7Canson.hu
> > ang%40nxp.com%7Ca840fd5be8c94d4d950608d7e1ea16a2%7C686ea1d3bc2
> > b4c6fa92cd99c5c301635%7C0%7C1%7C637226267845578228&amp;sdata=P
> > Be2CEoDdMo9I1m3DHbITCyYxB4GF%2FigP%2FNd7YCopCQ%3D&amp;reserve
> > d=0
> > > +
> > > +title: Clock bindings for Freescale i.MX6 Quad
> > > +
> > > +maintainers:
> > > +  - Anson Huang <Anson.Huang@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: fsl,imx6q-ccm
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 2
> > 
> > IMHO I would force them to have exactly two so we need
> > minItems: 2 too here.
> 
> Actually, those 2 interrupts are NOT necessary for some platforms, such as i.MX platforms
> do NOT enable them at all, so is it OK to force them to be '2' here?

Why do we list them as required if they are not required? Currently all
5 platforms adding both irqs so this won't break anything here.

Regards,
  Marco

> Thanks,
> Anson
