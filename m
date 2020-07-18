Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42195C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170202076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6AhkgcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgGRPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgGRPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:10:10 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:10:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so7901885pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=IEkDcyZYo6iOURvWpzbeSvoYq7YfOi81Gs+exzoifj0=;
        b=Z6AhkgcUQI8QpyZN57FCAOBhtt3IYGgBNPPVfYNE3pg2ZapgN8bUmLAWW31fiy2PLy
         T1qAWAWZnfMAUURlLXCCeqxbbvsYFWx12+jjtskQyt+4BZb74WjZn0OjSsI6PkrD7WAN
         vOj54RsLpLO0IsoIm15XsJPluWCsGcsuMUOHbN8O9kopMY4xYar1yP5X3CeGVfT3oTZa
         nz0UNw+lWJMngfv63Onj2eZYtLKli56dX9qLde4RlLQNJ/EXMdy0uEBXqZYmkNgHSY2b
         LxwiD1sdFlzeBd59k2Ov4LImltpfJOsQf0QoV1hvUD2ssVxm0VwIp8kjy3VE0873pVhA
         bS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IEkDcyZYo6iOURvWpzbeSvoYq7YfOi81Gs+exzoifj0=;
        b=irmTp0kRuThRobEX4ybFT0LXJj0eHP815vwHOU2pO0M7dVR8UacuagwvgCaAb56GuH
         ulIDBWb6eGW7ni/F7+qLjm1TJbU0/YF1B58v1CfGLViGha7EvIvihATTiQcSubPWhMx2
         Y/Stfo4pA+xPcbaY1YvVvJqHFc5b1EzyhhztIxlmQvx8L9KcRCJEWMVDUuLVgVyK1oDS
         1q4U/kWOgcaEO9qt1FRRimxqWBckm5fGQhZ0jiLrrVVEDG6VJrclU1XuYAOTvd3k8ep4
         PGjoLu1wTHuuuihdXQVNOvjzgugKHP6LYDHNJf32P7QS9OciAoPUi0+YN4/qfOrZ8c02
         NNfQ==
X-Gm-Message-State: AOAM530M6aDA/4CP+wAzZNWJID2MC+QdgIcMrXKqdZXX51/KnmFoP/kn
        ha9D9dd+NGmAPAQxZftVrLRafgKGX17Cmw==
X-Google-Smtp-Source: ABdhPJxBtt+nvNF2N91hikiSUdgqSBBCs2Sx5IXfAedebWishQcVQBztKSTuaESfEahAnZKRXb/6QA==
X-Received: by 2002:a17:90a:be06:: with SMTP id a6mr14925934pjs.136.1595085010028;
        Sat, 18 Jul 2020 08:10:10 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id i67sm11182459pfg.13.2020.07.18.08.10.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:10:09 -0700 (PDT)
Date:   Sat, 18 Jul 2020 20:39:55 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: core: Convert device logging to drm_* functions.
Message-ID: <20200718150955.GA23103@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert device logging with dev_* functions into drm_* functions.

The patch has been generated with the coccinelle script below.
The script focuses on instances of dev_* functions where the drm device
context is clearly visible in its arguments.

@@expression E1; expression list E2; @@
-dev_warn(E1->dev, E2)
+drm_warn(E1, E2)

@@expression E1; expression list E2; @@
-dev_info(E1->dev, E2)
+drm_info(E1, E2)

@@expression E1; expression list E2; @@
-dev_err(E1->dev, E2)
+drm_err(E1, E2)

@@expression E1; expression list E2; @@
-dev_info_once(E1->dev, E2)
+drm_info_once(E1, E2)

@@expression E1; expression list E2; @@
-dev_notice_once(E1->dev, E2)
+drm_notice_once(E1, E2)

@@expression E1; expression list E2; @@
-dev_warn_once(E1->dev, E2)
+drm_warn_once(E1, E2)

@@expression E1; expression list E2; @@
-dev_err_once(E1->dev, E2)
+drm_err_once(E1, E2)

@@expression E1; expression list E2; @@
-dev_err_ratelimited(E1->dev, E2)
+drm_err_ratelimited(E1, E2)

@@expression E1; expression list E2; @@
-dev_dbg(E1->dev, E2)
+drm_dbg(E1, E2)

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
Changes:
	v2: Fixed error in coccinelle script and diff,
	    i.e. removed the underscore.
		drv_dbg_ -> drm_dbg

 drivers/gpu/drm/drm_edid.c           | 6 ++----
 drivers/gpu/drm/drm_gem_cma_helper.c | 4 ++--
 drivers/gpu/drm/drm_mipi_dbi.c       | 7 +++----
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 52b357e75c3d..6840f0530a38 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1844,9 +1844,7 @@ static void connector_bad_edid(struct drm_connector *=
connector,
 	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
 		return;
=20
-	dev_warn(connector->dev->dev,
-		 "%s: EDID is invalid:\n",
-		 connector->name);
+	drm_warn(connector->dev, "%s: EDID is invalid:\n", connector->name);
 	for (i =3D 0; i < num_blocks; i++) {
 		u8 *block =3D edid + i * EDID_LENGTH;
 		char prefix[20];
@@ -5298,7 +5296,7 @@ int drm_add_edid_modes(struct drm_connector *connecto=
r, struct edid *edid)
 	}
 	if (!drm_edid_is_valid(edid)) {
 		clear_eld(connector);
-		dev_warn(connector->dev->dev, "%s: EDID invalid.\n",
+		drm_warn(connector->dev, "%s: EDID invalid.\n",
 			 connector->name);
 		return 0;
 	}
diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem=
_cma_helper.c
index 06a5b9ee1fe0..822edeadbab3 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -105,8 +105,8 @@ struct drm_gem_cma_object *drm_gem_cma_create(struct dr=
m_device *drm,
 	cma_obj->vaddr =3D dma_alloc_wc(drm->dev, size, &cma_obj->paddr,
 				      GFP_KERNEL | __GFP_NOWARN);
 	if (!cma_obj->vaddr) {
-		dev_dbg(drm->dev, "failed to allocate buffer with size %zu\n",
-			size);
+		drm_dbg(drm, "failed to allocate buffer with size %zu\n",
+			 size);
 		ret =3D -ENOMEM;
 		goto error;
 	}
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 0e55d8716e3d..a7a611894243 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -225,9 +225,8 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer=
 *fb,
 		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
 		break;
 	default:
-		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
-			     drm_get_format_name(fb->format->format,
-						 &format_name));
+		drm_err_once(fb->dev, "Format is not supported: %s\n",
+			     drm_get_format_name(fb->format->format, &format_name));
 		return -EINVAL;
 	}
=20
@@ -295,7 +294,7 @@ static void mipi_dbi_fb_dirty(struct drm_framebuffer *f=
b, struct drm_rect *rect)
 				   width * height * 2);
 err_msg:
 	if (ret)
-		dev_err_once(fb->dev->dev, "Failed to update display %d\n", ret);
+		drm_err_once(fb->dev, "Failed to update display %d\n", ret);
=20
 	drm_dev_exit(idx);
 }
--=20
2.17.1


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8TEMMACgkQ+gRsbIfe
745D1xAAnqx4ox4i6Ozb3kXepedJvH0J4rj8stB0ZHXrQ84WKQvbMvxX6vfn+v5V
A+GFR+0uBJx32XOwUGFrqVNyAMXnDW46B521kO7RamY4zkhlTPUzo6UFa4Y6kiEp
pf1Tpx00ZTsNCb1TMmknUHHiZ1DzMAdwCDVejZkrPvrvEhNRDZbssXxsJvFmvLXd
TYTDw1fGGxlbh8snRh+lg6LYyhEVC4HRfta1BAN52jCAsoCmZ54UtsjHwXSQj0fR
UUvlEutLwwd5go26u1Ct8+KTqqeoNRK/GFfyK6AfBIeSB1PVbpuZEOznEAbfIvFF
cc2T6BLt7zifYPlOneWypRr+7MidMEg+XcQRPdl7FqTHofdofyynQQsPON4GYXoi
04D4EE+d/P/Mz4CkJOghsbVmzp7RuIMNaKskGwwDDjcUiC0f+iWLzQLJfX0A2zl0
8kvKhg1behcj882Dqdbwkgs2J+Byp6tA7iGqJ174arr8OsXGk4PNqzd98pvFmX6d
OjCNDhpt1xLJwO6m1fiMJeL78LRdPhlB6zP4eGre4R4Y0z7eL6/3/IA3JnrOIFjP
/HxCRIeZ6pt6eT+fyzF+VPVRUoLiVYgo6h9swXQvjl5L0GqBiXzRy5+jy0TycnxU
hfF/xTTDDZUF4mhHbgMGCbsOJAY0lKFDaAhEyDuZJFq+QOnRlN4=
=QSMi
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
