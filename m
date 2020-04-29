Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D3BC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A66D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgD2KG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:06:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD2KGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:06:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3B04ED5A3D1979CF669D;
        Wed, 29 Apr 2020 18:06:48 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 18:06:41 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <geoff@infradead.org>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] powerpc/ps3: Move static keyword to the front of declaration
Date:   Wed, 29 Apr 2020 18:00:48 +0800
Message-ID: <1588154448-56759-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the static keyword to the front of declaration of 'vuart_bus_priv',
and resolve the following compiler warning that can be seen when
building with warnings enabled (W=1):

drivers/ps3/ps3-vuart.c:867:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
 } static vuart_bus_priv;
 ^

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/ps3/ps3-vuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index ddaa5ea..8e80e09 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -858,13 +858,13 @@ static int ps3_vuart_handle_port_interrupt(struct ps3_system_bus_device *dev)
 	return 0;
 }
 
-struct vuart_bus_priv {
+static struct vuart_bus_priv {
 	struct ports_bmp *bmp;
 	unsigned int virq;
 	struct mutex probe_mutex;
 	int use_count;
 	struct ps3_system_bus_device *devices[PORT_COUNT];
-} static vuart_bus_priv;
+} vuart_bus_priv;
 
 /**
  * ps3_vuart_irq_handler - first stage interrupt handler
-- 
1.7.12.4

