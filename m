Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED791C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16CB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863940;
	bh=DMawGORGw/GHzM9qUcSUjMhFK4aAx1nQqfwLv03Q3sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vjsm+1UYZ0ejD1eEy+S5OSxzAT+9GBeIx4z8DW1yxex/v9rfGuiOlqhn0vXYMLSFv
	 RdbqYvJpCnDxq2waA09voNCyrte/Q1B97iA21KMh5uEzZEecuMaOFg399WCPsHD9GQ
	 JMQoPh63yNW6lYn2nen8IpuasLNKHbLctel2NM6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbgAXLFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388880AbgAXLFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:05:36 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306D12071A;
        Fri, 24 Jan 2020 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863935;
        bh=DMawGORGw/GHzM9qUcSUjMhFK4aAx1nQqfwLv03Q3sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LAckbhbHZspg6lXvQRuVqjcD+kB2r72X1clyrv5Z9hkooivyDGiMr7ZrHHt3DXi38
         PulyjmyLx7+UMh9I57yS05maszMlcBSfgoEWHU3i/7z+JIZNbXYqH5jf2MLph6dUiy
         cYZ7Q/0NODF10IQCUcioidFYdhxSqgdfwfGoc5us=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/639] clk: dove: fix refcount leak in dove_clk_init()
Date:   Fri, 24 Jan 2020 10:24:44 +0100
Message-Id: <20200124093101.614796747@linuxfoundation.org>
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
index 59fad9546c847..5f258c9bb68bf 100644
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



