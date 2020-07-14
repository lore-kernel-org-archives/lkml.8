Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 255F322225
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW7IjMJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGNLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgGNLxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:53:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECAEC061755;
        Tue, 14 Jul 2020 04:53:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so7485442pgg.10;
        Tue, 14 Jul 2020 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gcGnZKmOcvQR6JjKvFpEHmamTFte6m24wBtwFxccrg0=;
        b=dW7IjMJ+MmtbcJCvGERY0fKKNbNVEGpkKBt+QKvOfV0raXbPhVTdFJ15c/F3EoMOIP
         W4MHVxHoT4KPT7wGpNjkaDIQukZDXFi4F0SVN37jGB6Whhkqiwv0n2nBh7pDpwhK7+pz
         tk+U2ekQl+BcEDcPa2jbD71DoBFYUn2P+BR16yuEjZkMYk/hd8vmnrd14m1iLp4Xehxw
         Rk8CAED+knH/QWR56T1mqzlzRogmossepTgGXfJ4g9LVg4l5gB9IGbTkggVAamBtuYIa
         RoVYRy1KiEuE9cACMIHEJy/c1yDRnZpQpukkFab0flTzgQuTfHPgltSfrdgHc3TCv5+7
         O3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gcGnZKmOcvQR6JjKvFpEHmamTFte6m24wBtwFxccrg0=;
        b=m9gZy51EYxwWAuEuJFR/yo00dfl/HG9d+1HzyTQ3lxszwm7Tqm+qWoIkyM9nIlYe9m
         OaMwaTNLlYDIWTqXxdPvusfo4Jw+tzVVYJUENyfd/0LATGqbPRLrfjW04TQl9K44gQa4
         aEov7R9E6LOAIUbGb+xt98ofjIdwJ7aafMmVRdQMpgbyXWSsfiFcv5WjL0EscQFTsF5+
         pORt0aFX1NhrZBZozqhnVwh0jxx3UAtkJYRRASIIUfPuV5tk75SxbNv33QnbfqeBPIGa
         WljBpGcZHgTQ6lrgXo/WFi4M3AJcxfD9hOz5kcle9/otzT4QGu8Tk6nrB4qcg8GAfRMR
         /a+Q==
X-Gm-Message-State: AOAM532jd0Mxlj+8VAQjtJtph8TKh0rIcx7AVfLWId5ejC18r8VLSmll
        O771HJxVL6KtD4v+Gp9v9Xs9Ge35rJNGIA==
X-Google-Smtp-Source: ABdhPJywmZS6ncd1jBuKpSljjO3Vp7b56juxOhpBOrNHard4BbokAUPnYhvuCgxRyl6ffJe4zXo5/g==
X-Received: by 2002:a62:cd0c:: with SMTP id o12mr3951843pfg.70.1594727586628;
        Tue, 14 Jul 2020 04:53:06 -0700 (PDT)
Received: from blackclown ([103.88.82.145])
        by smtp.gmail.com with ESMTPSA id u8sm2480068pjn.24.2020.07.14.04.53.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 04:53:05 -0700 (PDT)
Date:   Tue, 14 Jul 2020 17:22:49 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] USB: Remove pci-dma-compat wrapper APIs.
Message-ID: <20200714115249.GA8563@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
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
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

@@ expression E1, E2, E3; @@
- pci_zalloc_consistent(E1, E2, E3)
+ dma_alloc_coherent(&E1->dev, E2, E3, GFP_)

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
 drivers/usb/host/ehci-pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-pci.c b/drivers/usb/host/ehci-pci.c
index af3c1b9b38b2..71ec3025686f 100644
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -124,8 +124,7 @@ static int ehci_pci_setup(struct usb_hcd *hcd)
 		case 0x005b:	/* CK804 */
 		case 0x00d8:	/* CK8 */
 		case 0x00e8:	/* CK8S */
-			if (pci_set_consistent_dma_mask(pdev,
-						DMA_BIT_MASK(31)) < 0)
+			if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(31)) < 0)
 				ehci_warn(ehci, "can't enable NVidia "
 					"workaround for >2GB RAM\n");
 			break;
--=20
2.17.1


--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8NnIYACgkQ+gRsbIfe
746pMRAAgh0C4G7yswFeFhknFnQoPRapRiqqXFb0kUimI5bl/yqvpdeJjzU37woq
AXbP5yLLJCYkWsw2aJzuVrsB3Dj4MJ77+nWSx7iLwUp+0ys/9mf/bDoPD7EB/RNG
EQymoql8dc1aSO3kIJwHzKe3CZ99gW8y0GONMoKuXtmJljbCrNVPOK9yV2YAzDTJ
HRJ5n0xyKu9q8cZ0+uK2Hj48sDVragz+qmTZPdZCaGRr9dDwKO8hq5kn5yprbRsH
ctj2UsJcgY+zWEZHbUQhBd91QrFNezMN62STle0HYOXar79dMxuNv5sTaMPgVd09
30MrjTBm1dgkBKQlaUrAx5BmS6mVlilnYQEByBHlJaeHQe4aGr92z438dPZqDSNS
SiukbO+R6r5fQY87U0/Qeu6J8rVbNBjQJPzl1BgHV4VWrbgeA9v2r010qTtMNYPY
emqCyrDJ0lQQaDA3qD8NUCRX/+W+50tDljbvRoxxnjoVpJmo0EZiN84sQ+R119ms
UZY8fMXcLDbrKf5wTpg3Cf/SnVE8IAr3vXHFquzf5CFoCK/sU9muOiVbpPtxYu6S
OSDjtLEWvNN7TdB7CL8fq9t1mCoj/YZFjty1N2+poxlRKy6WPUdy0lRqzUBGH3ee
liYhecVR+SyexL69Vf04oE0DoMPG6M4Y8XIrU3YeDgKpR5COn5Y=
=DIFZ
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
