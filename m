Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0943FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40A0206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgEOKYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgEOKYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:24:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:24:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jZXWK-00063C-Ql; Fri, 15 May 2020 12:24:48 +0200
Message-ID: <a51cb70623c4c2441bb8df8385f56c99392b8435.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: fix perfmon domain interation
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Date:   Fri, 15 May 2020 12:24:47 +0200
In-Reply-To: <X0BDAQ.L99CTJZCDEJE3@crapouillou.net>
References: <20200511123846.96594-1-christian.gmeiner@gmail.com>
         <CAH9NwWcJNhUVkzd0KAfJyxNZJ9a71KLzipW+qRwhgEWUmnnxmg@mail.gmail.com>
         <X0BDAQ.L99CTJZCDEJE3@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 15.05.2020, 12:12 +0200 schrieb Paul Cercueil:
> Hi Christian,
> 
> Le ven. 15 mai 2020 à 12:09, Christian Gmeiner 
> <christian.gmeiner@gmail.com> a écrit :
> > Am Mo., 11. Mai 2020 um 14:38 Uhr schrieb Christian Gmeiner
> > <christian.gmeiner@gmail.com>:
> > >  The GC860 has one GPU device which has a 2d and 3d core. In this 
> > > case
> > >  we want to expose perfmon information for both cores.
> > > 
> > >  The driver has one array which contains all possible perfmon domains
> > >  with some meta data - doms_meta. Here we can see that for the GC860
> > >  two elements of that array are relevant:
> > > 
> > >    doms_3d: is at index 0 in the doms_meta array with 8 perfmon 
> > > domains
> > >    doms_2d: is at index 1 in the doms_meta array with 1 perfmon 
> > > domain
> > > 
> > >  The userspace driver wants to get a list of all perfmon domains and
> > >  their perfmon signals. This is done by iterating over all domains 
> > > and
> > >  their signals. If the userspace driver wants to access the domain 
> > > with
> > >  id 8 the kernel driver fails and returns invalid data from doms_3d 
> > > with
> > >  and invalid offset.
> > > 
> > >  This results in:
> > >    Unable to handle kernel paging request at virtual address 00000000
> > > 
> > >  On such a device it is not possible to use the userspace driver at 
> > > all.
> > > 
> > >  The fix for this off-by-one error is quite simple.
> > > 
> > >  Reported-by: Paul Cercueil <paul@crapouillou.net>
> > >  Tested-by: Paul Cercueil <paul@crapouillou.net>
> > >  Fixes: ed1dd899baa3 ("drm/etnaviv: rework perfmon query 
> > > infrastructure")
> > >  Cc: stable@vger.kernel.org
> > >  Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > >  ---
> > >   drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > >  diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c 
> > > b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > >  index e6795bafcbb9..35f7171e779a 100644
> > >  --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > >  +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > >  @@ -453,7 +453,7 @@ static const struct etnaviv_pm_domain 
> > > *pm_domain(const struct etnaviv_gpu *gpu,
> > >                  if (!(gpu->identity.features & meta->feature))
> > >                          continue;
> > > 
> > >  -               if (meta->nr_domains < (index - offset)) {
> > >  +               if ((meta->nr_domains - 1) < (index - offset)) {
> > >                          offset += meta->nr_domains;
> > >                          continue;
> > >                  }
> > >  --
> > >  2.26.2
> > > 
> > 
> > ping
> 
> I'll merge it tomorrow if there's no further feedback.

Huh? Etnaviv patches are going through the etnaviv tree.

We now have two different solutions to the same issue. I first want to
dig into the code to see why two developers can get confused enough by
the code to come up with totally different fixes.

Regards,
Lucas

