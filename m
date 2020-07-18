Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32833C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B04720759
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="Gf7N3qua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGRJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgGRJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:17:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB25C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:17:46 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a24so6571502pfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dPpR8M5iZHHlhAhtQMCfYZIYY4QgLTvQ7b9UaLMulFA=;
        b=Gf7N3quaKvxXNjE4IJH5DUM904x4OWIim1UTAiHGOnKrZo1QDsaLrUlubsPLNEQTOs
         1C7MVRmMa5A+Twpj3+h7dJuh5WSYm6sWZfYlE1ZvJd3IWOYmA4V18iKDVik1IAwO1ks1
         sB267DIK4h2GnEiyHtCNfOqfRbrsPJLOaaPRGQO++0K0JiIEimPOEQToCE8RZeZ4U0ye
         Lr9H3hFeOwQrnF9XMbhQiEmeClH96S0EgsyLRJh46uiB4h3BmI7E7hV8abuudTm0lRdE
         6I/4JP3q7CDm0BJ17z177MkraHN/uLLxRp07Lf6E4TYPaNWXq+DFRP4URIpwD2oKG/VR
         dbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dPpR8M5iZHHlhAhtQMCfYZIYY4QgLTvQ7b9UaLMulFA=;
        b=VC3oaPlxkbh7sDqRb0/NA5beERUMUj2NGRm8Tt7zHcokpiHHL4+W9jq0M3k0aR7LL6
         ZIgY5RE4hWcMPWzfUdxnbfdKICGP7ujlwEZeSwez2hcKe7eP2SSdEVKCxfZaAj8EkQjs
         WT0Q39kvXF40og0Os3/1BmKFFlyTPbboiVz+2zyB4mKBaUjVlo9PuGuFSn/5ffPSSI45
         WnH3dfDYQrtpmBjQMeuBQCWLNWg7bAP2rRC7esD2ucj4ocSWaKtrLcAC7X8rjGaQvUdy
         D8O2e5uwSMQUCAMzOxihQOWec5pkA44Gy2AVdnHKIJKE13hcgRijHOxCjH4e2jEmxqYa
         gG4Q==
X-Gm-Message-State: AOAM533uF4mWniOyIs45R0w/F3k/pleFY1RFtqSQ74VM1qEpZJY6Nkrv
        7qITPVBuBG/iR7KoTDvs7jl8fw==
X-Google-Smtp-Source: ABdhPJzWNj2+FsQiyHogMgKzYgJZla4S93f86nHKs2TwDQLTcKKRVIPW6LJ7ACe1X9VN/m1Y1ygSfg==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr11994522pgn.431.1595063866411;
        Sat, 18 Jul 2020 02:17:46 -0700 (PDT)
Received: from localhost ([2406:7400:73:207:8b43:3062:877d:c647])
        by smtp.gmail.com with ESMTPSA id s22sm9525830pgv.43.2020.07.18.02.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:17:45 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 18 Jul 2020 05:17:40 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: rtl8188eu: include: enclosed macros in do-while
 loops
Message-ID: <20200718091740.mzinnyks5tjafowm@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gh2egzqcljdzn7p"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gh2egzqcljdzn7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

enclosed macros starting with if inside do-while loops to
avoid possible if-else logic defects

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/odm_debug.h | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/odm_debug.h b/drivers/stagin=
g/rtl8188eu/include/odm_debug.h
index 857c64b8d2f4..c7a928d396b0 100644
--- a/drivers/staging/rtl8188eu/include/odm_debug.h
+++ b/drivers/staging/rtl8188eu/include/odm_debug.h
@@ -76,20 +76,24 @@
 #endif
=20
 #define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <=3D pDM_Odm->DebugLevel)) {				\
-		pr_info("[ODM-8188E] ");				\
-		RT_PRINTK fmt;						\
-	}
+	do {
+		if (((comp) & pDM_Odm->DebugComponents) &&			\
+			(level <=3D pDM_Odm->DebugLevel)) {			\
+			pr_info("[ODM-8188E] ");				\
+			RT_PRINTK fmt;						\
+		}
+	} while (0)
=20
 #define ODM_RT_ASSERT(pDM_Odm, expr, fmt)				\
-	if (!(expr)) {							\
-		pr_info("Assertion failed! %s at ......\n", #expr);	\
-		pr_info("      ......%s,%s,line=3D%d\n", __FILE__,	\
-			__func__, __LINE__);				\
-		RT_PRINTK fmt;						\
-		ASSERT(false);						\
-	}
+	do {
+		if (!(expr)) {							\
+			pr_info("Assertion failed! %s at ......\n", #expr);	\
+			pr_info("      ......%s,%s,line=3D%d\n", __FILE__,	\
+				__func__, __LINE__);				\
+			RT_PRINTK fmt;						\
+			ASSERT(false);						\
+		}
+	} while (0)
=20
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
=20
--=20
2.20.1


--7gh2egzqcljdzn7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8SvjQACgkQ471Q5AHe
Z2qt7AwAqyyxs0GY+J+0HsnO0XAp6PNIVdb506/UI/umTX12rlVBwRSmmjPvB5O3
0LVTMxsp7N25Ds1KFPVr7mxttARjVTG8BusnYRGHhzk0u/56pGEWLxZqow5yVgfl
lxE6zFBwts467ho8YtbG5pMCZBsrH83bIBvwjXuXT7Ru8mlt2HuvcVxfD7QL9zLQ
Y/9cM62zrJWxYL+FAYdpiYe9Zcn6q+850l/uwuvY2hYce5Y329rSDes44MfDouI0
qe+n9gYmCFog8VTpDeRgWzWKddS90FfqbFrG/DPEV8VG043JvBbeq4Q9Whok7Eh7
eMP7ejNiV/XlFSHGBDn/cmWhAUfcvTVjlYY1En4FQKdLDopUbcYB8YclBgKEFWUd
3TEKsByunnAYeZKLHwJGc4hp/CdiTLarh/NZG7jTvSNkZLho9IlKc1ISZhQIg+6R
EYthXze0BtjTgYWR4xPrVboiRfPtmISA2+zEgFHvmlNRdNwV5VwAd+DC7oH4h677
kUKAqkpA
=Hygm
-----END PGP SIGNATURE-----

--7gh2egzqcljdzn7p--
