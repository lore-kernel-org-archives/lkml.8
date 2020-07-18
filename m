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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410E4C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166A52073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5XRWCDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGRPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:40:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147CC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:40:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so7921088pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QC6uaWR6dusie0wlT5R1j0hRjcwCtYQTVPNPMCj1elU=;
        b=u5XRWCDEwVNvRlYCeFYHCCtYBeHFm3mH43DbR2tvhNuk3lyFOydU6bg09nFt430Dcc
         Ax8NNB9KYRwFp7C9gIrBQpDZTn+4cLLUFeuwKI98a52sWKrup9+8fdiYh0yJLZrTgL9y
         il+gx6cpkPK5ZUqiO7ugZ3vaE7vuLskXrLuGSUN46CZlYi7poBB2ITKrV4TWRKEYJocm
         GX1OY7fggtj8UHVDgo2uWRjzGcdMDC2cw1EKhTyI2iTTuAJe0S/7DmwUlyJ7RLF8WMle
         arkQgxvLKV3/sLe5hHsTvDqcBVOqwxADewXZTl8LeSo+XJhc3j2nINrwpQ1J2XWvBCOs
         iu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QC6uaWR6dusie0wlT5R1j0hRjcwCtYQTVPNPMCj1elU=;
        b=EmgCyw+qNgcC7UJ0NcZTA8tY/36a5n3BIPdSFPKulPc4f9HN4bbiuCiCWAo8wpFmK9
         NRGYp4UaK8+mQ92B47UAfuT8SKlZwsKNaG/YS0EdQglkHYxSSs0xlBvQUwUICkNqTC4E
         cTy2peak8cArQpoXmwkOiQ+/grtuGIQjtE27+JKvTzOn1UoRE3ghUSsejpjcJtGlJZN1
         srqGvQilXnKVAg/TlSXrEvGkH/mh6HYez+C3oUDaQGr1n91puooK8XLE3NvBMotfe6m+
         z2L/V0qqL2dNp+VMvAWSx8nqzF0uxEEHAppiDGlKCpJpaJLQR5cDCoQnVAUMeZJ911s/
         yW6g==
X-Gm-Message-State: AOAM532vCqV7BdInA610LEcMnaYR8Rtye/b3qU7b0nA8ANzTBdZ4u4q4
        UpzspXByWwjvwqVzybIbCTtYyhnCPvzlAQ==
X-Google-Smtp-Source: ABdhPJzh4ZFaYN9tEEiDLgn+AhUuJH9a0GEgjpvjHHnol+xqa6XewBBT431QVimiM0ZfbB0ZPkJuuQ==
X-Received: by 2002:a17:902:a981:: with SMTP id bh1mr11857962plb.280.1595086842407;
        Sat, 18 Jul 2020 08:40:42 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id 17sm5956823pjl.30.2020.07.18.08.40.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:40:41 -0700 (PDT)
Date:   Sat, 18 Jul 2020 21:10:30 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rts5208: rtsx: Replace depracated MSI API
Message-ID: <20200718154030.GA28042@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated pci_enable_msi with pci_alloc_irq_vectors.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/rts5208/rtsx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index e28e162d004e..b39d3f8b54df 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -310,7 +310,7 @@ static int __maybe_unused rtsx_resume(struct device *de=
v_d)
 	pci_set_master(pci);
=20
 	if (chip->msi_en) {
-		if (pci_enable_msi(pci) < 0)
+		if (pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) < 0)
 			chip->msi_en =3D 0;
 	}
=20
@@ -881,7 +881,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	dev_info(&pci->dev, "pci->irq =3D %d\n", pci->irq);
=20
 	if (dev->chip->msi_en) {
-		if (pci_enable_msi(pci) < 0)
+		if (pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI) < 0)
 			dev->chip->msi_en =3D 0;
 	}
=20
--=20
2.17.1


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8TF+0ACgkQ+gRsbIfe
747CGhAAnpA18/QVMvwQ9y5YMfOm81IHq7L/c/rnpI8bfFWCWBat+xEn4uiSqe51
1uB2eqGDr6Mzzd6V/ub9NUmA7ZBH8SABfHdzSh8jLo1V+Ql/yxs2chakIMZuTISb
kgliiEH262QBb5vgwyzaAOdx0TCubFBbn4RQyrs2qnKpIacsWeMzIpMMMJQV5bup
HonQeIXlXooL010HxI8lBfDYV7Ih+blrnAW09rfiwXvq5xZufT5tild5zMsjtUVo
gTzyWXY8Kvctx83c4e5HPkaeuYXG9/NA23pSKExtE0EWEvOyGvzX2n7rdHg0kfFi
und2xSVuLZnTVIhczKOnLB9m1KEfm2LBWx8/a7d9yCL+52CSHsiXeKKxvQ5qE6Ic
W2O97yhC8Wd2yFpY3Wh3AQ4jtXeACKUm4bxbDRdaOvQK6hYORQqosOJQ5hfiFHR8
NsVnj6jaEoK1ydDErwCEvoh2qo9N27m97eIpBUAWMwlU1GueQUYR+Gv4lFPSzoRb
kpp9B7VxhXfGgCf2NhcAztuM85JH8AZHUc31ezC4mtOaNU9JCunkJPQlFptRCsXj
SbjKASQMy7opzABOjPbMy82EO5jtAlk4kidsjlh2mHswI/VobQMvHh48YB47H5iv
/HWg5drO/V1zTboW9UiZ7vYaRBpxC7Wq4fx8HEc6nt+5zltZwfY=
=MFt4
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
