Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CF2C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D8520724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgDWW37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:29:59 -0400
Received: from v6.sk ([167.172.42.174]:57294 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDWW37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:29:59 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 70777610A5;
        Thu, 23 Apr 2020 22:29:57 +0000 (UTC)
Date:   Fri, 24 Apr 2020 00:29:52 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/15] ARM: dts: Marvell SoC Device Tree updates (for 5.8)
Message-ID: <20200423222952.GA26943@furthur.local>
References: <20200419171157.672999-1-lkundrak@v3.sk>
 <CAK8P3a17JFOD_SqF+ub+VEM_ABLzLYWFE6zj0eBXVjP3nn0g2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a17JFOD_SqF+ub+VEM_ABLzLYWFE6zj0eBXVjP3nn0g2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 05:35:48PM +0200, Arnd Bergmann wrote:
> On Sun, Apr 19, 2020 at 7:12 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> >
> > Hi,
> >
> > please consider applying the patches chained to this message to arm/dt.
> >
> > I've sent about the same patch set before, but there were some issues
> > and it was way too close to 5.7-rc1. Sorry for that. I decided not to
> > hurry it, because none of the fixes is really all that important.
> >
> > Majority of the patches just deal with reducing DT validation noise once
> > more schemas are converted to JSON-schema. Those that actually fix
> > things relevant to older released kernels have been Cc'd to stable@.
> 
> Can you check again which ones should perhaps be part of v5.7?
> I assume that at least anything that has a stable tag should also be
> included in the release, but I'd prefer to have you confirm that.

Yes, the three patches that have the stable@ patch should prefereably go
to 5.7 as well:

  [PATCH 13/15] ARM: dts: mmp3: Drop usb-nop-xceiv from HSIC phy Lubomir Rintel
  [PATCH 14/15] ARM: dts: mmp3: Use the MMP3 compatible string for /clocks Lubomir Rintel
  [PATCH 15/15] ARM: dts: mmp3-dell-ariel: Fix the SPI devices Lubomir Rintel

> 
>      Arnd

Thank you
Lubo

