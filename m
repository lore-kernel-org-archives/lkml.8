Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A61C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0313620578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgHYHc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:32:27 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45522 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgHYHcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:32:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C94C3FB03;
        Tue, 25 Aug 2020 09:32:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jxse1rfQBwXr; Tue, 25 Aug 2020 09:32:19 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2B0CD4593E; Tue, 25 Aug 2020 09:32:19 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:32:19 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "jsarha@ti.com" <jsarha@ti.com>,
        "sandor.yu@nxp.com" <sandor.yu@nxp.com>
Subject: Re: [PATCH v8 0/3] drm: Add support for Cadence MHDP DPI/DP bridge
 and J721E wrapper.
Message-ID: <20200825073219.GA5528@bogon.m.sigxcpu.org>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <20200812083937.GA8816@bogon.m.sigxcpu.org>
 <3bcbbb0b-ee04-0f1e-6c54-97b01c552d82@ti.com>
 <20200812135637.GA107602@bogon.m.sigxcpu.org>
 <DM6PR07MB61542D7CC2B319142CC5E0CAC5560@DM6PR07MB6154.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR07MB61542D7CC2B319142CC5E0CAC5560@DM6PR07MB6154.namprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,
On Mon, Aug 24, 2020 at 07:16:31AM +0000, Swapnil Kashinath Jakhade wrote:
[..snip..]
> Following are the differences between MHDP IPs from Cadence for Rockchip, TI and NxP:
> 
> The Rockchip and NXP MHDP Core shares the same part (IP8501) which is DP v1.3 SST
> Controller with HDCP 2.2/1.x. NXP's version additionally supports HDMI.
> TI uses a different part (IP8546A), which is DP v1.4 with HDCP 2.2/1.x.
> TI DP Controller adds support for additional features such as Multi Stream Support (MST),
> Forward Error Correction (FEC) and Compression (DSC).
> 
> Also, FW used for TI has significant differences than FW used for Rockchip or NXP.
> NxP and TI firmware are developed and maintained separately by Cadence and are in
> active support.
> 
> From the Linux driver perspective, given the differences, it would make sense to have
> TI driver maintained separately.

Thanks for the clarification, that indeed helps a lot. So the rockchip
and nxp drivers can be merged while the ti one should stay separate.
Cheers,
 -- Guido

> 
> Thanks,
> Swapnil
> 
> > 
> > > I'm worried that if there are IP differences, even if not great ones,
> > > and if the FWs are different and developed separately, it'll be a
> > > constant "fix X for SoC A, and accidentally break Y for SoC B and C",
> > especially if too much code is shared.
> > >
> > > In the long run I'm all for a single driver (or large shared parts),
> > > but I'm not sure if we should start with that approach.
> > 
> > 
> > 
> > 
> > >
> > >  Tomi
> > >
> > > --
> > > Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> > > Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> > >
> 
