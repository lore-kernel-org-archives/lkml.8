Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FDCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D626F20673
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 10:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgEMKlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 06:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:59744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgEMKli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 06:41:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A1977AC6D;
        Wed, 13 May 2020 10:41:39 +0000 (UTC)
Date:   Wed, 13 May 2020 12:41:27 +0200
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     robh+dt@kernel.org, robin.murphy@arm.com,
        devicetree@vger.kernel.org, talho@nvidia.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, afaerber@suse.de,
        arnd@arndb.de, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/4] dt-bindings: sram: add documentation for
 reserved-only flag
Message-ID: <20200513104127.GA2309@suse.de>
References: <20200512144803.24344-1-ykaukab@suse.de>
 <20200512144803.24344-2-ykaukab@suse.de>
 <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52f099e4-5c03-2141-f049-cd3adeb04c5b@wwwdotorg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 01:45:28PM -0600, Stephen Warren wrote:
> On 5/12/20 8:48 AM, Mian Yousaf Kaukab wrote:
> > Add documentation for the new optional flag added for SRAM driver.
> 
> > diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
> 
> > +  reserved-only:
> > +    description:
> > +      The flag indicating, that only SRAM reserved regions have to be remapped.
> > +      remapping type is selected depending upon no-memory-wc as usual.
> > +    type: boolean
> 
> This feels a bit like a SW flag rather than a HW description, so I'm not
> sure it's appropriate to put it into DT.

Reserved regions themselves are software descriptions, no? Then we have 'pool'
flag which is again a software flag and so on. This flag falls into same
category and nothing out of ordinary.
> 
> Are there any cases where the SW should map all of the SRAM, i.e. where
> we wouldn't expect to set reserved-only? [...]

Yes, here are a few examples:
arch/arm/boot/dts/aspeed-g*.dtsi
arch/arm/boot/dts/at91*.dtsi
arch/arm/boot/dts/bcm7445.dtsi
Then arch/arm/boot/dts/dra7.dtsi is an example where we should map everything
except the reserved region.

> [...] I'd expect reserved-only to be
> the default, and perhaps only, mode of operation for the SRAM driver.

It will break compatibility with existing dtbs.

> If we can't do that because some SW currently expects to be able to map
> arbitrary portions of the SRAM, shouldn't that SW be fixed to tell the
> SRAM driver which parts it's using, hence still allowing the driver to
> only map in-use portions?

User doesn’t need sram driver in that case. It can use genalloc api directly.

BR,
Yousaf
