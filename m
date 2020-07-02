Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888DA20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="fPOtA6Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgGBLWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGBLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:22:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:22:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so13334873pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nt96k6iAKxqAFLPuGZvFYf33kEJ+/jRhegvfMeKc9Xs=;
        b=fPOtA6Tb7M5g4NKvW+QtMg8fBqYNtKBM0zq7JWAD5tEQeaj7a4EM4Uwc8uLzIuzjWI
         lbG7Pi2tuDApXckkKxuI9NGIwojlLArPSNCQkO2WZT6Go6TGqWFNIF8agRJawsmk2BUF
         fxDy/cKeelxjZ/sjBTk2pGEsZs+VLxn4V0OtgejWlUeQ5R63qL9ZVtiaHWobJp516QXY
         OSoIZN2tdyuLKfX62JLAE9riYDmbWzIrcecj61ogKcf1FvfEJTpzBB/cvYAVRzRsa9TA
         pLaN7Qpa3lDyBw1JNQrfaojZ1EPM8m5MhRRpFtm7yPOO/g+PnRZYHdz9SImPFIJNEZwr
         WAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nt96k6iAKxqAFLPuGZvFYf33kEJ+/jRhegvfMeKc9Xs=;
        b=BYH3oc9VNxwIje7xPIXzBIbPnMeWYi3wFj56C5ntODj/Nads19GtIoGXsdXu8YxMvP
         UO6lEYR6J1/yBS/eETjUT7DojqOvtgRVyJI3gKhoMcG0V6vAC73ki5CwdSLv5HJc3MMW
         IVv5IO5ev9xIUSKInZm8ATwHiBRQaLFtUJIMshz9W8SLRL0WHnC/mwFb6yTHxaCiFf6S
         Tgh9KCOvYNV16mp/Jf2bXR+rflbv21yfrvdFYvY3rD+EINiW4nwjMDClkKPGsI+lt7xI
         EatpFjak52xa5ey7RYM6K4eE86obP2t1fIoW1wdZeoO8ZfrBOFYyoPpibqDCELI0dlo3
         kNww==
X-Gm-Message-State: AOAM533Xla6LhHKIQy3lC0RZZ7hlzX3l35oFPLL0cccEptr7d/Qq2KDb
        gAkv8+FuESRPXeHMkEJjY2sZPg==
X-Google-Smtp-Source: ABdhPJydMbhu4w4dIm3e/HYEXc5ZMYlZN68Nglf/tCAmFxbrbQ+hA0WwrlNL0s0aS9y6fW5p5PNPhA==
X-Received: by 2002:a63:f814:: with SMTP id n20mr23250319pgh.92.1593688938793;
        Thu, 02 Jul 2020 04:22:18 -0700 (PDT)
Received: from localhost ([2406:7400:73:3271:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id 7sm8674767pgw.85.2020.07.02.04.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:22:17 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Thu, 2 Jul 2020 07:22:10 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8188eu: include: rtw_pwrctrl.h: fixed
 multiple parentheses coding style issues.
Message-ID: <20200702112210.th4aiiszhdtufbpe@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ekcxpik5lw6jcut3"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ekcxpik5lw6jcut3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

add parentheses since complex valued macros must be enclosed within parentheses.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/rtw_pwrctrl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
index 404634999e35..c89328142731 100644
--- a/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
+++ b/drivers/staging/rtl8188eu/include/rtw_pwrctrl.h
@@ -84,7 +84,7 @@ struct reportpwrstate_parm {
 	unsigned short rsvd;
 };

-#define LPS_DELAY_TIME	1*HZ /*  1 sec */
+#define LPS_DELAY_TIME	(1*HZ) /*  1 sec */

 #define EXE_PWR_NONE	0x01
 #define EXE_PWR_IPS		0x02
@@ -201,7 +201,7 @@ struct pwrctrl_priv {
 };

 #define rtw_get_ips_mode_req(pwrctrlpriv) \
-	(pwrctrlpriv)->ips_mode_req
+	((pwrctrlpriv)->ips_mode_req)

 #define rtw_ips_mode_req(pwrctrlpriv, ips_mode) \
 	((pwrctrlpriv)->ips_mode_req = (ips_mode))
--
2.20.1


--ekcxpik5lw6jcut3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl79w2IACgkQ471Q5AHe
Z2rdZgv+PEEd2Ajt0okuG+6fIqzpISYZ/28PJjGjrCVHhXZtavp3LSNrCKIdMCW6
ib6K4zOhMrHNgOd97ktSdq/uRaP2dN0cpXOhzbo1zzHcR27F6t4j7wAMnyHwA3o+
OOK/sPiUkhibXeggNQPqVSVXASBIowpHk4EbJ3QVwSYjhFYGQDz02Jn1qovs1F63
VSBuRBS0iQ9EDoENbWgnLxdirSL+aeXHEWTc4ZhM44bq2NCcmXdLcoBMdGIc5TUZ
dliMSNXrehaFZ8yEiT8NAVNzc29MtS2s8Cki9RMEvTH2kxFHTYM3mYacWv9JlJ2u
BBGB5h61u/TmGuzqcYwcdu1xfAj1FBCFdsMHPD/SKsYjrKD/v/CgiixKuSWc0Kla
VjKwXYqIXPugV0rH6HZMyBxTezhhKblr0dXectcGErf+6s5RqkBtW2ZcKtOIaaYE
gbcjSHHgSDhHMZUed9UsfvTzqJn18rJF6K7KVEIbAf2ia5LJLmJ0PWuiBE99Qair
A8zGIgg/
=hbqL
-----END PGP SIGNATURE-----

--ekcxpik5lw6jcut3--
