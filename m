Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D7BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C322065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgENISL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgENISL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:18:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB68C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:18:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jZ947-0001v2-MZ; Thu, 14 May 2020 10:18:03 +0200
Message-ID: <1e15be39906034a95b86c026e060ed9866586d94.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Thu, 14 May 2020 10:18:02 +0200
In-Reply-To: <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
References: <20200513150007.1315395-1-lkundrak@v3.sk>
         <20200513150007.1315395-3-lkundrak@v3.sk>
         <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
         <CAOMZO5BdiXCVXs+8jP7PoRvgKd1sxCu4KhjvJBvL=Qig2WOs4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 (3.36.1-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 13.05.2020, 23:41 -0300 schrieb Fabio Estevam:
> On Wed, May 13, 2020 at 2:09 PM Fabio Estevam <festevam@gmail.com> wrote:
> 
> > The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
> > says that only the 'reg' clock could be optional, the others are
> > required.
> 
> arch/arm/boot/dts/dove.dtsi only uses the 'core' clock.
> arch/arm/boot/dts/stm32mp157.dtsi uses 'bus' and 'core'
> 
> Maybe the binding needs to be updated and it seems that using
> devm_clk_get_optional() like you propose is safe.

The binding is correct as-is. We want to require those clocks to be
present, but the dove DT was added before the binding was finalized, so
the driver still treats the clocks as optional to not break
compatibility with old DTs. Maybe this warrants a comment in the
code...

Regards,
Lucas

