Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF78720B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lvf6QEIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGBH7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgGBH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:59:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836DEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 00:59:51 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so23457733lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=FFjYKpBSKZwCdKgCzGqBigM/s8hti3IoOAkxJai5TVI=;
        b=Lvf6QEISPmWpQtZcoV5SkQG6V4tdaNpmjFz4OtN3tXn8yyQKv7iRmzcunTVlOtK+mV
         8YXfxD/TRRerP4FnWGnOYmfFln5uAtWpGdtUC3a0U8RE9TK/AvtP7o4g8N5L+fLFJXl2
         nJpBdXDElVw2P+2gEf+x2YZu3gBxaTHICuR9Y5myy0Z/X03GRld89NFbjlUP0C+SyC+U
         oVQo9G9UL26Eh1fEfgQz8QAu+EmMcM7wn/X2SgFs+92OpUkPky/a/B6mzG2JCvjjSnIH
         nytqy9ek36JtBsMJlDxn5jV5DIU47XrJwtTgoKA8TWMjAT4hh6JFxC6tsKGCLiHK5TDO
         0D6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=FFjYKpBSKZwCdKgCzGqBigM/s8hti3IoOAkxJai5TVI=;
        b=TzgaWKE+bWiBIa2TX4EbZBZoRSI9PJGXK6SabpZPP9IeYlPZtkMdPv+4M6bANg9lac
         gtPl5SgP0XzVjKJsKk73DmarWkEsXZP8AyhURHVX32ds0Qo37QV+KdMKy/Izv5H1vgnm
         9sJpgoEnCzmsx8jmI5mALrlG85TAbW888imaJqctk3wQk6toiB9ZRUYr7i94GIdLvw1w
         Ji5WQ9WRKhoYOUMp4Rv3dbETVi6PsETZNrMpaE+Sat1BRdiXNZy3JqRZY6U0cuQCEkwW
         VEiEdyugTNP0xODvIF3z2oF0uPcYDcjI4PhtInkTNOlYOzkNgbIehG6qaGAugBOu5yZ0
         Wgqg==
X-Gm-Message-State: AOAM530kwluMKk0GZcvzJhFJ5Q98BcMEEbZVLjq08QQEFb17tOaUpZei
        32YRNAtN7M/MXwsetro99Mo=
X-Google-Smtp-Source: ABdhPJxPdBERiUWVfp0+1OBAbCNX2qZqLxJb3bT+Oow/WYg3/9zanZkL1dKjkOlJ4RJqHm382OHIMA==
X-Received: by 2002:a2e:9ecd:: with SMTP id h13mr3902734ljk.17.1593676789643;
        Thu, 02 Jul 2020 00:59:49 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id i8sm2981244lja.18.2020.07.02.00.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:59:49 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:59:36 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     James Jones <jajones@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [git pull] drm for 5.8-rc1
Message-ID: <20200702105936.6ac90dd0@eldfell>
In-Reply-To: <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
        <20200630230808.wj2xlt44vrszqfzx@box>
        <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
        <20200701075719.p7h5zypdtlhqxtgv@box>
        <20200701075902.hhmaskxtjsm4bcx7@box>
        <77e744b9-b5e2-9e9b-44c1-98584d2ae2f3@nvidia.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/1XKmWarqMAAGn2W3pJg=x0V"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1XKmWarqMAAGn2W3pJg=x0V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2020 12:45:48 -0700
James Jones <jajones@nvidia.com> wrote:

> OK, I think I see what's going on.  In the Xorg modesetting driver, the=20
> logic is basically:
>=20
> if (gbm_has_modifiers && DRM_CAP_ADDFB2_MODIFIERS !=3D 0) {
>    drmModeAddFB2WithModifiers(..., gbm_bo_get_modifier(bo->gbm));
> } else {
>    drmModeAddFB(...);
> }
>=20
> There's no attempt to verify the DRM-KMS device supports the modifier,=20
> but then, why would there be?  GBM presumably chose a supported modifier=
=20
> at buffer creation time, and we don't know which plane the FB is going=20
> to be used with yet.  GBM doesn't actually ask the kernel which=20
> modifiers it supports here either though.  It just goes into Mesa via=20
> DRI and reports the modifier (unpatched) Mesa chose on its own.  Mesa=20
> just hard-codes the modifiers in its driver backends since its thinking=20
> in terms of a device's 3D engine, not display.  In theory, Mesa's DRI=20
> drivers could query KMS for supported modifiers if allocating from GBM=20
> using the non-modifiers path and the SCANOUT flag is set (perhaps some=20
> drivers do this or its equivalent?  Haven't checked.), but that seems=20
> pretty gnarly and doesn't fix the modifier-based GBM allocation path=20
> AFAIK.  Bit of a mess.

Hi,

the way I believe it is supposed to work is that modesetting DDX first
asks KMS what modifiers it supports, and then passes that list to GBM
when it is attempting to create a gbm_bo or a gbm_surface. If
modesetting does not do that and still uses modifiers API for creating
bos or surfaces, modesetting is broken I believe.

gbm_bo_create_with_modifiers()
gbm_surface_create_with_modifiers()

Of course, this doesn't affect the need of a kernel workaround.

How is modesetting creating the bo or surface currently?

Why would the KMS driver starting to support modifiers API suddenly
make the buffers fail, does it change how the buffers get allocated in
modesetting as well?

Or maybe you're talking about something else than what I assumed, I'm
not really up-to-date here.


Thanks,
pq

--Sig_/1XKmWarqMAAGn2W3pJg=x0V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl79k+gACgkQI1/ltBGq
qqeB0g//bCgxzhfwsFwQWNpJJROB8d0HJfL2wrFYHoCco5SaWO826/QQ6tVEy1D2
81ZvtCciJZnlnsYg+LvGrWh1rQt1K7HpacaKqL4e+86Puy1oQjesUEu6/z9ANl6q
mAipS5zVEmczSMb5437ZunBIIzHcv/TI1YxqdoGer24/hfPDhTLJzvZQri7f9KtV
e94492D9PuCkNqGYHrM/5K1kyXlqNpWPn5kVeD+5L8BWFEX/lW8XmbIKzjV1g5Vk
odknAPDl16fLEEGshDAhQ2t9T6RQJu5KH3FPQ6qMGzn8cBjwsIMa/EFUk5uHTM9I
HdG6wqm0dyTYHsCG2DOZ+ID0KlvFc/ZdLz7x7u+AfsZ4z9r/Mq3zePtxrQYSOzct
bg8VwLKjw+Q9jB02kIE1hF+gNBbS28RvTHhRIbiK1uOqVyVa9Wlfb4377rXwSCaE
8VSez9r98oNeTV5922WVEc9ocqTmT0y/jfy0gMLZnNex0vG29Oz1Fno4bMHOwLNE
VM3DOeHi4KhJkLQ3bjHf5Gbkzp6dyFmI0ncEntNPMMr2pmtOqTPzJ2xs7NPf1Hb6
4PI+jwnho2wB2oUyGGp6qMj9pluIWgLXV4iSJaY/Z6z0WvyGKqO9NHIILQwj/eU3
dCCIyb3Ws/ltJoxJIbGtMRtIzERiaxlhYZ6PHJAiUsB9mmmp1wA=
=xzji
-----END PGP SIGNATURE-----

--Sig_/1XKmWarqMAAGn2W3pJg=x0V--
