Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C9FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBC120787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kph2ozsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgERItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:49:19 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57963C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:49:19 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id z3so2194907vka.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 01:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8GaXNISpBU56tinwWEgmNwxx/8bwcx91Qa4//hCnFs=;
        b=Kph2ozsXLRPRu/dxLis1gDJmQZnJwAwLoC8AGDFvqAspAd55fLvrgyopC/YJwXexGO
         WZFLrskkt5/tormgb0wpKJP9O0JanDZ+XYw94xSKhjgRtSmtM98dhK1gMns+g9z6ecmI
         ddXDNmX89hRR11bx5uJYC52OO6sZTtSk3HpPOqw/AflsIAOoO3qBDYcTZZsZ3xjHCIPY
         vgGvvyEZ8bv2W3K/pH05Q+Z5XB5TE7ZiL8vv/m8NFrwJmNEgxje8q76l3iPx27X1d/i1
         Y3aX4gLXv1IF2JTmF466SLgWFIXDCjcy/BFcbR0vccGm6+57ELeMwwIw9m5EWwvEu7rv
         qjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8GaXNISpBU56tinwWEgmNwxx/8bwcx91Qa4//hCnFs=;
        b=l5IBYeHMXzKQyd/S7UCHn1ETj+HMxtHEGE6+WFD4X8euiFU+10pZrHW5FwASboP50M
         5x6U2lDWdhmKKTJEKlduKocqWJua/0/oPpzQOTN535xQ6TPjoQUqs559kTw6kua9HN+M
         PaZuvg2mEI6D2pI7fei2n6pftSs/OVRbSfQzW9UCY0k9uKCv+NOv7qoqyiThy8wPRN2f
         qGIUVWEy+t5k4Y4rCiJbVK44mQ9gIt8v7vNDgPFW94l9gdZce5lNNNfY3h5Aklk9rXv3
         3ir/2OslMgvG/8P276+u1NhayqqZ6gC10xtUdnK/F2eGlZTxY0wW1bjJM7qqZhX0b+MK
         iUCw==
X-Gm-Message-State: AOAM530muoflpYd2RxtKOJPb3Mx2FfoWbASjKPpuO9hxC5b97BAuUAQk
        BEAdTBRakECbPDuDFWe0VJ6Jekr33Rh3yamGrsg=
X-Google-Smtp-Source: ABdhPJw9/ty9sw1NZG3ECF+G8Anz7+Swnxt4WzKMd2QN8sUNskUcTmNMvE75R92q4PwRaGH3bTqKFFFDvBAcwkG/wVg=
X-Received: by 2002:a1f:24ce:: with SMTP id k197mr10159979vkk.13.1589791757909;
 Mon, 18 May 2020 01:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200511123744.96246-1-christian.gmeiner@gmail.com> <79f9e841042bf1c0fca39366d95cfb6f74da07bd.camel@pengutronix.de>
In-Reply-To: <79f9e841042bf1c0fca39366d95cfb6f74da07bd.camel@pengutronix.de>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Mon, 18 May 2020 10:49:06 +0200
Message-ID: <CAH9NwWe=8AUBaR=05ZEZHDMrD1wW5wkpx85a=8UEmo24q8VTzg@mail.gmail.com>
Subject: Re: [PATCH] drm/etnaviv: fix perfmon domain interation
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

Am So., 17. Mai 2020 um 14:03 Uhr schrieb Lucas Stach <l.stach@pengutronix.de>:
>
> Hi Christian,
>
> Am Montag, den 11.05.2020, 14:37 +0200 schrieb Christian Gmeiner:
> > The GC860 has one GPU device which has a 2d and 3d core. In this case
> > we want to expose perfmon information for both cores.
> >
> > The driver has one array which contains all possible perfmon domains
> > with some meta data - doms_meta. Here we can see that for the GC860
> > two elements of that array are relevant:
> >
> >   doms_3d: is at index 0 in the doms_meta array with 8 perfmon domains
> >   doms_2d: is at index 1 in the doms_meta array with 1 perfmon domain
> >
> > The userspace driver wants to get a list of all perfmon domains and
> > their perfmon signals. This is done by iterating over all domains and
> > their signals. If the userspace driver wants to access the domain with
> > id 8 the kernel driver fails and returns invalid data from doms_3d with
> > and invalid offset.
> >
> > This results in:
> >   Unable to handle kernel paging request at virtual address 00000000
> >
> > On such a device it is not possible to use the userspace driver at all.
> >
> > The fix for this off-by-one error is quite simple.
> >
> > Reported-by: Paul Cercueil <paul@crapouillou.net>
> > Tested-by: Paul Cercueil <paul@crapouillou.net>
> > Fixes: ed1dd899baa3 ("drm/etnaviv: rework perfmon query infrastructure")
> > Cc: stable@vger.kernel.or
>
> Missing last letter of the TLD.
>
> > Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> > ---
> >  drivers/gpu/drm/etnaviv/etnaviv_perfmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > index e6795bafcbb9..35f7171e779a 100644
> > --- a/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > +++ b/drivers/gpu/drm/etnaviv/etnaviv_perfmon.c
> > @@ -453,7 +453,7 @@ static const struct etnaviv_pm_domain *pm_domain(const struct etnaviv_gpu *gpu,
> >               if (!(gpu->identity.features & meta->feature))
> >                       continue;
> >
> > -             if (meta->nr_domains < (index - offset)) {
> > +             if ((meta->nr_domains - 1) < (index - offset)) {
>
> While the logic is correct, I find this quite hard to read. A more
> idiomatic way to write this (which is much easier to grok when reading
> the code IMHO) would be:
>
> if (index - offset >= meta->nr_domains)
>
> If you agree, please send a v2 of this patch.
>

Works for me - will send a v2 in the evening.

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
