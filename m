Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0DDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6E92064C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp0hPuYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgGGQhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgGGQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:02 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so16064433plm.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bmIb4cH2dMGtvHMr8FQlvNy97HPJZVEYJ99uMcxhXoU=;
        b=Wp0hPuYPNTBfQkHFnUoNn4p67iZB5+2ozxyZ3kliqMA5nY9Q04iNE3hoEJs/GpAtHv
         GyAjbzVHFfi8KBDEb7tkLyIPqoO5HmS03vFdNsbWGlFA94O9tgzoTMHTJ2VCGEi/n8Hi
         njHnFsOYwCbTZgGjwpnRsYijy+X1Z4eebvlHugPyFJ9nBRVquoyjEe5ayq0Pma8ntx1T
         j4woHGEArYUarHKF/WRSiq2l+XOKMOpeXPANnKVc0X+tMc/D6743UGgDqN69KJs0qtQM
         Mb5KFeCTs0JctQoyYqei2ledsOy0Q6KwQEeEUQD8lUGxl4Csxw+7EmDjpuj9QuiqLRvc
         zv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmIb4cH2dMGtvHMr8FQlvNy97HPJZVEYJ99uMcxhXoU=;
        b=tesc0dlF5JuPymgVhrQR3OC6mmHJVps6yG1xTWC8b6e2/gQDkKEhGfRsUHd7TjtF5E
         VnRJfsMjRRlrYtDH5579YfCXuBfHTFhS0RpUKg5rhMf1jM8GxuHVX2MyJJi3O2duatOm
         EwXY29knpBQpnC/U+VzQ0zTH0mqcyeUyI2Hur+oU8LqS9ko3NcpZ7ZaSoL/FRsCNAbrR
         NQ/+nsSMwFwQJmCpkruVO+bqe+IpctGe6C9UsvwgVffD7aiW85676lkDRO3dFscA4k9P
         /Q/RNMGdQ/VqgJQUf2tZb7zruuIiSgvXbH7fHCJwIPs/MSXd9aI8koaVhxM1xeNV37Ki
         6Tug==
X-Gm-Message-State: AOAM530k8/Wo4HEMLpoLEvtUWvbcyhlpOuw0CqqmGLXX8AMypj9PUl1t
        DXn6VAEn4/KEi4jLuzj7FD4=
X-Google-Smtp-Source: ABdhPJyFmHLpBCDY983fqPseLSiKhKoVuE3WzXBRRWWP52glRCodprglB0nT1ljdxGPfkgY8t3nx4Q==
X-Received: by 2002:a17:90a:2048:: with SMTP id n66mr5435327pjc.71.1594139822038;
        Tue, 07 Jul 2020 09:37:02 -0700 (PDT)
Received: from blackclown ([103.88.82.137])
        by smtp.gmail.com with ESMTPSA id y12sm22966423pfm.158.2020.07.07.09.36.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 09:37:01 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:06:47 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 3/4] drm: edid: Convert logging to drm_* functions.
Message-ID: <f40659c5656da4e1e3fad9cb731ed7f72feda3e3.1594136880.git.usuraj35@gmail.com>
References: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <cover.1594136880.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Change logging of warnings to drm_warn() form dev_warn().

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 31496b6cfc56..ad7a1f9817ed 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -1844,9 +1844,8 @@ static void connector_bad_edid(struct drm_connector *=
connector,
 	if (connector->bad_edid_counter++ && !drm_debug_enabled(DRM_UT_KMS))
 		return;
=20
-	dev_warn(connector->dev->dev,
-		 "%s: EDID is invalid:\n",
-		 connector->name);
+	drm_warn(connector->dev, "%s: EDID is invalid:\n", connector->name);
+
 	for (i =3D 0; i < num_blocks; i++) {
 		u8 *block =3D edid + i * EDID_LENGTH;
 		char prefix[20];
@@ -5284,7 +5283,7 @@ int drm_add_edid_modes(struct drm_connector *connecto=
r, struct edid *edid)
 	}
 	if (!drm_edid_is_valid(edid)) {
 		clear_eld(connector);
-		dev_warn(connector->dev->dev, "%s: EDID invalid.\n",
+		drm_warn(connector->dev, "%s: EDID invalid.\n",
 			 connector->name);
 		return 0;
 	}
--=20
2.17.1


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8EpJ8ACgkQ+gRsbIfe
746TcxAAkZNg/BfOOLgsJCdKiHfjZ+G8VmgQse7Oe491c79h5M7ehjraS2gAuXCu
7Ih7idgIH6BhEGhgTGumv+VDPHNZ1qxIGyhkxts5qDHcBnnOWwhIoT13v3YvgADp
ZccQRXRKMzs/6F1qqoUzmDWXRivdP17pao5Ybu+7+ZRlB3lE/q48zxoha6mBl53m
Y8+QZVYA6tidiCG+cc3KixVwYQEJBohuESbp9IShN8paS6OorxLOxf4ud2AvZolO
zDNwgkuHrkOY4/OMSikmcM3ydyGN+Z5OhySDDf72wmKByzRfeBATEZntzV9NugIr
+rfJddHV9COwm81g8SKEPIBagJaP2+gs3nwYpVe+Ey0mtapmKhQNe8pormdvmmMl
/ggI12SbHCNQ4dZ91biGhPTIDs7boEpPyNvfkAclY0YuWo6BlY3QGWYKvaZDnh5n
kyYpoSdA4SHy/auncAk0LPwgtaEONVTRF6oylKGAsfy4ht2l+8yZhxsaFBmPlsNO
YLURe/P24F3rfXm8vzSzw90B5vkRsttPAE6AJEoxOYXiHut8+74OkJllCCuH1ArG
xVxFV6O8zLK02PAWcdzQwBoqI+K7DrPHp/yKX0CH36PRzgQ1DeNaLp/zjKo8H8pB
o+JjSYvIVcYQkQ6nEsq9PqPLtyjndY4heDgYLUZ6vAalJUJpoJs=
=4ifc
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
