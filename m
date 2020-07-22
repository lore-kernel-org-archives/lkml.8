Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C8C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237CE20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEqY+uZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgGVPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGVPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:19:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFEC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:19:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so3022460pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Hnc1prn4gqdZY/uJrCuRN7dMv55IchBRg3AjBbSa9HY=;
        b=oEqY+uZztK+GTH0rvS82TpQ0E5rlT8GitcDlEjjT6sUzuHIY7BWKb0Y28BvioJW1t8
         KbnjWbWqaykvr8qEBeOQeaSBW04aI69x4f+b5jxjvyZgP/WBQKnScj4HyMZyLbbI4fCA
         cd+DJ8fiePq0JoH+Q5dFOpPkKuocgEjWCJ+IbNbN8ZjxYoSjyhJcPzhzKIt7iH2CThGN
         3b7yzo/9XgNvtmnS+CAODzPUVvoAo+P7LJXRIgFzCVFdJbCOXl3UjXhjF1nSj/KB9r4L
         kO53qX9tcHwFOgGp20vQ5QhxARO0STGcaOcgrsn+RgmyFeaPxjHnFtQ9xpnUZCX1nRWh
         VRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Hnc1prn4gqdZY/uJrCuRN7dMv55IchBRg3AjBbSa9HY=;
        b=Dip85Bc+E9DZjylNQQyAh+V84gBO9wrBaJEGGbr7t4RChnIYO4xFWhvY98Jsgls1XK
         Q578Zn4Ups+6LQcJL68zPpbSqyHerCiRgJbjUAUCjB6PxAfn+yk1ZX4VOYsc2ZUv/QR6
         seRBtubwpc0m9J+SczCYMBvCDDfOy6aIZDYJS5fHaq+31/yqWqNNhzh8R61mJ+UTi+rD
         Sq7uMfFgDzrrnxZVKBV9H6hb1vO0urgwoz6vgr2lxkiV+IwLlLw3ZjQCWmQ5rtvKtr1S
         E3vOJnx67nJEIvL94rG/emvOb+hA7aSZNiMj2+uXhX+g8f7QNVCm0QGLOh3Xzuk2o6uL
         3sPg==
X-Gm-Message-State: AOAM53234KgB7ChBcsr4tny+kX5G+RxXrl1a2tFvChS2QI7VH+ZsVpje
        QDMtqTEdsXtJ6ztCD+dmXoQ=
X-Google-Smtp-Source: ABdhPJyQgeFZerWlXivVvCHlBW+hxP8zzZ9rASx4/DF8X48FIeK29YiPlb+nmor4Ax1S/z2qIUAaPQ==
X-Received: by 2002:a17:90a:3684:: with SMTP id t4mr10143619pjb.91.1595431147867;
        Wed, 22 Jul 2020 08:19:07 -0700 (PDT)
Received: from localhost ([1.23.142.145])
        by smtp.gmail.com with ESMTPSA id 64sm281319pgb.63.2020.07.22.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:19:06 -0700 (PDT)
Date:   Wed, 22 Jul 2020 20:49:00 +0530
From:   Mrinal Pandey <mrinalmni@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, straube.linux@gmail.com,
        simon.fodin@gmail.com, yepeilin.cs@gmail.com,
        saurav.girepunje@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: Fix an indent coding style issue
Message-ID: <20200722151900.5dcebtavkdi5cc77@mrinalpandey>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fpt4wn3ldqcwypba"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fpt4wn3ldqcwypba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Only a single tab space is required after the if statement.
Fix this issue by running scripts/checkpatch.pl on the file.

Signed-off-by: Mrinal Pandey <mrinalmni@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rt=
l8188eu/core/rtw_recv.c
index 656fe70ae4fb..0a4c1b2686b5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -671,8 +671,8 @@ static int sta2sta_data_frame(struct adapter *adapter,
 		if (mcast) {
 			/*  For AP mode, if DA =3D=3D MCAST, then BSSID should be also MCAST */
 			if (!is_multicast_ether_addr(pattrib->bssid)) {
-					ret =3D _FAIL;
-					goto exit;
+				ret =3D _FAIL;
+				goto exit;
 			}
 		} else { /*  not mc-frame */
 			/*  For AP mode, if DA is non-MCAST, then it must be BSSID, and bssid =
=3D=3D BSSID */
--=20
2.25.1


--fpt4wn3ldqcwypba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE8DwCG1PwaC2uTI99xIwpEWwxhGQFAl8YWN4ACgkQxIwpEWwx
hGTV7BAAi1/qy9HC1pFSyKBVuey7wA8uYsw2/tIGlmHamM7UunyD9mOdyTKjHQaH
VKUukWo1302Gl2kiUG/mfLRbEzcZedY/qOuUfVaxP1Nfa+Hp25W4rfn6Mt0CXo7D
sneUd2HAexEvPn+qN+EoiZC/tCa/VqbwwPMovJ8/3riORAsSPhb661YHceJVjIjH
FI1peJln9zfGYTViju4CtIXbJpfADvntrDG9QJO/B8QLpcWr6WmefvJ+worv+ouZ
JUecDwPsPC5OCgm2Nqi1gNwfhHZzgVkyT7ucDgZCWeCYLazFffWZ2UoAKho23fmQ
iQnzjCG66tX5MZpwZObrWda2csvXtuZi019i0iBE9ZxD+2/G+5nAZ3OT5bChPK2o
lm9OYzJXaOJZZHRWVNM4FFLk/bzhuda9b/l9rjwKJqVLZXfn67TqvYhhPHp03CF9
2EEU92f+RTUlrO2m64AcBGitpzqOPTtFOKRtSONYFcukSonrXKPUSwQ75I2LeaoF
ICo7G3j2mzOcxIk+9XP4WtMvjclbzYwIJzIEElfHGXZxFc1AlIaEdZW13vHel3gA
hVJDUGHV9OqltqNXkryvj3vZ3QjRAUwC7OF0a8P/7QFOTrpS3DlgRGo/CYASwYZj
drGAErnjTln/x3+oMapcZUQxJsJRBbJDvxgugCaGIdD4WaHeiC0=
=vAMR
-----END PGP SIGNATURE-----

--fpt4wn3ldqcwypba--
