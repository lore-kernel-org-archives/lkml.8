Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9676EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7271420663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jtL5O4+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbgGAOBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGAOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:01:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9352FC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 07:01:13 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07809556;
        Wed,  1 Jul 2020 16:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593612072;
        bh=XA2+VD+CcVvmHi+egZz6MPHuCoj4THiqmknNDsUNyBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtL5O4+7rk+wQJ+1SotrLZ/SfiXTTgHQZI8AaUdiJlu/oqzFCCVct4aycicrd2RA4
         +VS4igVdSaBT57VBCoJEsKQ0pCervuGDaIMz0zV2aOcPN9EEfVa0olVednn+zJAqZf
         ZjsQiFR6YBXP2TEG6acmi+BBDNIFGM0FRKi6cHgg=
Date:   Wed, 1 Jul 2020 17:01:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701140108.GF27013@pendragon.ideasonboard.com>
References: <20200701090438.21224-1-tklauser@distanz.ch>
 <20200701131902.GC27013@pendragon.ideasonboard.com>
 <20200701133643.GZ2599@vkoul-mobl>
 <20200701134443.GE27013@pendragon.ideasonboard.com>
 <20200701140026.ziplawf6oimjyssh@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701140026.ziplawf6oimjyssh@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 04:00:26PM +0200, Tobias Klauser wrote:
> On 2020-07-01 at 15:44:43 +0200, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> > On Wed, Jul 01, 2020 at 07:06:43PM +0530, Vinod Koul wrote:
> > > On 01-07-20, 16:19, Laurent Pinchart wrote:
> > > > On Wed, Jul 01, 2020 at 11:04:38AM +0200, Tobias Klauser wrote:
> > > > > This fixes the following compiler warning when building with
> > > > > CONFIG_PM && !CONFIG_PM_SLEEP:
> > > > > 
> > > > > drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
> > > > >   830 | static int xpsgtr_resume(struct device *dev)
> > > > >       |            ^~~~~~~~~~~~~
> > > > > drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
> > > > >   819 | static int xpsgtr_suspend(struct device *dev)
> > > > >       |            ^~~~~~~~~~~~~~
> > > > 
> > > > Oops :-S Sorry about that.
> > > > 
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks for the review Laurent.
> 
> > > > Vinod or Kishon, can you pick this patch up, or do I need to send a pull
> > > > request ? (It's my first driver in the PHY subsystem so I don't know
> > > > what the usual practices are there)
> > > 
> > > patches are welcome :-)
> > > 
> > > > 
> > > > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > > > ---
> > > > >  drivers/phy/xilinx/phy-zynqmp.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> > > > > index 8babee2ce9ec..22a0ae635797 100644
> > > > > --- a/drivers/phy/xilinx/phy-zynqmp.c
> > > > > +++ b/drivers/phy/xilinx/phy-zynqmp.c
> > > > > @@ -815,7 +815,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
> > > > >   * Power Management
> > > > >   */
> > > > >  
> > > > > -#ifdef CONFIG_PM
> > > > > +#ifdef CONFIG_PM_SLEEP
> > > 
> > > How about marking it as __maybe_unused instead?
> > 
> > I don't mind either, I'll let Tobias decide, but his patch seems fine,
> > is there a drawback in his approach ? If it's just a matter of personal
> > preference, I'd rather not require a v2.
> 
> I don't mind either, it was just what seemed the more straight-forward
> fix. On the other hand, it seems that marking these functions as
> __maybe_unused is the more widely used method in other PHY drivers. In
> addition it would have the nice side-effect of the code always being
> compile-checked regardless of the value of CONFIG_PM_SLEEP.

That's a good point, haven't thought about it.

> Will send a v2 using __maybe_unused and will let you decide which one to
> pick :)

You can keep my R-b :-)

-- 
Regards,

Laurent Pinchart
