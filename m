Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF6DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DADA2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 17:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgE2R6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 13:58:33 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39279 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2R6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 13:58:33 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6BDB030004817;
        Fri, 29 May 2020 19:58:31 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4431510D0CE; Fri, 29 May 2020 19:58:31 +0200 (CEST)
Date:   Fri, 29 May 2020 19:58:31 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] spi: bcm2835: Implement shutdown callback
Message-ID: <20200529175831.p4dphb5luymgapzx@wunner.de>
References: <20200528190605.24850-1-f.fainelli@gmail.com>
 <20200529174719.5tvchnoov747fm2x@wunner.de>
 <c081060b-7442-bf20-40c9-cb403787610a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c081060b-7442-bf20-40c9-cb403787610a@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:48:11AM -0700, Florian Fainelli wrote:
> On 5/29/20 10:47 AM, Lukas Wunner wrote:
> > On Thu, May 28, 2020 at 12:06:05PM -0700, Florian Fainelli wrote:
> >> Make sure we clear the FIFOs, stop the block, disable the clock and
> >> release the DMA channel.
> > 
> > To what end?  Why is this change necessary?  Sorry but this seems like
> > an awfully terse commit message.
> 
> To ensure clocks are disabled and to save power in low power modes used
> on 7211 for instance.

Thanks for the explanation, that's an important tidbit.  I wasn't even
aware that this SPI controller is used on SoCs beyond the Raspberry Pi
ones.  Does the BCM7211 use shared interrupts for this controller?
Does it have DMA DREQ attached?
