Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F38BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E97B2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLGUD5CW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgGGQec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgGGQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:34:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD1C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:34:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so5202068pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=+s8uTpzOInwRzG7yF6uQj5b7go+jZCn77sviuWuu/rs=;
        b=uLGUD5CW7JVOfR39yhs5ov3P2Dlb5A/9QeyNgi1JIHHI0guuxzhv8ObBEp2ARtpRxM
         RotZk550MT4nE9vY0teDlr0KEHKY50A/q/fyADFvykvsdf0R+B7bl43jCvvAZIknstSA
         HUZPzL70RfeWHxoNNsqYmlrQnVdk8nSwdlUuXxUBF4xT/N18PSXwVcrn4qQ2PEkqXo/X
         tSKurmtfDJ7FuJHYd10SM/X1g1U7/MuY+Ak8x1BWrRIXzpWk7B9K8nEbZlsBRCSv8vcr
         +h59kTyJLJHVVTrk8YXHo9v4gXwhNe26ozAYbfoOV4XTjUu6qsRTHn+8qmND1DDGw6YM
         ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+s8uTpzOInwRzG7yF6uQj5b7go+jZCn77sviuWuu/rs=;
        b=ReluvCDl2no6Alz/qCUGoqj+/yRdiZp6Kq8+PTEcw+scsbFBxxu5ilqqWBhCDim3D/
         68MpwevaNFb/QByDdOh4VReHMZcOG3dkeF27IZjXllnbiPVuQ7P89pDC19ZNLHy+3qsb
         X7GKzG0qxaKLxHAYi3xGfiP70QvGvQlFGWaxJdrIFwcrlDyMkT4QTWLCwMdK8Dc4N9RK
         YoTfpkN/OdLj/MCaeeHuGhujRRa3D1XEKtgaRj7JttaioQuz3gqcIwwXANj2WS/DMOC6
         vZF6y03KHexIXKkPnaC/QQYh5MtnOKuX/iPPB3vm292JYVWeVoFOKH4W5GC0EHBVGoqH
         6kJg==
X-Gm-Message-State: AOAM531sR62H7C8KryeieLVHfltT+nOqJ1b50TdljnDePkxwpDTYwwOA
        m021qBKWSMHiSqG7IJo5oqE=
X-Google-Smtp-Source: ABdhPJz9+XZnqCl8VLL87L5hv+VKWsXBu2Z9nSSYEd5x5VE66ZUS9/DknkO4i0g4hw3MORg0llSTnA==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr5173541pjc.94.1594139670759;
        Tue, 07 Jul 2020 09:34:30 -0700 (PDT)
Received: from blackclown ([103.88.82.137])
        by smtp.gmail.com with ESMTPSA id s68sm3054324pjb.38.2020.07.07.09.34.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 09:34:29 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:04:14 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] drm: core: Convert logging to drm_* functions.
Message-ID: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


This patchset converts logging to drm_* functions in drm core.

The following functions have been converted to their respective
DRM alternatives :
dev_info()      --> drm_info()
dev_err()       --> drm_err()
dev_warn()      --> drm_warn()
dev_err_once()  --> drm_err_once().

Suraj Upadhyay (4):
  drm: mipi-dsi: Convert logging to drm_* functions.
  drm: mipi-dbi: Convert logging to drm_* functions.
  drm: edid: Convert logging to drm_* functions.
  drm: fb-helper: Convert logging to drm_* functions.

 drivers/gpu/drm/drm_edid.c      |  7 +++----
 drivers/gpu/drm/drm_fb_helper.c |  2 +-
 drivers/gpu/drm/drm_mipi_dbi.c  |  4 ++--
 drivers/gpu/drm/drm_mipi_dsi.c  | 15 +++++++--------
 4 files changed, 13 insertions(+), 15 deletions(-)

--=20
2.17.1



--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8Eo/wACgkQ+gRsbIfe
7451IRAApvuLP/V+UbhAWsY53dMQkKWHKyETrPZ/5yooQM5VN1yjjb47MC6DeRoQ
VT61BXY5D53zAtqVuTerPs/ySce80Hjnvr4rsdoRe405bqu5DIqbbyq/K9VoR9Yy
ueiWMZY8cO21LT+cPqq/9aRrCDzhpppmOCcgwar+3WR8Qi13PF2PZM9OrobdWZ+N
aJWun4uaZS3qE3ZZibwsvX5b2U4vG5iEtuAiDq8wDsY0OBX1WEH3cpzYI0QW841H
F0i9xdOIf+zofDGGzngAzp5UQut1GTttQsFE5B9AkWKx4s4WMhq/309YgXUK70nB
/uap/6xzhYEuVRLwJwWzIrl+aLwNIgsN3iiqY/7NKe6rSH6PklPfErJn3AAT+N++
xFFHYPLkRk7/XMw8XlW/WW7otISYBPxJ4T9UPKbSX4c8HewF97vcTkVkwCmSHc+5
WWpoBDbNEnEECzMLjV7TAKTbkWM+24urBnGrT6f1fOeF2qSjeQE7DzIzxMW98cPk
3HEp7jBHvsjzMl148dX4MTPjStGYZPoHKe99S2maoe0jBmSBkufrBNhETFjBWQOn
xPjJWYghuuwNy+mXjAKbPhkBpKCpb3mnCXnFzbOIfxB7XfNoF4JGIwZL2Q2a50yL
cXE6GGc/JyzeHM82yOhq8eypCYY7nrKqyED/r+IVARj4X/p7rsg=
=Kzoh
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
