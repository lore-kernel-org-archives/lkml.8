Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33719206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgHSKwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:52:05 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53677 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgHSKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:51:34 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 53C061C0006;
        Wed, 19 Aug 2020 10:51:17 +0000 (UTC)
Date:   Wed, 19 Aug 2020 12:51:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Stefan Roese <sr@denx.de>,
        Michael Zimmermann <michael.zimmermann@grandcentrix.net>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: Add GARDENA smart Gateway AT91SAM board
Message-ID: <20200819105116.GI4500@piout.net>
References: <20200810171921.8679-1-code@reto-schneider.ch>
 <20200817102136.GC4500@piout.net>
 <02431938-63ac-7f90-d985-534bcd60aac2@reto-schneider.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02431938-63ac-7f90-d985-534bcd60aac2@reto-schneider.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2020 11:04:48+0200, Reto Schneider wrote:
> Hi Alexandre,
> 
> On 8/17/20 12:21 PM, Alexandre Belloni wrote:
> > Thank you for this submission.
> 
> Thanks a lot for the feedback.
> 
> I will send a v2.
> 
> > Overall, I'm not convinced it is a good idea to start from
> > at91sam9x5ek.dtsi as it makes you dtb bigger than necessary but if you
> > want it that way, I'm fine with that.
> 
> Because using at91sam9x5ek.dtsi saves some code (maintenance effort?!) I
> am willing to accept the extra binary size.
> However, if you think that this causes the maintenance efforts to be
> greater than when doing it your way, I'd be up for changing it.
> 

I'd say at91sam9x5ek.dtsi has very little chances to change and even if
this is the case, it will probably not break your device tree but it is
still a possibility.

As said, I'll let you choose.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
