Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D654BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B422C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AFlVfLb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFJRFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:05:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:41344 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:05:50 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BCAAA29E;
        Wed, 10 Jun 2020 19:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591808747;
        bh=ZT/nC6qDo3qrxgHBIHIVh6Z1UO4m1PQ4ivQ/Rys58vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AFlVfLb5GWleANehz2I1Q3WGTN1a+PF08g2R3csISBNuHDYxzQ1Q2/J7MLXwsw8qy
         Hfm9q3uexu28uC50dA9K3rNzTUrjYJEiBPBRWZ3CiizAZI58/37KsMD6/rgv53Gf4A
         ZOhIdw03o69fRSdFjLPbm3As2Ypiqnbn6VtUj7rI=
Date:   Wed, 10 Jun 2020 20:05:27 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200610170527.GA364@pendragon.ideasonboard.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
 <20200526183201.GA134956@bogus>
 <20200528015537.GF4670@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200528015537.GF4670@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Thu, May 28, 2020 at 04:55:38AM +0300, Laurent Pinchart wrote:
> On Tue, May 26, 2020 at 12:32:01PM -0600, Rob Herring wrote:
> > On Wed, 13 May 2020 20:22:37 +0300, Laurent Pinchart wrote:
> > > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > > 
> > > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > > Processing System Gigabit Transceiver which provides PHY capabilities to
> > > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > > 
> > > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > > Changes since v7:
> > > 
> > > - Switch to GPL-2.0-only OR BSD-2-Clause
> > > 
> > > Changes since v6:
> > > 
> > > - Fixed specification of compatible-dependent xlnx,tx-termination-fix
> > >   property
> > > - Dropped status property from example
> > > - Use 4 spaces to indent example
> > > 
> > > Changes since v5:
> > > 
> > > - Document clocks and clock-names properties
> > > - Document resets and reset-names properties
> > > - Replace subnodes with an additional entry in the PHY cells
> > > - Drop lane frequency PHY cell, replaced by reference clock phandle
> > > - Convert bindings to YAML
> > > - Reword the subject line
> > > - Drop Rob's R-b as the bindings have significantly changed
> > > - Drop resets and reset-names properties
> > > ---
> > >  .../bindings/phy/xlnx,zynqmp-psgtr.yaml       | 105 ++++++++++++++++++
> > >  include/dt-bindings/phy/phy.h                 |   1 +
> > >  2 files changed, 106 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thank you Rob.
> 
> Kishon, now that the bindings have been acked, could you please take the
> series in your tree (which I assume to tbe
> https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/) ?
> Is it too late for v5.8 ?

Gentle ping.

-- 
Regards,

Laurent Pinchart
