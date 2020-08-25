Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D89CC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4869E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgHYUI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:08:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51645 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgHYUIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:08:55 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 04B8F20007;
        Tue, 25 Aug 2020 20:08:51 +0000 (UTC)
Date:   Tue, 25 Aug 2020 22:08:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jon Nettleton <jon@solid-run.com>,
        Rob Herring <robh@kernel.org>, a.zummo@towertech.it,
        Baruch Siach <baruch@tkos.co.il>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200825200851.GI2389103@piout.net>
References: <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
 <20200727144938.GC239143@piout.net>
 <20200727152439.GK1551@shell.armlinux.org.uk>
 <20200727154104.GE239143@piout.net>
 <20200727154335.GL1551@shell.armlinux.org.uk>
 <CABdtJHuVaTa5T0-KdQ-wZQrmFQ6HO3FvgnTgSo3aOi+=SPzDZA@mail.gmail.com>
 <20200727161632.GF239143@piout.net>
 <20200727173051.GM1551@shell.armlinux.org.uk>
 <CAC4G8N5zUVc0YvT9mCP4BfeQD+KOAo6Rbswo8zqUh_mULa=Xsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC4G8N5zUVc0YvT9mCP4BfeQD+KOAo6Rbswo8zqUh_mULa=Xsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2020 22:13:42+0100, Miguel Borges de Freitas wrote:
> Russell King - ARM Linux admin <linux@armlinux.org.uk> escreveu no dia
> segunda, 27/07/2020 à(s) 18:30:
> >
> > On Mon, Jul 27, 2020 at 06:16:32PM +0200, Alexandre Belloni wrote:
> > > On 27/07/2020 17:55:50+0200, Jon Nettleton wrote:
> > > > > So, can we please have that discussion, it is pertinent to this patch.
> > > > >
> > > >
> > > > Thinking about this some more, I believe whether or not an IOCTL
> > > > interface is in the works or needed is irrelevant.  This patch
> > > > describes the hardware and how it is designed and the topic of
> > > > discussion is if we need a simple boolean state, or if we need
> > > > something that could be used to support dynamic configuration in the
> > > > future.  I would rather make this decision now rather than keep
> > > > tacking on boolean config options, or revisit a bunch of device-tree
> > > > changes.
> 
> For what it's worth I also tend to agree.
> The patchset, regardless of the property name (that I admit might be
> misleading), is intended at enforcing a mode that the RTC/driver
> should use by default. This mode is strongly related to the hardware
> definition/implementation and its capabilities. While I understand the
> need for the IOCTL interface to solve issues exactly like the
> aforementioned factory example, I fail to see how it can be of any
> help to solve the problem at hand - as it won't likely configure the
> driver to use a different default mode depending on the board. The
> IOCTL interface might also allow the userspace to change this property
> back to the default mode (000) and end up breaking the RTC operation,
> but I guess that's the cost of configurability and, in the end, the
> user's responsibility.
> Any pointers on how to proceed are appreciated.
> 

I would think the simpler way to proceed is to have a device specific
property indicating that standard mode is not available. From the
driver, you can then switch from standard to DSM when this property is
present.

I think it is difficult to come up with a generic property for that as
most other RTCs with level/threshold switching have a fast edge
detection feature that is usually enabled by default. So what they would
require instead is a property indicating that the voltage is ramping
down at a certain rate allowing to disable fast edge detection and
saving a bit of power.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
