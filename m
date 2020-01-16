Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68AFC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939B1246BF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195191;
	bh=RFZvnn13LjXpc+Vciqf2E2oYPWncnxNZRarRGNg6eec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ku4WdOma62z3ajHtoqf7TJeGXC4uRU/xZ8B0CT18w90aPSxLgM++3BI1neFoNMHXK
	 ZETBhqAPKJtUPGIFKIoKbmJaG1xrcUa3JF0XoEUIllXjw2a7ZgYRMdJe8+6iezApKT
	 EoyEE2H68LyrWIiBr1NdWj8L17t1o2NKIDD1TZ5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391565AbgAPRTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391115AbgAPRSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9E8246B1;
        Thu, 16 Jan 2020 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195095;
        bh=RFZvnn13LjXpc+Vciqf2E2oYPWncnxNZRarRGNg6eec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=crjLltSlXEdhSEOwASd8Nw/WtQHeiUgeAyajays0t+EtoskNnGgZW1FNnOUKHqyyq
         Ji6IogLSUgWFWC2GAyPcssUTiHMh2kP011Wpa3mARNyLt3fiVFk/yQUvm9yWoqcpZT
         JzrBrC7GLPc4OE6cKG9ZcS84cZU6Z1eeWh6yZhTU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 041/371] clk: imx6sx: fix refcount leak in imx6sx_clocks_init()
Date:   Thu, 16 Jan 2020 12:11:49 -0500
Message-Id: <20200116171719.16965-41-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 1731e14fb30212dd8c1e9f8fc1af061e56498c55 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: d55135689019 ("ARM: imx: add clock driver for imx6sx")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index e6d389e333d7..baa07553a0dd 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -164,6 +164,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX6SX_PLL1_BYPASS_SRC] = imx_clk_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
 	clks[IMX6SX_PLL2_BYPASS_SRC] = imx_clk_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
-- 
2.20.1

