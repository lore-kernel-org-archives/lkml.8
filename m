Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61072C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34FAB205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnu3o+e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgGMOdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:33:08 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9850C061755;
        Mon, 13 Jul 2020 07:33:08 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so6086584pfm.4;
        Mon, 13 Jul 2020 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=64N8ajKPQ1vBpOMBvGwdnl++9di4450VUjADg8oTM3Q=;
        b=gnu3o+e28aD/jJDGN8pZ4qsyWOFZWl/4dnKr/JDTjGBvNghPIyJ1MEvjQwD9Bl8mcJ
         I8ZSHSqYG1wGbmXJQGRT5qv8kEFdN1Q6nOC00BkydiG4r0rTVfVc+8HHRoXhmGmCkWrV
         aSSBFarnQkhg06U4dAgPCKbQyE5+ncptD2VZtHF/ezs3NF2sRNKhOzCpeLItUKZxUSy1
         M/bNeSG5A6MnpTlsaj+sWTsNOh0Azvmq4m45tBN8Ys2Xvt3cnGjSj/NJBk0co3Gy4dmz
         weHJDl8bBm3u3P8G7r6MKISQ+ur5/rhmJzaYBOIDF39NlyrdHEaBNw+lXaNo1EIKD+jG
         YHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=64N8ajKPQ1vBpOMBvGwdnl++9di4450VUjADg8oTM3Q=;
        b=CupwbIugOTMhlkqi3cYpEi6lLQyokkaZMwQZ/Jm/SAoBQSYINqNKF4mgWYuN8fEBK3
         Nd2MEsfkyADWnWc3SQ2c2kaFFVirZrmFzoEDr7VjoGBv405rd3gyewFVBGg+41XQQM8m
         zRSm/IXhiiT/oS++BCRoC9p5gfx6le2PEIb6Xe38XGMUNUF2MCkqwmGeut3BLJERVxi0
         xKZ748gku2gli83s+OfeEpLJnCMUUaMO+g5KkXdDLSTr9wt62C0Oi68f9CWU4l3eWhTE
         Nw5HeJEhibr80Zv/c3FlBkBnyfOHGEXT23vP1sTM3naMNGb40oLK0QXFTcFvz7Qn3HZP
         uO2w==
X-Gm-Message-State: AOAM5317ZGE037TzJ1saVckkpHPwl0qUON7+yg0mjnuVix+8SSPdcHjH
        vACxWkC4yJJiNISE/Vl6fUY=
X-Google-Smtp-Source: ABdhPJxHThv3eBgMu7kxLLJoEQ+q6EDrylQALkR9gGd7yJ6o7hKCm8Aw7TMjtHr0F8UJgMMYQbeJ1g==
X-Received: by 2002:a62:640a:: with SMTP id y10mr186933pfb.190.1594650788159;
        Mon, 13 Jul 2020 07:33:08 -0700 (PDT)
Received: from blackclown ([103.88.82.220])
        by smtp.gmail.com with ESMTPSA id p10sm13608743pgn.6.2020.07.13.07.33.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 07:33:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 20:02:53 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, christophe.jaillet@wanadoo.fr
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] staging: comedi: s626: Remove pci-dma-compat wrapper APIs.
Message-ID: <20200713143253.GA14953@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The legacy API wrappers in include/linux/pci-dma-compat.h
should go away as it creates unnecessary midlayering
for include/linux/dma-mapping.h APIs, instead use dma-mapping.h
APIs directly.

The patch has been generated with the coccinelle script below
and compile-tested.

@@@@
- PCI_DMA_BIDIRECTIONAL
+ DMA_BIDIRECTIONAL

@@@@
- PCI_DMA_TODEVICE
+ DMA_TO_DEVICE

@@@@
- PCI_DMA_FROMDEVICE
+ DMA_FROM_DEVICE

@@@@
- PCI_DMA_NONE
+ DMA_NONE

@@ expression E1, E2, E3; @@
- pci_alloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)

@@ expression E1, E2, E3; @@
- pci_zalloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_ATOMIC)

@@ expression E1, E2, E3, E4; @@
- pci_free_consistent(E1, E2, E3, E4)
+ dma_free_coherent(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_single(E1, E2, E3, E4)
+ dma_map_single(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_single(E1, E2, E3, E4)
+ dma_unmap_single(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4, E5; @@
- pci_map_page(E1, E2, E3, E4, E5)
+ dma_map_page(&E1->dev, E2, E3, E4, (enum dma_data_direction)E5)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_page(E1, E2, E3, E4)
+ dma_unmap_page(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_sg(E1, E2, E3, E4)
+ dma_map_sg(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_sg(E1, E2, E3, E4)
+ dma_unmap_sg(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_cpu(E1, E2, E3, E4)
+ dma_sync_single_for_cpu(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_device(E1, E2, E3, E4)
+ dma_sync_single_for_device(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_cpu(E1, E2, E3, E4)
+ dma_sync_sg_for_cpu(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_device(E1, E2, E3, E4)
+ dma_sync_sg_for_device(&E1->dev, E2, E3, (enum dma_data_direction)E4)

@@ expression E1, E2; @@
- pci_dma_mapping_error(E1, E2)
+ dma_mapping_error(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_consistent_dma_mask(E1, E2)
+ dma_set_coherent_mask(&E1->dev, E2)

@@ expression E1, E2; @@
- pci_set_dma_mask(E1, E2)
+ dma_set_mask(&E1->dev, E2)

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
Changes:
	v2: Converted the GFP_ATOMIC flag to GFP_KERNEL to suit for the
	context. On reviewer's advise.

 drivers/staging/comedi/drivers/s626.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi=
/drivers/s626.c
index 084a8e7b9fc2..e7aba937d896 100644
--- a/drivers/staging/comedi/drivers/s626.c
+++ b/drivers/staging/comedi/drivers/s626.c
@@ -2130,13 +2130,15 @@ static int s626_allocate_dma_buffers(struct comedi_=
device *dev)
 	void *addr;
 	dma_addr_t appdma;
=20
-	addr =3D pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
+	addr =3D dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
+				  GFP_KERNEL);
 	if (!addr)
 		return -ENOMEM;
 	devpriv->ana_buf.logical_base =3D addr;
 	devpriv->ana_buf.physical_base =3D appdma;
=20
-	addr =3D pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
+	addr =3D dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
+				  GFP_KERNEL);
 	if (!addr)
 		return -ENOMEM;
 	devpriv->rps_buf.logical_base =3D addr;
@@ -2154,13 +2156,13 @@ static void s626_free_dma_buffers(struct comedi_dev=
ice *dev)
 		return;
=20
 	if (devpriv->rps_buf.logical_base)
-		pci_free_consistent(pcidev, S626_DMABUF_SIZE,
-				    devpriv->rps_buf.logical_base,
-				    devpriv->rps_buf.physical_base);
+		dma_free_coherent(&pcidev->dev, S626_DMABUF_SIZE,
+				  devpriv->rps_buf.logical_base,
+				  devpriv->rps_buf.physical_base);
 	if (devpriv->ana_buf.logical_base)
-		pci_free_consistent(pcidev, S626_DMABUF_SIZE,
-				    devpriv->ana_buf.logical_base,
-				    devpriv->ana_buf.physical_base);
+		dma_free_coherent(&pcidev->dev, S626_DMABUF_SIZE,
+				  devpriv->ana_buf.logical_base,
+				  devpriv->ana_buf.physical_base);
 }
=20
 static int s626_initialize(struct comedi_device *dev)
--=20
2.17.1


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8McIcACgkQ+gRsbIfe
747WIQ/7BdADpPXhYh4IdHYtyRfgR/Kma0OpFegNzOM2kJ5I5c9VX0g90U2ZQCVS
JYO/OgeJDFcj3fdX6JnN2cTTh5UItDsQeh0m35KXqUk1F2AxyPb63DyweF15z53U
sQA9w/o6xgTgcjTpUI83QyllrVbJ0gwYvN59nTenZYPE0j2lvkbnEURDjaziFrkt
z2TQfpVoxNCgGYdkO310R5qFpEaJj/pVtx1ZENI+WPYD0gQ8ywSDyhdN5IBX6RhZ
vqjv/A6LnbBuRg7A9JwmR4eJa9l4DIAfom4rJjk4t2KDHLz2sbNbsPS/G2xPhCVY
cqxqLVqRkWbTdgs8wmov2BAZDV2ZIAGA3jhLz1Ug/oMxBAeUgGSevwTTBcoQfXkq
wwMW8lJ58htd7Fiv96Eti+rzPz0CQRZvOF8zKiQIllAqcInm7LcoooKK8JGREvI8
PVrRk8Qq7XW+FwQP+RVDnLoJp7YIAWa7vpaKgWZR6cKs/cWAbyhUorn8KLT8qRx1
LGVsR0RVP5IQj1U60h8hlpN0Z09/nfBMMLand81mjOQzFl2KD30z0g+A4n0Lcsei
Kfdnez8/h75g+r109BrfCEv/LZWBjTPlkO4rVpcEv2pxlyOXXogIxjezcRxNG3cY
5aQQo6vfWUVPCVTXOhSeh5hM3p7W53F3B0l5o9VypIOTQ9pcmME=
=fF19
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
