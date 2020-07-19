Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B374021744
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="0ZrtCLEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgGSSET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:04:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F026C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:04:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so9244347pgq.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8VY7wQvNDAXulqB8yTLL9tA4Zf4W6b1Xjb+KQabtK9M=;
        b=0ZrtCLEoGnfESdQpCPYjZDeX/pOsgkaG5iBX37QJgR+KDzwFUNNi6brsH9YNyCji3V
         hCOjXQFORoPJqcjhuYGMieSDdAoNDjgwAl+3Yeh6ENuEM821MQtbOTggHNK/prqlsQwW
         129E6LRc6habV8z8sB7TZwN049jlQSGTLSK/cLf59DCB+d7efQpMMMRIf2lSkm5TcD/l
         RrF2EwvQMiBgLDDxOAFV0WnN1YH/k9SgX6WV15YP25lAm4FEKGayjF4dMfVe0kge0qa1
         bLuXn/FQ3xE46kC7cU8TmUdF4Le5lCHdGLB2TgYT1QgbG19xSfQX2INf8fmdS3VJ+YAD
         120w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8VY7wQvNDAXulqB8yTLL9tA4Zf4W6b1Xjb+KQabtK9M=;
        b=C1pEnDALhqokCDnX1gXOBDNs6iIS51SWDqULXgZH+RXYc2ZH/aefD/mVeB+18KBpRS
         lgNv2ONO/Ky4J22Qsp9vA99w7rlDoGc6Mx/4Uh8tC44T00GRt906yBcXlp8JqWO/9VEy
         R6kaYqmbdCMd7jBnk9GO2u90X9rIsfy4MmHWq9IbnWQLiwDuto8nfk0ZeX/i1LjIFO9i
         EcrfoK/bhfUZ1xe0zDdoiaya3CAMtM4D/SUYXd+uMOIdQzmRpbO2JvwgF5iQx1HroGxo
         9MonZtRfGqSvMUiFmCIDcgpZBZVtNUIg0pxk5tDVhp8jFsjwUFEBaj5CGUcF8+uN4KDn
         S6Jg==
X-Gm-Message-State: AOAM532xf72y2YezkxGfuwfY7JTJocHFWWg+3NBcpjdLj2XNsYIlFLeR
        s2dTaXFPEC5lfPRoiFO84x4X8VBXr/s=
X-Google-Smtp-Source: ABdhPJwobwrBkd2xp2+CB3udIYULH9nLcZbOToz22396wCC+tNpjTOq4Kq1k1haE56PXhuAjzr4UWw==
X-Received: by 2002:a62:15d1:: with SMTP id 200mr15596386pfv.227.1595181857851;
        Sun, 19 Jul 2020 11:04:17 -0700 (PDT)
Received: from localhost ([2406:7400:73:31d9:a904:3799:f42d:73f0])
        by smtp.gmail.com with ESMTPSA id i7sm12582258pgh.58.2020.07.19.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 11:04:16 -0700 (PDT)
Date:   Sun, 19 Jul 2020 14:04:11 -0400
From:   bkkarthik <bkkarthik@pesu.pes.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mark usbvision as obsolete
Message-ID: <20200719180411.bkojjvumwe7hkxyc@pesu.pes.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="abfiqjzug5ukjwjl"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--abfiqjzug5ukjwjl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

mark staging/media/usbvision as obsolete so
checkpatch tells people not to send patches.

Signed-off-by: bkkarthik <bkkarthik@pesu.pes.edu>
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


--abfiqjzug5ukjwjl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEIF+jd5Z5uS7xKTfpQZdt+T1HgiEFAl8UixsACgkQQZdt+T1H
giEiBwwAj2bg6y+SsmlCq9ywbbKJlFYkYxV3UL3+mfyrDGdFgNYZBZ5Rwc2OwNnY
qTIPxfVZIqwCHZmridZjSdjUy/YhhfHPqyj7uhKhcLyHNTghfh6Fl5Zu7y2aI6um
Qe3oHZ1Py6SMuJDkNiCUSqPvkbv/2F7imxArOc5RqtGoMxijc/rgXdrM4sE5VDDg
F4yiEwZjYkOUejVrhLwRB1AL/SXsgf+W+MNJFoYhQN3IsUEBGpQeHCDRV66//xYH
fOM9qpitOonz1D3ROz66dVPzo+FR74O6vu60B7JyXyzsfPCIBt9MGSuc5sMe+diT
oG9Fw79PWX34sxBIeGK7L0hoti/qpBOSstcRAbvoFxXZuIY7PvWlt+lwvfhynxb9
nxiHQCzNb8mRf3+mLwiflAXDc5bF6J/MwGUOnna4ZTnmCu7229iHQTdPwyNBN485
LksUNppal0wgXnOD9rEQytWSqy/oYNGFgpWlUAMRImRHD1iOB43H66F3s/njp4mG
PsJ5ZLqm
=ZSqL
-----END PGP SIGNATURE-----

--abfiqjzug5ukjwjl--
