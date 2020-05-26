Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C30FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379AF20723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgEZP26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:28:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgEZP26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:28:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E94BB260;
        Tue, 26 May 2020 15:28:58 +0000 (UTC)
Date:   Tue, 26 May 2020 17:28:47 +0200
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Stephen Warren <swarren@wwwdotorg.org>, robin.murphy@arm.com,
        devicetree@vger.kernel.org, talho@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/4] dt-bindings: sram: add documentation for
 reserved-only flag
Message-ID: <20200526152847.GA16107@suse.de>
References: <20200512144803.24344-1-ykaukab@suse.de>
 <20200512144803.24344-2-ykaukab@suse.de>
 <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
 <20200513104127.GA2309@suse.de>
 <efcc6b5e-423c-8ae1-8a46-d6a06c1a1bab@wwwdotorg.org>
 <20200519230326.GA827289@bogus>
 <20200520085558.GB2136208@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200520085558.GB2136208@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:55:58AM +0200, Thierry Reding wrote:
> On Tue, May 19, 2020 at 05:03:26PM -0600, Rob Herring wrote:
> > On Tue, May 19, 2020 at 10:16:43AM -0600, Stephen Warren wrote:
> > > On 5/13/20 4:41 AM, Mian Yousaf Kaukab wrote:
> > > > On Tue, May 12, 2020 at 01:45:28PM -0600, Stephen Warren wrote:
> > > >> On 5/12/20 8:48 AM, Mian Yousaf Kaukab wrote:
> > > >>> Add documentation for the new optional flag added for SRAM driver.
> > > >>
> > > >>> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> > > >>
> > > >>> +  reserved-only:
> > > >>> +    description:
> > > >>> +      The flag indicating, that only SRAM reserved regions have to be remapped.
> > > >>> +      remapping type is selected depending upon no-memory-wc as usual.
> > > >>> +    type: boolean
> > > >>
> > > >> This feels a bit like a SW flag rather than a HW description, so I'm not
> > > >> sure it's appropriate to put it into DT.
> > > > 
> > > > Reserved regions themselves are software descriptions, no? Then we have 'pool'
> > > > flag which is again a software flag and so on. This flag falls into same
> > > > category and nothing out of ordinary.
> > > 
> > > I suppose that's true to some extent. This is indeed a description of
> > > the system environment presented to the SW that consumes the DT, which
> > > is a bit more than pure HW description but still a description of
> > > something imposed externally rather than describing something that's up
> > > to the discretion of the consuming SW. So, go ahead.
> > > 
> > > >> Are there any cases where the SW should map all of the SRAM, i.e. where
> > > >> we wouldn't expect to set reserved-only? [...]
> > > > 
> > > > Yes, here are a few examples:
> > > > arch/arm/boot/dts/aspeed-g*.dtsi
> > > > arch/arm/boot/dts/at91*.dtsi
> > > > arch/arm/boot/dts/bcm7445.dtsi
> > > > Then arch/arm/boot/dts/dra7.dtsi is an example where we should map everything
> > > > except the reserved region.
> > > > 
> > > >> [...] I'd expect reserved-only to be
> > > >> the default, and perhaps only, mode of operation for the SRAM driver.
> > > > 
> > > > It will break compatibility with existing dtbs.
> > > > 
> > > >> If we can't do that because some SW currently expects to be able to map
> > > >> arbitrary portions of the SRAM, shouldn't that SW be fixed to tell the
> > > >> SRAM driver which parts it's using, hence still allowing the driver to
> > > >> only map in-use portions?
> > > > 
> > > > User doesn’t need sram driver in that case. It can use genalloc api directly.
> > > 
> > > This sounds a bit odd. Without a driver for the reserved region, nothing
> > > should be touching it, since otherwise there's no code that owns an
> > > manages the region. If any code needs to consume the region, it should
> > > obtain info about the region from some form of provider code that can
> > > handle both the allocation and mapping. Anything else sounds like some
> > > consumer code directly making use of DT nodes it doesn't own. But since
> > > I'm not familiar enough with the SRAM driver and genalloc code that you
> > > mention to fully understand the allocation paths I guess I won't object
> > > for now, although it does still sound fishy.
> > 
> > I'm fine with the concept, but I don't think a single flag is adequate. 
> > If there are reserved regions within the SRAM, then define child nodes 
> > to mark those regions reserved. I don't think you need a new flag. Just 
> > a 'reg' property and nothing else.
> 
> It sounds to me like there are two different interpretations of SRAM and
> reserved regions. On one hand, as you suggest, we have one SRAM that's
> made available as genalloc pool and then individual regions can be
> marked as reserved so that they aren't added to that pool.
> 
> At the same time, each reserved region is also exposed as a separate
> pool and that's in fact used by many consumers as a way of getting a
> specific chunk of the SRAM for their own use (via phandle to the region
> from the consumer's device tree node).
> 
> In addition to that, the reserved region code doesn't actually fully do
> its job because while the reserved region isn't actually added to the
> "top-level" SRAM pool, the memory is still mapped. At the same time this
> is something that we actually want because, like I mentioned, some of
> the consumers do want to get at their SRAM chunks via references to the
> partitions.
> 
> The problem that this patch series is really trying to solve is another
> still: the complete SRAM is always mapped to kernel memory, irrespective
> of whether any regions are marked reserved or not and that can cause
> speculative accesses to memory outside of the defined regions.
> 
> Stephen's suggestion is to default to only mapping memory for which a
> partition has been defined in the SRAM and assuming that all SRAM
> outside of those partitions is off limits. I think that's a sensible
> default and it's unambiguous.
> 
> But as Yousaf points out that would break compatibility with existing
> device trees. Depending on how you interpret the bindings one could
> argue that those device trees are buggy and should have partitions
> defined (in the cases I've looked at they end up using a fixed region
> anyway, so that could've just been made explicit in the device tree).
> 
> However, it also looks like all of the users that rely on the original
> behaviour where they can just access the full pool are those that don't
> define any reserved regions, whereas all users that do reserve regions
> will actually use those reserved regions.
> 
> So I think we can make use of this by differentiating in the driver
> between SRAM nodes with or without children and change the behaviour
> accordingly. I think that has the big advantage that it makes things
> work as (I think) most people would expect and doesn't further
> complicate the binding with extra flags.

I tend to agree on mapping partitions only if they exist. So far I could
only find one exception. It is arch/arm/boot/dts/armada-370.dtsi which is
using the top level pool as well as a partition to reserve 32 bytes at the
bottom of sram. This can be fixed along with the sram driver change, by
adding another partition for the rest of the sram and using its handle in
the crypto@90000 instead of top-level sram node handle. Do you see anymore
exceptions where both top level pool and the partitions both are being used?

Then on the backward compatibility topic, another issue is that boot code
could add sram nodes dynamically. For example arch/arm/mach-k3/common.c in
u-boot does it. This particular case will not break after the suggested change
because it is not adding any partitions. However, there could be other
boot-loaders which are not this lucky.

> 
> Thierry

/Yousaf

