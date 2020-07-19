Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CCAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E2422B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL8uP2hC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgGSOeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:34:16 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89420C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:34:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z5so9097514pgb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cGafgwhjZbI9rRStyay6bRCQergbF17/kauj57yW04s=;
        b=UL8uP2hCYUdNNJlk+Vzx7IM76dw+syvmMrQLtsEY8DyaRA2aNYZHbQO8UAj/LrBR8B
         jNDSJyEzSXLWNC5VCdh3uXt3X89nuo6YnvD0qfPhbBD3QxhiDOEKF2L/i2bWtkO6fboW
         5yfV/p6fswda0gvCTBX953g6rr6CUgO3OiIXXzF0nzA8wx/Jawdjl/iakEyv6B8fsTJC
         Jhd9pOrQuFIuf8ndWPyda/ArxyPDwFraPSuJZdd//OmCeT1HDBk2CCgOuW0QbeRnaD1m
         He8RsEj3Kz8kHCzAdKUSsKJQ/bFJ4Vdw8T+DzF2k4Kk+94ExoY9Wn6wItnznUuE1w9Bb
         rXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cGafgwhjZbI9rRStyay6bRCQergbF17/kauj57yW04s=;
        b=JEho50uZ5t8ogoFvV+zNOAyGIRhnUJUCW5GZZaN9UqD22omgwmd0vqO2HKNmygWoeh
         7nS6lfgc+g2DV/P0zf/txIwr2q7SPbL6JmoE/9xd7G/CH9XyxoW270yNrA0+755u3oEh
         Ya62X17/N5jeXNIu1v4AuE5Ql4lMzAW0bZHQgkCl4jPdL0ZhxQ+UnPwfesl3Cn/TswFj
         jW85UTW1YoPywIW2em22BuQH8UkjUHPPEIAbPo/5P7U4o5o7oIpcUWLCFdMIalke0G57
         SgaUzzCGrklftoezxBCUSNGklhPLNK3cKkprK26t3BCs4f53IP6c+6xXw5ok43fAVLaS
         2oKg==
X-Gm-Message-State: AOAM5315KHjANNooYkt9G1tOIKxRKlV8eA0EDggBxXTykohxZdtmvVs+
        U2GqNUgXClGhm29dDRrqM8o=
X-Google-Smtp-Source: ABdhPJxXJjkwTcPp6ikYmK99x//73VrfJdDZCPGlg20GSKcaUL3PeUoxwD7FkLb3tKUipNNE9KbStw==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr3899359pgh.309.1595169256065;
        Sun, 19 Jul 2020 07:34:16 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id y24sm14524807pfp.217.2020.07.19.07.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 07:34:15 -0700 (PDT)
Date:   Sun, 19 Jul 2020 20:04:04 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rts5208: rtsx: Replace depracated MSI API
Message-ID: <20200719143404.GA32519@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated MSI IRQ enablers and disablers
with pci_alloc_irq_vectors and pci_free_irq_vectors respectively.
Compile tested.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
Changes:
	v2: Replace MSI IRQ disablers too.
---
 drivers/staging/rts5208/rtsx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index e28e162d004e..898add4d1fc8 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -283,7 +283,7 @@ static int __maybe_unused rtsx_suspend(struct device *d=
ev_d)
 	}
=20
 	if (chip->msi_en)
-		pci_disable_msi(pci);
+		pci_free_irq_vectors(pci);
=20
 	device_wakeup_enable(dev_d);
=20
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
@@ -347,7 +347,7 @@ static void rtsx_shutdown(struct pci_dev *pci)
 	}
=20
 	if (chip->msi_en)
-		pci_disable_msi(pci);
+		pci_free_irq_vectors(pci);
=20
 	pci_disable_device(pci);
 }
@@ -594,7 +594,7 @@ static void rtsx_release_resources(struct rtsx_dev *dev)
 	if (dev->irq > 0)
 		free_irq(dev->irq, (void *)dev);
 	if (dev->chip->msi_en)
-		pci_disable_msi(dev->pci);
+		pci_free_irq_vectors(dev->pci);
 	if (dev->remap_addr)
 		iounmap(dev->remap_addr);
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
@@ -952,7 +952,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	dev->chip->host_cmds_ptr =3D NULL;
 	dev->chip->host_sg_tbl_ptr =3D NULL;
 	if (dev->chip->msi_en)
-		pci_disable_msi(dev->pci);
+		pci_free_irq_vectors(dev->pci);
 dma_alloc_fail:
 	iounmap(dev->remap_addr);
 ioremap_fail:
--=20
2.17.1


--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8UWdsACgkQ+gRsbIfe
744d6w//V5XT/RC+qOEq6QsxtGsxYRx/LbqqSuE8iTOoLupVtMnl+yuxzxOEFS4c
i/UVpZfWWd5WVSad0XoIcRfZuZwm8zxSA7/gp9CdBqHDJ3EYaqHfvxKt5443/lG2
pX/6OHWXiv2Pgh6C0wt3PzdA4BHjWh9PSLnbXACllDsFKYVLaeK7F68GrlhGbBi6
lPyPAX4B/LwqA7A12SwBs4YR0GA4uFzuK3L3MDwP+q5zNVrHA3D3BqOxitBuXUXi
RHmr67BzOUeXq2YOvRBNbZXV/JII4Csk0c3/SHxHejFV/zdriPyd6oEWl5x5VB7m
C44S0kRV712AVvw67GELkFoD58M0XRmu0pfvCyaVLnOOdkcq3ZmoZFzxa8lZX0Fq
6+SKuYAXV+debQgW/lkUcsSq70Dmgcj7YW57cJFy7N1mzBGQXln5X1OY5GrkjXMR
3E85kq5SzYJ0fQu2QDkcvzSAx0u1yY46yo1Zc80MBpvM+DQUKpfjNWaOR16L5Zmu
2A7CK0LYArcp59oEONt89F2qekAj0J8qFrkVKIzQhTGFq2YPbCjQTHh9DDoBhW/+
PKZ8mCgk91NRACZTPQAzXzzS2TWHtnWDEI3zS2J81HVG3VAq8MjuIFKBgy+IdKHN
1o2fNqVux1uqpuoiE9s6VnKlJ/BQc3nrOflDoSbAzbeYFBK+Gp0=
=2Oqc
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
