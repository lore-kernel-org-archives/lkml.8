Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F19C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F162076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 02:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGQCwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 22:52:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbgGQCwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 22:52:19 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE4CBA8B7E7047906218;
        Fri, 17 Jul 2020 10:52:17 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 10:52:11 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <hayashi.kunihiko@socionext.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <p.zabel@pengutronix.de>,
        <yamada.masahiro@socionext.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wanghai38@huawei.com>
Subject: [PATCH] net: ethernet: ave: Fix error returns in ave_init
Date:   Fri, 17 Jul 2020 10:50:49 +0800
Message-ID: <20200717025049.43027-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When regmap_update_bits failed in ave_init(), calls of the functions
reset_control_assert() and clk_disable_unprepare() were missed.
Add goto out_reset_assert to do this.

Fixes: 57878f2f4697 ("net: ethernet: ave: add support for phy-mode setting of system controller")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index f2638446b62e..81b554dd7221 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1191,7 +1191,7 @@ static int ave_init(struct net_device *ndev)
 	ret = regmap_update_bits(priv->regmap, SG_ETPINMODE,
 				 priv->pinmode_mask, priv->pinmode_val);
 	if (ret)
-		return ret;
+		goto out_reset_assert;
 
 	ave_global_reset(ndev);
 
-- 
2.17.1

