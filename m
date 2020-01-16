Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7643AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524642073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197455;
	bh=SNIUiTLu8bqf8c55iSNESq7sZ9yGi4zsvWP3lxc+q30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zD6yjP/9wmU9hKvLJj+XVmx7WtBd/2m/Gp8n6j6mJok7EGrOH40ysH/m3fcd3Xq4X
	 SGOUU2TxkVUhD17T9JYYtazDWaRwLNxTl+VfAE6zJw7UV0oy2tiFSOhvWuF3jGcJkB
	 YNrNkz7g2ZpcIcxLOGPHZHZTuXha37O3lktPdsIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394616AbgAPR5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405876AbgAPRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27EBD24718;
        Thu, 16 Jan 2020 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196601;
        bh=SNIUiTLu8bqf8c55iSNESq7sZ9yGi4zsvWP3lxc+q30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FLINbtoZRAqdVwM0kV/yZz6XS04Uy+MnkYwUa8pNUlDXx8i8Mq0lGVzsDtBO8gxc3
         SM6CMIwvan1EmeISB7HKQBeRnThXW//l27AOQbdAjdzx3lZieVCWhtcTLjGVCrC41C
         +n5b44yNTaYXXBstVmcN2Jo93UrcYBv20w3hcRVQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 023/174] clk: imx6q: fix refcount leak in imx6q_clocks_init()
Date:   Thu, 16 Jan 2020 12:40:20 -0500
Message-Id: <20200116174251.24326-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit c9ec1d8fef31b5fc9e90e99f9bd685db5caa7c5e ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 2acd1b6f889c ("ARM: i.MX6: implement clocks using common clock framework")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/imx/clk-imx6q.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 46c05c9a9354..39ea50102d52 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -155,6 +155,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
 	base = of_iomap(np, 0);
 	WARN_ON(!base);
+	of_node_put(np);
 
 	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
 	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
-- 
2.20.1

