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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3F1C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270B221775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHbDVx18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgGSOMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:12:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF55C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:12:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so7481294pls.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ogVwZHcdoirAU1j5aR0/R3zuLNG50DzLDPM0lgRbRy0=;
        b=pHbDVx18hDCP66ockL+jzt3tIxQR2d7BiMDsiRDOzHkxDWa3YWsfh6YQqNv/43VRdQ
         U5Jyv0DNfjqeXUFPFt7XRR9Bd6lLF0hpDX4wNKj0jhf11/REXlV/g/6MkFJGET19C3So
         toGB/oX7+IhV4k5oX4ocOBxwFmoSMnROfzMTBC3s4jsovm5gJLo1cpia5E4B40PLiqmF
         SPIV54JbNzUudl44XjAIaqNO3qRFLX0zDUSxknkfAeYJRVK9zN6MccWCVbG05h622+RY
         zpXvuOs68pt17hU1Uhbcbra0nYOXLwo2JxuriPxTbfGgzBBVYmRn/dyOG5N/O31Mt+eB
         YqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ogVwZHcdoirAU1j5aR0/R3zuLNG50DzLDPM0lgRbRy0=;
        b=ASVT6OD0b1j9fc/yOxi7tMm4TzEpdK32UgTEOr1HbR0Wzmp5W8hN8yeTHSnbQO/5bm
         LGPQkw7VIDLBtWS6tLr2YkgsBVNfIkYaXydq8G2XndOqrUoF0IEE5z0gP+ncUK01ZSXw
         VMvLotbZ/QfF9pMXWLn1qwVkCCGWfgMLav8MHip+dYxYQFW5DGHDx/aecV4c/ynnsQ1v
         80CXzi8iJ980oE/2fZhp0jxmLqUdG1VABv1eAj1+GDTK6UiupEktYQ+fVMZUw4SvbRmk
         6B/EQ6fZ5+olPJ+9JemTUUMHCFdszYbW410wHWtxtrvrLRQQ7NjxYCyWMyXwT2V7m0GE
         cxyQ==
X-Gm-Message-State: AOAM532sPsAyJKQ9bDHpUzK+zoOEUmJxGLo8PSyStz+5q6aRCumo0Oxw
        alcP4gz4JCV1j0W3DYXCyDo=
X-Google-Smtp-Source: ABdhPJx/ffurpmql9buHT+Gdtm6H37Vtzjsxm8iMC+7SJKdFWkI3kqBDnAWvW9Fr6EtiU6C6Z8MNNQ==
X-Received: by 2002:a17:90b:1106:: with SMTP id gi6mr19925396pjb.2.1595167955993;
        Sun, 19 Jul 2020 07:12:35 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id n63sm13729104pfd.209.2020.07.19.07.12.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 07:12:35 -0700 (PDT)
Date:   Sun, 19 Jul 2020 19:42:22 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: kpc2000: Replace depracated MSI APIs
Message-ID: <20200719141222.GA29679@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated MSI IRQ enabler and disabler
with pci_alloc_irq_vectors and pci_free_irq_vectors respectively.
Compile tested.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
Changes:
	v3: Replaced the disabler for MSI IRQ too with
            pci_free_irq_vectors.
	v2: Fix the undefined variable error.
	    Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/staging/kpc2000/kpc2000/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc20=
00/kpc2000/core.c
index 358d7b2f4ad1..952ae8d11f9d 100644
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
@@ -474,7 +474,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 err_free_irq:
 	free_irq(pcard->pdev->irq, pcard);
 err_disable_msi:
-	pci_disable_msi(pcard->pdev);
+	pci_free_irq_vectors(pcard->pdev);
 err_release_dma:
 	pci_release_region(pdev, DMA_BAR);
 err_unmap_dma:
--=20
2.17.1


--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8UVLwACgkQ+gRsbIfe
745Kwg/+KnEBX5JUYavy8PIGoQzZPtbYO5gIERC0+9HCPlefafLbASc+n5Wo9S3R
Rl1ZETYkWCxTNZ2JCZh9qrw4TcGv1Yylcvb8XROmn7ntapKGItANj1olMg6tzsCx
Xjn0RuQYVqIaLv54wmroFTctCDRQB44DmldNm9AaBO2xjDBn2yJtxi92Q3Vp18GX
WWNjTUoMm1Xxuse+XGtrXhINXQuJhNAS6Iv5AKHG0TAGnixiWgnCjL4FLlZj/kMk
UG5uUJrS/kbzRYfG3VApMEG1w0LCtRzW6oARQjigJGl13JdDGAwCsi8d6myplLOz
nZ2bIWIolMlbCAiyIEPz7aD7qjHmyI5qOiDqQyu+J/k0w2gHlPIpjujpZrTB8gMO
KGFnfhZ1U+dLWOnn5FLWfpDTPJpGBxZelFW29hL7ifC2oEpfsCuceOm+8oz1CWtl
MPOU3xGLLO7EtbO68Y1iDO4+xndvquWPOEKLkhJvczFZlzC5rdVQR0KQTqxavtku
lqvV75GV2L0F48RiD4fnwoSgN/g2yN5GVbKbV4sy6UPsjyKxd2Nl9XYRBvvvvcOo
W8Z5V8UqVdJrA3h2GkGM0L+WvRaMhCj1VY9FS+BKIX9pVL+FAN0Mr1/SCmh652O4
fjIECnP8kcRrHMcl7gKK3WOqVfWLfgQz1ODbLZRQGC9LvK8ombA=
=1mL5
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
