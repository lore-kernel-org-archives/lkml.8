Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A78C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EED8C205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgEMNR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:17:26 -0400
Received: from out28-101.mail.aliyun.com ([115.124.28.101]:44687 "EHLO
        out28-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729787AbgEMNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:17:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07502541|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.345318-0.00103386-0.653648;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HY0oTOn_1589375829;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HY0oTOn_1589375829)
          by smtp.aliyun-inc.com(10.147.41.120);
          Wed, 13 May 2020 21:17:20 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH v8 1/6] clk: Ingenic: Remove unnecessary spinlock when reading registers.
Date:   Wed, 13 May 2020 21:16:39 +0800
Message-Id: <1589375804-78423-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589375804-78423-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1589375804-78423-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to use spinlock when reading registers,
so remove it from cgu.c.

Suggested-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Burton <paulburton@kernel.org>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2:
    New patch.
    
    v2->v3:
    Adjust order from [5/5] in v2 to [1/5] in v3.
    
    v3->v4:
    Remove the spinlock around ingenic_cgu_gate_get().
    
    v4->v5:
    Rebase on top of kernel 5.6-rc1.
    
    v5->v6:
    No change.
    
    v6->v7:
    No change.
    
    v7->v8:
    No change.

 drivers/clk/ingenic/cgu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 6e96303..ab1302a 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -76,16 +76,13 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	const struct ingenic_cgu_pll_info *pll_info;
 	unsigned m, n, od_enc, od;
 	bool bypass;
-	unsigned long flags;
 	u32 ctl;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 	BUG_ON(clk_info->type != CGU_CLK_PLL);
 	pll_info = &clk_info->pll;
 
-	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
-	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	m = (ctl >> pll_info->m_shift) & GENMASK(pll_info->m_bits - 1, 0);
 	m += pll_info->m_offset;
@@ -259,12 +256,9 @@ static int ingenic_pll_is_enabled(struct clk_hw *hw)
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info = to_clk_info(ingenic_clk);
 	const struct ingenic_cgu_pll_info *pll_info = &clk_info->pll;
-	unsigned long flags;
 	u32 ctl;
 
-	spin_lock_irqsave(&cgu->lock, flags);
 	ctl = readl(cgu->base + pll_info->reg);
-	spin_unlock_irqrestore(&cgu->lock, flags);
 
 	return !!(ctl & BIT(pll_info->enable_bit));
 }
@@ -562,16 +556,12 @@ static int ingenic_clk_is_enabled(struct clk_hw *hw)
 	struct ingenic_clk *ingenic_clk = to_ingenic_clk(hw);
 	struct ingenic_cgu *cgu = ingenic_clk->cgu;
 	const struct ingenic_cgu_clk_info *clk_info;
-	unsigned long flags;
 	int enabled = 1;
 
 	clk_info = &cgu->clock_info[ingenic_clk->idx];
 
-	if (clk_info->type & CGU_CLK_GATE) {
-		spin_lock_irqsave(&cgu->lock, flags);
+	if (clk_info->type & CGU_CLK_GATE)
 		enabled = !ingenic_cgu_gate_get(cgu, &clk_info->gate);
-		spin_unlock_irqrestore(&cgu->lock, flags);
-	}
 
 	return enabled;
 }
-- 
2.7.4

