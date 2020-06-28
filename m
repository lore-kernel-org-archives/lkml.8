Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604CEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36D2220771
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="CzI1RdSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgF1Eim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 00:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgF1Eil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:38:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE0C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:38:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci15so445688pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 21:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HpMMZYRbzQ/bcdlkqQv+0ue6DbtFqUzMKo2iWLbzeLo=;
        b=CzI1RdSgDpgduvsNwIZoh/8jkiOyCbjTIWeVQhjLWnNWcF3W2lnJMXg3/XiCX9PbAJ
         PIMUbRTsUruQyMATe+jlNCQCmChUOfjKnCx2Ww1ILhip/iE3fL21if3CvY4CMkLYo84S
         mW3sWo5fB1fVS/bxWPoYqOh6Y5dXfGw8cnWUV/C1Cda4KVWEjgksz5Rrw+Ht52aAxQVe
         PBtGnIMPZ7mL1/cAq0jEvfTWnDtw3cIo7rkqCTPysBjYwtbq/nxKl1XCrqOkTH9Va3jp
         rBsUkjTpL0ndN4+k5GWDacYqQoqWxq4CtqZVKez0A7RdihYiVgWWqHKEiZgo9RX4UXpN
         95Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HpMMZYRbzQ/bcdlkqQv+0ue6DbtFqUzMKo2iWLbzeLo=;
        b=Xfe2Ik4yixuU5WktSMdTsBiSbfB8JMwhDkUbWeriek+takXHpnB3IYEXTt2ICdSqgw
         LTICf0geCEXzk2eK37nacscicxBgxvr3LjaN0B/dEE53Dt2H2RPojjCQGM2zKlliFJJK
         8qXTuW4Nq2hMOfkzKbjSvMFcci3KFdz6aWKH3uTssWN+pLTgMLyeoYXIoePzyr19Rr/h
         F/ldhChuJV1PZeEx/1jKfeAHHUGd79g7D/gRffdAt/TuVgpvNImE0hl/budjY910kZqU
         B7BCsSYLhEnvt2u6lt5QuiDHUWnhu6YdtE2l/Ywx+cV/0YMxR6RaRjY7HhtEnAWgvsKf
         r8IA==
X-Gm-Message-State: AOAM5324irCapvLOU351UTgDw19VbLpnm6NT7WhbE8hvRnFY8Kq2GhD2
        a+4Hy7D5yGZrg1bcW4Lp8atkUQ==
X-Google-Smtp-Source: ABdhPJwqyisUZBL/qB5SDxO8FQpoVPLJsZlI7dCcD5F6JQ1ZePzGnIsmX7YpJ3dqlmE3TeQt9X0ekQ==
X-Received: by 2002:a17:90b:3448:: with SMTP id lj8mr10880938pjb.163.1593319120296;
        Sat, 27 Jun 2020 21:38:40 -0700 (PDT)
Received: from localhost ([2406:7400:73:a66d:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id y200sm4521437pfb.33.2020.06.27.21.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 21:38:39 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sun, 28 Jun 2020 00:38:33 -0400
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: atomisp: i2c: atomisp-ov2680.c: fixed a
 brace coding style issue.
Message-ID: <20200628043833.3dodctrmkec6aoe5@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j63puneg2vpssyww"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j63puneg2vpssyww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a coding style issue.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
index 90d125ba080f..c90730513438 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
@@ -495,11 +495,11 @@ static int ov2680_h_flip(struct v4l2_subdev *sd, s32 value)
 	ret = ov2680_read_reg(client, 1, OV2680_MIRROR_REG, &val);
 	if (ret)
 		return ret;
-	if (value) {
+	if (value)
 		val |= OV2680_FLIP_MIRROR_BIT_ENABLE;
-	} else {
+	else
 		val &= ~OV2680_FLIP_MIRROR_BIT_ENABLE;
-	}
+
 	ret = ov2680_write_reg(client, 1,
 			       OV2680_MIRROR_REG, val);
 	if (ret)
--
2.20.1

--j63puneg2vpssyww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl74HskACgkQ471Q5AHe
Z2o3zgv8Dymrr9Re3CvjBKnfHsbHRE4sqJi/Ro6tYF71Lt7ivGvG/ifDyn6YM9wX
EMHC+KIxMMQHfVdcr0hf+2F7EhU7NkbGKGtb2ONJduh91V7jBNlTyJBX+itlGjoy
ZPMYuP/H7LVoxGMltlHzWrYJxOeCWnzdUzE7HQmSfsXwa9AhEPNILN/dNaYf16TL
lywM6qwwDWwezqK5MVrSLWrtF5pKT3mz4ziR3YP0UoNrdb87Oc4aFleqJLrYCCFe
rPalVYkBewnjL8kj2hBtxKWLn85ycZyR9zTbPdh55qVTiDJJBm2sXVCjeZuu8dwa
n4FGQFRdv6qwFbUaIQafhSwE46f2WcLockJa1/h4udXOD1uy3TCDBPFJ6siN2/ay
Xb+aV7ugY7vAtl4ZN1i2eAnbTN4vZzh2HifOSbMV0nIfBJ9AgwWFMNMXvVn/lrPD
fv1Lis0rQE84odycbWHKUHW4JiO22TEqNyMMmsAlHa457Dv1YWrE6bUyuRcA10Vt
CtnwnGzt
=1LYK
-----END PGP SIGNATURE-----

--j63puneg2vpssyww--
