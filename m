Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6DEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D3F205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgENBVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:21:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725943AbgENBVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:21:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4EA5FFC54B41A460E5CB;
        Thu, 14 May 2020 09:21:38 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 14 May 2020
 09:21:30 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <linux-net-drivers@solarflare.com>
CC:     <ecree@solarflare.com>, <mhabets@solarflare.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH -next] sfc: Make siena_check_caps static
Date:   Thu, 14 May 2020 09:20:42 +0800
Message-ID: <20200514012042.126071-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

drivers/net/ethernet/sfc/siena.c:951:14: warning:
symbol 'siena_check_caps' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/net/ethernet/sfc/siena.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/siena.c b/drivers/net/ethernet/sfc/siena.c
index ed1cb6caa69d..4b4afe81be2a 100644
--- a/drivers/net/ethernet/sfc/siena.c
+++ b/drivers/net/ethernet/sfc/siena.c
@@ -948,8 +948,8 @@ static int siena_mtd_probe(struct efx_nic *efx)
 
 #endif /* CONFIG_SFC_MTD */
 
-unsigned int siena_check_caps(const struct efx_nic *efx,
-			      u8 flag, u32 offset)
+static unsigned int siena_check_caps(const struct efx_nic *efx,
+				     u8 flag, u32 offset)
 {
 	/* Siena did not support MC_CMD_GET_CAPABILITIES */
 	return 0;
-- 
2.22.0

