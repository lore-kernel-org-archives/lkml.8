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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BCCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF492075F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 13:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE8Ko1Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgGKNQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGKNQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:16:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFE4C08C5DD;
        Sat, 11 Jul 2020 06:16:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d4so3785150pgk.4;
        Sat, 11 Jul 2020 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zWPFWZ7nY1yjdraK2wS+KgXEaieNv2NevddKOt7JQVc=;
        b=bE8Ko1ClEYTQBL3sYEndGbLZzLBfu0J0T4sgcj7bcNZ3cb42+oeM7Ub5vJXLvVDmHH
         OMyN3JXUHVUYShw9HZ5W6KiaMxz8kPF917Tl9nl1Ez9/HLSrhtJiOgmq/fVqfLPp1UBp
         5Rax4YpgPK3MDT67P/724UyGiv5ILwSU9385zAeUQuiMykw2ln2TaoCBoMoIhAeoLWWa
         RFezY8tVZCa2Kp0bKX27YklDhdHI8746vVO5VkFclUNG20ng6Y4B/tcuwgKbcf13p3AS
         jBU+LqaPqop/u1ZlBYEASSsJkHJeVeFQ4fgNQGFz5Tt2VsaCQPDoEUtW0blXUkp2W+Jj
         +Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zWPFWZ7nY1yjdraK2wS+KgXEaieNv2NevddKOt7JQVc=;
        b=txDUA0j1kui3qgTnab14aam/xLFQrolmv8ybtXOg8TYHiEVEMkboiJKGInCkPvMN4S
         nc9GZ24GMlRN3Yy+inVVqdQ7ODk3aH/ge0wyV7g+mi8tIqJYe4ZGVvsg0ycHJYx7/qhv
         UPIDnyX94nKCB8uFkbbK1TY3drTWyH2cyck+R2kapAGyY+0dYrz1nG6OK+lXOoNVNuFX
         qwWWOZ2MepHF92KGJVw6hC/yHoDLCuidUiupU9kQlQ0AKyF2w9IP5nV1A4Es0sMaEctC
         llJWAMbc6YpolUOytnbtDbw5aOGZPQQpTS3vXkvoY62KdSawJV7ySHQjYUyRCv99QPUi
         TO7w==
X-Gm-Message-State: AOAM533ch5p2cu282JP3NIjeWcZI6KSM0/sQtjzJUFNcUXP8dMPHM3cf
        uEACgDzHxlsMFYIS8ab2TzwmHZdX7tggWw==
X-Google-Smtp-Source: ABdhPJxnZH3Ne7c9a6HuT6N1wRXeETGpJI4+TxMtrXVE9fLl/rjCbmQ+4oJFiuJeYvo1CwJpjChmIQ==
X-Received: by 2002:a05:6a00:84e:: with SMTP id q14mr67622989pfk.309.1594473398850;
        Sat, 11 Jul 2020 06:16:38 -0700 (PDT)
Received: from blackclown ([103.88.82.158])
        by smtp.gmail.com with ESMTPSA id k3sm8772212pjl.15.2020.07.11.06.16.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 06:16:38 -0700 (PDT)
Date:   Sat, 11 Jul 2020 18:46:24 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtl8192E_dev: Remove pci-dma-compat
 wrapper APIs.
Message-ID: <20200711131623.GA20537@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
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
        in the post https://marc.info/?l=3Dkernel-janitors&m=3D158745678307=
186&w=3D4
        on kernel-janitors Mailing List.

 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_dev.c
index ddcd7885d190..9f869fb3eaa8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1215,9 +1215,9 @@ void  rtl92e_fill_tx_desc(struct net_device *dev, str=
uct tx_desc *pdesc,
=20
 	memset((u8 *)pdesc, 0, 12);
=20
-	mapping =3D pci_map_single(priv->pdev, skb->data, skb->len,
-				 PCI_DMA_TODEVICE);
-	if (pci_dma_mapping_error(priv->pdev, mapping)) {
+	mapping =3D dma_map_single(&priv->pdev->dev, skb->data, skb->len,
+				 DMA_TO_DEVICE);
+	if (dma_mapping_error(&priv->pdev->dev, mapping)) {
 		netdev_err(dev, "%s(): DMA Mapping error\n", __func__);
 		return;
 	}
@@ -1282,10 +1282,10 @@ void  rtl92e_fill_tx_cmd_desc(struct net_device *de=
v, struct tx_desc_cmd *entry,
 			      struct cb_desc *cb_desc, struct sk_buff *skb)
 {
 	struct r8192_priv *priv =3D rtllib_priv(dev);
-	dma_addr_t mapping =3D pci_map_single(priv->pdev, skb->data, skb->len,
-			 PCI_DMA_TODEVICE);
+	dma_addr_t mapping =3D dma_map_single(&priv->pdev->dev, skb->data,
+					    skb->len, DMA_TO_DEVICE);
=20
-	if (pci_dma_mapping_error(priv->pdev, mapping))
+	if (dma_mapping_error(&priv->pdev->dev, mapping))
 		netdev_err(dev, "%s(): DMA Mapping error\n", __func__);
 	memset(entry, 0, 12);
 	entry->LINIP =3D cb_desc->bLastIniPkt;
--=20
2.17.1


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8Ju6cACgkQ+gRsbIfe
746PVQ/5AdOPy5H4YQEgLsRgxPsin6vIQ3UZ+Vr0vVs8wXO6/gwM3vRqzwC50E//
kHmoWWc90Fc1bnVigYowL3tjnwErmWei0OBX52r9bJV4aSAjiJNAXjVPeMps6z4G
ifOSG8gLacQBuEf+3E4gEKKwcXjaAqcOtO2mfEZLuwZEwBV3PieolxgomsfbfydH
ukV9yyNS4aVXyc0uH8VGQ0EG79xYeXBrmyYzrLVI5o+kzkduKwfDITLf7FNZd/5U
78yRnSvLuqb8c+g2b3TBVkc6wWPEArgAr8BQpIP6UdJ7KRt9pMk1ls8guoaNqc5i
1iu/md3xVvR9en4BuMTCfUQJwgVxgu7q95YhSYV/Wm/mY6ZaC2paay4sARJ9IdhH
cyWpopEMltqiRnhB4AaPYtkScvNRih4iEUdrPUWeL64bVLUaFQ16DVp6sxxwvRjX
vAaN6wKz6RRkxpJwWtA6lmRFcUvC2Xp3xxQdpgqpMTFzBhNlxoA7AkID0hiUpX5r
HCcLuKiQyzDi+tdVkHkcSLRyMI+jbylX1bWVb0MQ7mKvVNRgbGdhhoz8BV0GsUC0
frU3VT9e/qBxggOPHoGQwAjnI0+4DaB/xzfXF3b9ZbRJDT4VJ3/ZybmpYjpOMRCX
9XzrZLozt2KXFj2koVerZ/QsulfNWUuwfIwWQGHAI8u627LL4pM=
=jxWP
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
