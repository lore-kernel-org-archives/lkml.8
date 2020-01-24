Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2ADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C6B24125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863852;
	bh=swb8ylO3whG6oEYMtfBN6kOtQsnU8P5uHHFFwn02onw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ecYWmpyNBkSpw1ZZc9OQIeDqjmJEg55Dl7sc2p53KzswWpihpn0xOJrGLLioem+Q1
	 RRI02FwcqOJ82KkTdcEBgYL78j8T8l5gJYWP4U8LoHcVGeLrY1MNwld8HZRl+906hf
	 6Onl3IJTrnQcDM9FTDM/FAsvh12tiQK1fUvZaccE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgAXLEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388147AbgAXLEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:04:09 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15132075D;
        Fri, 24 Jan 2020 11:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863848;
        bh=swb8ylO3whG6oEYMtfBN6kOtQsnU8P5uHHFFwn02onw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmElMHZeKjkhH2Hd/Th/miTcWwD+7kV5RmYEHNgdyHQ+vE6vxKEcKnjF1DHvOI2Kb
         X70y5jcI5GBxGMYNIpy5iIrNPthArJ+D+LUNVfCkDnEEHiHhjstG+FepZpky71iIXD
         /Wgb3ko7PbBt5s9TQV0A1anXStT6CRzfuY30AAa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/639] clk: socfpga: fix refcount leak
Date:   Fri, 24 Jan 2020 10:24:34 +0100
Message-Id: <20200124093100.386257740@linuxfoundation.org>
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

[ Upstream commit 7f9705beeb3759e69165e7aff588f6488ff6c1ac ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 5343325ff3dd ("clk: socfpga: add a clock driver for the Arria 10 platform")
Fixes: a30d27ed739b ("clk: socfpga: fix clock driver for 3.15")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/socfpga/clk-pll-a10.c | 1 +
 drivers/clk/socfpga/clk-pll.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 35fabe1a32c30..269467e8e07e1 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -95,6 +95,7 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_a10_base_addr = of_iomap(clkmgr_np, 0);
+	of_node_put(clkmgr_np);
 	BUG_ON(!clk_mgr_a10_base_addr);
 	pll_clk->hw.reg = clk_mgr_a10_base_addr + reg;
 
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index c7f463172e4b9..b4b44e9b59011 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -100,6 +100,7 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
 
 	clkmgr_np = of_find_compatible_node(NULL, NULL, "altr,clk-mgr");
 	clk_mgr_base_addr = of_iomap(clkmgr_np, 0);
+	of_node_put(clkmgr_np);
 	BUG_ON(!clk_mgr_base_addr);
 	pll_clk->hw.reg = clk_mgr_base_addr + reg;
 
-- 
2.20.1



