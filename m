Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39AC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2336D20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgCaI0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:26:24 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:23401 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCaI0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:26:24 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 3F26340E6;
        Tue, 31 Mar 2020 10:26:21 +0200 (CEST)
Received: from localhost (meh.true.cz [local])
        by meh.true.cz (OpenSMTPD) with ESMTPA id e7874178;
        Tue, 31 Mar 2020 10:26:07 +0200 (CEST)
Date:   Tue, 31 Mar 2020 10:26:06 +0200
From:   Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: olinuxino: add user red LED
Message-ID: <20200331082606.GD21251@meh.true.cz>
Reply-To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
References: <20200325205924.30736-1-ynezz@true.cz>
 <20200330175347.r4uam7cybvuxlgog@gilmour.lan>
 <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66+oT=qfu7oHTs3d_e2hd_8Fc_0ULhHRfMLmrdcfOoe=A@mail.gmail.com>
X-PGP-Key: https://gist.githubusercontent.com/ynezz/477f6d7a1623a591b0806699f9fc8a27/raw/a0878b8ed17e56f36ebf9e06a6b888a2cd66281b/pgp-key.pub
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen-Yu Tsai <wens@csie.org> [2020-03-31 09:19:57]:

Hi,

> On Tue, Mar 31, 2020 at 1:53 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Wed, Mar 25, 2020 at 09:59:24PM +0100, Petr Štetiar wrote:
> > > There is a red LED marked as `GPIO_LED1` on the silkscreen and connected
> > > to PE17 by default. So lets add this missing bit in the current hardware
> > > description.
> > >
> > > Signed-off-by: Petr Štetiar <ynezz@true.cz>
> >
> > QUeued for 5.8, thanks!
> 
> The gpio-led binding seems to prefer "led-0" up to "led-f" (^led-[0-9a-f])
> as the child node name. This was recently brought to my attention. Do we
> want to follow suit here?

I can see following in Documentation/devicetree/bindings/leds/leds-gpio.yaml:

 patternProperties:
   # The first form is preferred, but fall back to just 'led' anywhere in the
   # node name to at least catch some child nodes.
   "(^led-[0-9a-f]$|led)":

So it seems like `led-0` is indeed preferred, should I send v2 or a new patch
as a fix on top of the previous one?

-- ynezz
