Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1898FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E243E20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410264;
	bh=iKjqdQ3xF9xmP29Ev2BGUdYr1kdrt+juC44ZexWRT4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a2BJK0rcbs4Kxte4Y95Ohx57TcqvDYMkz8vWwcF5hhn1FIcmIxVOE213Kwb9UH3l/
	 c58ZPVz/4DhQu+cPjubOrvuD1S6kWJwbx7lzgWBaC94BCsC4K+y9mNx9v6Fs+nnd2Q
	 nPmYWCxF97huss+o+o12lavZtfMHF7RPk+7ScQCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbgA3SvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbgA3SqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A932B20CC7;
        Thu, 30 Jan 2020 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409971;
        bh=iKjqdQ3xF9xmP29Ev2BGUdYr1kdrt+juC44ZexWRT4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k21A9rmnCrpXn4YilQ7XVhgscnhLNgid5jCRCZoT7LTxjRzkryXceCswfdu6rz9Os
         EjfeghR37YnKZQtwGa2YGAjzNbwmbd1WiGMe1ScBvYCXiQAx/dlrBvdJS2z2EUMa32
         KwT+bzunG+9lzVtMlbAPKo2CxAEFh0genIf7DEe8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Alison Wang <alison.wang@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 106/110] crypto: caam - do not reset pointer size from MCFGR register
Date:   Thu, 30 Jan 2020 19:39:22 +0100
Message-Id: <20200130183626.004894950@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

commit 7278fa25aa0ebcc0e62c39b12071069df13f7e77 upstream.

In commit 'a1cf573ee95 ("crypto: caam - select DMA address size at runtime")'
CAAM pointer size (caam_ptr_size) is changed from
sizeof(dma_addr_t) to runtime value computed from MCFGR register.
Therefore, do not reset MCFGR[PS].

Fixes: a1cf573ee95 ("crypto: caam - select DMA address size at runtime")
Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: <stable@vger.kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Alison Wang <alison.wang@nxp.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/ctrl.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -685,11 +685,9 @@ static int caam_probe(struct platform_de
 	of_node_put(np);
 
 	if (!ctrlpriv->mc_en)
-		clrsetbits_32(&ctrl->mcr, MCFGR_AWCACHE_MASK | MCFGR_LONG_PTR,
+		clrsetbits_32(&ctrl->mcr, MCFGR_AWCACHE_MASK,
 			      MCFGR_AWCACHE_CACH | MCFGR_AWCACHE_BUFF |
-			      MCFGR_WDENABLE | MCFGR_LARGE_BURST |
-			      (sizeof(dma_addr_t) == sizeof(u64) ?
-			       MCFGR_LONG_PTR : 0));
+			      MCFGR_WDENABLE | MCFGR_LARGE_BURST);
 
 	handle_imx6_err005766(&ctrl->mcr);
 


