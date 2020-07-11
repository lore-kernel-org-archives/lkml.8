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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B283AC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846C3207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZrUFjg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgGKNYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGKNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:24:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6DDC08C5DD;
        Sat, 11 Jul 2020 06:24:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so3791732pgm.2;
        Sat, 11 Jul 2020 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jkqCB6rwltR0PLW6W8Tf/AHK3b3SNSzPlhoy+LsjjRE=;
        b=ZZrUFjg9JsLOtJwsM3vKb1eaqYGELbv7jee35aOeLU3QPGrUVaVeFdGIcXcwRq5YE9
         cFzApdeIED2Fi44mi/B9mcUrtLg0azVeVWH2spQxARf7rai4f9+WZ1seB2Czp2YyIm/v
         v2EIfiiB4nGD8GPRiv8+g1bWsAv2YcY+31//Dfuz14lpA57tlCJLDYNqyT7LFKLBkuY7
         Z/XVBwqjyKlQUWuhlTK7AhbN8p/cB5kNRUEmvbD0O3dyG4MIg2uOhEJaPenfUfyhr1dB
         ssCum+VuRY1JkgDiNH9Iz7DZfFAYtcMimsefD/sWzwDYfJBdpLul5n8jEv3ELvkYxdme
         pVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jkqCB6rwltR0PLW6W8Tf/AHK3b3SNSzPlhoy+LsjjRE=;
        b=IdcYQAd35dg2zvN1tRqTd/ILCxv6czHY5wVZy19lK35925bABQDIniZLskmi0J1Dc+
         /7Vo/d0gNSTR/2KScdOvCGYjFjzmnyZECNJ6C4AiZRSpAnXZsQ9Vk0Ouwi6QIaIORnlI
         O/qPnhSP1tLVzVlq0EDkV/QizbZEdN/3yKDGWnfNvldRx2ds2CP2XZCG+tVdOq0komGB
         1x3jm26HeKthWsbeUlK2uaFNcr8+TDrgFRtpGAIqctzDK7tmoP+wqAC3648o6n+vUM0z
         BeHcBVNDuKAyY/n32n2L3HDbHOsd4MYUZ9fSD1R4tttJfjoBTugXOamVk7awzm7wSIWU
         SUyQ==
X-Gm-Message-State: AOAM533Zcr77eWdEWE2Xt8F5uMDW1kqxk75Si7yrHYVTCH17XdPEYsgn
        RjwUeU+MkQi2wxI4CmLEuGA=
X-Google-Smtp-Source: ABdhPJzT+zN0PGFENRNLHFFW4jYdeb/FC0muUJel0utJcv92/Mx31jCUQiU2Q3NcXEEe73lBz2vCiQ==
X-Received: by 2002:a62:86cc:: with SMTP id x195mr60095050pfd.39.1594473844011;
        Sat, 11 Jul 2020 06:24:04 -0700 (PDT)
Received: from blackclown ([103.88.82.158])
        by smtp.gmail.com with ESMTPSA id j36sm8826757pgj.39.2020.07.11.06.24.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 06:24:03 -0700 (PDT)
Date:   Sat, 11 Jul 2020 18:53:49 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtl_core: Remove pci-dma-compat wrapper
 APIs.
Message-ID: <20200711132349.GA21618@blackclown>
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
+ dma_map_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_single(E1, E2, E3, E4)
+ dma_unmap_single(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4, E5; @@
- pci_map_page(E1, E2, E3, E4, E5)
+ dma_map_page(&E1->dev, E2, E3, E4, E5)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_page(E1, E2, E3, E4)
+ dma_unmap_page(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_map_sg(E1, E2, E3, E4)
+ dma_map_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_unmap_sg(E1, E2, E3, E4)
+ dma_unmap_sg(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_cpu(E1, E2, E3, E4)
+ dma_sync_single_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_single_for_device(E1, E2, E3, E4)
+ dma_sync_single_for_device(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_cpu(E1, E2, E3, E4)
+ dma_sync_sg_for_cpu(&E1->dev, E2, E3, E4)

@@ expression E1, E2, E3, E4; @@
- pci_dma_sync_sg_for_device(E1, E2, E3, E4)
+ dma_sync_sg_for_device(&E1->dev, E2, E3, E4)

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
        in the post https://marc.info/?l=3Dkernel-janitors&m=3D158745678307=
186&w=3D4
        on kernel-janitors Mailing List.

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 71 ++++++++++----------
 1 file changed, 34 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging=
/rtl8192e/rtl8192e/rtl_core.c
index dbcb8d0d9707..fac58eebf263 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1558,17 +1558,16 @@ static void _rtl92e_free_rx_ring(struct net_device =
*dev)
 			if (!skb)
 				continue;
=20
-			pci_unmap_single(priv->pdev,
-				*((dma_addr_t *)skb->cb),
-				priv->rxbuffersize, PCI_DMA_FROMDEVICE);
+			dma_unmap_single(&priv->pdev->dev,
+					 *((dma_addr_t *)skb->cb),
+					 priv->rxbuffersize, DMA_FROM_DEVICE);
 			kfree_skb(skb);
 		}
=20
-		pci_free_consistent(priv->pdev,
-			sizeof(*priv->rx_ring[rx_queue_idx]) *
-			priv->rxringcount,
-			priv->rx_ring[rx_queue_idx],
-			priv->rx_ring_dma[rx_queue_idx]);
+		dma_free_coherent(&priv->pdev->dev,
+				  sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
+				  priv->rx_ring[rx_queue_idx],
+				  priv->rx_ring_dma[rx_queue_idx]);
 		priv->rx_ring[rx_queue_idx] =3D NULL;
 	}
 }
@@ -1582,14 +1581,15 @@ static void _rtl92e_free_tx_ring(struct net_device =
*dev, unsigned int prio)
 		struct tx_desc *entry =3D &ring->desc[ring->idx];
 		struct sk_buff *skb =3D __skb_dequeue(&ring->queue);
=20
-		pci_unmap_single(priv->pdev, entry->TxBuffAddr,
-			skb->len, PCI_DMA_TODEVICE);
+		dma_unmap_single(&priv->pdev->dev, entry->TxBuffAddr,
+				 skb->len, DMA_TO_DEVICE);
 		kfree_skb(skb);
 		ring->idx =3D (ring->idx + 1) % ring->entries;
 	}
=20
-	pci_free_consistent(priv->pdev, sizeof(*ring->desc) * ring->entries,
-	ring->desc, ring->dma);
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(*ring->desc) * ring->entries, ring->desc,
+			  ring->dma);
 	ring->desc =3D NULL;
 }
=20
@@ -1676,8 +1676,8 @@ static void _rtl92e_tx_isr(struct net_device *dev, in=
t prio)
 		}
=20
 		skb =3D __skb_dequeue(&ring->queue);
-		pci_unmap_single(priv->pdev, entry->TxBuffAddr,
-		skb->len, PCI_DMA_TODEVICE);
+		dma_unmap_single(&priv->pdev->dev, entry->TxBuffAddr,
+				 skb->len, DMA_TO_DEVICE);
=20
 		kfree_skb(skb);
 	}
@@ -1782,9 +1782,10 @@ static short _rtl92e_alloc_rx_ring(struct net_device=
 *dev)
 	int i, rx_queue_idx;
=20
 	for (rx_queue_idx =3D 0; rx_queue_idx < MAX_RX_QUEUE; rx_queue_idx++) {
-		priv->rx_ring[rx_queue_idx] =3D pci_zalloc_consistent(priv->pdev,
-					      sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
-					      &priv->rx_ring_dma[rx_queue_idx]);
+		priv->rx_ring[rx_queue_idx] =3D dma_alloc_coherent(&priv->pdev->dev,
+								 sizeof(*priv->rx_ring[rx_queue_idx]) * priv->rxringcount,
+								 &priv->rx_ring_dma[rx_queue_idx],
+								 GFP_ATOMIC);
 		if (!priv->rx_ring[rx_queue_idx] ||
 		    (unsigned long)priv->rx_ring[rx_queue_idx] & 0xFF) {
 			netdev_warn(dev, "Cannot allocate RX ring\n");
@@ -1803,11 +1804,10 @@ static short _rtl92e_alloc_rx_ring(struct net_devic=
e *dev)
 			skb->dev =3D dev;
 			priv->rx_buf[rx_queue_idx][i] =3D skb;
 			mapping =3D (dma_addr_t *)skb->cb;
-			*mapping =3D pci_map_single(priv->pdev,
+			*mapping =3D dma_map_single(&priv->pdev->dev,
 						  skb_tail_pointer_rsl(skb),
-						  priv->rxbuffersize,
-						  PCI_DMA_FROMDEVICE);
-			if (pci_dma_mapping_error(priv->pdev, *mapping)) {
+						  priv->rxbuffersize, DMA_FROM_DEVICE);
+			if (dma_mapping_error(&priv->pdev->dev, *mapping)) {
 				dev_kfree_skb_any(skb);
 				return -1;
 			}
@@ -1831,7 +1831,8 @@ static int _rtl92e_alloc_tx_ring(struct net_device *d=
ev, unsigned int prio,
 	dma_addr_t dma;
 	int i;
=20
-	ring =3D pci_zalloc_consistent(priv->pdev, sizeof(*ring) * entries, &dma);
+	ring =3D dma_alloc_coherent(&priv->pdev->dev, sizeof(*ring) * entries,
+				  &dma, GFP_ATOMIC);
 	if (!ring || (unsigned long)ring & 0xFF) {
 		netdev_warn(dev, "Cannot allocate TX ring (prio =3D %d)\n", prio);
 		return -ENOMEM;
@@ -1905,9 +1906,9 @@ void rtl92e_reset_desc_ring(struct net_device *dev)
 				struct sk_buff *skb =3D
 						 __skb_dequeue(&ring->queue);
=20
-				pci_unmap_single(priv->pdev,
-						 entry->TxBuffAddr,
-						 skb->len, PCI_DMA_TODEVICE);
+				dma_unmap_single(&priv->pdev->dev,
+						 entry->TxBuffAddr, skb->len,
+						 DMA_TO_DEVICE);
 				kfree_skb(skb);
 				ring->idx =3D (ring->idx + 1) % ring->entries;
 			}
@@ -2028,10 +2029,8 @@ static void _rtl92e_rx_normal(struct net_device *dev)
 		if (unlikely(!new_skb))
 			goto done;
=20
-		pci_unmap_single(priv->pdev,
-				*((dma_addr_t *)skb->cb),
-				priv->rxbuffersize,
-				PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&priv->pdev->dev, *((dma_addr_t *)skb->cb),
+				 priv->rxbuffersize, DMA_FROM_DEVICE);
=20
 		skb_put(skb, pdesc->Length);
 		skb_reserve(skb, stats.RxDrvInfoSize +
@@ -2074,12 +2073,10 @@ static void _rtl92e_rx_normal(struct net_device *de=
v)
=20
 		priv->rx_buf[rx_queue_idx][priv->rx_idx[rx_queue_idx]] =3D
 								 skb;
-		*((dma_addr_t *)skb->cb) =3D pci_map_single(priv->pdev,
-					    skb_tail_pointer_rsl(skb),
-					    priv->rxbuffersize,
-					    PCI_DMA_FROMDEVICE);
-		if (pci_dma_mapping_error(priv->pdev,
-					  *((dma_addr_t *)skb->cb))) {
+		*((dma_addr_t *)skb->cb) =3D dma_map_single(&priv->pdev->dev,
+							  skb_tail_pointer_rsl(skb),
+							  priv->rxbuffersize, DMA_FROM_DEVICE);
+		if (dma_mapping_error(&priv->pdev->dev, *((dma_addr_t *)skb->cb))) {
 			dev_kfree_skb_any(skb);
 			return;
 		}
@@ -2417,8 +2414,8 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
=20
 	pci_set_master(pdev);
=20
-	if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32))) {
+	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+		if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 			dev_info(&pdev->dev,
 				 "Unable to obtain 32bit DMA for consistent allocations\n");
 			goto err_pci_disable;
--=20
2.17.1


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8JvWQACgkQ+gRsbIfe
745NdRAApaDp2Mho03Q9fdMVKJ2j7zNLqX7Ow4YnNYk5pVGxu3DF/ER/G3Ke3IDO
UpCoXjQLOykIMkJOK4VK48sBgJ5XE2YrbL2azghcCfXy6N97JwcZNPoGsQhJObiv
MTCU5TPoPWOF7++yluvnAZY5voBdghA1MRK3Vcs/0twf5kTNQmEAVQHx/NezsV7y
vUzBFTJWM1G4fgAe6cLiCPbQ3FK0S2mdIv0oJn+qIbvLEEwhLyYtRrDmo+rIgqvk
YICkWbUOnNMQQXS8Hx0o6cbNdlX8+VjTWRRNmMxPkKzmYpVRsHdZG7W71oAontwj
VltKqj+lS6qGV+NBoOzeGa+VJPFvOL9MtB5LcOE3o8DAVzNKNsQLFtRVVlH+w4Ra
jv3uZM6se4UHOP8M5GJnV1Ks+ciwiSN68vRrVzbboygnB+zWzAwyGo+sSf7tw0k7
JCHCDFNyrBrNfM2OEMNZLYHZNleub3n6tKnoFmkQU0OPaW8QS04arltEIspWvTxO
1c2eYghSRbBl7tjH+LAQxXew3vKy/iBlAfHjw8lmVaDh95iYj82lQXPCgOKEEV4Y
0Up7taLy7LqIkjTZyJoqypzxp5Je05w0SjbHi8wVrfiDDMjfAkVG/oxnv9z1lPve
yMjDAFXIRV6jVE9AmTs04+KWNqlNALiLEWo6hBUehlf7bh33ygU=
=TBaA
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
