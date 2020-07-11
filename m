Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD85C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BD82076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szfGIZb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgGKMfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:35:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE812C08C5DD;
        Sat, 11 Jul 2020 05:35:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so3344630ply.11;
        Sat, 11 Jul 2020 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=36WcEQAUH1mKZZkQq7Ag/oNpXtMLgwjbol+RbIVU1ME=;
        b=szfGIZb/K3Wsqmw1uVWSAPepQUrayVwnAQwtLFRXbVb8sJJ0/TutnVaczxzXRIRgPy
         7XDb3zLW88nICz7hS1VsY8g2jA2hnEgjzPgvMBmwsWeSGw57NuC/dytPw8HfTFyMAoCk
         JsoK/vF7UZ1pVLupcJ1zmYH7FbP3JOttpmyZoC8aFF7kHDRiJtI1cxHUcNI/2yUZFuaA
         45MmS5uahTscYkCzsRYP9DRH+ouuFf9mnZsPSvQZM2eUWwLiYxLDYkPJLDhhne/sdqnX
         x9TBPn0a3JYBduGG1kLt9W1a/VcBifv2Y8gV2zHHeAp9gmWHosCD7z753TeUR63mUHg1
         Zg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=36WcEQAUH1mKZZkQq7Ag/oNpXtMLgwjbol+RbIVU1ME=;
        b=FKjT86+aV0whqXQjBblnkEQELsNEMJQ76SdcL65AIrFe91ztI5mdbyY+bPYu4G5w3b
         dUOkltBaT+MHsXZr6K8bcHFonsFMvbY245gdnacGn/9jyhgv+pll+YCXVG3JrZvs11J3
         9MAXp92TGhTtAVv6cZ7I9z2k+sgC+QScZoNFeuMeQvsuuOL1Pe+1HuKhsIvbQm3wwTD7
         Lr0vEXPKKPa0aYhqBH3s/pWm/wC0uGb7Ikeo2bdwY02vjqmJcSOcE13sxd6nz2v0dM9+
         mL14cJI50GwtVW/Sy/u58nqKBPZbH5yT9XSEvmxUAm6pVhEXqbfpgqmidhIvf25+dKnq
         0mvA==
X-Gm-Message-State: AOAM530n6+W4ncS4f0/gpVFf9Vkiejk0Prdn/2+QndluzUIxFAgYBCH+
        ySuqZ8Z7Dmekw9EGQvuSKrU=
X-Google-Smtp-Source: ABdhPJzcy7LYLPaz+ONUlYoEzAUwBeSvrHUypYHJNfM7aQFTO4/iqIhcXb5yOEYYYZWq/U12uHbWPA==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr58265738plt.75.1594470949240;
        Sat, 11 Jul 2020 05:35:49 -0700 (PDT)
Received: from blackclown ([103.88.82.158])
        by smtp.gmail.com with ESMTPSA id b24sm8601682pgn.8.2020.07.11.05.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 05:35:48 -0700 (PDT)
Date:   Sat, 11 Jul 2020 18:05:33 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: comedi: s626: Remove pci-dma-compat wrapper APIs.
Message-ID: <20200711123533.GA15038@blackclown>
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
	This change is proposed by Christoph Hellwig <hch@infradead.org>
	in the post https://marc.info/?l=3Dkernel-janitors&m=3D158745678307186&w=
=3D4
	on kernel-janitors Mailing List.

 drivers/staging/comedi/drivers/s626.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/comedi/drivers/s626.c b/drivers/staging/comedi=
/drivers/s626.c
index 084a8e7b9fc2..c159416662fd 100644
--- a/drivers/staging/comedi/drivers/s626.c
+++ b/drivers/staging/comedi/drivers/s626.c
@@ -2130,13 +2130,15 @@ static int s626_allocate_dma_buffers(struct comedi_=
device *dev)
 	void *addr;
 	dma_addr_t appdma;
=20
-	addr =3D pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
+	addr =3D dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
+				  GFP_ATOMIC);
 	if (!addr)
 		return -ENOMEM;
 	devpriv->ana_buf.logical_base =3D addr;
 	devpriv->ana_buf.physical_base =3D appdma;
=20
-	addr =3D pci_alloc_consistent(pcidev, S626_DMABUF_SIZE, &appdma);
+	addr =3D dma_alloc_coherent(&pcidev->dev, S626_DMABUF_SIZE, &appdma,
+				  GFP_ATOMIC);
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

iQIyBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8JsgwACgkQ+gRsbIfe
7474BQ/4kb5fufct1WPXGSk5GazzpLTQpggErwbo+mTWR8xrR0hu0JEkSq3rlcJC
PlyH5wxUTm6AJM6ub8UbDbrIiFCoGvFW/wPKyBgdVFnkrEf5GbPg4QuGD0eEOegC
EDJ34j2meK2fPpOhvKh8I7mk/YXVl0uNB3CTul9GLzAC/NQG3GERX1g3JZsDo+Ib
5sNly1D6mRr2WOxaTOGGLK+JI5PXeQ5jT8x40Q6TwEfZNDFA1A6diStFLOAusNA0
txdSpArNNXJGjxSITQi7Gw4Ifp0g8MW0WnYjL/f4eYVqbGstVo6JYTjI+iwt1aPe
pJpQlNYlXmELft+vVFIq++I6/mIbdxuRjzOKI5e5FJ5/GQpU9nnxlCaW00/c3p0A
8ioeIhy0pI3JekPsDrw5pF5xUZZxXUbHiIxgzrts54g17isyQFwoh0mTnvmANlcz
LTVV9U0xjeQEc3btQMG3c6JWGQ2gpyFDA89Out1769HJvBpuWBzbytUtFVnTKizp
FFV+3c8RjyIih39KvNVE89zay2Y+EFSeiEl3oYhFX9digbSP+ErIQcu0YYaV4k+Q
FjIMZB1j/tBHshL5TwWbU20naZXbrmgReJkvdJwCb292ehp/kFDfV35VFi9qTJD7
D5TH075SMqXfsPrBMuZha868gzaO4dzfmiqAkZEcJ4QLNQ78Mg==
=YDlr
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
