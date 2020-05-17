Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6F3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08FD206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEQMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 08:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgEQMDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 08:03:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C6FC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 05:03:50 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jaI1D-0006Nw-6U; Sun, 17 May 2020 14:03:47 +0200
Message-ID: <79f9e841042bf1c0fca39366d95cfb6f74da07bd.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: fix perfmon domain interation
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Date:   Sun, 17 May 2020 14:03:44 +0200
In-Reply-To: <20200511123744.96246-1-christian.gmeiner@gmail.com>
References: <20200511123744.96246-1-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Am Montag, den 11.05.2020, 14:37 +0200 schrieb Christian Gmeiner:
> The GC860 has one GPU device which has a 2d and 3d core. In this case
> we want to expose perfmon information for both cores.
> 
> The driver has one array which contains all possible perfmon domains
> with some meta data - doms_meta. Here we can see that for the GC860
> two elements of that array are relevant:
> 
>   doms_3d: is at index 0 in the doms_meta array with 8 perfmon domains
>   doms_2d: is at index 1 in the doms_meta array with 1 perfmon domain
> 
> The userspace driver wants to get a list of all perfmon domains and
> their perfmon signals. This is done by iterating over all domains and
> their signals. If the userspace driver wants to access the domain with
> id 8 the kernel driver fails and returns invalid data from doms_3d with
> and invalid offset.
> 
> This results in:
>   Unable to handle kernel paging request at virtual address 00000000
> 
> On such a device it is not possible to use the userspace driver at all.
> 
> The fix for this off-by-one error is quite simple.
> 
> Reported-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Fixes: ed1dd899baa3 ("drm/etnaviv: rework perfmon query infrastructure")
> Cc: stable@vger.kernel.or

Missing last letter of the TLD.

> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> index e6795bafcbb9..35f7171e779a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> @@ -453,7 +453,7 @@ static const struct etnaviv_pm_domain *pm_domain(const struct etnaviv_gpu *gpu,
>  		if (!(gpu->identity.features & meta->feature))
>  			continue;
>  
> -		if (meta->nr_domains < (index - offset)) {
> +		if ((meta->nr_domains - 1) < (index - offset)) {

While the logic is correct, I find this quite hard to read. A more
idiomatic way to write this (which is much easier to grok when reading
the code IMHO) would be:

if (index - offset >= meta->nr_domains)

If you agree, please send a v2 of this patch.

Regards,
Lucas
>  			offset += meta->nr_domains;
>  			continue;
>  		}

