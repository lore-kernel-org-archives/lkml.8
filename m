Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08DB20708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864102;
	bh=sV4iwM9SEHdmE/1iFpICkuFdnRHqZTyEZmb5uZesbaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INR8hUWr7jM55rpVJL1RDMwYNnqFkjcsUg/wa4pNjE/yozzQNsT1kM1xsUhWmQRdo
	 P1HNo1Hlkkvr/qB67JlCOfY5TrRF4AObp/MWnhbyU99OPjY8Y7uyr8n2N48fkcfsJA
	 q7kF+sx7ip0HV/pZl0lJGyywdkIXOw4kCY0XpnqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgAXLIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:08:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389646AbgAXLIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:08:18 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F1A920708;
        Fri, 24 Jan 2020 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864097;
        bh=sV4iwM9SEHdmE/1iFpICkuFdnRHqZTyEZmb5uZesbaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FOamHHZUhTGQU23Dgpx6XLuhUfMEVQTPqqUfjByiD79J3cJGvspp2yY706ayKIer2
         dpf5YJzDxnljLprRe1QHX9sSvyLiR+xgImNzjaPFHgblwVTe8Md4zGfQHn3u89dWAG
         Xe47s6/ZiOCsilFd73T+aAnKjt4/yu1ix26DXPZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 171/639] clk: ingenic: jz4740: Fix gating of UDC clock
Date:   Fri, 24 Jan 2020 10:25:41 +0100
Message-Id: <20200124093108.582423801@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit b7e29924a1a628aec60d18651b493fa1601bf944 ]

The UDC clock is gated when the bit is cleared, not when it is set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
Fixes: 2b555a4b9cae ("clk: ingenic: Add missing flag for UDC clock")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ingenic/jz4740-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 4479c102e8994..b86edd3282493 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -165,7 +165,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
 		.mux = { CGU_REG_CPCCR, 29, 1 },
 		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
-		.gate = { CGU_REG_SCR, 6 },
+		.gate = { CGU_REG_SCR, 6, true },
 	},
 
 	/* Gate-only clocks */
-- 
2.20.1



