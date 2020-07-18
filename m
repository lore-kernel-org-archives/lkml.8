Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69767C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AED720759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="BPMOItQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgGRJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgGRJTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:19:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F28C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:19:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc15so4738831pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I4G2b6oiLn56qyVJ03FL/mQFC6Pc1n0o7UjqfCoRgAY=;
        b=BPMOItQAhvY6zTZ1HSTtEEfAlAI9uR1IILHlQbQBoU9OPVJVYSEXZQfgK7VWMYCqE2
         bMJADR/POLnQ8HDQtIxvAExu4Xuw8Lo9o7S2vwTiwWqqWwuXmxp7SvPI7/Vw3lb6usD4
         7EO0iNKYovcjekXGNuFlSWo/gDa4ub3QM9mTClHcr0U75KexMIl0ZuNa7xiPa5AMvMCH
         DWcfRRlc+ce424pw6rp8jPvBz+bJqfTLH5VsdrTla/cJHB9PLcu6CdDjMVY3f2cF4qe+
         CmiSZ5U9SrxxSKETeeVslFZvWWAqVb8xSCEh+1oO5GwB/j/DNcuEC2qb9dt0wMdJYnhG
         4KFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I4G2b6oiLn56qyVJ03FL/mQFC6Pc1n0o7UjqfCoRgAY=;
        b=q3Q7wLycKqfVsCVM4YsqTSLPdk433t3LggjyAlsHNNrbLi07z4aeDEpFowyRycgpEJ
         91e6VEhzmR+PzWlJFmFJZsoxCwnlgWlJxGoyZPLFfays5THSU6UcrHdhV77FsHaRZp3F
         0z7BAIcG6o4W0RptuydnKR4Z8Qp6PGOhqO5d/QUWCKNdl5XtZQCebA27MYhXZik4vuz6
         1kwHyRezAW2zyMuxN9wedhTHDvrKzBMgIf9pb102sRDicU8iFyAYS6AR2/8Hp/6njr3O
         /PcIGRQE9FH64Uacjf6+zqSeaDCPGDoSiV85r7XwLW9AsY4PH9Pj7lkWch/3VBcH0q/A
         rgww==
X-Gm-Message-State: AOAM531G60YJVQBFZeEq6kWD9pCGuIYOJ3wfqyztB3mEnb9CBS7prt7L
        IXNy2TTf5fS6ufeoM6k2skx0pQ==
X-Google-Smtp-Source: ABdhPJz6xCqd+mSY3e2SdNv8u7rqS8LT9NQEm8Rqlozz2Sv8U2owqVag111ocm/k68phBDhiehEIOg==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr13784566pjq.195.1595063943120;
        Sat, 18 Jul 2020 02:19:03 -0700 (PDT)
Received: from localhost ([2406:7400:73:207:8b43:3062:877d:c647])
        by smtp.gmail.com with ESMTPSA id s131sm9876087pgc.30.2020.07.18.02.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:19:02 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 18 Jul 2020 05:18:57 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8188eu: include: placed constant on the
 right side of the test in comparisons
Message-ID: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqcc3kjngupm4gpm"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqcc3kjngupm4gpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

placed constant on the right side of the test
to fix warnings issued by checkpatch

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_mlme.h | 4 ++--
 drivers/staging/rtl8188eu/include/wifi.h     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme.h b/drivers/staging=
/rtl8188eu/include/rtw_mlme.h
index 010f0c42368a..1b74b32b8a81 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme.h
@@ -266,7 +266,7 @@ static inline void set_fwstate(struct mlme_priv *pmlmep=
riv, int state)
 {
 	pmlmepriv->fw_state |=3D state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY =3D=3D state)
+	if (state =3D=3D _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess =3D true;
 }
=20
@@ -274,7 +274,7 @@ static inline void _clr_fwstate_(struct mlme_priv *pmlm=
epriv, int state)
 {
 	pmlmepriv->fw_state &=3D ~state;
 	/* FOR HW integration */
-	if (_FW_UNDER_SURVEY =3D=3D state)
+	if (state =3D=3D _FW_UNDER_SURVEY)
 		pmlmepriv->bScanInProcess =3D false;
 }
=20
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl=
8188eu/include/wifi.h
index 677827900607..dcef3da21970 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -326,7 +326,7 @@ static inline unsigned char *get_hdr_bssid(unsigned cha=
r *pframe)
=20
 static inline int IsFrameTypeCtrl(unsigned char *pframe)
 {
-	if (WIFI_CTRL_TYPE =3D=3D GetFrameType(pframe))
+	if (GetFrameType(pframe) =3D=3D WIFI_CTRL_TYPE)
 		return true;
 	else
 		return false;
--=20
2.20.1


--bqcc3kjngupm4gpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8SvoAACgkQ471Q5AHe
Z2rNtgv9Hd8w71e1h+llsOzTFBkJmx/DbNSr2Jc1k4R+GzO/BtAa4Zak/iL+KZEb
wI888iW7DKC6R68lzjQ1bRS3rGxxwEQK9rev/y8tzckdiZ0103kFjhmpdYmDxB7r
mehKoABIH3aTK9G7StXCeDScgqWYwfU6HmqfEeSzr66+XpdiMo+pcPZZTmawXTtK
Q26PV437be9J0PmX/ofCLJU5uCW/9YnVgCyKY/bqnT8Xg/wg66ZlhT0PhSzyIE61
PRVWQRpWm0P/vvXogjdAmHTyMXvkUK1Tkr+mRCorUQkvJRe5T3fu7V3QzY2rcoRn
1EI2dzpMmyCu68n7f2X+DNCffW9TBdxNLKi3kLfrHlQIjPAA16MJySzfulLguwPl
88oPoBY2WYtI8Lv3vHYLEPabUneZ/WxlubZ9CZono5YYKQqsP+LZf9+cx+DI3Clu
VKZHV9BRsS5i/ddZt7/XUdrR//cNZWSmSbOnxuI4qmjiDGlGo4kYR85853ly0Rfb
JESky8Ar
=DdPu
-----END PGP SIGNATURE-----

--bqcc3kjngupm4gpm--
