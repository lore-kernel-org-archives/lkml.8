Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48967C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBCB20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GstG9I6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgENI2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:28:12 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA86C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Iqx+R9RDnrWxC9fRW/DBM4vpRxdzcnblY4Sl8eFkAaY=; b=GstG9I6hknIsoz0GovgM/aKyw
        EOehkTOlDR+MGFWAu7a5CoJMVuTeM52dktLtmWG1IUTMC/D+Yi6lkQ5K0qL0LYEOI1QxS+YWG3UIT
        O2hb9kA+yw8UK97d6jTAY2SMjJoCylS0lO322C/SwZNJS52j8wT2p6O4pcCPqF18PUalGCja7QmCk
        MIvyJt3c5zoWFKS9wWnG10ZNsqAEOBz+LAT20a8DCisLnhKygRF2mL9IgpiP/PahEUAgV8SSjBKap
        NbagSgPI9Il7iUjkTkjTeCNk0Ni3t89PHrObFfwaI4vgvyW8eLWhZI29+XjxJ90SaGEb7tALpQoD/
        pQdL653pg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:57828)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jZ9Di-0007Ua-GB; Thu, 14 May 2020 09:27:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jZ9Dg-0000Pj-2w; Thu, 14 May 2020 09:27:56 +0100
Date:   Thu, 14 May 2020 09:27:56 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
Message-ID: <20200514082755.GN1551@shell.armlinux.org.uk>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
 <20200513150007.1315395-3-lkundrak@v3.sk>
 <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
 <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
 <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:18:02AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 13.05.2020, 23:41 -0300 schrieb Fabio Estevam:
> > On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> > 
> > > The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> > > says that only the 'reg' clock could be optional, the others are
> > > required.
> > 
> > arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
> > arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'
> > 
> > Maybe the binding needs to be updated and it seems that using
> > devm_clk_get_optional() like you propose is safe.
> 
> The binding is correct as-is. We want to require those clocks to be
> present, but the dove DT was added before the binding was finalized, so
> the driver still treats the clocks as optional to not break
> compatibility with old DTs. Maybe this warrants a comment in the
> code...

The binding doc in mainline says:

  clocks:
    items:
      - description: AXI/master interface clock
      - description: GPU core clock
      - description: Shader clock (only required if GPU has feature PIPE_3D)
      - description: AHB/slave interface clock (only required if GPU can gate slave interface independently)
    minItems: 1
    maxItems: 4

  clock-names:
    items:
      enum: [ bus, core, shader, reg ]
    minItems: 1
    maxItems: 4

which looks correct to me - and means that Dove is compliant with that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
