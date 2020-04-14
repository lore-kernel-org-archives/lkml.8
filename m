Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39C5C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8184A206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qAyB0QMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633018AbgDNUT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:19:29 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33934 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632966AbgDNUTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:19:19 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD388521;
        Tue, 14 Apr 2020 22:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586895557;
        bh=+UhAukuHpWBQw5cLcXoxWsl3QYmiftvO+F62gY+DOGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAyB0QMoFxjy4QyceMIsascEC65p391ITrJJHsqG3JgqkgHjET9sYmXcUApgnNXfE
         HyrCHh1hPH9C34IeDxpKlx3lwGP9DEaBmgfJeeo0G1aktnr45Eh3NPrkHuqyGOTJmD
         3GB9h1SYiaE+TeLJjQOvs3eBiHEnG0ifRuczLiyM=
Date:   Tue, 14 Apr 2020 23:19:05 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200414201905.GK19819@pendragon.ideasonboard.com>
References: <20200401221025.26087-1-laurent.pinchart@ideasonboard.com>
 <20200401221025.26087-2-laurent.pinchart@ideasonboard.com>
 <20200414164717.GA11384@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200414164717.GA11384@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Apr 14, 2020 at 11:47:17AM -0500, Rob Herring wrote:
> On Thu, Apr 02, 2020 at 01:10:23AM +0300, Laurent Pinchart wrote:
> > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > 
> > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > Processing System Gigabit Transceiver which provides PHY capabilities to
> > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > 
> > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > Changes since v6:
> > 
> > - Fixed specification of compatible-dependent xlnx,tx-termination-fix
> >   property
> > - Dropped status property from example
> > - Use 4 spaces to indent example
> > 
> > Changes since v5:
> > 
> > - Document clocks and clock-names properties
> > - Document resets and reset-names properties
> > - Replace subnodes with an additional entry in the PHY cells
> > - Drop lane frequency PHY cell, replaced by reference clock phandle
> > - Convert bindings to YAML
> > - Reword the subject line
> > - Drop Rob's R-b as the bindings have significantly changed
> > - Drop resets and reset-names properties
> > ---
> >  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
> >  include/dt-bindings/phy/phy.h                 |   1 +
> >  2 files changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > new file mode 100644
> > index 000000000000..d28ddca7b90e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > @@ -0,0 +1,105 @@
> > +# SPDX-License-Identifier: GPL-2.0
> 
> I think I said this already, but dual license please.

It's still pending legal review on Xilinx's side. I've decided to post
v7 without waiting for that to get the rest of the review done while
waiting for the license change green light, which I don't assume would
be denied.

-- 
Regards,

Laurent Pinchart
