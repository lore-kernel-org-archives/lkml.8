Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A641A206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C5fqAYsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgGANou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:44:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:35544 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgGANot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:44:49 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90710556;
        Wed,  1 Jul 2020 15:44:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593611087;
        bh=jbfeaPWgjpyl4npCPZWd2u+j30R3LLCtbd3TT1XMVz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5fqAYsqdnilwzhbLwwgku/jiab3H+cQ6NW6ij3QAkeVVv2udukoexBOkw3d+xzO7
         SO5HJu6rDJ9lgGl2GqTzy6Y5lfrcJj+NWdxjAjzLWAW3W+iGlK+/GvMcRmLFVMZOIX
         v0gt/1b/xViXCQBLiDGcOGtgYFM3ZKQO2kuPetC8=
Date:   Wed, 1 Jul 2020 16:44:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701134443.GE27013@pendragon.ideasonboard.com>
References: <20200701090438.21224-1-tklauser@distanz.ch>
 <20200701131902.GC27013@pendragon.ideasonboard.com>
 <20200701133643.GZ2599@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701133643.GZ2599@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, Jul 01, 2020 at 07:06:43PM +0530, Vinod Koul wrote:
> On 01-07-20, 16:19, Laurent Pinchart wrote:
> > On Wed, Jul 01, 2020 at 11:04:38AM +0200, Tobias Klauser wrote:
> > > This fixes the following compiler warning when building with
> > > CONFIG_PM && !CONFIG_PM_SLEEP:
> > > 
> > > drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
> > >   830 | static int xpsgtr_resume(struct device *dev)
> > >       |            ^~~~~~~~~~~~~
> > > drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
> > >   819 | static int xpsgtr_suspend(struct device *dev)
> > >       |            ^~~~~~~~~~~~~~
> > 
> > Oops :-S Sorry about that.
> > 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Vinod or Kishon, can you pick this patch up, or do I need to send a pull
> > request ? (It's my first driver in the PHY subsystem so I don't know
> > what the usual practices are there)
> 
> patches are welcome :-)
> 
> > 
> > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > ---
> > >  drivers/phy/xilinx/phy-zynqmp.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> > > index 8babee2ce9ec..22a0ae635797 100644
> > > --- a/drivers/phy/xilinx/phy-zynqmp.c
> > > +++ b/drivers/phy/xilinx/phy-zynqmp.c
> > > @@ -815,7 +815,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
> > >   * Power Management
> > >   */
> > >  
> > > -#ifdef CONFIG_PM
> > > +#ifdef CONFIG_PM_SLEEP
> 
> How about marking it as __maybe_unused instead?

I don't mind either, I'll let Tobias decide, but his patch seems fine,
is there a drawback in his approach ? If it's just a matter of personal
preference, I'd rather not require a v2.

-- 
Regards,

Laurent Pinchart
