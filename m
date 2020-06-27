Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7AFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67872080C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 04:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="HdfxoZlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgF0Ev6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 00:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgF0Ev5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:51:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D3BC03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:51:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so5043383plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 21:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2m5JaK8rotSonwx/sP/f5LHubDWMPNymxIpTxYlUo6A=;
        b=HdfxoZlWJQlGoozkGi3XYW/MiGAw4euyHjR+e7WfgPMw4zz7LBb41nC1qVtih34Ur5
         hjqDXgcA4iJ+/fBCVjwza6b9MLdjCr3cVosVUp+58OnQbYqfiCIV0GAYT0Vl5knrZFyH
         KIs4SYsGgUqG3SKmHTefnx5j1nrHsmYMlVrwzfpXZnhOZBon23SQUixaExCdhWp7v106
         SHnIOxAi2phCuEUz8VxTz3X75sbCPQpi1YMx3MuhPIwwOPPy5VTeCyf+RYpt8+I8EAk+
         DzxPZqDVcw4JDutORo9PvNVEWKEPsXRm8d94LgzyCQQAnuOramTHpu346Ii8zhHeFD4y
         Q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2m5JaK8rotSonwx/sP/f5LHubDWMPNymxIpTxYlUo6A=;
        b=K7jWd2aeVV71Ettd5OsC5xmDsMEOHx98smdszM4qO/nF85UUM6YqccsiVQb/23cEe8
         lhcyFdFY+2gfiLCZ/EYeCPsh03S8+pXU1PEI+awVGnux+MEe0dONzadAzECTi7LZiK9l
         /uwUES2gkInN0aACtv6jrCMUKKsC3FEPZJfpc76YtFOzts5wOoq5nv2f5F073Gxbc6VB
         OiNJMw708+b/oT8Ug8934AX7I3SiVGHdvIgl2g8t9hamHF5VaXUBEbKchgywjb++etw+
         KMpdApvC8nGnTmoRJT3GnI+1nJdIeRuz61O6C/4K4K+dV3noxp1UWsE3YZAfX/aMxMzt
         EWjQ==
X-Gm-Message-State: AOAM532Tz+hFDeK/V5gDOMQV//LmFoyhEg8KZmJDvpLSz1fSYAA+EVsi
        xdztzRKMHHTQf/2w3Psox3Stig==
X-Google-Smtp-Source: ABdhPJxHyMwtOzx+gAvFq1xBuRoB6v6iA5rKjZad34+AZjGjKrJ6P0JsrDQTjuK5Sur8logNECvRNw==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr5227052plb.207.1593233516708;
        Fri, 26 Jun 2020 21:51:56 -0700 (PDT)
Received: from localhost ([2406:7400:73:59a9:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id t5sm5499821pgl.38.2020.06.26.21.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:51:55 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 27 Jun 2020 00:51:50 -0400
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Sebastian =?utf-8?B?R8O2dHRl?= <linux@jaseg.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbtft-bus.c: Removing that prohibited space before ')'
Message-ID: <20200627045150.ysqvd47o52f4a6rc@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t7rr5fenqhwyb57p"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7rr5fenqhwyb57p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fbtft-bus.c:

fixing ERROR: space prohibited before that close parenthesis ')' by removin=
g that space and ',' in line 65 and 67.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtf=
t-bus.c
index 63c65dd67b17..847cbfbbd766 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                         =
    \
 EXPORT_SYMBOL(func);
=20
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
=20
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
--=20
2.20.1


--t7rr5fenqhwyb57p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl720GYACgkQ471Q5AHe
Z2qzmAv9H0yKGQeZE/+LG3U87JdxsfJKO6l2V+1+Bqb4T+jrD52zcitgEaKaPkMd
y5JqgAPxpFk1YNpSFbw+j4xsa36+TFKGYIDCuPIPmYhEtUfUG1Aj8roQPdqrs2Ir
oiGfJ293xMBp1GDYOMAAdB55BWNGHGiEgJ1GG++9AVSXz1Nm0R9SIJwPddoPq9yA
Ez+tYms6eNVfnk+CVEpsEjhUf6rk+WARb+UgfJ9lxzebU1damViQda/naEiIOPm5
MRt1V5PUUZcYYlGsrisCbc8DhTrMrD82j/j3uKyS/3Wm/+J39bq7WZO2t6kDcl9k
2vdUFUinO9szZJR9bfEbsZkRVZzkv3j5Qyqg4Sur09vy04se6JZWod2vTBaepnnx
vulIXywLvtsnfyZLVsBsRPit8zyO1BI2P+o1T+NRjfQKUuvkmzChmGt3DanuvGBB
Fop35oDLMjcbK/KIH8lQGXzt51kpQ8M5sCc8DAWxGlGJFK7h0bVUnOe5w/3G1S5G
YWNuuvZC
=Tfl7
-----END PGP SIGNATURE-----

--t7rr5fenqhwyb57p--
