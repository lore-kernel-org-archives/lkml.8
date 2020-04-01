Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D74C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E042063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759764;
	bh=xEilnWJ17LjYXpfYjIrLh48O2kZon12YRiOCLDFS4mA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X2dSzFT/ziCvIx0tAeNRNSGOaEjsf6oESM80gdBXbuPFZJS3ZmETB5+N6BIACJ1Xi
	 UBsT7FzFD0giFMD7Vqw4zvIJ1mvWX9CFW6sJplk8sGDYmPeH30Fl7GGGfcBnVvNb2f
	 3fGHfoJXjZK5OnS1tZqEiXWlB5epsDUik0RchZNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbgDAQtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:49:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388677AbgDAQnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:43:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FC6520787;
        Wed,  1 Apr 2020 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759388;
        bh=xEilnWJ17LjYXpfYjIrLh48O2kZon12YRiOCLDFS4mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wirpl6mGYTFFMRzdfx8QOlbxAHgOD0U4bVVSXMjoL0jyPmzXkg0/iXYAMR7us2CP8
         pqyZPC1ZfPJZwW6fJPGx8eeeQ29m3dmGTDokSe8rdNn9rjY4nnBjr9Cftar+yicM/4
         jpAZ5t5wODrcCTwe2mEpeVmIOYgvREwXaN9BCWao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 064/148] net: stmmac: dwmac-rk: fix error path in rk_gmac_probe
Date:   Wed,  1 Apr 2020 18:17:36 +0200
Message-Id: <20200401161559.861571306@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

[ Upstream commit 9de9aa487daff7a5c73434c24269b44ed6a428e6 ]

Make sure we clean up devicetree related configuration
also when clock init fails.

Fixes: fecd4d7eef8b ("net: stmmac: dwmac-rk: Add integrated PHY support")
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1362,7 +1362,7 @@ static int rk_gmac_probe(struct platform
 
 	ret = rk_gmac_clk_init(plat_dat);
 	if (ret)
-		return ret;
+		goto err_remove_config_dt;
 
 	ret = rk_gmac_powerup(plat_dat->bsp_priv);
 	if (ret)


