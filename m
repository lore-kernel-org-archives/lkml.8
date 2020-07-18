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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DAAB2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEGsFDVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGRNgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgGRNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:36:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD0BC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:36:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so6796836pfu.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 06:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hf1JlkYLKT1Z4ZHTIAJh4Na1qYAPsAkz6yljdjIDt2o=;
        b=bEGsFDVFOa/GO/5dvpcQ3fnipAJp3/sVkjMbf3aLVvV8oGwggcXOvPkVWzNYHVm2zG
         nvTY7VuRHwtUEXJ6QQPBkY4/pnJ76Rd8TQ2upkpObuL8XXVMKmxzrIJYG3AtzqL5FS8y
         n+POXa9uGk5BddZTYrl14aZDSu0fnKYFkfFf0HVwxgRxDbU5HmseHF2LhWVZTr7OKj5K
         HDm5mPq/APcpGCxmNUICfYFcs8u6tkM/xq/KpEx1vwN8ZoAjhhHGE6SYykrjpG2GVpIy
         e8scs4rwExsnhqO29GtYjmhhUzHw9gi+OLRYIOtAK/cPqjnntOLvSdGJ5DmLIOEhpXmC
         G8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hf1JlkYLKT1Z4ZHTIAJh4Na1qYAPsAkz6yljdjIDt2o=;
        b=dje+y6M420emn1NW24XIIVF/wKeJ7jyhjDCCB74pDorjtXAfh1y9Bd+Qh8MhDNDnR0
         Z9v++xjkYT3g6uULbacrcaNDXOShBnKIXYLq36veZKHZXTeolLpRuXVWCdvCN6dLL1lb
         te/pRSxBprVWcQX7s+CyGSLDus0m6heFNZrzUMuByddyOzD0ZvA4/ulJEFl1sXXJAleN
         iUfUYgEzNUowDra4YepxczH8Se/Uq+bsWXswxkp2npw1w6YGyNDTGCf4j9W1dU8rPxVe
         uqRctchtg7LmCR/S82doZNFo+xpkxQJ9Hk6Tw53qt8oYtRulpgmLTL7PyqGO417jMb+U
         nOMQ==
X-Gm-Message-State: AOAM530YZvxVR1oNc5S4tht9QwVes6LOYSwSg6+hehTA39bBOjyEnRLy
        Lazkksnc4wA8MyDQdRXDVEFhGwPnWGq7Cg==
X-Google-Smtp-Source: ABdhPJy4LoGIB/Dskjj5ges98ogVIQLWn5k29RGdbXVt3GaSg15jfcqzNFbu+J6NHP3Ou6ZRJwr7ow==
X-Received: by 2002:a65:67d9:: with SMTP id b25mr12728135pgs.311.1595079403038;
        Sat, 18 Jul 2020 06:36:43 -0700 (PDT)
Received: from blackclown ([103.88.82.25])
        by smtp.gmail.com with ESMTPSA id m140sm10610952pfd.195.2020.07.18.06.36.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 06:36:42 -0700 (PDT)
Date:   Sat, 18 Jul 2020 19:06:29 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: kpc2000: Replace depracated MSI API.
Message-ID: <20200718133629.GA12522@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace depracated pci_enable_msi with pci_alloc_irq_vectors.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/staging/kpc2000/kpc2000/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000/core.c b/drivers/staging/kpc20=
00/kpc2000/core.c
index 358d7b2f4ad1..bf21cdc5546f 100644
--- a/drivers/staging/kpc2000/kpc2000/core.c
+++ b/drivers/staging/kpc2000/kpc2000/core.c
@@ -440,7 +440,7 @@ static int kp2000_pcie_probe(struct pci_dev *pdev,
 	dev_dbg(&pcard->pdev->dev,
 		"Using DMA mask %0llx\n", dma_get_mask(PCARD_TO_DEV(pcard)));
=20
-	err =3D pci_enable_msi(pcard->pdev);
+	err =3D pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_MSI);
 	if (err < 0)
 		goto err_release_dma;
=20
--=20
2.17.1


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8S+twACgkQ+gRsbIfe
747C9w/+N/0Qx9ZzK/dQGEasiWXA8l34Sqz1DL3FNxdPoCWAOC/zgQclA4BQWrF/
hhfOcTJWPN7BbZigR57pWzHdAw2mCnHGFwS1IsWlY8UadYlHK6G5zkP8cxf0W9m4
IKf550lcnd2D3Q3PUI9oZIfO+lBe5f+2mc9nagcP2PSxJbcv2xMp7CTFA/NPz/Lh
BRL3bIxUodVdKu1X7GTwCR1OhqT8SY8Smyi5r2pp7QvPvIAk4FgyY78n4yBBGkvk
KDmu46uHVHqn2JMzYvKPR3l32OeXsLVMtlABnpSGeO20RVWIZUmsEb215NYYTG+Q
vpWv0+JkhsBZJrW5BcaCRj0dZ4KaVqJ4iHR9t77ZbGuu66BMw2szenbddiKfm8ls
+skEdCMsZjC6kH9RiRa7i/+6RueTr6rWu915ty+pRCEyLCsO1XDmZVVMGhkj2gnr
W9EDcOzYFcHbH0WobOzyBnvD8iVCeXowjYKDZgLMCO5VUknCIKauaQOmi4is13w1
Cgv1RQJK3IzZ3xmZcdaHt3BPcDrZe3KKgLORYUwTMxJ2Ba/FvDpDQeRi8t4CFMW1
6JJP+arDwU4ygwnI5nxeLshbIktS03LaxVz1zNtlLDJY/3EGDJMN3Q3JkpsWvNsH
NS+9kn6ELPx+PWYlM40Ggo0gBt/pL7JzrCNR8OuEFbPcemKdJZM=
=zo+Z
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
