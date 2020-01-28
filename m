Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13047C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0F024681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220478;
	bh=SFSwj7ofrhv7b1VMq8Ya7BJAa4I1uHTpBaO86EKB4FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RPlvSPQ8ZWHtxgFQwpo71PE8quV0ucb+0gReqZcyZrFxg9pi5ognZC0EkvMvyK4Bx
	 kmG6zq8NLsJuJ1/ObEfB1g7Lf4a0j594RCCIEy4Gqbw6J5mjuVn/hv2AELi/R9tYP+
	 riyySWSfBUxlHpC+FF4nCtU1edJ2F7hy3vAAXoWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgA1OH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgA1OHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:07:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 147E724681;
        Tue, 28 Jan 2020 14:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220474;
        bh=SFSwj7ofrhv7b1VMq8Ya7BJAa4I1uHTpBaO86EKB4FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sq4rFqHp1Y3MZFaRxAu7gmmzu7olfiNssodW7HI7x1CPlq0VrRqlFqLdiSkd4EOAu
         xAhdij8GnY3w7jvGyDUZh5b3SicL4sP8wcR+BwxHAS02jL0z0WmSSUbj0qof+BoMUG
         l43W12nE/9yRli3Nskc/Y0GaICMBr4FLS9jCmXKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 021/183] clk: highbank: fix refcount leak in hb_clk_init()
Date:   Tue, 28 Jan 2020 15:04:00 +0100
Message-Id: <20200128135832.047986798@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 5eb8ba90958de1285120dae5d3a5d2b1a360b3b4 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Fixes: 26cae166cff9 ("ARM: highbank: remove custom .init_time hook")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-highbank.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-highbank.c b/drivers/clk/clk-highbank.c
index be3a21abb185a..4105066b428ca 100644
--- a/drivers/clk/clk-highbank.c
+++ b/drivers/clk/clk-highbank.c
@@ -294,6 +294,7 @@ static __init struct clk *hb_clk_init(struct device_node *node, const struct clk
 	/* Map system registers */
 	srnp = of_find_compatible_node(NULL, NULL, "calxeda,hb-sregs");
 	hb_clk->reg = of_iomap(srnp, 0);
+	of_node_put(srnp);
 	BUG_ON(!hb_clk->reg);
 	hb_clk->reg += reg;
 
-- 
2.20.1



