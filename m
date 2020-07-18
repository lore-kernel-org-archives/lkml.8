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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3969C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6A820775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlG1QL4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGRPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGRPuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:50:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516D5C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:50:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so6888681pfi.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PU89rIZ7UicaR18/w3oKDai0PyxcTqFg/JkstWArQKw=;
        b=hlG1QL4BszVlDSU8mbGgFsI9e4IJf7XAZr8kJDvOXBYaZEHXTJ+W/JTlzbvLyRM5hd
         PG4XTKp0qMCyuHkuq/6pIOP3H/QWw+iFLc3y7q1EScxo8x+BbJXwF8mski5ALjv0m7sc
         wbvK93vjtblwEmR8Y5qcu8I9AmtZY71A9WXpKsgoxueDXZaxoLMqauUs0D1y46BSFtRp
         NnsFLVyk8fto8lqdACEDvX5nk/vqbsatjcN4K+BnM5H881ZlQk8AMf5vegHTGO3MI2wG
         x5U6sEkc4c7MI5t+PShqUR+889DN6wE+IJNmVUz7jPW3Haq7qDj4RNQW8GOgCDccnoye
         +EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PU89rIZ7UicaR18/w3oKDai0PyxcTqFg/JkstWArQKw=;
        b=hwZ2wYNbwvkwRlpdxyu8MPkEgO53PcWoMrdxPGjXkAv71JfVMkygMAouWSYQaIq86g
         pJvKYfcjoR+GIL6ZHumLf+47G4n67sZgEcD6T3Kq+ZsW7eOlVD/QifCjlL5SZJV4S0OV
         9g66kNb1N9yX977hcsIH+ixndy9AuZ5blisDHxOneVumGglgb17iQpJ4iyW80aHdeks/
         TvIAsBDb3PB8aBBVDeaxkFNC/4C6lW4wlFWy+toSRXIH7fet6QD4UxSeHbnoZXym9ktD
         UGaG2mPi246Yi/Bvb1RUhxLzB51Rovlnrv/u8LuYLsmnt39XgXGU+orm/e2xoK/uXgvW
         wXPQ==
X-Gm-Message-State: AOAM531YjZ4UzbIMw7KWTMrWKKhE6Qb5fLXfRzR12Zq3MeTbw9VGrCJD
        wYNiyG2XeSrNp7E+QBceYo0Tz4mGBmLmBg==
X-Google-Smtp-Source: ABdhPJyK6HBWXLxtHkvs/cIBSk8hjcHqVpv2FTRmqJIxuoPhUdC8pR1XR4J2Lu1TuMZjyUjIenvfkw==
X-Received: by 2002:a65:6645:: with SMTP id z5mr13182086pgv.123.1595087403546;
        Sat, 18 Jul 2020 08:50:03 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id b8sm4900270pjd.5.2020.07.18.08.50.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:50:02 -0700 (PDT)
Date:   Sat, 18 Jul 2020 21:19:51 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: kpc2000: Replace depracated MSI API.
Message-ID: <20200718154951.GA28857@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated pci_enable_msi with pci_alloc_irq_vectors.
And as a result modify how the returned value is handled.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
Changes:
	v2: Removed the undefined variable.
	    Reported by kernel-bot.

 drivers/staging/kpc2000/kpc2000/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc20=
00/kpc2000/core.c
index 358d7b2f4ad1..8339026ffb41 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -440,7 +440,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	dev_dbg(&pcard->pdev->dev,
 		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
=20
-	err =3D pci_enable_msi(pcard->pdev);
+	err =3D pci_alloc_irq_vectors(pcard->pdev, 1, 1, PCI_IRQ_MSI);
 	if (err < 0)
 		goto err_release_dma;
=20
--=20
2.17.1


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8TGh8ACgkQ+gRsbIfe
745NJA//RO45+2ZAODj98WtYa0DZkQvAHz/y+yO2eV8BTv4FFl3x2b+iajiyC+w/
gGObRdNsAJgsQ8ayyHAtIh/MVw0DCW5CKbXvaEu5HdgwSlVRN1rSqg2UCJAZb9XZ
a3/6e+L54JAtnf6mvI+1I4q0JI9Xvok19+lAFTesbikA/EP3E0e0S/8q/B7zkvPc
pcby0yFsOQK/b5rX/zKeQzLb2wMPTo1PnQv2atbXMuvAsL0PWB8J/kJMIG2sYvCh
+mh4E4q81+d1j0IYx0bttEGFjU7C4BoWlfXA05fZGHwgF+Ay3CVlON8upX3OfqM3
2nBsAVzvq4N03083usPys6iP1ueYvPNwfEIPrhfFU3JSeaQRlqu6XJ8tN73ZZF6Z
tx9hxZjLLa67wrhC5pxYhk6FJL8BoAf5X9U6WpUPssbVS2MU0Q5vzLsooPAMUO12
j2mQSuhRSD4BECHWKKG5mrbn8bG73h3xABNRQtiP5FJE358i8TYNUZFZB3Gt9n1W
jDPAjJwRApO2TmS/yT7hljLp5sRauxSU4vVKgXjBiQSi8POwdKeOodBiCT35TBSb
XfQ3SrURK1fDdHt01aphHvdoZi/FKqeGLJiSbFyjbM8LGs07ONX+qv+wi9GH3slh
AD6VqlsJPhdvAnlWjMvx3D/Gt2n5gVbKflJ99f/CTmaEuxwkgcY=
=IRn5
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
