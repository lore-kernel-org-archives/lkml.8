Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A7BC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E055246D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195120;
	bh=i5owRwERAnOiCFmbkU+ANJ+g3C6UCYGaMA8Usv0k760=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EjLu3PUys14lUW3y8Oe71tlE96YwmoaUm7hRjsL8kW9uKuq1r63AFzCFccEFEd1AA
	 dSorlk/zItA/zCJkmMDTOtoYtNrnTKbaOib0QtCwjcJ5Ro0+qRaNJfHIOE+is7w6H4
	 UMW8PgHzfHHosqavHmSBKVPYFerVlwcih1qhhp20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391532AbgAPRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391462AbgAPRSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F3F24653;
        Thu, 16 Jan 2020 17:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195105;
        bh=i5owRwERAnOiCFmbkU+ANJ+g3C6UCYGaMA8Usv0k760=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jbkc/0O3MUDPEcbWbHLstUALC/exfc76tGPlLQg7BE9n7JHYYwvce8h2Z2HyLUPBR
         07W0IzvymIahFHBbOYz7OliJxnWsLl2fp/2/FJDCBcMOKaiVpugmU6xTSIs9CP7/Dg
         1XT9vhRV9sSPLtKn7fMr9PWmwDk6BdaeHhqGRRDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 048/371] clk: dove: fix refcount leak in dove_clk_init()
Date:   Thu, 16 Jan 2020 12:11:56 -0500
Message-Id: <20200116171719.16965-48-sashal@kernel.org>
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

[ Upstream commit 8d726c5128298386b907963033be93407b0c4275 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 8f7fc5450b64 ("clk: mvebu: dove: maintain clock init order")
Fixes: 63b8d92c793f ("clk: add Dove PLL divider support for GPU, VMeta and AXI clocks")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/dove.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
index 59fad9546c84..5f258c9bb68b 100644
--- a/drivers/clk/mvebu/dove.c
+++ b/drivers/clk/mvebu/dove.c
@@ -190,10 +190,14 @@ static void __init dove_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &dove_coreclks);
 
-	if (ddnp)
+	if (ddnp) {
 		dove_divider_clk_init(ddnp);
+		of_node_put(ddnp);
+	}
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, dove_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(dove_clk, "marvell,dove-core-clock", dove_clk_init);
-- 
2.20.1

