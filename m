Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17F7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCAC22080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="D9kcG+VD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGTDQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgGTDQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:16:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A49C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:16:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so9464334pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bAK4Ji36gBHdTX80qQpJh+6afIU0fbEtgOxLA/wjz9U=;
        b=D9kcG+VDWyQbphvCpnxI4/rol031vC3+mf1UAsK7vRia/aCbGrzTFDy3q+AdPJd+0C
         cam9gXzW1KKEOTDKrfoJYWiZcfprWmqL/Ck0mhnAwfIwtDb9RfizMoyDhTr21RZHnDly
         jjwhVuA2Ae4vAlZf6VeKKXXp87/RXKisNIKbID47RktvdwJTGtFN9A8kFR2KTx50Wi08
         EUFLf1ok80mixERvVw+IgdImD1kedZ6zs3dclksIR2pYImUbDanChyjxwvXmKSFEAEvX
         OOaS3KIj4hlALR9vTLLjGh4Se1JHSYfL3PcTvse5uKxHhcFEgAO18dM+dFRxwgycqeNc
         4WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bAK4Ji36gBHdTX80qQpJh+6afIU0fbEtgOxLA/wjz9U=;
        b=SipQPQs7i0/2nJ+72ojAmjMhEUfIw1Gx5kb884duTdNxs2bSmpAhbDajWKx3owjbJa
         o/yYo1wMhImrqEL60I0E54B2umgUsSKvy4wUk4ub69Tqbhuug9NqUznCZ7N63xI2ndEp
         MN6m2K26hUukPnwzpHvXdotdRkDCYKQZD064v81q9U+wdu8wEbtfY38L78laRiGGz0cd
         m0EPITPpRLPuW25w74dNvNIt1Fx2sy2zzsZLZ3lWE7Yw9CsWc4a1IncmYxOB5pdryDD4
         uEp2a1SIFyTLgnB217CaTP2/9J3ED2N141p4IR1TsZVO5crl/lyR5PLf70kKTG9B7Yeu
         C5HA==
X-Gm-Message-State: AOAM530H3YAhsXk22w9y1lHzCwLjysfBsoO5ql3g6tmXMGbLRdjMBw93
        ZUMHiQlw3s47laqpTpVGCX73WOy5h/k=
X-Google-Smtp-Source: ABdhPJzVC1q8XzfNdIhLF7gnrQtf0P1j1RWcHDDMEzcjVsHZaxQZPsf6aMXKWNGqHrLj1dNvRjrHTg==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr19825961pjb.21.1595214974986;
        Sun, 19 Jul 2020 20:16:14 -0700 (PDT)
Received: from localhost ([2406:7400:73:58e5:a904:3799:f42d:73f0])
        by smtp.gmail.com with ESMTPSA id x9sm13196216pgr.57.2020.07.19.20.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 20:16:13 -0700 (PDT)
Date:   Sun, 19 Jul 2020 23:16:08 -0400
From:   B K Karthik <bkkarthik@pesu.pes.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark usbvision as obsolete
Message-ID: <20200720031608.cujruuzsrfpnt7sh@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2i2bmcanxvm7ru25"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2i2bmcanxvm7ru25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

mark staging/media/usbvision as obsolete so
checkpatch tells people not to send patches.

Signed-off-by: B K Karthik <bkkarthik@pesu.pes.edu>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a88bf0759c90..82120c2fcedd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17946,7 +17946,7 @@ F:	include/uapi/linux/uvcvideo.h
 USB VISION DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-S:	Odd Fixes
+S:	Odd Fixes / Obsolete
 W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/staging/media/usbvision/
--=20
2.20.1


--2i2bmcanxvm7ru25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8VDHgACgkQQZdt+T1H
giG/hQwAhiYxySNfPfIQAodHgxFflzXTWMPJWKPsH8xfQWCVWjQW3iY/OCrMU9mp
7aJiY8DpmBedQhBfXKAJ7dRsqb8a8FxarY9x8pTSbjjVbjJw7tTeycEziu6d5zfV
cuzEny/LFqShXmS2zAtZ4Xq4aF3MI/MkBvxBYYkcI9D8F+Red09OElkfSaAVDMCi
QDmqYtFNu9yLCv8DPW//H5iUzflzs02z7V41VegDi7YD8Ke17l6OYEjavPXsOVid
ZZGqVl4zva4VWKP3+22wWx15t0+73icFeZ2J344CTAhOhpavgOJVFJPB/nEBNfLo
Gx3JhsrQuutfUMMY5R4b46IWR+PW3aGPssXo4TxdReJWNgVBRfFlZ6+D45EoqOyk
M5VBuTqNBONe/E60c0bZn1ByDCdsyYbigEwnSEIqrm0Tij/D+KXbWcIZ7/59sNLK
oXQMWeeqJMk9CdnydRe227yvyotdULbrqo+Dlwn1YlMHBzH4LZIKaIINwTp0CqT4
gbDV/YzF
=iWsF
-----END PGP SIGNATURE-----

--2i2bmcanxvm7ru25--
