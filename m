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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03265C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07C720708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEc5z4hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgGGQgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:36:24 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9B3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:36:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so5021897pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P+tEcuvDANaU3TFunPyWDY6whSvjt/qMfIX+MZZgXbo=;
        b=VEc5z4hgiiI3ZAzjq0KOY/WOP0UxDZ+hWick5n4yRumfLVVQEcBqt2cyhYsRbxbFPx
         SJbjYxUfoam3g90qUeF4oMPa/OQFa0AJ2jL24fCMzIan6hiHK+1+Vq029EDc/Zlby8Vt
         udPbyjjFuK0oKp1eljurXkOCeaj5IDFhr7x2h7ht70mbGNblCxWqFax6P4ooahnHPYfU
         wWhuCWmdHczaLn8t744/RHpRKyCcDo2tkrr0/1IwlwAxq7+GG6wlBrJ5U+4PXeiBTZBz
         rl3xbkLBWe8WbpQ2mFSEssH3o+QJC1IbB4ylG/Oggt0urgotGfLPiosbro8nVmyVNFbC
         JgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P+tEcuvDANaU3TFunPyWDY6whSvjt/qMfIX+MZZgXbo=;
        b=QRQuz8bYx3AsOHJ+kUptKBi1AHIY2hAE4WT1fweTrinz4mhmbMHH6iFEUWcMotkksT
         7CZ0BlimJGqK/jzq3cDNLXq4kYpDGJwglirJUNVvpDTm2oLRtfnCksguA18YkU5kBiEo
         gCMa8dA9JXKAikdBD3n2sUHhZu6/kCVTxZI5c2RujYVpeHp41v5k2SvziS0HS+5DKBWf
         rIGbG9hvs77egJ51DEtHJyrRsUQQ4ZHoyu12jIS7LBhx5T6m1ySauRIr7Sq+Z0OlX896
         ALZo2WVSwRM/z/YZ/mNrlAokVtP3vPujslSz+/6vYWGqYbdd3cvSPffvkvdSlVQcM8FB
         otKg==
X-Gm-Message-State: AOAM532zjnsEKQr33yGtHFDCIyHv1eDMsYnwzBjc7qqimbwghd89Edr2
        NA3p0aYt8T3vzQu1LIs+oho=
X-Google-Smtp-Source: ABdhPJzHQmKoJIE1rCFwDMK3xXHpbwCQt+33rQ1Uu18muRkY/5KyR1c/K96qcJhDAtnHZBK8FFFgOw==
X-Received: by 2002:a63:e23:: with SMTP id d35mr44007529pgl.435.1594139783774;
        Tue, 07 Jul 2020 09:36:23 -0700 (PDT)
Received: from blackclown ([103.88.82.137])
        by smtp.gmail.com with ESMTPSA id u74sm1444074pgc.58.2020.07.07.09.36.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jul 2020 09:36:23 -0700 (PDT)
Date:   Tue, 7 Jul 2020 22:06:09 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm: mipi-dbi: Convert logging to drm_* functions.
Message-ID: <20c4bdc75f610aea8c779aa075483e04f47b719d.1594136880.git.usuraj35@gmail.com>
References: <cover.1594136880.git.usuraj35@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <cover.1594136880.git.usuraj35@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert logging of errors once from dev_err_once() to drm_err_once().

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 79532b9a324a..ccfb6eb1a29f 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -225,7 +225,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer=
 *fb,
 		drm_fb_xrgb8888_to_rgb565(dst, src, fb, clip, swap);
 		break;
 	default:
-		dev_err_once(fb->dev->dev, "Format is not supported: %s\n",
+		drm_err_once(fb->dev, "Format is not supported: %s\n",
 			     drm_get_format_name(fb->format->format,
 						 &format_name));
 		return -EINVAL;
@@ -295,7 +295,7 @@ static void mipi_dbi_fb_dirty(struct drm_framebuffer *f=
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


--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8EpHkACgkQ+gRsbIfe
744s7Q//dlnhywxEYAxmGVUZ1YniixJpFNn6Mvebnv/oUm/1HK3ryCrCLpaE+aZG
/PzqnkGBPg4k8GwlG5ho7pcQaEo74iWw0SuBnlo7M4MqaZqkB58/+uoD1CKTeQ5M
X62OosJ1jGcrQCAQYKH4vKkStgzPGB0pvByiNfzfVEsNtrWzMoxNnLluaEDOxXFR
IUXreuk+tSEmidaXWx+zXxo0E85VHTCHtiLK1EeDUPDBX70ErcfIXyHZxWMbwP3F
KqHJIaRQZ62J8t/TzB5KNROraZiB+9/glg8qK43YcK3TUOJJn0zjCOdKDeTcUz+z
R0qVsLta3bpd2BUxyA6uVQjfSxi/f9LKHF5692fSw+oE+yeALL90q4ZIj/6z/NRs
xLzg8GEu5KA2+fUFXZos0q5DZnt0kB/iYqs7sJTgh6Gc7qBBPgNjWzXkd8Qk2oKJ
FYG3ieO8HFXgEuB+aYz3FgZS/sv7ygwG9BbJvwFY3JI2fqlxZJKK1knu3TBSRwwz
eUWQrtiwcbhePCu9lRSmuXM/v0tiHE6QzEV0LrPlTeC6rqHZG3p37y/s7KWkECWd
DiGShUhbRUuUBilYvJC86YcwM8Q/1O9chJrSLAkLUCEcDAwiXMPeLDzszxVx/dPe
3YRAAttDmeuwuRj0afn8wSimBTiduB9bnurGCZddgadYZgU4A8c=
=zKPq
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
