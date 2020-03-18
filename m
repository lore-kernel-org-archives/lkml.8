Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BF6C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD452076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgCRJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:20:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:20:56 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEUsa-0006vf-Bx; Wed, 18 Mar 2020 10:20:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jEUsZ-0006yY-8Y; Wed, 18 Mar 2020 10:20:47 +0100
Date:   Wed, 18 Mar 2020 10:20:47 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        Paul Barker <pbarker@konsulko.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Message-ID: <20200318092047.25gjkx43jwfyywsl@pengutronix.de>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
 <20200317225656.GK2527@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317225656.GK2527@pendragon.ideasonboard.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Laurent,

On Wed, Mar 18, 2020 at 12:56:56AM +0200, Laurent Pinchart wrote:
> On Tue, Mar 17, 2020 at 02:32:27PM +0200, Oleksandr Suvorov wrote:
> > PWM can have a normal polarity and a reverted one. The reverted polarity
> > value is defined.
> 
> I would squash this patch with 2/7, apart from that it looks fine.
> However, I also agree with Thierry that the PWM cell that contains this
> value is a bitmask, so once we get more flags it may get a bit awkward.

For me the usefulness of PWM_POLARITY_NORMAL increases with more bits
used. That's because if there are 5 things that can be set there and the
patch author mentions only the two that are non-zero, I as a reviewer
don't know if the author actually know and thought about the other
three. If however they spell out PWM_POLARITY_NORMAL it's quite sure
they want normal polarity.

> Will we have one macro for each flag that will evaluate to 0 to report
> that the flag isn't set ?

Yes. Given the above mentioned advantage this is cheap enough in my
eyes.

> Or should we define a single PWM_FLAG_NONE (or
> similarly named) macro ?

I like one macro for each bit field better for the above mentioned
reason.

> In retrospect, maybe PWM_POLARITY_INVERTED
> should have been named PWM_FLAG_POLARITY_INVERTED.

Seems to be subjective. I don't see much added semantic that justifies
the longer name.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
