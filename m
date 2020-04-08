Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D054E21556
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbgDHQtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:49:10 -0400
Received: from fudo.makrotopia.org ([185.142.180.71]:52755 "EHLO
        fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgDHQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:49:10 -0400
X-Greylist: delayed 1482 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2020 12:49:08 EDT
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.92.3)
        (envelope-from <daniel@makrotopia.org>)
        id 1jMDUv-0002ru-7m; Wed, 08 Apr 2020 18:24:19 +0200
Date:   Wed, 8 Apr 2020 17:23:49 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Imre Kaloz <kaloz@dune.hu>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Paul Spooren <mail@aparcar.org>, Andrew Lunn <andrew@lunn.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "freifunk@adrianschmutzler.de" <freifunk@adrianschmutzler.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kaloz@openwrt.org" <kaloz@openwrt.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
Message-ID: <20200408162009.GC1995@makrotopia.org>
References: <20200407210816.866084-1-mail@aparcar.org>
 <20200407224615.GA359603@lunn.ch>
 <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
 <ecf4dc01-81f8-a33d-b4a7-2065748993ed@gmail.com>
 <VI1PR02MB5325621D39BF0FFAFE3993C4A0C00@VI1PR02MB5325.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR02MB5325621D39BF0FFAFE3993C4A0C00@VI1PR02MB5325.eurprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Imre,

On Wed, Apr 08, 2020 at 08:32:41AM +0000, Imre Kaloz wrote:
> Hi,
> 
> I'm on the same page here - this has not an issue for years. The common sense and policy was always to reject kernel changes that would only make the userland's job easier - and here were are not even talking about the userland, but a script that's being used for image generation.
> 
> The reason codenames are preffered to marketing names is simple: the same board can be sold under multiple marketing names.
> 
> The Linksys Viper has been sold as E4200v2 and EA4500. The Linksys Focus as EA6100 and EA5800. The LeMans is the EA6300 and the EA6200. The Macan is both EA7500 and EA7400 - on the other hand, the EA7500v2 and the EA7400v2 are the Savannah.

What Paul, Adian and others are trying to achieve here is consistency.
See also the debate on openwrt-devel:

http://lists.infradead.org/pipermail/openwrt-devel/2020-April/022567.html

The goal is to make it easier for users and semi-automated processes
to identify the right OpenWrt image for a specific device.
This especially becomes necessary for OTA updates and we have invested
quite a bit of work to no longer need to scrape and translate that
with additional layers of abstraction but simply use the first (ie.
most significant) compatible from DTS to indentify the right image.

As product-name aliases are indeed very common, we usually deal with it
in a way that the first product name which hits the OpenWrt tree is
used for model, compatible, DTS- and image filenames. We then add
aliases to that in our build-scripts which allows web-based wizards and
such to match the alternative names as well when entered by the user.


> 
> 
> Best,
> 
> Imre
> 
> ________________________________
> From: Florian Fainelli <f.fainelli@gmail.com>
> Sent: Wednesday, April 8, 2020 2:07:38 AM
> To: Paul Spooren <mail@aparcar.org>; Andrew Lunn <andrew@lunn.ch>
> Cc: devicetree@vger.kernel.org <devicetree@vger.kernel.org>; jason@lakedaemon.net <jason@lakedaemon.net>; gregory.clement@bootlin.com <gregory.clement@bootlin.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; daniel@makrotopia.org <daniel@makrotopia.org>; freifunk@adrianschmutzler.de <freifunk@adrianschmutzler.de>; robh+dt@kernel.org <robh+dt@kernel.org>; kaloz@openwrt.org <kaloz@openwrt.org>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>; sebastian.hesselbarth@gmail.com <sebastian.hesselbarth@gmail.com>
> Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
> 
> 
> 
> On 4/7/2020 4:38 PM, Paul Spooren wrote:
> > Hi Andrew,
> >
> > thank you very much for the quick response!
> >
> > On Wed, 2020-04-08 at 00:46 +0200, Andrew Lunn wrote:
> >> On Tue, Apr 07, 2020 at 11:08:10AM -1000, Paul Spooren wrote:
> >>> Linksys chose to use codenames for a few of their devices and sell
> >>> their
> >>> them under an entirely different name.
> >>>
> >>> codename  model name
> >>> rango  -> wrt3200acm
> >>> mamba  -> wrt1900ac
> >>> cobra  -> wrt1900ac-v2
> >>> caiman -> wrt1200ac
> >>> shelby -> wrt1900acs
> >>
> >> Hi Paul
> >>
> >> There was quite a bit of discussion about this when the first board
> >> was added. If i remember correctly, it was Mamba.
> >>
> >> Imre Kaloz, <kaloz@openwrt.org> was the one arguing for
> >> the name armada-xp-linksys-mamba.dts.
> >>
> >> So it seems that openwrt.org has now come full circle?
> >
> > I talked with three currently active OpenWrt core developers and all
> > were in favor of a unification. I wasn't aware of any previous
> > discussions nor any pro arguments to keep code names.
> >
> > I've added Imre via CC so maybe he can share his opinion, too.
> >>
> >>> This introduces some extra loops in OpenWrt, a distribution
> >>> specialized
> >>> on embedded Internet facing devices, as both codename and model
> >>> name are
> >>> used within the build system. The double naming requires developers
> >>> to
> >>> keep track of that mapping and introduces inconsistencies:
> >>>
> >>> To build a specific device in OpenWrt profiles are used, named
> >>> after the
> >>> the compatible string for targets using device tree (similar to how
> >>> .dts
> >>> files are named in the linux source tree). However, the first item
> >>> of
> >>> the DT `compatible` list in this case is `linksys,rango`, which is
> >>> inconsistent with the model name and not what common users would
> >>> expect.
> >>>
> >>> Such double naming complicates currently the automatic search for
> >>> firmware upgrade as the build system does not support such mapping.
> >>> Ideally the first item of the DT `compatible` list would contain a
> >>> string suitable to be used as a filename recognizable by normal
> >>> users to
> >>> belong to that device.
> >>> With this patch set the Linksys device tree files are moved from
> >>> containing the codename to contain a sanitized model name and also
> >>> use
> >>> it as first entry of the DT `compatible` list.
> >>
> >> I've no problems adding another compatible to the list. But i don't
> >> like the idea of renaming the files. The file names could be
> >> considered ABI! What installers/bootloaders are you going to break by
> >> renaming them?
> >
> > Are you okay with adding the new compatible string as first element of
> > the list? This would already simplify the OpenWrt build system.
> 
> Having a mapping table between model names in OpenWrt profiles and .dts
> file names in the kernel sources is not that complicated to maintain,
> changing the kernel for that reason sounds a bit weak IMHO.
> --
> Florian
