Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3930CC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAC6217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635931AbgDPMlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635883AbgDPMkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:40:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FE5C061A0C;
        Thu, 16 Apr 2020 05:40:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 750ED2A20B2;
        Thu, 16 Apr 2020 13:40:40 +0100 (BST)
Date:   Thu, 16 Apr 2020 14:40:36 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        cheol.yong.kim@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        masonccyang@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>,
        piotrs@cadence.com, qi-ming.wu@intel.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on
 Intel LGM SoC
Message-ID: <20200416144036.3ce8432f@collabora.com>
In-Reply-To: <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
        <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
        <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
        <20200416113822.2ef326cb@collabora.com>
        <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
        <20200416122619.2c481792@collabora.com>
        <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
        <20200416131725.51259573@collabora.com>
        <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com>
        <20200416135711.039ba85c@collabora.com>
        <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 15:26:51 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Apr 16, 2020 at 3:03 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Thu, 16 Apr 2020 19:38:03 +0800
> > "Ramuthevar, Vadivel MuruganX"
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:  
> > > On 16/4/2020 7:17 pm, Boris Brezillon wrote:  
> > > > On Thu, 16 Apr 2020 18:40:53 +0800
> > > > "Ramuthevar, Vadivel MuruganX"
> > > > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:  
> 
> ...
> 
> > > There are different features involved and lines of code is more, if we
> > > add new driver patches over xway-nand driver  
> >
> > How about retro-fitting the xway logic into your driver then? I mean,
> > adding a 100 lines of code to your driver to get rid of the 500+ lines
> > we have in xway_nand.c is still a win.
> >  
> > >
> > > is completely looks ugly and it may disturb the existing functionality
> > > as well since we don't have platform to validate:'(.  
> >
> > How ugly? Can you show us? Maybe we can come with a solution to make it
> > less ugly.
> >
> > As for the testing part, there are 4 scenarios:
> >
> > 1/ Your changes work perfectly fine on older platforms. Yay \o/!
> > 2/ You break the xway driver and existing users notice it before this
> >    series gets merged. Now you found someone to validate your changes.
> > 3/ You break the xway driver and none of the existing users notice it
> >    before the driver is merged, but they notice it afterwards. Too bad
> >    this happened after we've merged the driver, but now you've found
> >    someone to help you fix the problem :P.
> > 4/ You break things for old platforms but no one ever complains about
> >    it, either because there's no users left or because they never
> >    update their kernels. In any case, that's no longer your problem.
> >    Someone will remove those old platforms one day and get rid of the
> >    unneeded code in the NAND driver.
> >
> > What's more likely to happen is #3 or #4, and I think the NAND
> > maintainer would be fine with both.
> >
> > Note that the NAND subsystem is full of unmaintained legacy drivers, so
> > every time we see someone who could help us get rid or update one of
> > them we have to take this opportunity.  
> 
> Don't we rather insist to have a MAINTAINERS record for new code to
> avoid (or delay at least) the fate of the legacy drivers?
> 

Well, that's what we do for new drivers, but the xway driver has been
added in 2012 and the policy was not enforced at that time. BTW, that
goes for most of the legacy drivers in have in the NAND subsystems
(some of them even predate the git era).

To be clear, I just checked and there's no official maintainer for this
driver. Best option would be to Cc the original author and contributors
who proposed functional changes to the code, as well as the MIPS
maintainers (Xway is a MIPS platform).
