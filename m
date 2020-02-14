Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE95C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822FE246EC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696962;
	bh=7d2HlSTu28tCyC8lFDF6nFQvL3dmP8YskVis4QaibWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0ctZiMkm/rD6q7a+ImaSh0oNS9XYn81wrq3vzoeJBHc0CLCCJlYldkZhmYeEliMM
	 IpMuw+mh2xI5xazONB6XsAScA62LoQmcQsyiPiEx4mTyXXjDttYYhaE4Vrz22TS47s
	 CI5wDuKFdXVbof+FUJ5dbwvpnHi2PmAHnE0J5T9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392530AbgBNQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404072AbgBNQPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87729246E2;
        Fri, 14 Feb 2020 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696904;
        bh=7d2HlSTu28tCyC8lFDF6nFQvL3dmP8YskVis4QaibWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkWMuEcXpfoi97XMNJc3e5ChApFWCrZcbyS8zNEnhr7UllqVdU3jRaoLog+GlkvIm
         RpTAKiztYTz+7cAdS5avWoFFr7N7V3zOrqF1IYClhGiDEJsvXb0BIGvvnhvS3rq8h/
         D5MLwb6RbB7K5LCg+M51IcoO0ueN8v6xd2ysFekk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 154/252] wan: ixp4xx_hss: fix compile-testing on 64-bit
Date:   Fri, 14 Feb 2020 11:10:09 -0500
Message-Id: <20200214161147.15842-154-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 504c28c853ec5c626900b914b5833daf0581a344 ]

Change the driver to use portable integer types to avoid
warnings during compile testing:

drivers/net/wan/ixp4xx_hss.c:863:21: error: cast to 'u32 *' (aka 'unsigned int *') from smaller integer type 'int' [-Werror,-Wint-to-pointer-cast]
        memcpy_swab32(mem, (u32 *)((int)skb->data & ~3), bytes / 4);
                           ^
drivers/net/wan/ixp4xx_hss.c:979:12: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'dma_addr_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
                                              &port->desc_tab_phys)))
                                              ^~~~~~~~~~~~~~~~~~~~
include/linux/dmapool.h:27:20: note: passing argument to parameter 'handle' here
                     dma_addr_t *handle);
                                 ^

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/ixp4xx_hss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 6a505c26a3e74..a269ed63d90f7 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -261,7 +261,7 @@ struct port {
 	struct hss_plat_info *plat;
 	buffer_t *rx_buff_tab[RX_DESCS], *tx_buff_tab[TX_DESCS];
 	struct desc *desc_tab;	/* coherent */
-	u32 desc_tab_phys;
+	dma_addr_t desc_tab_phys;
 	unsigned int id;
 	unsigned int clock_type, clock_rate, loopback;
 	unsigned int initialized, carrier;
@@ -861,7 +861,7 @@ static int hss_hdlc_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
-	memcpy_swab32(mem, (u32 *)((int)skb->data & ~3), bytes / 4);
+	memcpy_swab32(mem, (u32 *)((uintptr_t)skb->data & ~3), bytes / 4);
 	dev_kfree_skb(skb);
 #endif
 
-- 
2.20.1

