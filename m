Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EA0C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0011820675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645974;
	bh=TBcOzdlkBS4YbY4gK3VVWnQ8aiNxZfo4NGJlloFDJbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yn3w3YHbwVZ2olgL7hN/0AwpJpM641rc69dD6uhkhcy7TVeSaXY56e0F1apLwwYKq
	 0R1f/wOp1vHmNAUitVlaMIThce52q9qsWbEpjjKr6G8KMamJB3i1jKsvOCalC3Ef5f
	 NDe8SJssTIepfeIYYVHc65Z3rTeI6KWFvNvQ11Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731805AbgCaJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbgCaJLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D066020B1F;
        Tue, 31 Mar 2020 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645904;
        bh=TBcOzdlkBS4YbY4gK3VVWnQ8aiNxZfo4NGJlloFDJbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bbyyn8ek0ijOECeq7TH5xJD3jyAsNrfeTwspiC1F+DwOuyU92R87PvCE3Sxt5UbhV
         eK6M40D2qOQtDrSXqy7s94piiUz76e+P7hKI8zygY5JLUXgZPJXLS79MztlyvI1rto
         kgq0jwywUabqGyI/jSTqqkPBWUKdnKcWoFMDgdOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 031/155] net: stmmac: dwmac-rk: fix error path in rk_gmac_probe
Date:   Tue, 31 Mar 2020 10:57:51 +0200
Message-Id: <20200331085421.887539165@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
@@ -1411,7 +1411,7 @@ static int rk_gmac_probe(struct platform
 
 	ret = rk_gmac_clk_init(plat_dat);
 	if (ret)
-		return ret;
+		goto err_remove_config_dt;
 
 	ret = rk_gmac_powerup(plat_dat->bsp_priv);
 	if (ret)


