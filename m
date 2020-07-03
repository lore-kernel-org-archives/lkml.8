Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE799C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9030320782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuCxf3z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGCNiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCNiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:38:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451BC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 06:38:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so374807pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VFd81vfcBlp3Es3dpBrxLjfarRsAbMK7vh/f9iOrSDw=;
        b=NuCxf3z6WqYbYeQD/SMMZHBdiw6c5t9v2q2YxbZrv6Zaojas+kJuGUPC1ScH7uZsRR
         nhRA4XbnmEDBnvoEL/VQb4tVkpOR+vU5/B7CoUjVkszSCSjS3uj0/hyrUqVqFQvFz9j4
         QT+FXMZBN4nUHJPeu86Z45y33e3NPSmT2+OLc+/8MdEUhStLRgzRPTFwyMpEvmH7fV/w
         95tZySfGDiSLOx1MtiJ9PrDDwRtQgo+nHLid4jIjTgr+SBXiNUXdvNw1Ltzth6tQgsOM
         IjHE+gYbI63OwcA5yBDU4LFKa9ZLSzzVgCmKLlUXiMJcVdwNuHmQOtnQaRQg4cN/xmxB
         gRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VFd81vfcBlp3Es3dpBrxLjfarRsAbMK7vh/f9iOrSDw=;
        b=uGEoSBVnvKyKEWQ+3KiKU5IQqbyJl2o258w/dYMLOErjRoxSZD/9tMngihsC/np+b4
         neaDGHeVToEOgHBxFpvFafoaeVgetgdCJJpf8+Dn7ibyc6w8fJd/3CYKQwHiipPXOXc4
         6rzmlFVBGBVe1s3nAv3Qm4ese9G1j3nRlLsGldO9Bx9GkUbuq0Piuaz9d3KqspJyxJLE
         j90+Ahyln6QmwTjQFQhptHvdzm2h6gC5Kqa8U52aZ8URy/4FNIiNlA1B86QCy1dqRjVL
         NSBA81V9uZGG01fzkfXbHbzCFJS6Fra82/pm15ctVmlZX0COY6OdxprM6wCR8yHMMFKD
         EOSg==
X-Gm-Message-State: AOAM532neMdZ1zUgWi5Caf00/rGY90CcaIgwHnL9K13fMqyaacr0B2J6
        u36J8ixc9xMRqmZmlCKwHis0Vs9lEND7XYqY
X-Google-Smtp-Source: ABdhPJyfIBGoalH1o3MDckuQZrNhSkZAWShuJgSblfifU72BKYDJBrIzFNPbd90TLvmj4l57K/RIwQ==
X-Received: by 2002:a63:db46:: with SMTP id x6mr26092809pgi.265.1593783501349;
        Fri, 03 Jul 2020 06:38:21 -0700 (PDT)
Received: from blackclown ([103.88.83.224])
        by smtp.gmail.com with ESMTPSA id d9sm12219404pgv.45.2020.07.03.06.38.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2020 06:38:20 -0700 (PDT)
Date:   Fri, 3 Jul 2020 19:08:06 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: connector: Indent code using tabs.
Message-ID: <20200703133805.GA11191@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace space-indents with tab-indents.
Issues found with checkpatch.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/gpu/drm/drm_connector.c | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c
index 00e40a26a800..441d4075dfa5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1906,11 +1906,11 @@ int drm_connector_set_path_property(struct drm_conn=
ector *connector,
 	int ret;
=20
 	ret =3D drm_property_replace_global_blob(dev,
-	                                       &connector->path_blob_ptr,
-	                                       strlen(path) + 1,
-	                                       path,
-	                                       &connector->base,
-	                                       dev->mode_config.path_property);
+					       &connector->path_blob_ptr,
+					       strlen(path) + 1,
+					       path,
+					       &connector->base,
+					       dev->mode_config.path_property);
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_set_path_property);
@@ -1936,11 +1936,11 @@ int drm_connector_set_tile_property(struct drm_conn=
ector *connector)
=20
 	if (!connector->has_tile) {
 		ret  =3D drm_property_replace_global_blob(dev,
-		                                        &connector->tile_blob_ptr,
-		                                        0,
-		                                        NULL,
-		                                        &connector->base,
-		                                        dev->mode_config.tile_property);
+							&connector->tile_blob_ptr,
+							0,
+							NULL,
+							&connector->base,
+							dev->mode_config.tile_property);
 		return ret;
 	}
=20
@@ -1951,11 +1951,11 @@ int drm_connector_set_tile_property(struct drm_conn=
ector *connector)
 		 connector->tile_h_size, connector->tile_v_size);
=20
 	ret =3D drm_property_replace_global_blob(dev,
-	                                       &connector->tile_blob_ptr,
-	                                       strlen(tile) + 1,
-	                                       tile,
-	                                       &connector->base,
-	                                       dev->mode_config.tile_property);
+					       &connector->tile_blob_ptr,
+					       strlen(tile) + 1,
+					       tile,
+					       &connector->base,
+					       dev->mode_config.tile_property);
 	return ret;
 }
 EXPORT_SYMBOL(drm_connector_set_tile_property);
@@ -2024,10 +2024,10 @@ int drm_connector_update_edid_property(struct drm_c=
onnector *connector,
=20
 	ret =3D drm_property_replace_global_blob(dev,
 					       &connector->edid_blob_ptr,
-	                                       size,
-	                                       edid,
-	                                       &connector->base,
-	                                       dev->mode_config.edid_property);
+					       size,
+					       edid,
+					       &connector->base,
+					       dev->mode_config.edid_property);
 	if (ret)
 		return ret;
 	return drm_connector_set_tile_property(connector);
--=20
2.17.1


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl7/NL0ACgkQ+gRsbIfe
745R2Q/+MrJ/7YsoeXHWQ5EIqUEJZeTQ0ohelFWFDlBOMNFjEWFIa9YI2+PK+zCS
e+1Mm8vso9bcMBm42ahPUXkd42SKmUUTABQuq2FU15XQn0A7M9LOFliEqpmAnSYi
BkOztVjxxq3rTcCM7VfGn7oytGtctu3Aruhk3MvdyvoTBzxRhLXLBuQfPfesUQoc
ErzUBg4JAAD07erPir1XeliEQ/616qL+mozqqsnu5Ol7p9wV0zrmhLyF1uZIFYVT
eP0V8YQEaJWOHXgplefcCY0f3kYnac971IzQgh9x13cgqYez22WTq6PmedP70/AY
EQza2Qei/dsWHq6pUIaMjdTVes8psBnKTRriaJu68RSISID8oInueDUNcwD+tdrQ
/gdHqppTadpozO36GjvCm72MJIQHoAveK8sqy/mF3UTWt5qucSgGk10sBMH3E7/f
lhyGQiTRFVANRzBjPwrJu+lABL9dd0ItKJfzibydagcgs0GtKHVYIuv3hpHx5ARg
YDzhq+tizgl6Vir8sBEPTKuywCANYRTlugutNitBO3IB/UzAmDSj8E+vUAK3XD6i
7jFQnFeDpQNB5bAtVPXbuoioxAwXGQ49Mb3S7I6LjEJLiEXsLNftcVaTIeyhVqPb
aMVP4fp6jfOlVu+NLMUVJLzR51e+fnAd+srKegPLDbV4OSSD4S4=
=yF/2
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
