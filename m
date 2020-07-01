Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6269C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58B2207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EJWVupU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgGANTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGANTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:19:09 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80382C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:19:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7FA1D556;
        Wed,  1 Jul 2020 15:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593609546;
        bh=QIuGWYDVJn87PMqCbqVV5hXAULxxSaTU2ZHwKo1N98g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJWVupU9GI2h+3VbaQNgDH9oXTC82DsapYCPV1BrYhumTtJayEl4OWedY/Fj2D762
         x2R/d3F+1XcVnOSWM2URyIF04AhIW/0TXOtkzutkzyoSykpPPRf0dtPDEn/BeUytTO
         B5GnnJMOhpiGOXsLDOlUZ32/kIfExmZNHL2kgrTY=
Date:   Wed, 1 Jul 2020 16:19:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] phy: zynqmp: Fix unused-function compiler warning
Message-ID: <20200701131902.GC27013@pendragon.ideasonboard.com>
References: <20200701090438.21224-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701090438.21224-1-tklauser@distanz.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

Thank you for the patch.

On Wed, Jul 01, 2020 at 11:04:38AM +0200, Tobias Klauser wrote:
> This fixes the following compiler warning when building with
> CONFIG_PM && !CONFIG_PM_SLEEP:
> 
> drivers/phy/xilinx/phy-zynqmp.c:830:12: warning: ‘xpsgtr_resume’ defined but not used [-Wunused-function]
>   830 | static int xpsgtr_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~
> drivers/phy/xilinx/phy-zynqmp.c:819:12: warning: ‘xpsgtr_suspend’ defined but not used [-Wunused-function]
>   819 | static int xpsgtr_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~

Oops :-S Sorry about that.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Vinod or Kishon, can you pick this patch up, or do I need to send a pull
request ? (It's my first driver in the PHY subsystem so I don't know
what the usual practices are there)

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index 8babee2ce9ec..22a0ae635797 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -815,7 +815,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
>   * Power Management
>   */
>  
> -#ifdef CONFIG_PM
> +#ifdef CONFIG_PM_SLEEP
>  static int xpsgtr_suspend(struct device *dev)
>  {
>  	struct xpsgtr_dev *gtr_dev = dev_get_drvdata(dev);
> @@ -854,7 +854,7 @@ static int xpsgtr_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM */
> +#endif /* CONFIG_PM_SLEEP */
>  
>  static const struct dev_pm_ops xpsgtr_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(xpsgtr_suspend, xpsgtr_resume)

-- 
Regards,

Laurent Pinchart
