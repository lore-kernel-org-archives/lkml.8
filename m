Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460ACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185F8207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405580AbgFYOzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:55:08 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:38510 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405425AbgFYOzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:55:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C3418FB03;
        Thu, 25 Jun 2020 16:55:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1airAkfx232Y; Thu, 25 Jun 2020 16:55:03 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3490445273; Thu, 25 Jun 2020 16:55:03 +0200 (CEST)
Date:   Thu, 25 Jun 2020 16:55:03 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/etnaviv: Ignore MC bit when checking for runtime
 suspend
Message-ID: <20200625145503.GA48167@bogon.m.sigxcpu.org>
References: <cover.1583176306.git.agx@sigxcpu.org>
 <4c61fde86c5e0dced249221dbc0a8d4207d5bffa.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c61fde86c5e0dced249221dbc0a8d4207d5bffa.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Mar 03, 2020 at 12:55:04PM +0100, Lucas Stach wrote:
> On Mo, 2020-03-02 at 20:13 +0100, Guido Günther wrote:
> > At least GC7000 fails to enter runtime suspend for long periods of time since
> > the MC becomes busy again even when the FE is idle. The rest of the series
> > makes detecting similar issues easier to debug in the future by checking
> > all known bits in debugfs and also warning in the EBUSY case.
> 
> Thanks, series applied to etnaviv/next.
> 
> > Tested on GC7000 with a reduced runtime delay of 50ms. Patches are
> > against next-20200226.
> 
> I've already wondered if 200ms is too long, 50ms sounds more
> reasonable. Do you have any numbers on the power draw on the i.MX8M
> with idle GPU, vs. being fully power gated?

The difference is at least 250mW. It makes a huge difference over here.
We hit
https://lore.kernel.org/dri-devel/20200614064601.7872-1-navid.emamdoost@gmail.com/
recently and you notice instantly when that happens when looking at the
SoC temperature.

Cheers,
 -- Guido
> 
> Regards,
> Lucas
> 
> > Thanks to Lucas Stach for pointing me in the right direction.
> > 
> > Guido Günther (5):
> >   drm/etnaviv: Fix typo in comment
> >   drm/etnaviv: Update idle bits
> >   drm/etnaviv: Consider all kwnown idle bits in debugfs
> >   drm/etnaviv: Ignore MC when checking runtime suspend idleness
> >   drm/etnaviv: Warn when GPU doesn't idle fast enough
> > 
> >  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 26 ++++++++++++++++++++++----
> >  drivers/gpu/drm/etnaviv/state_hi.xml.h |  7 +++++++
> >  2 files changed, 29 insertions(+), 4 deletions(-)
> > 
> 
