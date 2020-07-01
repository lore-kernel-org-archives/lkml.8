Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E94206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V7uKOxV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgGANdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:33:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35500 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgGANdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:23 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D7552556;
        Wed,  1 Jul 2020 15:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593610401;
        bh=ro/PJ0uAPUTGMg/4fOvOKCnVZODkwKOfuYsBoctPuz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7uKOxV90LjtqTmQSx0SFlXauB1FtNa6h0tNPe/JX4+4qlS2qBhO9YC99zURkwE+I
         XSHF9haICdyZHgEWrCDnhCDYdp7ZjYbBCP1dOvqWvOBfjhSCDMS2QSxIe3J2JKlo2T
         X1i/S9LPu/7YdvfdgwQydYJ5sJ6joy5NsJOdyY4k=
Date:   Wed, 1 Jul 2020 16:33:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200701133317.GD27013@pendragon.ideasonboard.com>
References: <20200629120054.29338-1-laurent.pinchart@ideasonboard.com>
 <20200629120054.29338-2-laurent.pinchart@ideasonboard.com>
 <20200629223011.GA3074548@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629223011.GA3074548@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Jun 29, 2020 at 04:30:11PM -0600, Rob Herring wrote:
> On Mon, 29 Jun 2020 15:00:52 +0300, Laurent Pinchart wrote:
> > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > 
> > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > Processing System Gigabit Transceiver which provides PHY capabilities to
> > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > 
> > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v8:
> > 
> > - Rebase on phy/next
> > 
> > Changes since v7:
> > 
> > - Switch to GPL-2.0-only OR BSD-2-Clause
> > 
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
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:0: [0, 4248829952, 0, 262144] is too long
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.example.dt.yaml: example-0: phy@fd400000:reg:1: [0, 4248633344, 0, 4096] is too long
> 
> 
> See https://patchwork.ozlabs.org/patch/1319269
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

Sorry :-S I've updated the schema now. The patch has already been
merged, so I'll submit a fix.

-- 
Regards,

Laurent Pinchart
