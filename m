Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5FFC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE36206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgDGXia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:38:30 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42645 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgDGXia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:38:30 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id E8F3020004;
        Tue,  7 Apr 2020 23:38:21 +0000 (UTC)
Message-ID: <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
From:   Paul Spooren <mail@aparcar.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, daniel@makrotopia.org,
        freifunk@adrianschmutzler.de, kaloz@openwrt.org
Date:   Tue, 07 Apr 2020 13:38:17 -1000
In-Reply-To: <20200407224615.GA359603@lunn.ch>
References: <20200407210816.866084-1-mail@aparcar.org>
         <20200407224615.GA359603@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thank you very much for the quick response!

On Wed, 2020-04-08 at 00:46 +0200, Andrew Lunn wrote:
> On Tue, Apr 07, 2020 at 11:08:10AM -1000, Paul Spooren wrote:
> > Linksys chose to use codenames for a few of their devices and sell
> > their
> > them under an entirely different name.
> > 
> > codename  model name
> > rango  -> wrt3200acm
> > mamba  -> wrt1900ac
> > cobra  -> wrt1900ac-v2
> > caiman -> wrt1200ac
> > shelby -> wrt1900acs
> 
> Hi Paul
> 
> There was quite a bit of discussion about this when the first board
> was added. If i remember correctly, it was Mamba.
> 
> Imre Kaloz, <kaloz@openwrt.org> was the one arguing for
> the name armada-xp-linksys-mamba.dts.
> 
> So it seems that openwrt.org has now come full circle?

I talked with three currently active OpenWrt core developers and all
were in favor of a unification. I wasn't aware of any previous
discussions nor any pro arguments to keep code names.

I've added Imre via CC so maybe he can share his opinion, too.
> 
> > This introduces some extra loops in OpenWrt, a distribution
> > specialized
> > on embedded Internet facing devices, as both codename and model
> > name are
> > used within the build system. The double naming requires developers
> > to
> > keep track of that mapping and introduces inconsistencies:
> > 
> > To build a specific device in OpenWrt profiles are used, named
> > after the
> > the compatible string for targets using device tree (similar to how
> > .dts
> > files are named in the linux source tree). However, the first item
> > of
> > the DT `compatible` list in this case is `linksys,rango`, which is
> > inconsistent with the model name and not what common users would
> > expect.
> > 
> > Such double naming complicates currently the automatic search for
> > firmware upgrade as the build system does not support such mapping.
> > Ideally the first item of the DT `compatible` list would contain a
> > string suitable to be used as a filename recognizable by normal
> > users to
> > belong to that device.
> > With this patch set the Linksys device tree files are moved from
> > containing the codename to contain a sanitized model name and also
> > use
> > it as first entry of the DT `compatible` list.
> 
> I've no problems adding another compatible to the list. But i don't
> like the idea of renaming the files. The file names could be
> considered ABI! What installers/bootloaders are you going to break by
> renaming them?

Are you okay with adding the new compatible string as first element of
the list? This would already simplify the OpenWrt build system.

What about the changed labels? Are they considered ABI too?

Regarding file names, I'm new to ABI policies. Within OpenWrt this is
all done via a single line patch, I'm not familiar with any other
installers/bootloaders. 

If renaming is a reason not to merge this I'd send a v2 containing only
the the added compatible list and updated labels.

Best,
Paul

