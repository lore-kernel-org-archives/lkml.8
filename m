Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173D121D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAWPuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:50:44 -0500
Received: from muru.com ([72.249.23.125]:52014 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgAWPuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:50:44 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2761A810A;
        Thu, 23 Jan 2020 15:51:26 +0000 (UTC)
Date:   Thu, 23 Jan 2020 07:50:40 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix undefined reference to omap_secure_init
Message-ID: <20200123155040.GW5885@atomide.com>
References: <20200122172017.4791-1-afd@ti.com>
 <f183f31e-32ae-3e9e-96b4-a6f40984cd6e@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f183f31e-32ae-3e9e-96b4-a6f40984cd6e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dan Murphy <dmurphy@ti.com> [200122 18:10]:
> Andrew
> 
> On 1/22/20 11:20 AM, Andrew F. Davis wrote:
> > omap_secure_init() is now called from all OMAP2+ platforms during their
> > init_early() call. This function is in omap-secure.o so include that
> > in the build for these platforms.
> > 
> > Fixes: db711893eac8 ("ARM: OMAP2+: Add omap_secure_init callback hook for secure initialization")
> > Reported-by: Dan Murphy <dmurphy@ti.com>
> > Signed-off-by: Andrew F. Davis <afd@ti.com>
> > ---
> >   arch/arm/mach-omap2/Makefile | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index f07cfda85156..e1135b9d67c6 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -16,11 +16,11 @@ hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
> >   clock-common				= clock.o
> >   secure-common				= omap-smc.o omap-secure.o
> > -obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
> > +obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
> >   obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
> >   obj-$(CONFIG_ARCH_OMAP4) += $(hwmod-common) $(secure-common)
> > -obj-$(CONFIG_SOC_AM33XX) += $(hwmod-common)
> > -obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
> > +obj-$(CONFIG_SOC_AM33XX) += $(hwmod-common) $(secure-common)
> > +obj-$(CONFIG_SOC_OMAP5)  += $(hwmod-common) $(secure-common)
> >   obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
> >   obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
> 
> 
> Tested-by: Dan Murphy <dmurphy@ti.com>

Thanks applying into omap-for-v5.6/soc.

Regards,

Tony
