Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D71E206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955186;
	bh=lbGMWCj1Ow4xOVH+P9eXNDdT+gYet8KYpgKFEEcJB1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ynzlU4WK2d9pHf5+/mCn6YP4sb1p16347+nv7FV6Y76eOK3oepOBNQ19KqeGZ5p4l
	 QGBvVD+My48qQh0ref6Z2/kEdBuIftWJL+l/hsxH6AsqMrLlQY3rOyXZLmVkd2ozG+
	 SCnPAWFXqMO5v/F1NX6VEx5s6Co5X6+vZ+Ziga7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370563AbgDOMxD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:53:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897147AbgDOLmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:42:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49ED4206A2;
        Wed, 15 Apr 2020 11:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950953;
        bh=lbGMWCj1Ow4xOVH+P9eXNDdT+gYet8KYpgKFEEcJB1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TqlT7Wv3HJX1xD5UnEhxWSgkS0pynih6HItDoibC3ZjpqUCQXdCD5IKsnWYM3IR6L
         u0UGhrf/11Jf/u8hN/qHNEvyWU16HsJaAlUFg4R9hQYkTJGfv6OFcq6nOBnH6+szUx
         FjCITT4aCS+jneRxTWGfy48TPqHNIFMqvnGLX+AI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 005/106] clk: imx: pll14xx: Add new frequency entries for pll1443x table
Date:   Wed, 15 Apr 2020 07:40:45 -0400
Message-Id: <20200415114226.13103-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 57795654fb553a78f07a9f92d87fb2582379cd93 ]

Add new frequency entries to pll1443x table to meet different
display settings requirement.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-pll14xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 3636c8035c7d9..c5df14caa1675 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -55,8 +55,10 @@ static const struct imx_pll14xx_rate_table imx_pll1416x_tbl[] = {
 };
 
 static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
+	PLL_1443X_RATE(1039500000U, 173, 2, 1, 16384),
 	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
 	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
+	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
 	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
 	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
 };
-- 
2.20.1

