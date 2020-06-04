Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90832C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AFB2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2JTTev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgFDIWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgFDIWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:22:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95EC05BD1E;
        Thu,  4 Jun 2020 01:22:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so6188330ljn.4;
        Thu, 04 Jun 2020 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=/pZRUQwbTJyxIjfL2SLZaaCRlVPUN1E89Tgo7boEHrY=;
        b=gn2JTTevK/73GbATNCXpC8WiDu0GR/R4p9RCNBJJHKqT4hXpfs8Se96Z++XqTbDTvv
         1I68UMOFgVBIHBDuA0wxomVL9CML8c90CiQoarDdiXXIIehcqsxzrHALuyutxN3vfRGO
         Ooh772/2qY2Qs9y2pVA+K4YHHc6Phcc0JNyeZ+evo3H9JAJhROOmhuFZx/ZTZj+DSDYh
         rVeaz8/1k0Jrp1/9DHAIkBPMbCAb+UjCH7NXFqgUhfkGj59Gonq9pBF3EqKP3NI/LX7M
         UkLLuYQQQQnfdhXpeMOnLvdG8CeF+v42IUf3tuHUcTYbFu1k0RBBtbmR7qnyERxaUd+c
         8Cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=/pZRUQwbTJyxIjfL2SLZaaCRlVPUN1E89Tgo7boEHrY=;
        b=AjjQIuvbhXsI3329Jbk79OzEVMdusJt/o2Wm9mjQsMqyh0PvkOWSTosQPAXHp8BJpt
         J+3yiBfdWrwnv9IyxZaSv+cM70n5ycOVGoWdh8fgzhvCVY0QGjqCzPRuSLouM4PAAAvK
         IqznGrT2c032o92PtIsTrbfnS1bBi5jfKKoyp+YECWONru98GYRrIYWAQ37wAtNPqyxe
         moiSYsIE/s3woCleUdCDfszkHcD9RJZgR6xvxZGz+WJAo1Ds8BJfYKNhDWdQFZTZVfQv
         RLrkGMP9sBK3OTjc8JD0FFEyARCiKyU4fXI9EiO5X4xBgSHrCwGhH/Qx/6W2mIXi/BCK
         7dZQ==
X-Gm-Message-State: AOAM531mZn5BqgjKuGmuEcaeE9CwnvpizNbP8JtlsNoQjKT70gXluIFJ
        gyhNJI7Lr2eW8TPkVK3rRu0=
X-Google-Smtp-Source: ABdhPJwpcV8sR/8e6TUhVrMndC2q04n2y9gia509NnYsFtk4TjSvo4KVguFBEyVdx9FhLnf8nSSCyA==
X-Received: by 2002:a2e:8246:: with SMTP id j6mr1524263ljh.54.1591258965089;
        Thu, 04 Jun 2020 01:22:45 -0700 (PDT)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id k29sm1038116ljc.136.2020.06.04.01.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:22:44 -0700 (PDT)
Date:   Thu, 4 Jun 2020 11:22:34 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Andrew Morton <akpm@osdl.org>, linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, linux-geode@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Adrian Bunk <bunk@stusta.de>,
        Andres Salomon <dilinger@queued.net>,
        David Vrabel <dvrabel@arcom.com>
Subject: Re: [PATCH] fbdev: geocode: Add the missed pci_disable_device() for
 gx1fb_map_video_memory()
Message-ID: <20200604112234.7d840c15@eldfell.localdomain>
In-Reply-To: <20200603092547.1424428-1-hslester96@gmail.com>
References: <20200603092547.1424428-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7zGwgSlxxHt_4_lufD_uPZr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7zGwgSlxxHt_4_lufD_uPZr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed,  3 Jun 2020 17:25:47 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Although gx1fb_probe() has handled the failure of gx1fb_map_video_memory()
> partly, it does not call pci_disable_device() as gx1fb_map_video_memory()
> calls pci_enable_device().
> Add the missed function call to fix the bug.
>=20
> Fixes: 53eed4ec8bcd ("[PATCH] fbdev: geode updates]")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/video/fbdev/geode/gx1fb_core.c | 37 ++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Hi,

there is a typo in the patch subject, the driver seems to be called
geode, not geocode.


Thanks,
pq

--Sig_/7zGwgSlxxHt_4_lufD_uPZr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl7Yr0sACgkQI1/ltBGq
qqfEDw/+KLMc9/wo+jXiWAnLH7DQ87u0JEDybMYKFKx6EpC9KBlSApWcagjDaiw7
Swy6OTzovGayh7moGisYDCTSsXsG0KyA3AmGbOhTDSjIyWYb+HPPAI9X10yMmwvo
ql4+Jl5NF5ClfmQl3FAQKcrsdcUiTMJCu9rUBtaZG4RhTS/IV8Ou78BymOtzHSU3
0W/IeutQWwjH3txsdthOe4O2mkJy3DCok0jxn76VsivoifPKxRbia8O7NH+UbFP6
7p164/E4mVaTIHzFfqvvPqfZrh4w5k6meQHRy+9TC5AE46vADO/L7wcrghqrj0dK
wXc6i16+04wreh1cQLK/37V3SGYLhILjvK+K/ERvr1utyGUoPu3pmf67qugwxSoj
RfxWJj3yMnba/H7rCVXUKak5DtMixvtLlgwWg9JM0k453H8Ma4+pPPnEs5LrVVuw
ANeolbROqLp7EDQ4nFSgLY3Jac2QH3uiUg/KyB+MMbA8HyTqHEyfPXoFQWFeEGdW
c+ZPkw+f7QOYDOxGMmMKiZb6Vut5lNbfpSOIsleOeMbeifx2xtDK8IKV5gSfeFlI
kueD9zp8FjwMZ4wDRYXpW+l8y3EQj1Dt0GDuw6f9K5Xo2a7s89jMY+2K+qJX9y5m
oa24nht3w0fptulkyk4NPiuZVMXe6s8fZ/Fwf5M5W/Dd6Ii/dEE=
=W7Eg
-----END PGP SIGNATURE-----

--Sig_/7zGwgSlxxHt_4_lufD_uPZr--
