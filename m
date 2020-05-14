Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B082C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573FC2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483405;
	bh=LJUH6SI1WM2SUCEX/8syheNDQeQu0nGxG/o/Bs3whsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mhE+i9iJxQOJG+AaoM64cJJnmrF85pec3GMr7qNiMymLT9Uu5rRAKyS9TXLkn4b3N
	 tTk25+/C6INNWAKfK8C46F/3B4X6pEYOaCJhzjPKPKWb+aj0GdSXoO4rDrPj+jASmF
	 YyYCVTaMqiPFhMJiCADgnGMfuFJ7s85N1/i56Y50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgENTKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbgENSwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:52:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC55F206D8;
        Thu, 14 May 2020 18:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482356;
        bh=LJUH6SI1WM2SUCEX/8syheNDQeQu0nGxG/o/Bs3whsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EyoI/SP3LdEDNArum8N02A+u4MbPQ5Np4IdRT9ly5WnP3QsQ2Z1/GxrY9/MEn8LZo
         q+VEsVROGMweFlCgXbT5urshBwPueqZEvSgHbgA+LcuK00mei1cR/tHqnF6GsT5cgr
         8Ul1QNtDA42Ra4+E3m03mS+7vaZGsph2KBrwk3ZI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.6 37/62] net: stmmac: gmac5+: fix potential integer overflow on 32 bit multiply
Date:   Thu, 14 May 2020 14:51:22 -0400
Message-Id: <20200514185147.19716-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185147.19716-1-sashal@kernel.org>
References: <20200514185147.19716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 44d95cc6b10ff7439d45839c96c581cb4368c088 ]

The multiplication of cfg->ctr[1] by 1000000000 is performed using a
32 bit multiplication (since cfg->ctr[1] is a u32) and this can lead
to a potential overflow. Fix this by making the constant a ULL to
ensure a 64 bit multiply occurs.

Fixes: 504723af0d85 ("net: stmmac: Add basic EST support for GMAC5+")
Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index 494c859b4ade8..67ba67ed0cb99 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -624,7 +624,7 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 		total_offset += offset;
 	}
 
-	total_ctr = cfg->ctr[0] + cfg->ctr[1] * 1000000000;
+	total_ctr = cfg->ctr[0] + cfg->ctr[1] * 1000000000ULL;
 	total_ctr += total_offset;
 
 	ctr_low = do_div(total_ctr, 1000000000);
-- 
2.20.1

