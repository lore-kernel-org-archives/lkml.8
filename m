Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F9EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60ACA21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942100;
	bh=bowaRiHwIq+KBj4KPgpBFge6RdbJxJTdfm47V3GMM0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tBcD8EwKAgRhlgpnSuHgMRLeTFRWunx1DiBhxfuM2I4+nJK0DxUeEWR85xXaAyZMs
	 NTcFHPzvjE5rkhH7VaZK4ntA0JU/zKjq2CFxRIK7HY6TJBrI0ZDswa61khPI5WVHvH
	 h0vrEYefM6HV+cUUggnUNLVektPAVfW5IWlRQ9qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgEHMsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgEHMsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A538321473;
        Fri,  8 May 2020 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942089;
        bh=bowaRiHwIq+KBj4KPgpBFge6RdbJxJTdfm47V3GMM0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmNOcgPoD2vxHgd18A93+Zv91yqzSw2n4RKv9odBu4SoeT9gTEL9x18hqquR8uNSa
         44WgbfWwL81mZMT9ALsT8SPNrgA246Z7jY9z4Ctp1vx4T6jonVOqZ5HIfx+7OqChya
         r/D7cmSSunjBjvoWpn1Ma90SxetRjZhBXoovUDf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 292/312] net: ethoc: Fix early error paths
Date:   Fri,  8 May 2020 14:34:43 +0200
Message-Id: <20200508123144.909944189@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 386512d18b268c6182903239f9f3390f03ce4c7b upstream.

In case any operation fails before we can successfully go the point
where we would register a MDIO bus, we would be going to an error label
which involves unregistering then freeing this yet to be created MDIO
bus. Update all error paths to go to label free which is the only one
valid until either the clock is enabled, or the MDIO bus is allocated
and registered. This fixes kernel oops observed while trying to
dereference the MDIO bus structure which is not yet allocated.

Fixes: a1702857724f ("net: Add support for the OpenCores 10/100 Mbps Ethernet MAC.")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/ethoc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1088,7 +1088,7 @@ static int ethoc_probe(struct platform_d
 	if (!priv->iobase) {
 		dev_err(&pdev->dev, "cannot remap I/O memory space\n");
 		ret = -ENXIO;
-		goto error;
+		goto free;
 	}
 
 	if (netdev->mem_end) {
@@ -1097,7 +1097,7 @@ static int ethoc_probe(struct platform_d
 		if (!priv->membase) {
 			dev_err(&pdev->dev, "cannot remap memory space\n");
 			ret = -ENXIO;
-			goto error;
+			goto free;
 		}
 	} else {
 		/* Allocate buffer memory */
@@ -1108,7 +1108,7 @@ static int ethoc_probe(struct platform_d
 			dev_err(&pdev->dev, "cannot allocate %dB buffer\n",
 				buffer_size);
 			ret = -ENOMEM;
-			goto error;
+			goto free;
 		}
 		netdev->mem_end = netdev->mem_start + buffer_size;
 		priv->dma_alloc = buffer_size;
@@ -1122,7 +1122,7 @@ static int ethoc_probe(struct platform_d
 		128, (netdev->mem_end - netdev->mem_start + 1) / ETHOC_BUFSIZ);
 	if (num_bd < 4) {
 		ret = -ENODEV;
-		goto error;
+		goto free;
 	}
 	priv->num_bd = num_bd;
 	/* num_tx must be a power of two */
@@ -1135,7 +1135,7 @@ static int ethoc_probe(struct platform_d
 	priv->vma = devm_kzalloc(&pdev->dev, num_bd*sizeof(void *), GFP_KERNEL);
 	if (!priv->vma) {
 		ret = -ENOMEM;
-		goto error;
+		goto free;
 	}
 
 	/* Allow the platform setup code to pass in a MAC address. */


