Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB126C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F516206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHLN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:56:46 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:44600 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgHLN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:56:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id DEF02FB04;
        Wed, 12 Aug 2020 15:56:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d1YLBnojmT0o; Wed, 12 Aug 2020 15:56:38 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8DD1A45770; Wed, 12 Aug 2020 15:56:37 +0200 (CEST)
Date:   Wed, 12 Aug 2020 15:56:37 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Swapnil Jakhade <sjakhade@cadence.com>, airlied@linux.ie,
        daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        robh+dt@kernel.org, a.hajda@samsung.com, narmstrong@baylibre.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, praneeth@ti.com, nsekhar@ti.com,
        jsarha@ti.com, sandor.yu@nxp.com
Subject: Re: [PATCH v8 0/3] drm: Add support for Cadence MHDP DPI/DP bridge
 and J721E wrapper.
Message-ID: <20200812135637.GA107602@bogon.m.sigxcpu.org>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <20200812083937.GA8816@bogon.m.sigxcpu.org>
 <3bcbbb0b-ee04-0f1e-6c54-97b01c552d82@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bcbbb0b-ee04-0f1e-6c54-97b01c552d82@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Aug 12, 2020 at 01:47:42PM +0300, Tomi Valkeinen wrote:
> Hi Guido,
> 
> On 12/08/2020 11:39, Guido Günther wrote:
> > Hi,
> > On Thu, Aug 06, 2020 at 01:34:29PM +0200, Swapnil Jakhade wrote:
> >> This patch series adds new DRM bridge driver for Cadence MHDP DPI/DP
> >> bridge. The Cadence Display Port IP is also referred as MHDP (Mobile High
> >> Definition Link, High-Definition Multimedia Interface, Display Port).
> >> Cadence Display Port complies with VESA DisplayPort (DP) and embedded
> >> Display Port (eDP) standards.
> > 
> > Is there any relation to the cadence mhdp ip core used inthe imx8mq:
> > 
> >     https://lore.kernel.org/dri-devel/cover.1590982881.git.Sandor.yu@nxp.com/
> > 
> > It looks very similar in several places so should that use the same driver?
> > Cheers,
> >  -- Guido
> 
> Interesting.
> 
> So the original Cadence DP patches for TI SoCs did create a common driver with Rockchip's older mhdp
> driver. And looks like the IMX series points to an early version of that patch ("drm/rockchip:
> prepare common code for cdns and rk dpi/dp driver").
> 
> We gave up on that as the IPs did have differences and the firmwares used were apparently quite
> different. The end result was very difficult to maintain, especially as (afaik) none of the people
> involved had relevant Rockchip HW.

Is the `struct mhdp_platform_ops` a leftover from that? Can that be dropped?

> The idea was to get a stable DP driver for TI SoCs ready and upstream, and then carefully try to
> create common parts with Rockchip's driver in small pieces.

I wonder how imx8 would best blend into this? First thing will likely be
to upstream the phy code in driveres/phy/ so a modified version of this bridge
driver could call into that, then go and look for common patterns.

> If the Rockchip and IMX mhdp have the same IP and same firmware, then they obviously should share
> code as done in the series you point to.

I'm pretty sure they use different firmware though - the imx8mq
additionally supports HDMI with a different firmware on the same IP core
(13.4 and 13.5 in the imx8mq ref manual).

> Perhaps Cadence can clarify the differences between IMX, TI and
> Rockchip IPs and FWs?

That would be great!
 -- Guido


> I'm worried that if there are IP differences, even if not great ones, and if the FWs are different
> and developed separately, it'll be a constant "fix X for SoC A, and accidentally break Y for SoC B
> and C", especially if too much code is shared.
> 
> In the long run I'm all for a single driver (or large shared parts), but I'm not sure if we should
> start with that approach.




> 
>  Tomi
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
