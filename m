Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA66C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AF3206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgICGb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:31:59 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:37174 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICGb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:31:56 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id BE99DC6D9D;
        Thu,  3 Sep 2020 14:31:51 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140609134245632S1599114708716326_;
        Thu, 03 Sep 2020 14:31:51 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <98c5abcf751c2ae445524d828d190fa7>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Elaine Zhang <zhangqing@rock-chips.com>
To:     heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH v2 2/6] clk: rockchip: Export rockchip_clk_register_ddrclk()
Date:   Thu,  3 Sep 2020 14:31:43 +0800
Message-Id: <20200903063147.10237-3-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903063147.10237-1-zhangqing@rock-chips.com>
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by the Rockchip clk driver, export it to allow that
driver to be compiled as a module..

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/rockchip/clk-ddr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
index 9273bce4d7b6..282b6f22eb22 100644
--- a/drivers/clk/rockchip/clk-ddr.c
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -136,3 +136,4 @@ struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
 
 	return clk;
 }
+EXPORT_SYMBOL(rockchip_clk_register_ddrclk);
-- 
2.17.1



