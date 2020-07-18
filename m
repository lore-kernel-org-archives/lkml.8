Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F5CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7EA20684
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJpYIhhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGRNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgGRNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:19:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5CEC0619D2;
        Sat, 18 Jul 2020 06:19:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so6773220pfi.2;
        Sat, 18 Jul 2020 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=bW56Dq/EZQ7Q0OxXWw3lSP4NAzICRQndu6/ZLfdw/eU=;
        b=lJpYIhhryLyntBJ0OGcZIbxju01m3oYcIhETi0dMSh5uePg0c0Q+y+BLuEvQ9ZQowu
         2dFUjjhy24tQmuib5A/VMpjqurNaRbmiHGbpbt3kPgg0VN2XeNLXVq3tauUsAik4uIMg
         4BwK7L8XSTIdcyRmoui4tpu9cydMpK8YEU0CLnVIaatENE+Y9kDNfcTxd9sGll45+g8P
         6YIC1Pol3Eid2XdSikbBdAJMMAEOX/+ja48Z/JSgLjeG+UdoWcqSnm6A0j5OhK70ugZo
         hMwXxSjYLVFsP1Hc/hHCTs+QzA3BxHPAJRByUTBHwZ2CQsD0sJNRZ7Hg7WlAsEVBBJlZ
         Prmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bW56Dq/EZQ7Q0OxXWw3lSP4NAzICRQndu6/ZLfdw/eU=;
        b=hh32COq+6DbzqPfz8KrWYXIDivtuTs164wMXaM5rRfuc6TO4RNIuYqwCHAKPbitrVk
         8YMgLMO26uEjZnGw0y9zlBgw/xTjYMMq59CcFMku/7UjpLzliPtCTGEdx8vI24cstLXY
         oClg/10M7/qAJ1hZr6F3GQ2Hz30rkkB8ng04NpL1hNkcGzz+ysq9JPKyw3b4/EeysYPr
         IgIg6okhlvkSA5VqrJIttDlfO28dopccW6JNHn12XYPGnipIph0oy93UqyY4swjlHzL7
         e0wzguJ76PXzY9RZHfo1q/DbdhDK4E4ySc1TLkYMoeEXAPHkStwx5Eryoo/YaSJBZBu7
         ACWA==
X-Gm-Message-State: AOAM531FHqTyIounwjkje728saSgjT7DwOUQYRcZhlx4GTmzsDHaD+s8
        JDKf/6MrTzQLTUHKH0WzZGs=
X-Google-Smtp-Source: ABdhPJxceziaeE//any/1Ek+Lh/N/UukPxOOP9stjgcSoj2QsLa6Jau86qLHgQMAmF+rFxE81qUTKQ==
X-Received: by 2002:a63:5619:: with SMTP id k25mr12218506pgb.139.1595078349459;
        Sat, 18 Jul 2020 06:19:09 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id 129sm10446524pfv.161.2020.07.18.06.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 06:19:08 -0700 (PDT)
Date:   Sat, 18 Jul 2020 18:48:56 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rts5208: rtsx: Replace depracated MSI API
Message-ID: <20200718131856.GA10837@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated pci_enable_msi with pci_alloc_irq_vectors.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index e28e162d004e..adc80e766412 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -310,7 +310,7 @@ static int __maybe_unused rtsx_resume(struct device *de=
v_d)
 	pci_set_master(pci);
=20
 	if (chip->msi_en) {
-		if (pci_enable_msi(pci) < 0)
+		if (pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI) < 0)
 			chip->msi_en =3D 0;
 	}
=20
@@ -881,7 +881,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	dev_info(&pci->dev, "pci->irq =3D %d\n", pci->irq);
=20
 	if (dev->chip->msi_en) {
-		if (pci_enable_msi(pci) < 0)
+		if (pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI) < 0)
 			dev->chip->msi_en =3D 0;
 	}
=20
--=20
2.17.1


--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8S9sAACgkQ+gRsbIfe
747zJhAAnYwOribTqVdCoKelWsg/J1bRcpu3igKxafUf9i6Jdyk+XmaL4ZtRFsG4
Gc5EQT8o6bhufzzW+We8doUAjusxMIpEBL4+TzN0vK0YdmNeN/Ebi8Be6JmsGa8U
BEedBfiYtT6jVuRC2AdquNK3XJ3U4+8FXkSfG0NuGhwViwks0TzQHOAZJCxuS5Cq
+XFhBNXpjK8E+IOXOFKEUB1cngLfwYKOZopITObQO182b7NND2yWLR5U7TLJlBHX
rE8Nv3Ie7On89qoXSfDUrYNZ7jHok9FRO3K5D2L7v7Uzdcy9JoarwG9cwN3nsWXy
A1l40jF8ctR+VhukddlrMs6cl/lGoIX3j6oBW/rm7MuW/TgLRnefZLKi9ffAmq5s
29JyX9k2ZuqyWUcuXkSLxri/hzqGzKv66Zg4QeeKjPVdNWc1Lg15zAtiXnkLT2j9
coiA8+9d6FfPonwPsYHxwxtMK+BYxUtnAzfbII3uIBHB0av6GVpjjgSIaMvsPcRZ
R/XnG4XO8zqXyttXxJqzS82BhGvVUvEbtSK/wdqbMeYGrX/4HGjMv6wA4TrCU5wH
2t0J/yEE+timKORy0b00Q7paKNTrKO4fiYE3yEg48AHFNzjOIOmuPOJDffX/9imb
4RkGNUBQLqgvUr8fMvzhqmH2yL39UnGW9j50TBnwfXH0GetHv/o=
=PY3U
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
