Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CB8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627E920888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbgE1P1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:27:45 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:43132 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404080AbgE1P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:27:43 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 527E980307C0;
        Thu, 28 May 2020 15:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OIK7Ou4SGDs1; Thu, 28 May 2020 18:27:40 +0300 (MSK)
Date:   Thu, 28 May 2020 18:27:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] dmaengine: dw: Add dummy device_caps callback
Message-ID: <20200528152740.ggld7wkmaqiq4g6o@mobilestation>
References: <20200526225022.20405-1-Sergey.Semin@baikalelectronics.ru>
 <20200526225022.20405-9-Sergey.Semin@baikalelectronics.ru>
 <20200528145303.GU1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200528145303.GU1634618@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:53:03PM +0300, Andy Shevchenko wrote:
> On Wed, May 27, 2020 at 01:50:19AM +0300, Serge Semin wrote:
> > Since some DW DMA controllers (like one installed on Baikal-T1 SoC) may
> > have non-uniform DMA capabilities per device channels, let's add
> > the DW DMA specific device_caps callback to expose that specifics up to
> > the DMA consumer. It's a dummy function for now. We'll fill it in with
> > capabilities overrides in the next commits.
> 
> I think per se it is not worth to have it separated. Squash into the next one.

bikeshadding? There is no any difference whether I add a dummy callback, then
fill it in in a following up patch, or have the callback added together
with some content. Let's see what Vinod thinks of it. Until then I'll stick with
the current solution.

-Sergey
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
