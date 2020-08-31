Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65B8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776272073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 11:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598872931;
	bh=h1kMcG8he3kJobrVkF04CR2+ioy68IPllAuj7Q35pyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gkA66ldeb/5z3IYo6LCBfBTwGvPa+0gbJMFvR5tjX7Cpk4868js9tthW8YMwgH/FF
	 37cr1ZL3RAz55iJOrau4XwduVmZn/m5vMzJ3cOvEUhDr5Ngtar5m1/cP6tZrc9p2T2
	 iYvCsg6TEx1oK/ZwEaJez19Z/VVhZqOFjnO84QXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHaLWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgHaLR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:17:58 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4475E2072D;
        Mon, 31 Aug 2020 11:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598872297;
        bh=h1kMcG8he3kJobrVkF04CR2+ioy68IPllAuj7Q35pyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xoELkdYRm3whuwOE+7jGts+1CArRNLFlX1HvBNtbFsEs1b4R5WzDV3NzunMhvbPY0
         pd+mwILwRXzKlcNqaBrSS7DwAWuKnhWxTC3ZWsoHpY/xsLadTBe0OeoXc75ZYg+nqN
         HhVfrwX5RiknoLolgw3dDUfpYmqmslXD15NWlTL8=
Date:   Mon, 31 Aug 2020 16:41:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, Tony Lindgren <tony@atomide.com>,
        robh+dt@kernel.org, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-binding: phy: convert ti,omap-usb2 to YAML
Message-ID: <20200831111133.GP2639@vkoul-mobl>
References: <20200821081144.29288-1-rogerq@ti.com>
 <a6a59fba-6a0c-c00f-29e7-e85c7dcc1319@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6a59fba-6a0c-c00f-29e7-e85c7dcc1319@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 10:47, Roger Quadros wrote:
> Hi,
> 
> On 21/08/2020 11:11, Roger Quadros wrote:
> > Move ti,omap-usb2 to its own YAML schema.
> > 
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > 
> > v4
> > - fix example to fix dt_binding_check warnings
> > - '#phy-cells' -> "#phy-cells"
> > - Add 'oneOf' to compatible logic to allow just "ti,omap-usb2" as valid
> > 
> > v3
> > - Removed quotes from compatibles
> > - changed property to "ti,disable-charger-det"
> > 
> > v2
> > - Address Rob's comments on YAML schema.
> > 
> >   .../devicetree/bindings/phy/ti,omap-usb2.yaml | 72 +++++++++++++++++++
> >   .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
> >   2 files changed, 72 insertions(+), 37 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> > new file mode 100644
> > index 000000000000..a05110351814
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> > @@ -0,0 +1,72 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/ti,omap-usb2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: OMAP USB2 PHY
> > +
> > +maintainers:
> > + - Kishon Vijay Abraham I <kishon@ti.com>
> > + - Roger Quadros <rogerq@ti.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +        - enum:
> > +          - ti,dra7x-usb2
> > +          - ti,dra7x-usb2-phy2
> > +          - ti,am654-usb2
> 
> I missed these two.
> "ti,omap5-usb2"
> "ti,am437x-usb2"
> 
> While "ti,am437x-usb2" is being used in the device tree files
> I don't see "ti,omap5-usb2" being used anywhere.
> 
> omap5-l4.dtsi uses "ti,omap-usb2"
> 
> Should we get rid of "ti,omap5-usb2"?

Sure drop them ;-) we can always add back when we have a user

-- 
~Vinod
