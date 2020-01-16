Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A348AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748982073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198278;
	bh=nrkyTp04R64DK9v4TJK/K3uh8Hrme3Fh3FlyFA1d3rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I5AfBtbNndB/VOnwCiXrhW9gIlPdUILlmCx78h0faPmGDz2VjGYMqoHZSHLld5PmL
	 jOvkm/ru0ZtBwkM2qJ/PUGHpLA2FWafrgkaeMFcZ9ahINGCAQsLS0NzZqaYbWLoT2t
	 JPbkIqbCN+ZmDL8QkUfRUDXQx5IWbyAqjOMW5Hq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405401AbgAPRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405016AbgAPRfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:35:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C6524713;
        Thu, 16 Jan 2020 17:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196125;
        bh=nrkyTp04R64DK9v4TJK/K3uh8Hrme3Fh3FlyFA1d3rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qp3/AtMfhs1Kk6g1DJ3XJQW20S4lwsbnpTxxh7NlN7zONqgOJB9CHhDIpyIQxLm8z
         H5owTc8f/QmjbYcDOvZeX/81OAquEqQ6hc/3XlothL6Mcyl4PbncP1AhlteC4qPAIF
         E7Sw7F2ZWFTt/0WPuA2wjPAdtjzsXzoyPYnpIVio=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 030/251] clk: imx7d: fix refcount leak in imx7d_clocks_init()
Date:   Thu, 16 Jan 2020 12:31:04 -0500
Message-Id: <20200116173445.21385-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173445.21385-1-sashal@kernel.org>
References: <20200116173445.21385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 5f8c183a996b76bb09748073c856e4246fd4ce95 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 8f6d8094b215 ("ARM: imx: add imx7d clk tree support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx7d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index e7c7353a86fc..8c0c0d015132 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -415,6 +415,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX7D_PLL_ARM_MAIN_SRC]  = imx_clk_mux("pll_arm_main_src", base + 0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 	clks[IMX7D_PLL_DRAM_MAIN_SRC] = imx_clk_mux("pll_dram_main_src", base + 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-- 
2.20.1

