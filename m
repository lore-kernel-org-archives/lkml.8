Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1B0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B7720728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193980;
	bh=tI28Hzf5zYprls2QJ9JCO2LTS0EKJ1WUECK8F/0QlKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6o/f/Qwqrwy/6DwQml+7Y1o7Yv67zYE3LdrAKiHBj23NKF046QY2jXHCpXC494xm
	 lM1QMEQ5z90UPsuFn+0VzBmaj8z90LkOMjlTlGGO2JkyMG5WxvL4QgwoI3i3uAXk6L
	 N8AEb0essumpmA+NC1MQ2iBogwf6gXM7RDXD0tX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgAPQ7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733180AbgAPQ5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D62392467E;
        Thu, 16 Jan 2020 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193835;
        bh=tI28Hzf5zYprls2QJ9JCO2LTS0EKJ1WUECK8F/0QlKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObVfXGfYGAJsRqLjo36UIum8zfZsvA9aTJg2gRhc3ditUK6tosDre1Kxugpae3Rdc
         s+ttctWL4nXUeggvly7THM9lx4zld+V1RmHRyBY8xCdmtgIlbY0bmqMKkiYjYn45OZ
         /6fx67/YQ2hO2Fn1KgLvDE6s3Vp7tHW3x3ruul/k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 091/671] clk: imx7d: fix refcount leak in imx7d_clocks_init()
Date:   Thu, 16 Jan 2020 11:45:22 -0500
Message-Id: <20200116165502.8838-91-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
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
index 881b772c4ac9..83412bc36ebf 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -413,6 +413,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	clks[IMX7D_PLL_ARM_MAIN_SRC]  = imx_clk_mux("pll_arm_main_src", base + 0x60, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
 	clks[IMX7D_PLL_DRAM_MAIN_SRC] = imx_clk_mux("pll_dram_main_src", base + 0x70, 14, 2, pll_bypass_src_sel, ARRAY_SIZE(pll_bypass_src_sel));
-- 
2.20.1

