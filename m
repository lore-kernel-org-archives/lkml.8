Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02232073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608312;
	bh=KA/MyvMwJ+jw7ZYC4Oz1VoKvr9CaBEm6TUKSIkAN5ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIBiqlgbwoOhiQURUf9gyyj8lUEuFCOlVl02FD3ujPXTAKfGRyNIN54yx/qsY0zA2
	 orfZqn133BxIKe9ucvDlVuYTNzfQsshZca46i3B92s53nURlYUBh6fLu5Y3mxiNjTK
	 oa9OF2k0+I2Jksgn+3tvq/EEc//AzwvA/XP2690o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgBMPib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:38:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbgBMP3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:14 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9F62467D;
        Thu, 13 Feb 2020 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607753;
        bh=KA/MyvMwJ+jw7ZYC4Oz1VoKvr9CaBEm6TUKSIkAN5ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2bfN7QSwTNLy0oJ2oRNJePWDLfngexqF1FuNtRpADSgZDv/sfGNnEnrofqVF+vyN
         oga3XihD8H+3AAdwv9hL3Z52QXB2o3thh9meaIam/6Ed0sC7bRT9a/+NiaFHJeNqb7
         SrXHAL1DeRZzMhWbljvphUzVOAk/tyOcHIrxvxRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.5 098/120] crypto: caam/qi2 - fix typo in algorithms driver name
Date:   Thu, 13 Feb 2020 07:21:34 -0800
Message-Id: <20200213151933.989219152@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horia Geantă <horia.geanta@nxp.com>

commit 53146d152510584c2034c62778a7cbca25743ce9 upstream.

Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamalg_qi2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -2481,7 +2481,7 @@ static struct caam_aead_alg driver_aeads
 				.cra_name = "echainiv(authenc(hmac(sha256),"
 					    "cbc(des)))",
 				.cra_driver_name = "echainiv-authenc-"
-						   "hmac-sha256-cbc-desi-"
+						   "hmac-sha256-cbc-des-"
 						   "caam-qi2",
 				.cra_blocksize = DES_BLOCK_SIZE,
 			},


