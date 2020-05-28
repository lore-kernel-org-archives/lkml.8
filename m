Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB0921501
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QqOuFKFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgE1Bzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1Bzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:55:52 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FFBC05BD1E;
        Wed, 27 May 2020 18:55:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DD10F2A3;
        Thu, 28 May 2020 03:55:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590630951;
        bh=weeaXrG0JGqx89U8YtVtnwMwqP8R4uUV/wMhTEheEHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqOuFKFbdOT3jofW7/jAoPGdoDGs1Y48RAyScxf+m1A4NGx7tul3bSuRoO8x0UIrG
         rpu0eM1T6GQYkwanZQYE8svrte5Flbpqk8FKr7Jp6r8JfIZj+Ll+QeZNCYWAz9sSYM
         eR0fMJ0ZcaPb6jbdFpuq1noAGI0XoisMCK6Q2qWo=
Date:   Thu, 28 May 2020 04:55:37 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: phy: Add DT bindings for Xilinx
 ZynqMP PSGTR PHY
Message-ID: <20200528015537.GF4670@pendragon.ideasonboard.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-2-laurent.pinchart@ideasonboard.com>
 <20200526183201.GA134956@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526183201.GA134956@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:32:01PM -0600, Rob Herring wrote:
> On Wed, 13 May 2020 20:22:37 +0300, Laurent Pinchart wrote:
> > From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > 
> > Add DT bindings for the Xilinx ZynqMP PHY. ZynqMP SoCs have a High Speed
> > Processing System Gigabit Transceiver which provides PHY capabilities to
> > USB, SATA, PCIE, Display Port and Ehernet SGMII controllers.
> > 
> > Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
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
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you Rob.

Kishon, now that the bindings have been acked, could you please take the
series in your tree (which I assume to tbe
https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/) ?
Is it too late for v5.8 ?

-- 
Regards,

Laurent Pinchart
