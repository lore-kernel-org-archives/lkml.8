Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AF8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748C020728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193975;
	bh=ZwqDkMDorujERg4ed4tu5PZFGsbWC60v1U3aRAhe01A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q9ENsyqW++ZH5P6bVHcRLmDVnjeYL0zrPVHCxkfBpC/2SKS2/l7S1hZR/W1og+yIF
	 Qaf4Y1ZsgfQN5yzRrnolGJS813G4NqXW8AZ2qOn0QeTXKtPHREOV36Ft/GrJWTK25x
	 eSmc9u/zjbV8OPe1+k+TDCGqz0yQkSFru3xcTrFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387536AbgAPQ7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbgAPQ5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:57:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267F124681;
        Thu, 16 Jan 2020 16:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193836;
        bh=ZwqDkMDorujERg4ed4tu5PZFGsbWC60v1U3aRAhe01A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKE4kWdcrZS3CQs6V6JkXBYBKaOWZfU1cCx2MmDESQ8wesW6DhXjcOy7XUktyatHs
         7KdwE2zG6AsIhnOwngaDL787rLTSXWRz1bszOp0F+UBiIEVV2cI8aYg0Lxpe2UxlGn
         PFoQRQrDBvYiKbIW2SCucn04ZDjq2sU6GDQHT/C4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 092/671] clk: vf610: fix refcount leak in vf610_clocks_init()
Date:   Thu, 16 Jan 2020 11:45:23 -0500
Message-Id: <20200116165502.8838-92-sashal@kernel.org>
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

[ Upstream commit 567177024e0313e4f0dcba7ba10c0732e50e655d ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 1f2c5fd5f048 ("ARM: imx: add VF610 clock support")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-vf610.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index 6dae54325a91..a334667c450a 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -203,6 +203,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,vf610-anatop");
 	anatop_base = of_iomap(np, 0);
 	BUG_ON(!anatop_base);
+	of_node_put(np);
 
 	np = ccm_node;
 	ccm_base = of_iomap(np, 0);
-- 
2.20.1

